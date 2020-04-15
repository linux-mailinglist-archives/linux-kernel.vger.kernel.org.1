Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96BA1A9668
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408042AbgDOI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:28:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4522 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894455AbgDOI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:27:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96c4a00000>; Wed, 15 Apr 2020 01:24:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 01:25:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 01:25:49 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 08:25:49 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Apr 2020 08:25:48 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e96c5090002>; Wed, 15 Apr 2020 01:25:48 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V2 8/8] phy: tegra: xusb: Enable charger detect for Tegra210
Date:   Wed, 15 Apr 2020 13:55:08 +0530
Message-ID: <1586939108-10075-9-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586939040; bh=055RAzmaGHUjBmQF8JPysR26eaww2SCbnUqbBC+ZFk4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=k8fQPFJ192XnwKkG4g9GVom7Z04W0MGP1M9gcjdJGRYEEIMkcAhs5WcelJNpK2QWQ
         dMYVctTvIAq2wvH3ck9xdxgX2S7ekzH1iaq2NNH2gr0RKbUNFvsawkzThv69Mh3Rcq
         VuGlhccCLB7dHhz4JxNLQDi73iwBsDPLnE04aojmyD2MqB27BnZtzj/vv7SiqDJx19
         lEU8a3la3weiHi3xDEevptnouoODmOn/Ufd1DUjKNktJmHK10QUAKMBMf3Pi7DhrXk
         6CkkPtNLZLNt6P0c4k2maXC2P2AIrq09Wplv0wUUDXN888E2s7SD6XT20REbNI80rd
         jJM3YP8Y/PUaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 SoC supports charger detect, set corresponding soc flag.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 7d84f1a..2be5201 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -2352,6 +2352,7 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 	.supply_names = tegra210_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
 	.need_fake_usb3_port = true,
+	.charger_detect = true,
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
-- 
2.7.4

