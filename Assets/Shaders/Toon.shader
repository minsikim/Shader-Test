Shader "Salinger/Toon" 
{
	Properties{
		_Color1("Color 1", Color) = (1,1,1,1)
		_Color2("Color 2", Color) = (1,1,1,1)
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf SimpleLambert

		half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
			c.a = s.Alpha;
			return c;
		}

		float4 _Color1;
		float4 _Color2;

		struct appdata
		{
			float4 vertex : POSITION;
			float4 uv : TEXCOORD0;
			float3 normal : NORMAL;
		};

        struct Input {
			float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
			o.Emission = o.Normal;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
