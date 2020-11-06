Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726DF2A8CD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKFC2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKFC2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E0CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so2649828pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZAw8U8D8vUHF1iKm82K3cyupIMt/ic4sf021LXENYE=;
        b=oIjNDl0zi+tWdyTAiIsIrDRLeNt3wr6uCZ1wu4wnkQE8Ygsqv5rsDN5tFftVM35Rr4
         ooaPFKla07r24s13egCTqRIdG+r4XgY44zSwbXH5puBugnDHXYxxczb0w4jp853uP77U
         4Pkx0sRjAZkEsb2OUn08YsURqp/QNUSnJivegoY/+l22I+ItxIh20qYHiX2wnYRfy/o2
         +qy6KLZ58Gxk+Ltb8oWH90f6FigFiKps4PdG3bTyf+hZgN50VjJpLoc2l5ORwsMsqqGa
         0muwqdlkejVwvfOYiXd0Mf+TP0rHxnixehINf+zhnLBlXbypkiwDMb6fr5Eusq5UpnDT
         FG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZAw8U8D8vUHF1iKm82K3cyupIMt/ic4sf021LXENYE=;
        b=ikmsV6Oe96GRv4mpiEKqox68Oqm+LplBW/2Ml7jtvH93jICsEliWl80Fm4jdveJEDE
         YKKjOzQv/ePR/SpefRbNLuUHuzzrSYO8y4SGvacz+oOr9Q7DwzfVFvgGf5fHT2RWrrhE
         BxPPs4Qo2KolFKa7ru6surE+xdUlzJnYZckNIKB2ERgT/eiD97wUHFKr+Zg+X/WC0wW7
         zNcDgF0y+jiL7JidBE6/Iu1EbjGNR/KgGxlzCcCl0SNkWi77Cpc996DtOC1tlocRgHWo
         T8+hW6jDSWautC1xwRACionlZTwxBT8Ud7eYy7qG3RjZT+tslX0v/pWYwVbS9+6eGLU0
         4neA==
X-Gm-Message-State: AOAM530RpKCtBArD0OmHJRZaAWpsMzKxr3lLeGK2WQJG3gRkNQDzr5fp
        Eq4A1p6ANn4eMKuZhBXEo77KlQ==
X-Google-Smtp-Source: ABdhPJzK378a95yCfn6eUIRq+vi+CZ1APkk+uYquqTfgUt0dC1DA1WZcm9dBq5RJjc8jWrWFLnUYlw==
X-Received: by 2002:a17:90a:1b84:: with SMTP id w4mr352286pjc.65.1604629711046;
        Thu, 05 Nov 2020 18:28:31 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:30 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 11/27] mmc: sdhci-uhs2: dump UHS-II registers
Date:   Fri,  6 Nov 2020 11:27:10 +0900
Message-Id: <20201106022726.19831-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump UHS-II specific registers, if available, in sdhci_dumpregs()
for informative/debugging use.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  4 ++++
 drivers/mmc/host/sdhci.c      |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index f29d3a4ed43c..08905ed081fb 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -18,6 +18,36 @@
 #define DRIVER_NAME "sdhci_uhs2"
 #define DBG(f, x...) \
 	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+#define SDHCI_UHS2_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host)
+{
+	if (!host->mmc || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
+	SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+	SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_COMMAND),
+			sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+	SDHCI_UHS2_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
+			sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
+	SDHCI_UHS2_DUMP("Dev Int Code:  0x%08x\n",
+			sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
+	SDHCI_UHS2_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_SW_RESET),
+			sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
+	SDHCI_UHS2_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
+	SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3b157df9c89c..b9529d32b58d 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -207,4 +207,8 @@
 #define SDHCI_UHS2_EMBED_CTRL	0xE6
 #define SDHCI_UHS2_VENDOR	0xE8
 
+struct sdhci_host;
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 592a55a34b58..d4a57e8c9bb8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -111,6 +111,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (host->ops->dump_uhs2_regs)
+		host->ops->dump_uhs2_regs(host);
+
 	if (host->ops->dump_vendor_regs)
 		host->ops->dump_vendor_regs(host);
 
-- 
2.28.0

