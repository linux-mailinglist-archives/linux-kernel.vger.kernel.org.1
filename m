Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92C4279EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgI0Gkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0Gko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:40:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC8C0613CE;
        Sat, 26 Sep 2020 23:40:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so2184742wmh.1;
        Sat, 26 Sep 2020 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJ0ZHS1d57KNEY4Rx6TKOmB7vVLfoBeCqrt2wDIdNtk=;
        b=m9OoNcRQNZooTEb4teSobF3LcOgbpTj4WOqdwWP27lM4sraesDSZH+/BxJ5gsvkTov
         VLDGQ+ixNT38/VMZfhzK7SuWh95iIvNlWb1APBVi1+m+2vaDbs9BXiXVTurgoL0j7AlZ
         vw7h/JsXRqRWmfcv+edaJNy6kWNnzlB9HtxYNBs37TNwiISSGWAyLsZJj473K3QzTuyF
         VSN52StNylDXRRJxVDT7XMUqlLz5xSnCiYI6vJcBXh6J9wbBPqHFotwir6qfv5CCMlHe
         RLv0XkwBn/godp+65kLiS29LFq5hM83QwnO5JyRULMtpNXhquENjoqRSj3ZxZf6U0n8z
         eT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJ0ZHS1d57KNEY4Rx6TKOmB7vVLfoBeCqrt2wDIdNtk=;
        b=FtttwPRdID3VcgdegaeotSxGHxQNKLeUnaSIJ7Ddi8rY2h8x9mfz7mh3+4sWw+z+vj
         HfYQpntCVkbG2VHMxvCX3jT041T5CKYMdTYdS+6MYxy8XHSd9o41fclQ+1Y0jqBa71xw
         rBsySTNW2YWODQgUeBcGMQKnmYYL5LMIjke9CVf0Ep8hDQSiQaAcTUIjQSRlCTPLTZWt
         WlrG+uGK/jAya84i/QgOoBX5LapLqsR9iI89n1kgtt2bbBgYiqX5noNJlyfZAX4s8llL
         eg9p2pfbWuauDVCXM/2L5oVdUepLOQ48OnB+iysq7M+27O5g+jWiA5ct++BUVWlEicb7
         dj1w==
X-Gm-Message-State: AOAM531rW+0HGOrY1ui5JxlZvFImZTt0o9OOrBK0l/T8rPuIOh6HnKMB
        OFZVT7cxu0+tgUN8Sp8wgrXDS7clW4A0hg==
X-Google-Smtp-Source: ABdhPJxPu+dWl9yY0rdy3vNrFImQ/VjUrE+tVgYd+lOrHIs/cnPpyg7IVN4raXECRwNUK7xcBoWZGg==
X-Received: by 2002:a7b:c938:: with SMTP id h24mr5780867wml.142.1601188843088;
        Sat, 26 Sep 2020 23:40:43 -0700 (PDT)
Received: from mamamia.internal (a89-183-16-81.net-htp.de. [89.183.16.81])
        by smtp.gmail.com with ESMTPSA id 70sm4803531wme.15.2020.09.26.23.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 23:40:42 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: De-duplicate eMMC
 definitions
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200925085043.16389-1-pali@kernel.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <a02747f7-8c9d-d445-fac3-afefe3a8ff4e@gmail.com>
Date:   Sun, 27 Sep 2020 08:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200925085043.16389-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 10:50, Pali Rohár wrote:
> eMMC definitions in files armada-3720-espressobin-emmc.dts and
> armada-3720-espressobin-v7-emmc.dts is same. So move it into common
> armada-3720-espressobin.dtsi file with status "disabled".
> 
> This change simplifies eMMC variants of DTS files for Espressobin.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Andre Heider <a.heider@gmail.com>
Tested-by: Andre Heider <a.heider@gmail.com>

> ---
> Compiled DTB files armada-3720-espressobin-emmc.dtb and
> armada-3720-espressobin-v7-emmc.dtb are identical as without applying
> this patch.
> 
> Files armada-3720-espressobin.dtb and armada-3720-espressobin-v7.dtb
> are slightly different compared to version without this patch.
> 
> Main change is that numering in all "phandle" nodes is shifted and
> "sdhci0" node contains more attributes, but node is disabled.
> 
> 
> Andre, could you test this change on Espressobin (without eMMC) if
> everything is OK and there is no issue?

Look good to me, the node appears with status=disabled and everything 
seems to work as before.

> 
> ---
>   .../marvell/armada-3720-espressobin-emmc.dts  | 18 --------------
>   .../armada-3720-espressobin-v7-emmc.dts       | 18 --------------
>   .../dts/marvell/armada-3720-espressobin.dtsi  | 24 +++++++++++++++++++
>   3 files changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> index ec72a11ed80f..5c4d8f379704 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> @@ -21,24 +21,6 @@
>   		     "marvell,armada3720", "marvell,armada3710";
>   };
>   
> -/* U11 */
>   &sdhci0 {
> -	non-removable;
> -	bus-width = <8>;
> -	mmc-ddr-1_8v;
> -	mmc-hs400-1_8v;
> -	marvell,xenon-emmc;
> -	marvell,xenon-tun-count = <9>;
> -	marvell,pad-type = "fixed-1-8v";
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc_pins>;
>   	status = "okay";
> -
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	mmccard: mmccard@0 {
> -		compatible = "mmc-card";
> -		reg = <0>;
> -	};
>   };
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 6062a7df7342..4775a7eda481 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -36,24 +36,6 @@
>   	label = "wan";
>   };
>   
> -/* U11 */
>   &sdhci0 {
> -	non-removable;
> -	bus-width = <8>;
> -	mmc-ddr-1_8v;
> -	mmc-hs400-1_8v;
> -	marvell,xenon-emmc;
> -	marvell,xenon-tun-count = <9>;
> -	marvell,pad-type = "fixed-1-8v";
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc_pins>;
>   	status = "okay";
> -
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	mmccard: mmccard@0 {
> -		compatible = "mmc-card";
> -		reg = <0>;
> -	};
>   };
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 3169a820558f..8a1c678bea5f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -58,6 +58,30 @@
>   	phy-names = "sata-phy";
>   };
>   
> +/* U11 */
> +&sdhci0 {
> +	/* Main DTS file for Espressobin is without eMMC */
> +	status = "disabled";
> +
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,xenon-emmc;
> +	marvell,xenon-tun-count = <9>;
> +	marvell,pad-type = "fixed-1-8v";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc_pins>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	mmccard: mmccard@0 {
> +		compatible = "mmc-card";
> +		reg = <0>;
> +	};
> +};
> +
>   /* J1 */
>   &sdhci1 {
>   	wp-inverted;
> 

