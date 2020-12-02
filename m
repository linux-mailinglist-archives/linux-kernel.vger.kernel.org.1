Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83D2CC147
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgLBPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgLBPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:49:26 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA3C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:48:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so9304644wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:message-id:date
         :mime-version;
        bh=aK2Yejuziy9XYpoRYVV6bzgJz5NlgVPwFHDuLLWc9Ug=;
        b=Bdjc1UwJwZGMSn7TM4F4sOv7ZcNypjDjFExNtcI88V83srE3qggHvizPjaeCEbaucL
         +aB/EW09iqQSYC720eeWbk9D2YyMm1mBOk8eFTM7tSacgqqupB3LtwiQRJN1/eP10hDI
         VaRZZ/fodJW9tcsrcSaWEP/slWcVW1cGBa3WzSnuKPIahMzbqPSjzmcmSWNzT8PyobRi
         fQ2WA7OH+P3F3Df8ulVSNXFLyrDpYBHe8nH4ijdrPjZwi/q1CqQmFoDN5h+FeQHXi6iL
         i/kUNrbmoCltJYPmzaJu/Np1q3WAURywvJ/VtHXp4hGtsiYzwD8tWJJ9XXGmiiJoL8jl
         iW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:message-id:date:mime-version;
        bh=aK2Yejuziy9XYpoRYVV6bzgJz5NlgVPwFHDuLLWc9Ug=;
        b=GwsRm5jdlCZDVMsF6fbDLZkFjfQKnO1QHLfg2007ID5VfGlxBsvnhR0E0+yWFXKgY8
         XrJEbm9PEyUTZl3fdNiwOspJOUjM2Go+V9GJQudV6D9Pr71baTseoY4Y3q3gUGhYvqSq
         ifRXy7Kf5hMngNprYYoD+lB7m27WxdmXs0M0TIj59yu1GnmRaDuYFdfEBfhVouhNfOY1
         o5czxaNFeCxUKymqZiGIQQrf+LQ8EuQLkhVTKZXGCahzWJDoTZ4wEF9xUPY6pSx3/mtl
         jUNqYYG9hVVCOgiXxUOeXqY7a1atU8sOpKZUt0VmE0czICMpJt715ZgW56TSW7tXOH76
         N+Jw==
X-Gm-Message-State: AOAM5320S5m1eMubmgSUY97F8R23MaID2uUwHdFoDbliiANQqHgPpdDO
        zNyUzi4OVAfxjACdX+W2JodXJA==
X-Google-Smtp-Source: ABdhPJz8kyT3Q+GAhoeJvRzlTWJN6+74jd9rSGhZ+vv9wugh+iaHMt7J2oHuytEnrxiyIiI1z63VYg==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr3774131wml.33.1606924118881;
        Wed, 02 Dec 2020 07:48:38 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id l8sm2630263wmf.35.2020.12.02.07.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:48:38 -0800 (PST)
References: <20201116062031.11233-1-christianshewitt@gmail.com>
 <20201116062031.11233-4-christianshewitt@gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] arm64: dts: meson: add audio playback to
 khadas-vim2
In-reply-to: <20201116062031.11233-4-christianshewitt@gmail.com>
Message-ID: <1jk0u0p5t6.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 02 Dec 2020 16:48:37 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 16 Nov 2020 at 07:20, Christian Hewitt <christianshewitt@gmail.com> wrote:

> Add initial audio support limited to HDMI i2s.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index bff8ec2c1c70..d4734220443c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -7,9 +7,9 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/input/input.h>
> -
>  #include "meson-gxm.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/sound/meson-aiu.h>

It's ok to do clean up or refactoring but it should not be done silently
or mixed with something unrelated

Same in the previous patch

>  
>  / {
>  	compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
> @@ -145,6 +145,45 @@
>  		clock-frequency = <32768>;
>  		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
>  	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "GXM-KHADAS-VIM2";
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status = "okay";
>  };
>  
>  &cec_AO {
> @@ -154,7 +193,6 @@
>  	hdmi-phandle = <&hdmi_tx>;
>  };
>  
> -

Same here

>  &cpu_cooling_maps {
>  	map0 {
>  		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;

