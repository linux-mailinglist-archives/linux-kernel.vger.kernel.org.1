Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8293B2F072B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAJMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJMZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:25:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F013224D2;
        Sun, 10 Jan 2021 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610281488;
        bh=X1qUIEYc3YCrEbL5H65OA6kfb+Zk0PZj29+V9NliGuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgmYry9fJvF5BxlInIafB1JtzlEnVGWZ9wi2Rs6+w0qHtHyAcCpKnF1CDmNHq0RDk
         paHTabtkeB8pn/xoUATF2hQs5W0MSNGiawGfbmgS2/IW+0/Zv+x7J1OUxPpju/ucvE
         qsRrMpu+ikB0rc6n2XQEljaF526JFvK3fCf2HSt17WiuJTIpbsNuIER3WdGR1RgV96
         /fM2vpYIIc4mZz/yQVsPITYM2PTLgiX4yPGrn+69NvAYMRucdqEuur/S9i8CFLzxIF
         hwsFW5qYZml67EvuykVBsQcHbmZ4uupXbOD31lOz92/PaEl90fKNIDoyzylOAPLSZG
         ijKgqgsnvUw1g==
Date:   Sun, 10 Jan 2021 20:24:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <20210110122440.GJ28365@dragon>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <a930ccca2f9a5dc49f24c46c3f4280c4de960f9d.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a930ccca2f9a5dc49f24c46c3f4280c4de960f9d.1608216796.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Applied, thanks.
