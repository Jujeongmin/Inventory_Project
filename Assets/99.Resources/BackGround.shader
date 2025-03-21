Shader "Custom/LowerGradient"
{
    Properties
    {
        _Color1 ("Top Color", Color) = (1, 1, 1, 1)  // 위쪽 색상
        _Color2 ("Bottom Color", Color) = (0, 0, 0, 1) // 아래쪽 색상
        _GradientStart ("Gradient Start", Range(0, 1)) = 0.3 // 그라데이션 시작 위치
        _GradientEnd ("Gradient End", Range(0, 1)) = 0.7   // 그라데이션 끝 위치
    }
    SubShader
    {
        Tags { "Queue"="Background" "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _Color1;
            float4 _Color2;
            float _GradientStart;  // 그라데이션 시작 위치
            float _GradientEnd;    // 그라데이션 끝 위치

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float gradientFactor = (i.uv.y - _GradientStart) / (_GradientEnd - _GradientStart);
                gradientFactor = clamp(gradientFactor, 0.0, 1.0);  // 그라데이션 범위 밖은 클램프

                return lerp(_Color2, _Color1, gradientFactor);  // 그라데이션 색상 보간
            }
            ENDCG
        }
    }
}
