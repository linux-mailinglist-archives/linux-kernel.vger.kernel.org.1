Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3418D2A871F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgKET2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:28:00 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54821 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731799AbgKET16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:27:58 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 619BF23078;
        Thu,  5 Nov 2020 20:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4MLf2/TOiYjV3fsQDtUBagoBi797jwm6AKIfsC7qEQ=;
        b=ukAGETkXkM3KI0T27MsOakxhn8gqj0dep3ovdkqybrD6seWu+OUXlKa/2NjzryVwnpnEiY
        YvKe1UGFixjhHJjFVwNuZZ4BGOFX0k4MGGbEfWY77+hiPb8Z3x/e+CPiIgV6QtOla/QFY4
        4XMJNh3iC84dcO+WBxrjqJmJ6qANWnY=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/3] clk: composite: add devm_clk_hw_register_composite_pdata()
Date:   Thu,  5 Nov 2020 20:27:45 +0100
Message-Id: <20201105192746.19564-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105192746.19564-1-michael@walle.cc>
References: <20201105192746.19564-1-michael@walle.cc>
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

 drivers/clk/clk-composite.c  | 50 ++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  7 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 2ddb54f7d3ab..0506046a5f4b 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 
@@ -405,3 +406,52 @@ void clk_hw_unregister_composite(struct clk_hw *hw)
 	kfree(composite);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_composite);
+
+static void devm_clk_hw_release_composite(struct device *dev, void *res)
+{
+	clk_hw_unregister_composite(*(struct clk_hw **)res);
+}
+
+static struct clk_hw *__devm_clk_hw_register_composite(struct device *dev,
+			const char *name, const char * const *parent_names,
+			const struct clk_parent_data *pdata, int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_composite, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_composite(dev, name, parent_names, pdata,
+					 num_parents, mux_hw, mux_ops, rate_hw,
+					 rate_ops, gate_hw, gate_ops, flags);
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
+
+struct clk_hw *devm_clk_hw_register_composite_pdata(struct device *dev,
+			const char *name,
+			const struct clk_parent_data *parent_data,
+			int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	return __devm_clk_hw_register_composite(dev, name, NULL, parent_data,
+						num_parents, mux_hw, mux_ops,
+						rate_hw, rate_ops, gate_hw,
+						gate_ops, flags);
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9ead4633c8c8..5f896df01f83 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1089,6 +1089,13 @@ struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
+struct clk_hw *devm_clk_hw_register_composite_pdata(struct device *dev,
+		const char *name, const struct clk_parent_data *parent_data,
+		int num_parents,
+		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+		unsigned long flags);
 void clk_hw_unregister_composite(struct clk_hw *hw);
 
 struct clk *clk_register(struct device *dev, struct clk_hw *hw);
-- 
2.20.1

