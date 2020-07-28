Shader "Salinger/WorldPos" 
{
	Properties{
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
		float4 _RimColor;
		float _RimPower;

        struct Input {
			float3 viewDir;
			float3 worldPos;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			//o.Emission = IN.worldPos.y > 1 ? float3(0, 1, 0) : float3(1, 0, 0);
			o.Emission = pow(rim, _RimPower) * (frac(IN.worldPos.y * 10 * 0.5) > 0.4 ?
				float3(0, 1, 0) : float3(1, 0, 0));
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
