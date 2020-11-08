Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19542AAAC8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 13:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKHMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 07:11:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:56446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgKHMLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 07:11:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604837458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LMxUbZmKpoftJaR4p1JKT4oaedBDHSwqphXapOjtz48=;
        b=EUV/I00AYACgE12fm4u9M/O0Tj6Jkp4uR/6sosnIyfQRS+SGQrnWyx2yGxNlXzPguXE/R+
        lb+b4ACmHCwVcNJQWwfrUXb97M5G2TLiU5vjsI/xep5osts9X0OYTyKv/qXey6p+dHYRyF
        r28PJcrwtGCgLfgmqiBnmRzjvpeGqLQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CE2FAB93;
        Sun,  8 Nov 2020 12:10:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com
Subject: [PATCH] PCI: Rockchip: output proper error message for regulator error
Date:   Sun,  8 Nov 2020 20:10:52 +0800
Message-Id: <20201108121052.240909-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regression caused by commit aea6cb99703e ("regulator: resolve
supply after creating regulator") which makes RK808 unable to register
its regulators.

This leads to vpcie1v8 and vpcie0v9 unable to be looked up, causing
rockchip pcie root controller unable to initialize.

At the same time, the dmesg shows nothing about the problem, making
debug much harder.

This patch will introduce a macro, rockchip_get_regulator(), which we
can get mandatory or optional regulator with just one line, with proper
error message when it goes wrong.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 58 ++++++++++++++-------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 9705059523a6..981ea882ba26 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -578,6 +578,33 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+#define rockchip_get_regulator(rockchip, name, optional)		\
+({									\
+	struct device *dev = rockchip->dev;				\
+	int ret = 0;							\
+									\
+	if (optional)							\
+		rockchip->name = devm_regulator_get_optional(dev,	\
+							     #name);	\
+	else								\
+		rockchip->name = devm_regulator_get(dev, #name);	\
+	if (IS_ERR(rockchip->name)) {					\
+		ret = PTR_ERR(rockchip->name);				\
+		if (ret != -ENODEV || !optional) {			\
+			dev_err(dev, "failed to get %s regulator: %d\n",\
+				#name, ret);				\
+		} else if (optional) {					\
+			dev_info(dev, "no %s regulator found, skip\n",	\
+				 #name);				\
+			ret = 0;					\
+		}							\
+	}								\
+	ret;								\
+});
+
+#define OPTIONAL	true
+#define MANDATORY	false
+
 /**
  * rockchip_pcie_parse_host_dt - Parse Device Tree
  * @rockchip: PCIe port information
@@ -586,7 +613,6 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
  */
 static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 {
-	struct device *dev = rockchip->dev;
 	int err;
 
 	err = rockchip_pcie_parse_dt(rockchip);
@@ -597,29 +623,21 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 	if (err)
 		return err;
 
-	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
-	if (IS_ERR(rockchip->vpcie12v)) {
-		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
-			return PTR_ERR(rockchip->vpcie12v);
-		dev_info(dev, "no vpcie12v regulator found\n");
-	}
+	err = rockchip_get_regulator(rockchip, vpcie12v, OPTIONAL);
+	if (err)
+		return err;
 
-	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
-	if (IS_ERR(rockchip->vpcie3v3)) {
-		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
-			return PTR_ERR(rockchip->vpcie3v3);
-		dev_info(dev, "no vpcie3v3 regulator found\n");
-	}
+	err = rockchip_get_regulator(rockchip, vpcie3v3, OPTIONAL);
+	if (err)
+		return err;
 
-	rockchip->vpcie1v8 = devm_regulator_get(dev, "vpcie1v8");
-	if (IS_ERR(rockchip->vpcie1v8))
-		return PTR_ERR(rockchip->vpcie1v8);
+	err = rockchip_get_regulator(rockchip, vpcie1v8, MANDATORY);
+	if (err)
+		return err;
 
-	rockchip->vpcie0v9 = devm_regulator_get(dev, "vpcie0v9");
-	if (IS_ERR(rockchip->vpcie0v9))
-		return PTR_ERR(rockchip->vpcie0v9);
+	err = rockchip_get_regulator(rockchip, vpcie0v9, MANDATORY);
 
-	return 0;
+	return err;
 }
 
 static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
-- 
2.29.2

