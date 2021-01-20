Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B922FDBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbhATVdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbhATVIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:08:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A48AB2343E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
        dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA9/Ks+q"
Envelope-to: broonie@sirena.co.uk
Delivery-date: Wed, 20 Jan 2021 20:59:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
        by cassiel.sirena.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <SRS0=VDVm=GX=gmail.com=digetx@kernel.org>)
        id 1l2KZq-0000z4-H5
        for broonie@sirena.co.uk; Wed, 20 Jan 2021 20:59:44 +0000
Received: by mail.kernel.org (Postfix)
        id AC0E6235F9; Wed, 20 Jan 2021 20:59:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 0FAB5233FC;
        Wed, 20 Jan 2021 20:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAB5233FC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=digetx@gmail.com
Received: by mail-lj1-f177.google.com with SMTP id n8so81737ljg.3;
        Wed, 20 Jan 2021 12:59:39 -0800 (PST)
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
        b=r/1lW6NZ8wtI9CIkygeME3wInLN/zE+6ngkcH5/LrVBE7yV8zmBzxtun2fR2kHdnn7
         1GmeqZa1UbABnxi4wpBUQRHVmC7v6yaTY+/oRy7zpM4LMUeTcO2nhbCfm1CpDl8O6azm
         ToKH/qcu6WcIe74oRyoFYgp2MSvcXHZsq7pGOVRQDdPMC7CGf7AE5qxIog9MMJ9M3/nX
         RCeJxkQM60Ov6OhG/sRjPgrInVBanjOsTzfibcOQ9/zEzwK6FLsJ7bqGzdmYbiwO9zx2
         66xeHKgg6MdES+OE6k7AYB5uSEdw79Lf626HEOAKc3FZbRaOHNb7rdlIe7OxLIClIOWi
         OkXw==
X-Gm-Message-State: AOAM530t1Syy8FYnLosQ0GC0YAryLmlke/ax414IaaWUxUx7iR3tr0oC
        fPx6m0YTVsh3W6+1amiizW4dg0XlLsY=
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
Date:   Wed, 20 Jan 2021 23:58:44 +0300
Message-Id: <20210120205844.12658-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: SRS0=VDVm=GX=gmail.com=digetx@kernel.org
Subject: [PATCH v1] regulator: consumer: Add missing stubs to regulator/consumer.h
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: Z/2diuZqPolq
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

