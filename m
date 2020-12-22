Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C470F2DD5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgLQRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgLQRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:12:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C3C0617B0;
        Thu, 17 Dec 2020 09:11:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so4468343pjv.5;
        Thu, 17 Dec 2020 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T1gPbGSQyXprLbcE5R+zdsGLaUZGdveusvFSwm7a4XY=;
        b=UTcP7CY8dSSzs+EPlJ1MiJvou+FdQw4D8uA7Hq6VBPuhAxRSKvdc4i1z8tl/k3YSqh
         pLxSFc+yx9J9/59ZDWfUP8V7DOprqvB8lDxZEZuhCIsmBUk1dgXdlF3k6SxcwA/NHQwZ
         z2fqNAWN+58vV8lBhc47GAGX+Dh/EBKaE6jj9str7NneCeMAKrnsY8+f789GSr569k72
         z/XX2lM+qJh5RjL82p56gq4Nm27aoiSCeuXzH3Mu5RwuzrwnpNY3G+2G1MY0AssWeEhj
         MaFJdppSALTlDC8RlIOcNvqiAGM2fMrUbBg3gtsuGJp4tPeq0ikGDD0hkjOVd37Lp5Tk
         OLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T1gPbGSQyXprLbcE5R+zdsGLaUZGdveusvFSwm7a4XY=;
        b=TtlAhOxUReE5YJcZaNWotuFPDDB6diF/+kuRVOsQ2PEaUJC47S3jsOYOJEHbPrFngz
         Gex3qAwdD/SOWobM2XKrs8MYsav1K6ggLX4SEPkR+rqA5w73BRoaQI8yMoBz/SoJeMGV
         s4WdSmKg3Hqfs4zwKuzd3MAmtjymFrtzymWQWfSh1lkeq3LrQQE0SRE6VjleQBE4Tw7e
         wDRCsVnUqn5VUeWb4Le6wYsR9PwMoyF/sGmquWqOr+puocNeOrE4cPGDwwxas/G1L6Yy
         MphiW6xQZpUq6DsnwLgnaQ3EeQU2WyPp+Wbxpt8isxXgg+SyM5vJHOLf2B9qTrTFuiMl
         pb5w==
X-Gm-Message-State: AOAM532flxxZzehIiBCTanQFmylVIJ8RRU81iVB6XHVViN4xRWne1kyU
        3e1hRJt2w2J6bsZIsXlAc6o=
X-Google-Smtp-Source: ABdhPJwmk/gYEdTzvhk87nxQcfMbRrmFSHx2WD3hI/8iYp1jNJ5KnXlduxcY1rrsmPAM/jY4NAerDw==
X-Received: by 2002:a17:902:a5c4:b029:dc:240a:8806 with SMTP id t4-20020a170902a5c4b02900dc240a8806mr311437plq.40.1608225098022;
        Thu, 17 Dec 2020 09:11:38 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o14sm1403021pgr.44.2020.12.17.09.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 09:11:37 -0800 (PST)
Subject: Re: [PATCH v3 6/6] ARM: dts: Add dts for RPi4b + Cirrus Logic
 Lochnagar2 + CS47L15
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        robh+dt@kernel.org, kuninori.morimoto.gx@renesas.com,
        nsaenzjulienne@suse.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20201217154142.24301-1-rf@opensource.cirrus.com>
 <20201217154142.24301-7-rf@opensource.cirrus.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <0b4dac1c-59dd-38cb-97ea-d352a024ccf1@gmail.com>
Date:   Thu, 17 Dec 2020 09:11:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217154142.24301-7-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 7:41 AM, 'Richard Fitzgerald' via
BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> This adds a devicetree configuration for Raspberry Pi 4b connected to
> Cirrus Logic Lochnagar 2 audio development board and CS47L15 codec.
> 
> The common (codec-independent) Lochnagar 2 configuration is separated
> into a dtsi to simplify re-using it for other codecs.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  MAINTAINERS                                   |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  ...bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dts | 186 ++++++++++++++++
>  .../dts/bcm2711-rpi4b-cirrus-lochnagar.dtsi   | 201 ++++++++++++++++++
>  4 files changed, 389 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dts
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5cc595ac7b28..7dca1db52144 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4193,6 +4193,7 @@ M:	Charles Keepax <ckeepax@opensource.cirrus.com>
>  M:	Richard Fitzgerald <rf@opensource.cirrus.com>
>  L:	patches@opensource.cirrus.com
>  S:	Supported
> +F:	arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar*
>  F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
>  F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
>  F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ce66ffd5a1bb..240cc58fd954 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -93,6 +93,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2837-rpi-3-b-plus.dtb \
>  	bcm2837-rpi-cm3-io3.dtb \
>  	bcm2711-rpi-4-b.dtb \
> +	bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dtb \

Is there a reason you are not following the convention established above
and have this file be named: bcm2711-rpi-4-b-cirrus-lochnagar-cs47l15.dtb?
-- 
Florian
