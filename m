Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E82A8CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgKFC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgKFC3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:29:17 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74821C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:29:17 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r10so2768169pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b27GJGEmE1Mom6xyD9K+l/VA3DKeEcufnAZxDfWuSpA=;
        b=QloUebj4KbG5jJRv0H8hCra2triZfLbfW8YzbN7Y8qwMNY7nfk7UPDQCEEo7y0Dyoy
         M7RwEGOd+lbQdUe3ko8l1jzzg2egeZ/LCN3t6mNuoBaC9WbpNs7RiLPqcz/3wpRoqfx/
         dHOTXc6I6T7t7vMGDZ9iuu2Zull02bHOMMWq162+yW1i4hBq1gNZwy0mUiaYgmPSiCgj
         mKN0IVeOHmRoaEow/UPYyPm3BRfkGHtheIclmoo1rdIiJ3/EXbBdUJWjBmLYz4lhDpAV
         hYElcanv3jr12+UMMLPwTUaGF8WAigBqYsgQuYhUHNce7g6qLWsuHHu3ljNihLXyoU0I
         Uoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b27GJGEmE1Mom6xyD9K+l/VA3DKeEcufnAZxDfWuSpA=;
        b=aDsuxyNfOfzh/+vaDYHIgYgValke5pnvMY6l3K/IXxxj0CVqU2cZUBkizYAgL+noQx
         GOwkLwDNgWROBr65WoUHPR9jlMwWQEHqjmIcPq7c41z9wZ9QIZiZiGCuq1Ak2xy8w4Zo
         u8H8Ok2UQvA66rajSyqdJfWLAslaEmX/1ugVJaLNWYwzreOmKnzf/hTIvtA+/i5sXOG4
         vcjdEiKqFm5wfBfaaBbCu5sKENzqDhP13VwyKGO9HYeuGqhdY/lNsyoTkS8f6CUlyvs1
         QW7hngEqjC6DHuBXB9wulqhGs/hL755BpJndz1zK7ZSTfMVbxaWbBZ+vnKwvGpz4kC0+
         sXKQ==
X-Gm-Message-State: AOAM531HG+xA8dSaQ09DIutijZxg12dc5WKiQ63DWr1dTghL+UyIw9np
        NwC5ouViAjKlPH1P80MA8Kh6rQ==
X-Google-Smtp-Source: ABdhPJxQw8fWMpTvx9u5nTg84ZaSUEZW34L5U3OWH0F3P/t0ZewQONa/xdteYMWibBFvGrrfbR2GUg==
X-Received: by 2002:a17:90a:1f0b:: with SMTP id u11mr5388492pja.105.1604629757052;
        Thu, 05 Nov 2020 18:29:17 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:16 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 26/27] mmc: sdhci-pci: add UHS-II support framework
Date:   Fri,  6 Nov 2020 11:27:25 +0900
Message-Id: <20201106022726.19831-27-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 23da7f7fe093..a896c7b325d0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -39,6 +39,7 @@
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2215,7 +2216,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2226,6 +2230,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d0ed232af0eb..c961ec3cec26 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -137,6 +137,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -186,6 +187,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.28.0

