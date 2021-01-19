Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699382FB6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbhASJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:24:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12791 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbhASI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:56:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60069ea00000>; Tue, 19 Jan 2021 00:56:00 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 08:55:58 +0000
Received: from jckuo-lt.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Jan 2021 08:55:55 +0000
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v6 02/15] clk: tegra: Don't enable PLLE HW sequencer at init
Date:   Tue, 19 Jan 2021 16:55:33 +0800
Message-ID: <20210119085546.725005-3-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119085546.725005-1-jckuo@nvidia.com>
References: <20210119085546.725005-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611046560; bh=gguPJ5VOzO9Vc3llEbIEJZuHhChUK6oYDayYAJFTFkY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=AEQf96b6t3e48HhCcymBZfArgK8iHjQ7FejHKvkNmh8CaDA5O3u+YLwGyGy6Ze3Q5
         NI6sJ9OxOo5E4zUEZioJDAuonbSCXQElXvf6N1C9gao97oGu3uS0gMhzpqv0MG45dj
         B78U4loL7q1RXUYIwcl+VfZdmyB/9jBf1z3ZC7B1lWy7Fr9A+lYE1Bs1bSmMSnup+s
         GhflA2OefSfKFU/+rQlU+f+4vovVfYVprlpv8KsUb8rDlFi60Leu9SEY4Pn0cCH4V5
         Ns32p2jM3PSudl8YsY6iuZ+PdW/MBngwFvNBs7Qe0lZSGiSbyMNrc7NUfJaPIIiwxQ
         pKOsEUuG7BcRQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLLE hardware power sequencer references PEX/SATA UPHY PLL hardware
power sequencers' output to enable/disable PLLE. PLLE hardware power
sequencer has to be enabled only after PEX/SATA UPHY PLL's sequencers
are enabled.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v6:
   no change
v5:
   no change
v4:
   no change=20
v3:
   no change

 drivers/clk/tegra/clk-pll.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index c5cc0a2dac6f..0193cebe8c5a 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -2515,18 +2515,6 @@ static int clk_plle_tegra210_enable(struct clk_hw *h=
w)
 	pll_writel(val, PLLE_SS_CTRL, pll);
 	udelay(1);
=20
-	val =3D pll_readl_misc(pll);
-	val &=3D ~PLLE_MISC_IDDQ_SW_CTRL;
-	pll_writel_misc(val, pll);
-
-	val =3D pll_readl(pll->params->aux_reg, pll);
-	val |=3D (PLLE_AUX_USE_LOCKDET | PLLE_AUX_SS_SEQ_INCLUDE);
-	val &=3D ~(PLLE_AUX_ENABLE_SWCTL | PLLE_AUX_SS_SWCTL);
-	pll_writel(val, pll->params->aux_reg, pll);
-	udelay(1);
-	val |=3D PLLE_AUX_SEQ_ENABLE;
-	pll_writel(val, pll->params->aux_reg, pll);
-
 out:
 	if (pll->lock)
 		spin_unlock_irqrestore(pll->lock, flags);
--=20
2.25.1

