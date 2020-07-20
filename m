Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF63225C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGTJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 05:58:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13275 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgGTJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:58:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f156aaa0000>; Mon, 20 Jul 2020 02:58:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 02:58:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Jul 2020 02:58:15 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 09:58:12 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jul 2020 09:58:12 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f156ab20003>; Mon, 20 Jul 2020 02:58:12 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [PATCH V5 7/7] phy: tegra: xusb: Enable charger detect for Tegra210
Date:   Mon, 20 Jul 2020 15:25:48 +0530
Message-ID: <1595238948-20531-8-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595238948-20531-1-git-send-email-nkristam@nvidia.com>
References: <1595238948-20531-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595239083; bh=IRmodFgyrsXFxwmr8S2hl3grV6926jU80x+Tbe9U/28=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XRicwZmvpGt3VEp6DBRasSUhZZUYsKeP6u34EyMI6tCGulqh+rehpkIDOQ2RyWfZr
         SQfLSrSrey154uE9R1KwprXURsTMfPp+UrvjAGjaCJS5UDxpuz6FHgB6rZVaAugtr+
         pKXzB4U2VdwoZ0CyClMt4oQWRYpx6eBWFhjfdkOWKa5Jrdf2ouU66eboW2GbCI56vB
         bPdVXv+lJxuTZTyx58WelhLntMmRpf6y3K8aIHDjDhwkiXzRm4Yyg4zzKLbYpiyT7E
         GbrwyM2FlkWz5+tJjY2enk41mS1iNS13Anrx1N9+2RWi/iw5NqJYzwAGBZsoeG2ZpZ
         7eynERyurlCYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 SoC supports charger detect, set corresponding soc flag.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4-V5:
 - No changes
---
V3:
 - Used supports_charger_detect name instead of charger_detect.
 - Added Acked-by updates to commit message.
---
V2:
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 3aff284..86c2149 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -2353,6 +2353,7 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 	.supply_names = tegra210_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
 	.need_fake_usb3_port = true,
+	.supports_charger_detect = true,
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
-- 
2.7.4

