Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366822A8CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgKFC2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKFC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:28 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:28 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q10so2325846pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSSavh8aYuAKIHXfk4k19j1F92a9eMW5CzDb9993MqU=;
        b=BYEo3Q0d7sowonRQAWHJQ0Me1yZyJMKZyhajU473DZ6B0j4VLTclPc57wc3qV0r7BN
         4wVU+Iuoj4j9IuhR999knyLoDMjx94Z/DRp4+bdQtmKIsRmttbs5gfZ4HmYHAdWu6qro
         uv1ulvPWaAYa2q+zihYt6yFP9UtB8kLIIX3dE4mtWyqE8Vl0H8CKRQ2f8Ko74rnmRetZ
         BmnTvjHr4DnOS+P2JcHVin3B0VeTgjuAniluISo0BBbMcadsFEqjHgQfoTKnjUQdGKvE
         fvHMfqHqMJYImxwzBjuJjkFphXdRE00WTehhKT1WrXBW5ltLKd5Z9CXmxPiR1RSPTgAp
         /Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSSavh8aYuAKIHXfk4k19j1F92a9eMW5CzDb9993MqU=;
        b=mEeDkRAtzPAscEyrtzi98H92wzCABaH33kxy0eIccGPxl95iOLoUP8DB8vEbDFbIJn
         z2liMRQjVzwnkYpd/JCtJWA+nESZDwZA8nOWQ5Zevaogu5zoajGNrNZ+b/EljENuqr2u
         plJudqjE2lspLo4xsZZTR4bF/8vJIbuIQsBhJ45YUnEkyM1rJWVfGu8+lRqfpO3wh59T
         SG6f0wJpiBhcdMeBPwyK0d/NgI7tY9rZ0HCCDCI0LEcZd4FQ+JzXH2aJFHuP13dujnOX
         OmzuegYYfHpPKHfX9TW2zSluUvRj82cwb7QZXA25ah1USfb8uswwzB98aFIhqrQc5ZTu
         X2iw==
X-Gm-Message-State: AOAM531cW1LlqY5Lk9mP0XPmH8MNtFd3+jfZlCPqJ5vR+lHzMNr2tLN6
        xnibGjt0cY/vQmXOOUEO96z8PA==
X-Google-Smtp-Source: ABdhPJyC7aqLgd76lj5QmCOs7lCdy4oablIuNeLjwbHbR/B1L06vGJJDJ0rnPG1YsQcFxBEyw2FW0g==
X-Received: by 2002:a63:1512:: with SMTP id v18mr3213908pgl.450.1604629708080;
        Thu, 05 Nov 2020 18:28:28 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:27 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 10/27] mmc: sdhci: add UHS-II module
Date:   Fri,  6 Nov 2020 11:27:09 +0900
Message-Id: <20201106022726.19831-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skelton for further development in this patch series.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 451c25fc2c69..f6e9b05c3b30 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 000000000000..f29d3a4ed43c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *  Copyright (C) 2020 Genesys Logic, Inc.
+ *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *  Copyright (C) 2020 Linaro Limited
+ *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <linux/module.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static int __init sdhci_uhs2_mod_init(void)
+{
+	return 0;
+}
+module_init(sdhci_uhs2_mod_init);
+
+static void __exit sdhci_uhs2_exit(void)
+{
+}
+module_exit(sdhci_uhs2_exit);
+
+MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
+MODULE_DESCRIPTION("MMC UHS-II Support");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

