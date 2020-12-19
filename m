Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4057C2DEEB6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLSMYP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Dec 2020 07:24:15 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:36865 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgLSMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:24:13 -0500
Received: by mail-ej1-f45.google.com with SMTP id ga15so7094972ejb.4;
        Sat, 19 Dec 2020 04:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1SgvVIKqtLbX962dHPjPKKjppmglPFbNo/Ixnq6OHrA=;
        b=Da4XxCcho/nlxpgUHoOQZjtdc+tdh5WBHES/A1Q7rCUmg5aCTBR1KpUG12tZfx82Mp
         2o3CSy15V6/O/IdRdZrunvQCHV79ZO4F4i/ZfZxh/UOFjDT4hijZ9C+lcW5JgZuavMej
         x+4smt8qAVDJ8AHFWr5BwqBzaqJtyJwgovkFQ/60iLh9u6a1PipFg1YWA3Mp95PRnSpJ
         ItGTTEqg9SEm3j0oGXrCHwQK19jsTB8UIgxWZJUCDtuDYyAz6d6VDJlUMWNp0skYG8za
         3+rIQUJR0CmdfltRBBYHltCqpf/U2QpedY2PlJLNYBgRLpaHUBoBI6bw7QKXIyVGzOvL
         OqSQ==
X-Gm-Message-State: AOAM530PoPYxhFTuO+84PWWwc3Ogz/untGU76uEjqseOFaeDgJAmadrI
        DjJK0T0eB7AuExRKegUVTf0=
X-Google-Smtp-Source: ABdhPJzig+n69PCVXpe0WbOgbniF4CUUNfeu931xkjzwc7zYqcPzHgUy1CkMHh7l9UjvT7n2owy/9A==
X-Received: by 2002:a17:906:8151:: with SMTP id z17mr8375380ejw.48.1608380611520;
        Sat, 19 Dec 2020 04:23:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e11sm6693365ejz.94.2020.12.19.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:23:30 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:23:28 +0100
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
Subject: Re: [PATCH v2 1/4] arm64: defconfig: Enable Librem 5 devkit
 components
Message-ID: <20201219122328.GE13886@kozik-lap>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <2f23f8a4fd7ccfbb4cacf933dcaebe7d38facdfe.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2f23f8a4fd7ccfbb4cacf933dcaebe7d38facdfe.1608216796.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:13:12PM +0100, Guido Günther wrote:
> The Librem 5 devkit is based on NXP's i.MX8MQ. Schematics are at
> https://source.puri.sm/Librem5/dvk-mx8m-bsb.
> 
> This enables drivers for the following hardware components that aren't
> yet enabled in defconfig:
> 
> - Goodix GT5688 touchscreen
> - iMX8MQ's PWM for the LCD backlight
> - TI BQ25896 charge controller
> - NXP SGTL5000 audio codec
> - Microcrystal RV-4162-C7 RTC
> - magnetometer: CONFIG_IIO_ST_MAGN_3AXIS
> - the SIMCom SIM7100E/A modem
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/configs/defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
