Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CB52FDBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbhATVb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436671AbhATVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:00:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746AAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:59:39 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 3so72524ljc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSu9QLstLHNet8eU6MN3rod6A2tO2uWH3oxh1LfZAuA=;
        b=DA9/Ks+qH0EB8odSn151I1TDAWizJMKChGvGIlK6+n377dQChIAt6FnWROTbHWI1+B
         DH+wyLWak1VXDn8dKdG4wGHWWVHLXcn7kowQn7OS8xHvqceRPGhk83GQ6VEADbZTVhe0
         fNByhWN712OsZfCC7q2rrpQMv7XLVZ3FoY8EbOPrJ9Z641Ofb3YQTWJ+JvRBu5tbIp7g
         FHgasLKTtELL7Mx87GPW2JYeJ5JDrmTXMmwlaZesH0+segxlHxzyAPucAmbSfuTobsdc
         wwKafmpebFBjZe19b2bseW52XJW5pYbfCvAUAjRPAc22knxQPwMGqJXbOHBbRQruSp8Z
         inGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSu9QLstLHNet8eU6MN3rod6A2tO2uWH3oxh1LfZAuA=;
        b=qUXx+YioUrda9ldoZBnAWjOxdwdo5J4yIdvtJYnRowRNcaGWwiBfhLTTg+EZvt2/aR
         ZeMlVzc1gVbNw7ahIeFYh85sOdmBU93FFcd3Wr5xu+gS+/0Ac+eYB23O/mP7fzfEKJMZ
         FSJv0Q7NlpbhzpGK8ymU6apNU8kxauugITpj1dy1sv9e1AQZ6wUFnPJU4JI2dLZFCd2C
         407azWtQKEFCR+QiEl8OmagkvfJjSLOL2aHyPdfwWLJrbGF3BVWGe9kGE/qwb+hTOMaZ
         DbzPXQws203o2WXkYzhAZObTtdYTkNYR8BclBrTCvNJYjYXSFuKIenY9zxzbr5XyVaDC
         CSrQ==
X-Gm-Message-State: AOAM530ywKs9EFq3+s5V5mBB6jRxpMvuMooNnSql5ZDSQLo3FOMiv9ix
        TWu4yd6p4AsfrwwDJz++vhk=
X-Google-Smtp-Source: ABdhPJzpXnErScihoK5W5RrQSFs0k63y4aaWjITBu/+dptleiaH/8FjVZxFbptDfuBfHsr2uzcQ4nw==
X-Received: by 2002:a05:651c:118a:: with SMTP id w10mr5315822ljo.13.1611176378058;
        Wed, 20 Jan 2021 12:59:38 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id v19sm349546ljj.126.2021.01.20.12.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:59:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] regulator: consumer: Add missing stubs to regulator/consumer.h
Date:   Wed, 20 Jan 2021 23:58:44 +0300
Message-Id: <20210120205844.12658-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing stubs to regulator/consumer.h in order to fix COMPILE_TEST
of the kernel. In particular this should fix compile-testing of OPP core
because of a missing stub for regulator_sync_voltage().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/regulator/consumer.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 2024944fd2f7..20e84a84fb77 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -331,6 +331,12 @@ regulator_get_exclusive(struct device *dev, const char *id)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct regulator *__must_check
+devm_regulator_get_exclusive(struct device *dev, const char *id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct regulator *__must_check
 regulator_get_optional(struct device *dev, const char *id)
 {
@@ -486,6 +492,11 @@ static inline int regulator_get_voltage(struct regulator *regulator)
 	return -EINVAL;
 }
 
+static inline int regulator_sync_voltage(struct regulator *regulator)
+{
+	return -EINVAL;
+}
+
 static inline int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV)
 {
@@ -578,6 +589,25 @@ static inline int devm_regulator_unregister_notifier(struct regulator *regulator
 	return 0;
 }
 
+static inline int regulator_suspend_enable(struct regulator_dev *rdev,
+					   suspend_state_t state)
+{
+	return -EINVAL;
+}
+
+static inline int regulator_suspend_disable(struct regulator_dev *rdev,
+					    suspend_state_t state)
+{
+	return -EINVAL;
+}
+
+static inline int regulator_set_suspend_voltage(struct regulator *regulator,
+						int min_uV, int max_uV,
+						suspend_state_t state)
+{
+	return -EINVAL;
+}
+
 static inline void *regulator_get_drvdata(struct regulator *regulator)
 {
 	return NULL;
-- 
2.29.2

