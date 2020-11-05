Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B132A8752
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgKETf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:35:26 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:45577 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbgKETfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:35:22 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AADC222F9C;
        Thu,  5 Nov 2020 20:35:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReHp2fm9OSWxCgIlDeVZla1A8qw/osOuWokzylh+8xI=;
        b=sOJbKSIz15FFPpqCG/+es9pUQ0P+ZCT5x1GN3fteL7H2XAtaXQkzb5Dl0rn9dHss0FTAC6
        4wdNNc+5BAcYS1UrJ0i0cIaIQfuu9VVsY2rKN/BqDA2e5Fh7F6CnUHqIBIonlcHjSdNXNq
        8x/nkLxzO3gc8HFnZyTSQ4iycd16pvQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/5] clk: divider: add devm_clk_hw_register_divider_table()
Date:   Thu,  5 Nov 2020 20:35:08 +0100
Message-Id: <20201105193512.22388-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105193512.22388-1-michael@walle.cc>
References: <20201105193512.22388-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will simplify drivers which would only unregister the clk in their
remove() op.

Signed-off-by: Michael Walle <michael@walle.cc>
---
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
index 03a5de5f99f4..9ead4633c8c8 100644
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

