using UnityEngine;
using UnityEngine.UI;

[ExecuteAlways]
public class GradientImage : MonoBehaviour
{
    public Color color1 = Color.red;
    public Color color2 = Color.blue;
    private Image image;

    void Awake()
    {
        image = GetComponent<Image>();
        UpdateGradient();
    }

    void OnValidate()
    {
        UpdateGradient();
    }

    void UpdateGradient()
    {
        if (image == null) return;

        Texture2D texture = new Texture2D(1, 256);
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255f;
            texture.SetPixel(0, i, Color.Lerp(color1, color2, t));
        }
        texture.Apply();

        image.sprite = Sprite.Create(texture, new Rect(0, 0, 1, 256), new Vector2(0.5f, 0.5f));
    }
}
