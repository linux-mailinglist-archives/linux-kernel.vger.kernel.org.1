Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F308F25D694
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgIDKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgIDKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:41:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261CC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 03:41:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so6238301wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGBcS2K0ImWeFfrWpXAI/Xo9a8mhl/De79Zkj63qpo8=;
        b=A8RehVNj2xNOT/YL0vidlBxy+xDK9yHRYixalgDgUzpDo0b2eWBf91ky71RbcCgfLI
         DSUxy5yGwMgvxqu2EHmf6TyyQKvfmM8vyx21XwUgomecbTqPw+Bu7ifHxTDobz3xrrSN
         Kw6co+OlPpAwUfCQuG9m6IsytM808G+9eMJPWCVrbeEXbf4uIyxfN6l/4SuLfQRK8jAm
         ZrixQptcS2fmcPcDzTkuA3kiZBb33JUdnadF/BvwS1Tw1e+wM2peYT7wSutrbzLMyiJ3
         ahIiKveyR3l8fkxoFDO6OV+EMlf5kFbj0OdiL8M+3esTGP23zrwqxWayWnzK3lpPbsP3
         UAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGBcS2K0ImWeFfrWpXAI/Xo9a8mhl/De79Zkj63qpo8=;
        b=WW9F+5KeQD663/yvEz/qyGzcegbkrb/r8rIDgHFsyvV9nvHrIg+084OvuntS7KI4MT
         x0OqF3vmlfOz6x1MWzkUF65zdoRKMmpBVuw2cP8DncJzmmEiZ7N2NLGA6F9yAIo2poHn
         kAx36UL0dyRwADOAKkO/63iXFgnhuqj5aU8NCiY7o9C38vkaQIh6AgG9TXpvl7GjfHsy
         zuEqCLhE31HmkT29TapA1Kp9XU9hPeKReRsNOx+8Iu+z3FxQx8jdFOMo0p/OuBN0NVn1
         GAkvBFawAmCd7J2xIcTH7gjZeCUtrRLmZ5jDkLRjv/airx2OD6Vs/GqhS4TYOBzlY4/z
         Gcgg==
X-Gm-Message-State: AOAM5333aClzEhoHOy63Z/gP4JoXtKODT5vdKGNHRN1E/n+8C9dixRAI
        66x5xz2/RRpcxEu6m0UaJsa74g==
X-Google-Smtp-Source: ABdhPJyYDoIzAUGsvrlxti84wRUhnYjSfHM11wVKMy+B6EhxhYo/CAqxDEzFb+cyF2MVww28hUddEQ==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr6771808wrm.216.1599216063406;
        Fri, 04 Sep 2020 03:41:03 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id h2sm10621197wrp.69.2020.09.04.03.41.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 03:41:02 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] ASoC: dt-bindings: Add dt binding for lpass hdmi
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
References: <1598855964-1042-1-git-send-email-srivasam@codeaurora.org>
 <1598855964-1042-3-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0aa914dd-6a6e-208d-d29f-214a84dfd8a2@linaro.org>
Date:   Fri, 4 Sep 2020 11:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1598855964-1042-3-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/08/2020 07:39, Srinivasa Rao Mandadapu wrote:
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> 
> Adds bindings for lpass hdmi interface
> which can support audio path over dp.
> 
> Signed-off-by: Srinivasa Rao <srivasam@codeaurora.org>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> ---
>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 51 ++++++++++++++++++++--
>   1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> index 09c9bd2..7c2ac0c 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> @@ -22,6 +22,7 @@ properties:
>         - qcom,lpass-cpu
>         - qcom,apq8016-lpass-cpu
>         - qcom,sc7180-lpass-cpu
> +      - qcom,sc7180-lpass-hdmi

Why do we need a new compatible per interface, IMO, you should just use 
the existing compatible.
Or please explain the reasons why we need this?

>   
>     reg:
>       maxItems: 1
> @@ -60,10 +61,12 @@ properties:
>       const: 0
>   
>   patternProperties:
> -  "(^mi2s-[0-9a-f]$|mi2s)":
> +  "^dai@[0-9a-f]$":
>       type: object
> -    description: Required properties for each DAI
> -
> +    description: |
> +      LPASS CPU dai node for each I2S device. Bindings of each node
> +      depends on the specific driver providing the functionality and
> +      properties.
>       properties:
>         reg:
>           maxItems: 1
> @@ -145,6 +148,22 @@ allOf:
>           - iommus
>           - power-domains
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sc7180-lpass-hdmi
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pcnoc-sway-clk
> +            - const: audio-core
> +            - const: pcnoc-mport-clk
> +      required:
> +        - iommus
> +        - power-domains
> +
>   examples:
>     - |
>       #include <dt-bindings/sound/sc7180-lpass.h>
> @@ -178,12 +197,36 @@ examples:
>               #address-cells = <1>;
>               #size-cells = <0>;
>               /* Optional to set different MI2S SD lines */
> -            mi2s-primary@0 {
> +            dai@mi2s-primary {
>                   reg = <MI2S_PRIMARY>;
>                   qcom,playback-sd-lines = <1>;
>                   qcom,capture-sd-lines = <0>;
>               };
>           };
> +
> +        lpassh@62d87000 {
> +            compatible = "qcom,sc7180-lpass-hdmi";
> +
> +            reg = <0 0x62d87000 0 0x68000>;
> +
> +            iommus = <&apps_smmu 0x1032 0>;
> +
> +            power-domains = <&lpass_hm 0>;
> +
> +            clocks = <&gcc 131>,
> +                 <&lpasscc 6>,
> +                 <&lpasscc 10>;
> +
> +            clock-names = "pcnoc-sway-clk", "audio-core",
> +                          "pcnoc-mport-clk";
> +
> +            #sound-dai-cells = <1>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            interrupts = <0 268 1>;
> +        };
>       };
>   
>   ...
> 
