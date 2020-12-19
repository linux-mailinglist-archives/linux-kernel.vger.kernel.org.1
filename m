Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913552DEEBA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgLSM0F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Dec 2020 07:26:05 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:38688 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgLSM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:26:04 -0500
Received: by mail-ej1-f41.google.com with SMTP id 6so7083423ejz.5;
        Sat, 19 Dec 2020 04:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zZ7EJLys01DqzuUR6ipCHgKdEulJwYjJt2zUkoSoVlg=;
        b=mmU32fFUGQj5XYDP17A9OkUISxxC2axT1RCd1CIG+imIQa7XIYWVs2uJWx3bdQ281o
         zOUoznaXFW1m9W2OYGXK16c/RVkdd7pHmah5RvPhrMdzkcBHxFD4HVN5qIezgMWBEenu
         PtKDLjJdNSGjp2rSl8IE12x1jM5Hwm1S1A4nx1G81o9BWotxM6u9/BvG0r7Od36NoiRl
         kYcgbep6CwxobSgX4N0K5la6caGyjdcnsc8pyAfRawyS0EPxX2fK0VnlbE8pCvsCGfrf
         PnV+g78wPWphSHR1ljb5EUtSpfDFw7rV6d7NbhfB9oLolTfUqVvgyNGHE3f+5bf6/3bI
         Ifsw==
X-Gm-Message-State: AOAM5333mIjbQaEjG734tvo7InUpaBqd70aNldVngXMP9fG6qA90ymxj
        06U8MmSTVFg0xUEww81k7Kk=
X-Google-Smtp-Source: ABdhPJxB9snOTiP8vZlki6mdO9xk6/iWgpkCOj0trDktPJIhoezGqW54fLsiuKTpuOOcR05REra48w==
X-Received: by 2002:a17:906:c1c6:: with SMTP id bw6mr8326821ejb.199.1608380722051;
        Sat, 19 Dec 2020 04:25:22 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id bn21sm6807810ejb.47.2020.12.19.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:25:21 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:25:19 +0100
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
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5-devkit: Tweak pmic
 regulators
Message-ID: <20201219122519.GG13886@kozik-lap>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <a930ccca2f9a5dc49f24c46c3f4280c4de960f9d.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a930ccca2f9a5dc49f24c46c3f4280c4de960f9d.1608216796.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:13:13PM +0100, Guido Günther wrote:
> BUCK3 needs a regulator-enable-ramp-delay since otherwise the board
> freezes on etnaviv probe. With this pgc_gpu suspends and resumes as
> expected. This must have been always broken since gpcv2 support was
> enabled.
> 
> We also enable all the regulators needed for Deep Sleep Mode (DSM) as
> always-on:
> 
> - VDD_SOC supplied by BUCK1
> - VDDA_1P8 supplied by BUCK7
> - VDDA_0P9 supplied by LDO4
> - VDDA_DRAM supplied by LDO3
> - NVCC_DRAM supplied by BUCK8
> - VDD_DRAM supplied by BUCK5
> 
> Finally LDO5 and LDO6 provide VDD_PHY_1V8 and VDD_PHY_0V9 used by the
> SOCs MIPI, HDMI and USB IP cores. While we would in theory be able to
> turn these off (and I've tested that or LDO6 and mipi with USB disabled)
> it is of little practical use atm since USB doesn't runtime suspend so
> let's revisit this at a later point.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../boot/dts/freescale/imx8mq-librem5-devkit.dts      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
