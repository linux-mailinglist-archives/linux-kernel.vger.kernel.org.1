Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6AA2950A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444562AbgJUQWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444530AbgJUQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:21:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CD1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ce10so4107694ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q55g9eud64WpGhGaDa2Dvtt/hAwehZmCVZltK6UXP+c=;
        b=C8IiecTVGT1P3sYupPuqXGfRgdRRrllku4/9/WB8lckeu/jILHTWJy3B5zpSZyjidT
         atUg8s0QUes2oxWPMwZaQgc7aW4jFqhIh/dS2Rv0A8FxIfwsIdqxc5Zcd3cS1nlHVP0X
         +l5Q3URFShXC990ojgt4igfaCwLJjQqkxDZoR66LbHrjv6mO+6UndtcNzKWAP+at5sJ8
         XJJT7hE4BAcPwZQ/7j/1+F84Cp7ISEpLXSHvhtfxd/e/OFeJwbuUxYpZJEs0YTIxNhjB
         neNko+1u4H7RJzazj3QYvOE3w75o3HnCie8sXXcbAgtRd5XvPayvu7g3jZPCtB/L6dcG
         KFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q55g9eud64WpGhGaDa2Dvtt/hAwehZmCVZltK6UXP+c=;
        b=Wq76dWc7zX7OaIg422tNn7Qu/Ml9LiWkCeqMzOS9WeRh1oWY9uuffwnC8E7UDo8whT
         f3hwAhD5e4Qjkcr0B3+4990sb1M3e+bkLoFpcyxp9BMX3fp8egtholApUzOJuqifqPjC
         68n1O8xZ+vZPT/CPuLfoltxmr/hxKeEWB0pV+1P475BFZtpnBqiGa3I7YWMUwRRhW5W6
         2YQyswspIbXxUrGRop5VxcGG2Oc5uWWBn0BglOuo1RkYTyTcDloWMC3gx4ffInBIncuL
         DI+DN7shw6MvMwa2GBYGSVlLNe5cEZwdV5s7T6xeVsd5njzlLp6JNxTZjykOUd/Z3Xcf
         OvaQ==
X-Gm-Message-State: AOAM5333TIuLL0mesIYUQmqY4y/XX1vf8IBSG2SRvhsrQciSZna078MY
        MQC1W+HerRdc4F4cOA4VF3IJ2A==
X-Google-Smtp-Source: ABdhPJz+G1dBjBjCpnBLdWHbW1tSyTbYS7kPkAsPqhbosb2z4K4f83WPnTBKLviiVvM6Z1MI0t69sg==
X-Received: by 2002:a17:907:206e:: with SMTP id qp14mr4330789ejb.76.1603297316070;
        Wed, 21 Oct 2020 09:21:56 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 11sm2566667ejy.19.2020.10.21.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:21:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 2/3] clk: add api to get clk consumer from clk_hw
Date:   Wed, 21 Oct 2020 18:21:46 +0200
Message-Id: <20201021162147.563655-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201021162147.563655-1-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_register() is deprecated. Using 'clk' member of struct clk_hw is
discouraged. With this constraint, it is difficult for driver to
register clocks using the clk_hw API and then use the clock with
the consumer API

This adds a simple helper, clk_hw_get_clk(), to get a struct clk from
a struct clk_hw. Like other clk_get() variant, each call to this helper
must be balanced with a call to clk_put(). To make life easier on the
consumers, a memory managed version is provided as well.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c            | 61 ++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  5 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 88e5797bb6b4..d27153f26fa9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3667,6 +3667,24 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	return clk;
 }
 
+/**
+ * clk_hw_get_clk: get clk consumer given an clk_hw
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Returns: new clk consumer
+ * This is the function to be used by providers which need
+ * to get a consumer clk and act on the clock element
+ * Calls to this function must be balanced with calls clk_put()
+ */
+struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *con_id)
+{
+	struct device *dev = hw->core->dev;
+
+	return clk_hw_create_clk(dev, hw, dev_name(dev), con_id);
+}
+EXPORT_SYMBOL(clk_hw_get_clk);
+
 static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
 {
 	const char *dst;
@@ -4187,6 +4205,49 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
 
+static void devm_clk_release(struct device *dev, void *res)
+{
+	clk_put(*(struct clk **)res);
+}
+
+/**
+ * devm_clk_hw_get_clk: resource managed clk_hw_get_clk()
+ * @dev: device that is registering this clock
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Managed clk_hw_get_clk(). Clocks got with this function are
+ * automatically clk_put() on driver detach. See clk_put()
+ * for more information.
+ */
+struct clk *devm_clk_hw_get_clk(struct device *dev, struct clk_hw *hw,
+				const char *con_id)
+{
+	struct clk *clk;
+	struct clk **clkp;
+
+	/* This should not happen because it would mean we have drivers
+	 * passing around clk_hw pointers instead of having the caller use
+	 * proper clk_get() style APIs
+	 */
+	WARN_ON_ONCE(dev != hw->core->dev);
+
+	clkp = devres_alloc(devm_clk_release, sizeof(*clkp), GFP_KERNEL);
+	if (!clkp)
+		return ERR_PTR(-ENOMEM);
+
+	clk = clk_hw_get_clk(hw, con_id);
+	if (!IS_ERR(clk)) {
+		*clkp = clk;
+		devres_add(dev, clkp);
+	} else {
+		devres_free(clkp);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_get_clk);
+
 /*
  * clkdev helpers
  */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 03a5de5f99f4..86b707520ec0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1088,6 +1088,11 @@ static inline struct clk_hw *__clk_get_hw(struct clk *clk)
 	return (struct clk_hw *)clk;
 }
 #endif
+
+struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *con_id);
+struct clk *devm_clk_hw_get_clk(struct device *dev, struct clk_hw *hw,
+				const char *con_id);
+
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
-- 
2.25.4

