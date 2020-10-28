Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA929D921
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgJ1Woc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbgJ1WmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:42:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v6so803439lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x514F6gZYdZ6Ml7d5BwMRGVQM3GbGutbqJsB1Ozu+Nc=;
        b=rUP+JJfwCO3GMrN5WC7KVKpPvj7+iVkYGyHDLhTqKl5FYjGMBB9DnL1ZGaYO/jNIg8
         Lmt5mX1qdOC0eGxqN5xlwtilpqSAObS9rs51EeMhivf7Vs+z9mMXkB+CRPyqPURdSIfN
         JYCHh3ZhhOGtzQi+iaReVKTHtfPLu/WSSsAVeGL9zlWzem15a2h3Or/1GODbdn4s/8B5
         l3XBxCxYTKHt9pf2QV2L8p2L+OoUXBjb8sU8nAE4H63h4nygaKide9qwB5WpLHNPS8eP
         tR6lyFTZ4x6cYyBJyrR2JVtzrNA1ikmJ7rDagJims9vxm3CmJbcrmuPaFDCn4tCiRv1G
         U7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x514F6gZYdZ6Ml7d5BwMRGVQM3GbGutbqJsB1Ozu+Nc=;
        b=heBf+FgEskF+IeY+kPg3uvDaSGwEbqa/0CWBbdJnh+GaRhWM0JykzM8Ue+BadfaWng
         oUBnzqIHuZXtZy/VlWywpwo9/0+FFvg7f+GQrGu2EowyC9mOUWGyJIu+acPbCZxfGnLu
         rrTUzI8xMOeEhge/eQXrmnstg8zI/Prp15JfJbTkjrKNOD0RODvvICLLQ8/eVFIrhNmF
         tjcA3lGS56swqe1Z+qhf6nSMexVlCYcJqvpqYJ06ce4e3ywqp9QuZ0x5nIt0CI00kvjA
         vPi0/02E7ZEa/Zd0l424O599GfIhCg5PmOnTsiiODyfd1X3rga1t6vjdXJu/WsOCagLq
         CSwg==
X-Gm-Message-State: AOAM531mcbwzNshpOfdPRaP2Yc30OzDPi75g8AOhIJyuJsNZhpbpZv5M
        7IIHEAp4hCQvFtMVKcIwfNYJaoSLWqM6KA==
X-Google-Smtp-Source: ABdhPJxmgjy0sWYNhQDDvIzYf6zbC83N2esx/kijWUC+e1Ze75JVCM/aZaXbPnw77v647Bv/IDoHrA==
X-Received: by 2002:adf:f146:: with SMTP id y6mr3245254wro.418.1603898386817;
        Wed, 28 Oct 2020 08:19:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e2sm5699576wrr.85.2020.10.28.08.19.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:19:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Add SM8250 sound card
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        plai@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
 <20201026170947.10567-2-srinivas.kandagatla@linaro.org>
 <20201028150135.GA4009047@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <31981724-b260-e94d-ebc6-ccea21763531@linaro.org>
Date:   Wed, 28 Oct 2020 15:19:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201028150135.GA4009047@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2020 15:01, Rob Herring wrote:
> On Mon, Oct 26, 2020 at 05:09:46PM +0000, Srinivas Kandagatla wrote:
>> This patch adds bindings required for SM8250 based soundcards
>> for example Qualcomm Robotics RB5 Development Kit which makes
>> use of ADSP and Internal LPASS codec.
> 
> You didn't send to DT list...

Ah.. my bad.. I did not realize that I missed it!

> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,sm8250.yaml           | 161 ++++++++++++++++++
>>   1 file changed, 161 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> new file mode 100644
>> index 000000000000..b8f97fe6e92c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> @@ -0,0 +1,161 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies Inc. SM8250 ASoC sound card driver
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description:
>> +  This bindings describes SC8250 SoC based sound cards
>> +  which uses LPASS internal codec for audio.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: qcom,qrb5165-rb5
>> +      - items:
>> +        - const: qcom,sm8250
> 
> This collides with the top level SoC compatible resulting in:
> 

I did run dt_binding_check before sending out this patch, I might have 
missed it somehow because the make dt_binding_check did not 
end/termnitate in any errors, however if I had scrolled 15-20 Page ups 
it does have this error log!


> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: $nodename:0: '/' was expected
> 	From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/arm/qcom.yaml
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible: ['qcom,qrb5165-rb5'] is not valid under any of the given schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible: ['qcom,qrb5165-rb5'] is too short
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,apq8016-sbc']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,apq8064-cm-qs600', 'qcom,apq8064-ifc6410']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,apq8074-dragonboard']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,apq8060-dragonboard', 'qcom,msm8660-surf']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,apq8084-mtp', 'qcom,apq8084-sbc']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,msm8960-cdp']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['fairphone,fp2', 'lge,hammerhead', 'sony,xperia-amami', 'sony,xperia-castor', 'sony,xperia-honami']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,msm8916-mtp/1' was expected
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['longcheer,l8150', 'samsung,a3u-eur', 'samsung,a5u-eur']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,msm8996-mtp' was expected
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,ipq4019-ap-dk04.1-c3', 'qcom,ipq4019-ap-dk07.1-c1', 'qcom,ipq4019-ap-dk07.1-c2', 'qcom,ipq4019-dk04.1-c1']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,ipq8064-ap148']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,ipq8074-hk01', 'qcom,ipq8074-hk10-c1', 'qcom,ipq8074-hk10-c2']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,sc7180-idp']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['xiaomi,lavender']
> 	/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165-rb5' is not one of ['qcom,ipq6018-cp01-c1']
> 
> 	From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/arm/qcom.yaml
> 
Documentation/devicetree/bindings/arm/qcom.yaml does have 
qcom,qrb5165-rb5 entry under [qcom,sm8250]

Can you help me understand why is this not a valid compatible?


> Also, the indentation is off:
> ./Documentation/devicetree/bindings/sound/qcom,sm8250.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
I will fix it!

--srini
>> +        - const: qcom,qrb5165-rb5
>> +
>> +  audio-routing:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description:
>> +      A list of the connections between audio components. Each entry is a
>> +      pair of strings, the first being the connection's sink, the second
>> +      being the connection's source. Valid names could be power supplies,
>> +      MicBias of codec and the jacks on the board.
>> +
>> +  model:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: User visible long sound card name
>> +
>> +patternProperties:
>> +  ".*-dai-link$":
> 
> '.*' at the beginning is not necessary.
> 
>> +    description:
>> +      Each subnode represents a dai link. Subnodes of each dai links would be
>> +      cpu/codec dais.
>> +
>> +    type: object
>> +
>> +    properties:
>> +      link-name:
>> +        description: Indicates dai-link name and PCM stream name.
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        maxItems: 1
>> +
>> +      cpu:
>> +        description: Holds subnode which indicates cpu dai.
>> +        type: object
>> +        properties:
>> +          sound-dai: true
>> +
>> +      platform:
>> +        description: Holds subnode which indicates platform dai.
>> +        type: object
>> +        properties:
>> +          sound-dai: true
>> +
>> +      codec:
>> +        description: Holds subnode which indicates codec dai.
>> +        type: object
>> +        properties:
>> +          sound-dai: true
>> +
>> +    required:
>> +      - link-name
>> +      - cpu
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - model
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +
>> +  - |
>> +    #include <dt-bindings/sound/qcom,q6afe.h>
>> +    #include <dt-bindings/sound/qcom,q6asm.h>
>> +    sound {
>> +        compatible = "qcom,qrb5165-rb5";
>> +        model = "Qualcomm-qrb5165-RB5-WSA8815-Speakers-DMIC0";
>> +        audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
>> +                    "SpkrRight IN", "WSA_SPK2 OUT",
>> +                    "VA DMIC0", "vdd-micb",
>> +                    "VA DMIC1", "vdd-micb",
>> +                    "MM_DL1",  "MultiMedia1 Playback",
>> +                    "MM_DL2",  "MultiMedia2 Playback",
>> +                    "MultiMedia3 Capture", "MM_UL3";
>> +
>> +        mm1-dai-link {
>> +            link-name = "MultiMedia0";
>> +            cpu {
>> +                sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
>> +            };
>> +        };
>> +
>> +        mm2-dai-link {
>> +            link-name = "MultiMedia2";
>> +            cpu {
>> +                sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
>> +            };
>> +        };
>> +
>> +        mm3-dai-link {
>> +            link-name = "MultiMedia3";
>> +            cpu {
>> +                sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
>> +            };
>> +        };
>> +
>> +        hdmi-dai-link {
>> +            link-name = "HDMI Playback";
>> +            cpu {
>> +                sound-dai = <&q6afedai TERTIARY_MI2S_RX>;
>> +            };
>> +
>> +            platform {
>> +                sound-dai = <&q6routing>;
>> +            };
>> +
>> +            codec {
>> +                sound-dai = <&lt9611_codec 0>;
>> +            };
>> +        };
>> +
>> +        wsa-dai-link {
>> +            link-name = "WSA Playback";
>> +            cpu {
>> +                sound-dai = <&q6afedai WSA_CODEC_DMA_RX_0>;
>> +            };
>> +
>> +            platform {
>> +                sound-dai = <&q6routing>;
>> +            };
>> +
>> +            codec {
>> +                sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro>;
>> +            };
>> +        };
>> +
>> +        va-dai-link {
>> +            link-name = "VA Capture";
>> +            cpu {
>> +                sound-dai = <&q6afedai VA_CODEC_DMA_TX_0>;
>> +            };
>> +
>> +            platform {
>> +                sound-dai = <&q6routing>;
>> +            };
>> +
>> +            codec {
>> +                sound-dai = <&vamacro 0>;
>> +            };
>> +        };
>> +    };
>> -- 
>> 2.21.0
>>
