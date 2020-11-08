Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616352AACFE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgKHSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:51:35 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:49739 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgKHSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:51:29 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 052FD23E6D;
        Sun,  8 Nov 2020 19:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604861487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwkqiufIQtcaBVLbmmkjLHr/tl4pmMlFgzsuoMAu7hc=;
        b=Jd5BoL5e/EBPSlRziNj4wLuW0ATWEobr9Un9k/OzO91rcGp7dVAxuYBsY9FbXjhqHZMv+B
        O+9ODnRJPpclhWh/57IK3T21n0p5ph55g07j9KS9E4MJoMjwiFsYB0Ns1Dt6Btqqml3X3A
        e/NwxMkk1iFA2MRitKzpsmz5qpu0vdI=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 5/9] clk: divider: add devm_clk_hw_register_divider_table()
Date:   Sun,  8 Nov 2020 19:51:09 +0100
Message-Id: <20201108185113.31377-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108185113.31377-1-michael@walle.cc>
References: <20201108185113.31377-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will simplify drivers which would only unregister the clk in their
remove() op.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v2:
 - none

Changes since v1:
 - new patch

 drivers/clk/clk-divider.c    | 34 ++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h | 27 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8de12cb0c43d..c499799693cc 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -578,3 +579,36 @@ void clk_hw_unregister_divider(struct clk_hw *hw)
 	kfree(div);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_divider);
+
+static void devm_clk_hw_release_divider(struct device *dev, void *res)
+{
+	clk_hw_unregister_divider(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		const struct clk_div_table *table, spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_divider, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_divider(dev, np, name, parent_name, parent_hw,
+				       parent_data, flags, reg, shift, width,
+				       clk_divider_flags, table, lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_divider);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 33db52ff83a0..5f896df01f83 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -639,6 +639,12 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock);
+struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		const struct clk_div_table *table, spinlock_t *lock);
 struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
@@ -779,6 +785,27 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 				  (parent_data), (flags), (reg), (shift),     \
 				  (width), (clk_divider_flags), (table),      \
 				  (lock))
+/**
+ * devm_clk_hw_register_divider_table - register a table based divider clock
+ * with the clock framework (devres variant)
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @table: array of divider/value pairs ending with a div set to 0
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_divider_table(dev, name, parent_name, flags,     \
+					   reg, shift, width,		      \
+					   clk_divider_flags, table, lock)    \
+	__devm_clk_hw_register_divider((dev), NULL, (name), (parent_name),    \
+				       NULL, NULL, (flags), (reg), (shift),   \
+				       (width), (clk_divider_flags), (table), \
+				       (lock))
 
 void clk_unregister_divider(struct clk *clk);
 void clk_hw_unregister_divider(struct clk_hw *hw);
-- 
2.20.1

