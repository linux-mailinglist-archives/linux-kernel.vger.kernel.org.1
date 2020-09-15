Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA526AE09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgIOTto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:49:44 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34424 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgIORLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:11:10 -0400
Received: by mail-il1-f194.google.com with SMTP id a8so3743929ilk.1;
        Tue, 15 Sep 2020 10:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFviqgFIWRut0eU0K6H+y+f/pPgiXCv3xoSL8tn8HHs=;
        b=kwkMWCE4+Q+I2TkUrTJmXLoygnJ+0BmJqr0nKQr0SHWQx35SvVNwA6BmkzqyhFFC5I
         36GZGhbBSfCsm0rSIpa6ZErrsBU4o220BGDoHqUeiYUBLCFt4Or7wigdf1bKkP96gEUG
         r3V7H0rOSK8TAMD288FQHniqcDUOyMUu0Q1j5jTDV8R8Rvjv+9/3KHp0Wb8l+f906MNc
         rmKq8BXm6edBgbu1ENW0sZX3MNsIM890WSHKzfxQkjvWkkf4cIy6kSOjCZB//ubdGsVK
         A2fLhkGRGkMAw7uQQmNu8Zb5ic4MpEma3Eb0eyqlV8yhdp0pGjZ8031GE9XDR5lbIvH1
         kUcg==
X-Gm-Message-State: AOAM530X3f6IiPDb73BajVVCykv+LoeuGy9P1eQTiXWpROjEZ+aq7XEY
        YVfbeVx0jwmOHUAm4b77eFVpb4QRKlkm7Eo=
X-Google-Smtp-Source: ABdhPJwlOK3415SZU7crEdleYLmA5Xut63SzqKMQt4DXj3NOqdQUDv7Z1Gs9HZKBmjrRx8Wu+CD9eA==
X-Received: by 2002:a5d:840a:: with SMTP id i10mr15791731ion.4.1600189202340;
        Tue, 15 Sep 2020 10:00:02 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r5sm9320455ilc.2.2020.09.15.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:00:01 -0700 (PDT)
Received: (nullmailer pid 2122994 invoked by uid 1000);
        Tue, 15 Sep 2020 16:59:58 -0000
Date:   Tue, 15 Sep 2020 10:59:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Subject: Re: [PATCH v4 2/5] ASoC: dt-bindings: Add dt binding for lpass hdmi
Message-ID: <20200915165958.GA2118432@bogus>
References: <1599587037-6742-1-git-send-email-srivasam@codeaurora.org>
 <010101746ed1d41a-5890a534-9c2c-4203-bce5-46075d7827da-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101746ed1d41a-5890a534-9c2c-4203-bce5-46075d7827da-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 05:44:39PM +0000, Srinivasa Rao Mandadapu wrote:
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> 
> Adds bindings for lpass hdmi interface
> which can support audio path over dp.
> 
> Signed-off-by: Srinivasa Rao <srivasam@codeaurora.org>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 51 ++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> index 09c9bd2..7c2ac0c 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> @@ -22,6 +22,7 @@ properties:
>        - qcom,lpass-cpu
>        - qcom,apq8016-lpass-cpu
>        - qcom,sc7180-lpass-cpu
> +      - qcom,sc7180-lpass-hdmi
>  
>    reg:
>      maxItems: 1
> @@ -60,10 +61,12 @@ properties:
>      const: 0
>  
>  patternProperties:
> -  "(^mi2s-[0-9a-f]$|mi2s)":
> +  "^dai@[0-9a-f]$":
>      type: object
> -    description: Required properties for each DAI
> -
> +    description: |
> +      LPASS CPU dai node for each I2S device. Bindings of each node
> +      depends on the specific driver providing the functionality and
> +      properties.
>      properties:
>        reg:
>          maxItems: 1
> @@ -145,6 +148,22 @@ allOf:
>          - iommus
>          - power-domains
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
>  examples:
>    - |
>      #include <dt-bindings/sound/sc7180-lpass.h>
> @@ -178,12 +197,36 @@ examples:
>              #address-cells = <1>;
>              #size-cells = <0>;
>              /* Optional to set different MI2S SD lines */
> -            mi2s-primary@0 {
> +            dai@mi2s-primary {

The unit address should be a number.

As this is not failing checks, then you are missing an 
'additionalProperties: false'.

>                  reg = <MI2S_PRIMARY>;
>                  qcom,playback-sd-lines = <1>;
>                  qcom,capture-sd-lines = <0>;
>              };
>          };
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
>      };
>  
>  ...
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
