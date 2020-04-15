Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2291A9671
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894555AbgDOI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:28:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4463 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894488AbgDOI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:27:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96c49c0000>; Wed, 15 Apr 2020 01:23:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 01:25:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 01:25:45 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 08:25:45 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Apr 2020 08:25:45 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e96c5050001>; Wed, 15 Apr 2020 01:25:44 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V2 7/8] phy: tegra: xusb: Enable charger detect for Tegra186
Date:   Wed, 15 Apr 2020 13:55:07 +0530
Message-ID: <1586939108-10075-8-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586939036; bh=NFF4rNyK1bxZi46MjrBDC+rV9hWDW87mBhP0TbbGgTA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mk01WjuZWgabl8Wy/fkvjv+ayfW5bgYmcF+pYBmsNhgjaa+VOyrFXHUbz6BQHacU5
         tzif5yOp2K6WtRLenXrgyZIm4vftNJsgZ6fU2BFH3iHt40t+f8AiBa/6EATEQRD+/T
         OKn8qpNxCv1J1rDD2x5G5TnE5XUa/mnMPiDG46THt1bGSGYpSmjHrNZO5WgGwl3P/e
         0e6lKj7TXyM9+x/x4FDNZ3AIpY3rBEbN2GfHdA0dizbsqYmBvgr6yLpdt/T0ugcwyX
         vF4SP36dyi8GBbdFLVdklbN2+2qAvirR693fijsaJ0f/jQJlxeOOkb1WQvpaktXZD6
         13zQ5COLtk36Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 SoC supports charger detect, set corresponding soc flag.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 03bdb5b..12ff492 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -1041,6 +1041,7 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc = {
 	.ops = &tegra186_xusb_padctl_ops,
 	.supply_names = tegra186_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra186_xusb_padctl_supply_names),
+	.charger_detect = true,
 };
 EXPORT_SYMBOL_GPL(tegra186_xusb_padctl_soc);
 #endif
-- 
2.7.4

