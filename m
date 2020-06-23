Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC32047AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 04:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbgFWCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 22:53:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbgFWCvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3925CAE84;
        Tue, 23 Jun 2020 02:51:32 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 06/29] soc: realtek: chip: Detect RTD1296
Date:   Tue, 23 Jun 2020 04:50:43 +0200
Message-Id: <20200623025106.31273-7-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detection logic from downstream drivers/soc/realtek/rtd129x/rtk_chip.c.

Acked-by: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 TODO: Name the bit in ISO_CHIP_INFO1:bound_opts.
 
 v1 -> v2:
 * Instead of direct iso register access use the new syscon regmap
 
 drivers/soc/realtek/chip.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index c4650d512c91..103f564aad7f 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -23,6 +23,8 @@
 
 #define SB2_CHIP_INFO_REVISE_ID		GENMASK(31, 16)
 
+#define REG_ISO_CHIP_INFO1	0x028
+
 struct dhc_soc_revision {
 	const char *name;
 	u16 chip_rev;
@@ -57,9 +59,32 @@ static const char *default_name(struct device *dev, const struct dhc_soc *s)
 	return s->family;
 }
 
+static const char *rtd1295_name(struct device *dev, const struct dhc_soc *s)
+{
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "iso-syscon");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		if (ret == -EPROBE_DEFER)
+			return ERR_PTR(ret);
+		dev_warn(dev, "Could not check iso (%d)\n", ret);
+	} else {
+		ret = regmap_read(regmap, REG_ISO_CHIP_INFO1, &val);
+		if (ret)
+			dev_warn(dev, "Could not read chip_info1 (%d)\n", ret);
+		else if (val & BIT(11))
+			return "RTD1296";
+	}
+
+	return "RTD1295";
+}
+
 static const struct dhc_soc dhc_soc_families[] = {
 	{ 0x6329, "RTD1195", default_name, rtd1195_revisions, "Phoenix" },
-	{ 0x6421, "RTD1295", default_name, rtd1295_revisions, "Kylin" },
+	{ 0x6421, "RTD1295", rtd1295_name, rtd1295_revisions, "Kylin" },
 };
 
 static const struct dhc_soc *dhc_soc_by_chip_id(u16 chip_id)
-- 
2.26.2

