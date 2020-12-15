Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0B2DA9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgLOJTw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Dec 2020 04:19:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36746 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgLOJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:19:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id b2so20235075edm.3;
        Tue, 15 Dec 2020 01:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EC1tVeiWQY+DqulLx0ZrfVheJ4LDwFrt9+IjNkA/ogM=;
        b=sRvIki88Rym1uDVf53pNTZLyVv6JrBghsyikMdhv7UOIpJcAnkt0vITKuzyzAn8Syy
         sCyShoUmP1hTjTpTa8bBy5f/e121iOnQ9MraRph0tcKoPNiWQjSSpxnIqIhmgH+xY7ZV
         9yH7iRh6AOZeB34GyVwiAIw4eaxycpp6hUFs85Ar3T28A8pJCoUYDusU5CU0hzdkVy2j
         rsNSoXYhuDVzcmJZ03Y23cZ/Ax+/DLC7pL9P8f1jWCh6dcW4GVr73vhNi3LgrHEQrXFE
         fq/purHKps5NlYfC9vdFgh76KqwBA7UZsOhfdHb0Cupx/KYHa7PAZUO7uXCtU2KlZcuT
         eYxQ==
X-Gm-Message-State: AOAM5323gdL/Zy2Z+NCi42IGUAAFlAa95XVpmj7pMFrY3RATa9TzHtCg
        T4OUm38FT7RLmsSv+/8ApaM=
X-Google-Smtp-Source: ABdhPJwCMmnqLA7MYbA9s0nbI+S7+lVphN4/eZUftV1V4FpgsrzHZ5sJ6ZvmR7Cz8s14D2BOcIJbmQ==
X-Received: by 2002:a05:6402:379:: with SMTP id s25mr6894300edw.367.1608023927183;
        Tue, 15 Dec 2020 01:18:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n1sm907005ejb.2.2020.12.15.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:18:45 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:18:44 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: imx8mq-librem5-devkit: Disable snvs_rtc
Message-ID: <20201215091844.GD29321@kozik-lap>
References: <cover.1607879709.git.agx@sigxcpu.org>
 <d66739ead267a9468977801d9ad7f9f23c7de166.1607879709.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d66739ead267a9468977801d9ad7f9f23c7de166.1607879709.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 06:17:12PM +0100, Guido Günther wrote:
> The board has it's own rtc chip.

s/rtc/RTC/

Even if you have on-board RTC, why disabling the SNVS?

Best regards,
Krzysztof


> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index af139b283daf..12f5d75a5e44 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -886,6 +886,10 @@ &snvs_pwrkey {
>  	status = "okay";
>  };
>  
> +&snvs_rtc {
> +	status = "disabled";
> +};
> +
>  &sai2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai2>;
> -- 
> 2.29.2
> 
