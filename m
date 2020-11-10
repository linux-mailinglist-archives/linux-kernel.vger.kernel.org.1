Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75802ADB63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKJQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:13:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56170 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:13:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0C8141F44CE8
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2] mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional() function.
Date:   Tue, 10 Nov 2020 17:13:37 +0100
Message-Id: <20201110161338.18198-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds syscon_regmap_lookup_by_phandle_optional() function to get an
optional regmap.

It behaves the same as syscon_regmap_lookup_by_phandle() except where
there is no regmap phandle. In this case, instead of returning -ENODEV,
the function returns NULL. This makes error checking simpler when the
regmap phandle is optional.

Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---

Changes in v2:
- Add Matthias r-b tag.
- Add the explanation from the patch description to the code.
- Return NULL instead of -ENOTSUPP when regmap helpers are not enabled.

 drivers/mfd/syscon.c       | 18 ++++++++++++++++++
 include/linux/mfd/syscon.h | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ca465794ea9c..c6f139b2e0c0 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -255,6 +255,24 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
 
+/*
+ * It behaves the same as syscon_regmap_lookup_by_phandle() except where
+ * there is no regmap phandle. In this case, instead of returning -ENODEV,
+ * the function returns NULL.
+ */
+struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
+					const char *property)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, property);
+	if (IS_ERR(regmap) && PTR_ERR(regmap) == -ENODEV)
+		return NULL;
+
+	return regmap;
+}
+EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..fecc2fa2a364 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -28,6 +28,9 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
 					const char *property,
 					int arg_count,
 					unsigned int *out_args);
+extern struct regmap *syscon_regmap_lookup_by_phandle_optional(
+					struct device_node *np,
+					const char *property);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -59,6 +62,14 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
+					struct device_node *np,
+					const char *property)
+{
+	return NULL;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.28.0

