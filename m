Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915122DABA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgLOLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgLOLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:07:47 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1033C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:07:00 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so20521756edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=E/kGG23CuugXLZck5NSeBoHhv9wXgJjs6PBWPuEf4ek=;
        b=tjS84lj7A5dCdMOd8b8N0ew0ViF4pB9i7y1hJAIdGKDSDwcEOLN9Rx/EoNyCvU0VjS
         g1be2Ok5bTpnYvoKoQRGE7lqJHZ82XfjxQWCWGG0b1x8XpmrIEuTWOCclbrwM6SZwl11
         lFectPeRZ6/WENXtmTzG8eCEVmQv4s9JkIbg35sB1OkUbq2E+Waf4fjElvQL8bmwH8hu
         qcE/Mx1sVq1eki1/3NHb8ZjczkXl8rjaFfzxFTHcvQuj/uTPBtpzUo6vMi7WlaEf/0eE
         eEPeEKx4tKO4XbZbE+sA0OXxpzNdrUwNGRhQv2YnEms+5TTPXPxBC/0Hn+Yucujt6cyF
         7rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=E/kGG23CuugXLZck5NSeBoHhv9wXgJjs6PBWPuEf4ek=;
        b=U1g8ZqGTAcKCPIfq3zWZVt84DJQF6jaoHryVK3zt8SFyjyVkdGlmuzFRu0Hke2SZBZ
         J1BuH0m3Gc1yOgetItO9o3CHCZU6yqGv9q4+m+QaN1toBTAFFGJju/8SzXKmSZaEgxJY
         TDwP8Yq5M6hVCfj9G24Ka/qFh+8YZK5E8c5ap9QfbOvFDS/BE+jP7sB0rq2f6lZg9guw
         oXxIj81q/Jb/LTOGKIAOgaHTBjwnu9otGdwpKwHdcfAhOgzEp1A5rIanEBVlb94jDZ0Y
         /NATDn9Q7PflfDuL6vii0UbCvkfh/AF9M2vgYZUd4aBVCod/EEW7Oq/8XmJaGOjTxCfo
         XnXA==
X-Gm-Message-State: AOAM530FE0hneGyok5gYUv6bOeVVbsYEvNtDNpZ5q9ScHnMcRLLPC/Qe
        jJxWNdBG6vJmroX6ywddul0v1w==
X-Google-Smtp-Source: ABdhPJxodm7zMu059raAbyVPwN1yyu3J57f2oGupv5Nhnn7WQ0KXyvDt6Oa5wkgRHMZmWbh0hhjMHw==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr28854817edk.377.1608030419495;
        Tue, 15 Dec 2020 03:06:59 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id h16sm1096134eji.110.2020.12.15.03.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 03:06:58 -0800 (PST)
References: <20201207095346.26297-1-jbrunet@baylibre.com>
 <20201207095346.26297-3-jbrunet@baylibre.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: meson: vim3: enable hdmi audio loopback
In-reply-to: <20201207095346.26297-3-jbrunet@baylibre.com>
Message-ID: <1jr1nr1g6m.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 15 Dec 2020 12:06:57 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 07 Dec 2020 at 10:53, Jerome Brunet <jbrunet@baylibre.com> wrote:

> Enable audio capture frontends and a tdm decoder.
> This makes it possible to loopback the audio played on the hdmi codec,
> which is the only output interface at the moment.
>
> Of course, one TODDR device would be enough to do that but since
> the 3 FRDDRs are enabled on the playback side, let's do the same on the
> capture side.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 41 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 12465c4becc7..4cf2c193d168 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -166,11 +166,16 @@ hdmi_connector_in: endpoint {
>  	sound {
>  		compatible = "amlogic,axg-sound-card";
>  		model = "G12B-KHADAS-VIM3";
> -		audio-aux-devs = <&tdmout_a>;
> +		audio-aux-devs = <&tdmin_a>, <&tdmout_a>;
>  		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>  				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
>  				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> -				"TDM_A Playback", "TDMOUT_A OUT";
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMIN_A IN 1", "TDM_A Capture",

Oops this is wrong

> +				"TDMIN_A IN 3", "TDM_A Loopback",

And this correct for the vim3 but not the vim3l ...
Please don't take this patch. Patch 1 can still be applied though.

> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT";
>  
>  		assigned-clocks = <&clkc CLKID_MPLL2>,
>  				  <&clkc CLKID_MPLL0>,
> @@ -193,8 +198,20 @@ dai-link-2 {
>  			sound-dai = <&frddr_c>;
>  		};
>  
> -		/* 8ch hdmi interface */
>  		dai-link-3 {
> +			sound-dai = <&toddr_a>;
> +		};
> +
> +		dai-link-4 {
> +			sound-dai = <&toddr_b>;
> +		};
> +
> +		dai-link-5 {
> +			sound-dai = <&toddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-6 {
>  			sound-dai = <&tdmif_a>;
>  			dai-format = "i2s";
>  			dai-tdm-slot-tx-mask-0 = <1 1>;
> @@ -209,7 +226,7 @@ codec {
>  		};
>  
>  		/* hdmi glue */
> -		dai-link-4 {
> +		dai-link-7 {
>  			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>  
>  			codec {
> @@ -449,10 +466,26 @@ &tdmif_a {
>  	status = "okay";
>  };
>  
> +&tdmin_a {
> +	status = "okay";
> +};
> +
>  &tdmout_a {
>  	status = "okay";
>  };
>  
> +&toddr_a {
> +	status = "okay";
> +};
> +
> +&toddr_b {
> +	status = "okay";
> +};
> +
> +&toddr_c {
> +	status = "okay";
> +};
> +
>  &tohdmitx {
>  	status = "okay";
>  };

