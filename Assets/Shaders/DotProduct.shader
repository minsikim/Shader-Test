Shader "Salinger/DotProduct" 
{
	Properties{
		_myColor("SampleColor", Color) = (1,1,1,1)
	}
	SubShader{

		CGPROGRAM
		#pragma surface surf Lambert

		fixed4 _myColor;

        struct Input {
			float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
			//half dotp = dot(IN.viewDir, o.Normal);
			half dotp = dot(IN.viewDir, o.Normal);
			//o.Albedo = float3(1 - dotp, 0, 0);
			o.Albedo = float3(dotp, 1, 1);
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
