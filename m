Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395302F26E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 05:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbhALEDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 23:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbhALEDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:03:32 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B3C0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 20:02:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d6so681572plr.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 20:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X7CTBa0CXHOMqqTGqsqUqty/+Ht2Bje2c2Eq+Eb4V0I=;
        b=dosHyd1xU5Jxa86wRgk5aAlB3weKCxWCFviYJFQ5ts0KGDbckGx5opGQ9PLbHJ5ifJ
         tIx+WKUaCrT1bO4ZigiP/f8LvgOpoR0509E71Qmx3WsN9pNKinGTFVzU/eSeXcR3MEFo
         pyH2d+ZDMVfsWs16oKFRAVN0K68ioK92ODhM45kYJpAEummKurbw+PnoHkcS84hgBtjy
         O/p8Zb1VEpMHkikB2uWbC20guJy5HMkUPcimdCcqIR/FuGrxq2UzRqLO8uT3KP3Sfl3Q
         EfaL6y3GAFHULAWVUHDTfc1mTnOOyYvy4gw+IbLuPPN+xfWnajuLPR+y3vR22v8DHHY8
         MsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X7CTBa0CXHOMqqTGqsqUqty/+Ht2Bje2c2Eq+Eb4V0I=;
        b=T1xNSM2gYFL7FZEA8V7ZpX7C5B8b6ZHVt916GdqaqY+aulzJQMpYzQmrZyP51lnHgi
         8zhqbHvqt50z4hy7MalBTTq7pjLsPcxefME9NrywHlYB1sX0vhvTEhF84KRmkq1gSYSS
         L6Q/Z/ZdOBNhwHjgj9Qeml/M4nKeMmEW5rOztODiHIU61Ucbb+R2ySQskhie+w8L0w5w
         6XiX5Q90mVxndBcDbzuzLWRk+qdH7AysQbDzHh3ak4x79GD6V6zHGX5H6edOh1FCWP6N
         Ug3gQjyH3DRc5aNIw0gYslbSCsIXRg5pnj+hd6WNgY5pT+fowzfRCyNPtesOJ7ETtL8m
         aFlw==
X-Gm-Message-State: AOAM5339xCa869ROZIhRfAt/yddmS7r40ls6VgXflp+hsfJPhwCWKN/Y
        9n1rlFx9be+oRAM1J56Sh8pcSlMLefVWbSr7
X-Google-Smtp-Source: ABdhPJyXGja+0Cr6qcY6OW3IG/D9g+yhPgqXQIJ7KYT6DxWIWIIz08eY6z+Wu8RStj7uYyMxpSEhnjEkGAwCOm5s
Sender: "victording via sendgmr" <victording@victording.c.googlers.com>
X-Received: from victording.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:65c7])
 (user=victording job=sendgmr) by 2002:a17:902:fe07:b029:dc:43e4:fcbf with
 SMTP id g7-20020a170902fe07b02900dc43e4fcbfmr2668307plj.63.1610424140274;
 Mon, 11 Jan 2021 20:02:20 -0800 (PST)
Date:   Tue, 12 Jan 2021 04:02:05 +0000
In-Reply-To: <20210112040205.4117303-1-victording@google.com>
Message-Id: <20210112040146.2.Ic902bbd9f04e2d82ac578411e7fafc77b6c750e2@changeid>
Mime-Version: 1.0
References: <20210112040205.4117303-1-victording@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/2] mmc: sdhci-pci-gli: Disable ASPM during a suspension
From:   Victor Ding <victording@google.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Victor Ding <victording@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GL9750 has a 3100us PortTPowerOnTime; however, it enters L1.2 after
only ~4us inactivity per PCIe trace. During a suspend/resume process,
PCI access operations are frequently longer than 4us apart.
Therefore, the device frequently enters and leaves L1.2 during this
process, causing longer than desirable suspend/resume time. The total
time cost due to this L1.2 exit latency could add up to ~200ms.

Considering that PCI access operations are fairly close to each other
(though sometimes > 4us), the actual time the device could stay in
L1.2 is negligible. Therefore, the little power-saving benefit from
ASPM during suspend/resume does not overweight the performance
degradation caused by long L1.2 exit latency.

Therefore, this patch proposes to disable ASPM during a suspend/resume
process.

Signed-off-by: Victor Ding <victording@google.com>
---

 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c  | 46 +++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pci.h      |  1 +
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 9552708846ca..fd7544a498c0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -67,7 +67,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
-static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
+int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
 {
 	int i, ret;
 
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 9887485a4134..c7b788b0e22e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -109,6 +109,12 @@
 
 #define GLI_MAX_TUNING_LOOP 40
 
+#ifdef CONFIG_PM_SLEEP
+struct gli_host {
+	u16 linkctl_saved;
+};
+#endif
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -577,14 +583,48 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int sdhci_pci_gli_suspend(struct sdhci_pci_chip *chip)
+{
+	int ret;
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	struct pci_dev *pdev = slot->chip->pdev;
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL,
+			&gli_host->linkctl_saved);
+	if (ret)
+		goto exit;
+
+	ret = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
+			gli_host->linkctl_saved & ~PCI_EXP_LNKCTL_ASPMC);
+	if (ret)
+		goto exit;
+
+	ret = sdhci_pci_suspend_host(chip);
+
+exit:
+	return ret;
+}
+
 static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
 {
+	int ret;
 	struct sdhci_pci_slot *slot = chip->slots[0];
+	struct pci_dev *pdev = slot->chip->pdev;
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
 
-	pci_free_irq_vectors(slot->chip->pdev);
+	pci_free_irq_vectors(pdev);
 	gli_pcie_enable_msi(slot);
 
-	return sdhci_pci_resume_host(chip);
+	ret = sdhci_pci_resume_host(chip);
+	if (ret)
+		goto exit;
+
+	ret = pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+			PCI_EXP_LNKCTL_ASPMC, gli_host->linkctl_saved);
+
+exit:
+	return ret;
 }
 
 static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
@@ -834,7 +874,9 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
 	.probe_slot	= gli_probe_slot_gl9750,
 	.ops            = &sdhci_gl9750_ops,
 #ifdef CONFIG_PM_SLEEP
+	.suspend        = sdhci_pci_gli_suspend,
 	.resume         = sdhci_pci_gli_resume,
+	.priv_size      = sizeof(struct gli_host),
 #endif
 };
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d0ed232af0eb..16187a265e63 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -187,6 +187,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 }
 
 #ifdef CONFIG_PM_SLEEP
+int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
 int sdhci_pci_enable_dma(struct sdhci_host *host);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

