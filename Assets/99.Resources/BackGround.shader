Shader "Custom/LowerGradient"
{
    Properties
    {
        _Color1 ("Top Color", Color) = (1, 1, 1, 1)  // ���� ����
        _Color2 ("Bottom Color", Color) = (0, 0, 0, 1) // �Ʒ��� ����
        _GradientStart ("Gradient Start", Range(0, 1)) = 0.3 // �׶��̼� ���� ��ġ
        _GradientEnd ("Gradient End", Range(0, 1)) = 0.7   // �׶��̼� �� ��ġ
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
            float _GradientStart;  // �׶��̼� ���� ��ġ
            float _GradientEnd;    // �׶��̼� �� ��ġ

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
                gradientFactor = clamp(gradientFactor, 0.0, 1.0);  // �׶��̼� ���� ���� Ŭ����

                return lerp(_Color2, _Color1, gradientFactor);  // �׶��̼� ���� ����
            }
            ENDCG
        }
    }
}
