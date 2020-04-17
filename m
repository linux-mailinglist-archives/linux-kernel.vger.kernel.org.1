Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C9B1AD45E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 04:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgDQCOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 22:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:14:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1213C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:14:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g30so330491pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GvlfOPTE55KbhIluk/tI2KUYnjup+BkCQaBFLOr/Q8g=;
        b=Ecr32k2Dj+rh/hjbSIF/RChp7KOg9vUZWR443AkeBFAF/E3p2Du1TgBJ/2ZyxKhcXH
         Kg1yzT/TB6ZDpmjVgq5KCD3YTiikf4jCBYrOWy94SpIPqLLk7zitnVwtNcnsJBvU0OUc
         9VgNhhtZmr5mgh3e7h25v13dxTJm5MqhrUQ1VhH6dfh+gjSoUr47h4t8caCFDyiSCedn
         Lgb++Q3OGpueu8uBlNzfolZeE8cTCTJEJvZr3U0IYbBfe5c7GIL7AEvmRWxpqZRuGsKi
         LtJXcupCZ0lzQ6sG6JKPCIf3UmRZ7KBe+4ga8z+aR5CdfrkBYFE4uyxxyT/0moJvUN8r
         PRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GvlfOPTE55KbhIluk/tI2KUYnjup+BkCQaBFLOr/Q8g=;
        b=BXi/rS3rbSM9q6u+nJrzihwIGNRWcAo5E1cu29Nzuo6MGo6jvkXCh+/lfUJjcLFeWC
         Jx2SIHOg8wdntJHht2hXIVGhrBbQthDA7IQCXZx6KmHeqGsQ7SnxZSfXP1afmUfrHrfw
         BccFZpc0jcbsHtzwZfgYdDsLFElYOIgrVPMXwFrOLuzlcqOb4P3Vf8jut6OK1Zbqz1ym
         K4SlZJ3yxjuvIdS9f9/RS97l1flHZTYu0Kq+5ZzaCVnHsGXUPxYPv+59Vs01MC+IFwig
         R/rDOd+4A4DAExAQQ6i4UKBGYLlIMnt0/IhAIn6IOilESR5Itpv+aWd/Lggzdcd615Ok
         +RDg==
X-Gm-Message-State: AGi0PuYDwb+aX0Igpq+xPSShDluvWSAHb+tgzzfSTCYyaKtLUMf003so
        XhWsm/6eIvw8YQ8PknWgfm0=
X-Google-Smtp-Source: APiQypJCKEUkpq0Dtaz7W171p2IZ3Ihx2jE7Arr4sWGIrh1IB/ZFcy+PsoR467MxQ7vbp3vN4Jo52w==
X-Received: by 2002:a63:5511:: with SMTP id j17mr755785pgb.4.1587089674579;
        Thu, 16 Apr 2020 19:14:34 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id h11sm18035319pfn.125.2020.04.16.19.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:14:33 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: syscon: Support physical regmap bus
Date:   Fri, 17 Apr 2020 10:14:14 +0800
Message-Id: <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587088646.git.baolin.wang7@gmail.com>
References: <cover.1587088646.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587088646.git.baolin.wang7@gmail.com>
References: <cover.1587088646.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms such as Spreadtrum platform, define a special method to
update bits of the registers instead of reading and writing, which means
we should use a physical regmap bus to define the reg_update_bits()
operation instead of the MMIO regmap bus.

Thus add a new helper for the syscon driver to allow to register a physical
regmap bus to support this new requirement.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/syscon.c       | 23 +++++++++++++++++++++--
 include/linux/mfd/syscon.h |  7 +++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816d0cba..92bfe87038ca 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 
 static struct platform_driver syscon_driver;
+static struct regmap_bus *syscon_phy_regmap_bus;
 
 static DEFINE_SPINLOCK(syscon_list_slock);
 static LIST_HEAD(syscon_list);
@@ -106,14 +107,25 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
-	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	 /*
+	  * The Spreadtrum syscon need register a real physical regmap bus
+	  * with new atomic bits updating operation instead of using
+	  * read-modify-write.
+	  */
+	if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
+	    of_device_is_compatible(np, "sprd,atomic-syscon") &&
+	    syscon_phy_regmap_bus)
+		regmap = regmap_init(NULL, syscon_phy_regmap_bus, base,
+				     &syscon_config);
+	else
+		regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
 		goto err_regmap;
 	}
 
-	if (check_clk) {
+	if (check_clk && !syscon_phy_regmap_bus) {
 		clk = of_clk_get(np, 0);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
@@ -172,6 +184,13 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
+void syscon_register_phys_regmap_bus(struct regmap_bus *phy_regmap_bus)
+{
+	if (phy_regmap_bus)
+		syscon_phy_regmap_bus = phy_regmap_bus;
+}
+EXPORT_SYMBOL_GPL(syscon_register_phys_regmap_bus);
+
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	return device_node_get_regmap(np, false);
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..fbc2a2f0f414 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -13,6 +13,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/regmap.h>
 
 struct device_node;
 
@@ -28,6 +29,7 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
 					const char *property,
 					int arg_count,
 					unsigned int *out_args);
+extern void syscon_register_phys_regmap_bus(struct regmap_bus *phy_regmap_bus);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -59,6 +61,11 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline void
+syscon_register_phys_regmap_bus(struct regmap_bus *phy_regmap_bus)
+{
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.17.1

