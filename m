Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB2C2C8D26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgK3Snb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbgK3Sna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:30 -0500
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com [IPv6:2607:f8b0:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E96C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:50 -0800 (PST)
Received: by mail-ot1-x362.google.com with SMTP id 11so12284459oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N9HqDAuUXynTYpLDzH3HkZyBd0q2HRUjTDeSo8L8NpU=;
        b=PpIZytARgvKMxV0LgLxafzZj9XiRksi5OBpmJ0i88LDpw78hsE4SlC54tlOoJT5ktj
         kZiApnyNV7FfkKFtPNmpCCLRiRUYgyQCTBL/PN2looCwBboKP3UfRxYY1aQeAIZQ8Mve
         vwrsxAhlxI2KrQdg+hfoz7hvHsPGAkGc/hfKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N9HqDAuUXynTYpLDzH3HkZyBd0q2HRUjTDeSo8L8NpU=;
        b=sqhSv62s74MgIzjNvXbtw4qKhOeashOqEm1cAIcMyJnCvxLkuw6ejTeY3Si8hyQlIC
         XVDRWOzID9R5/D52HBNj3rZ7Okcqew0SI8/QdSJHzYHIH5iQWeLQD9T4B4wc2PeKJTay
         NflmX2uflAOuKkrgsOC35GI6cPZkx42eBkWL3iWPysF1zAcYO5P3j02wuu+UCX/xRewI
         dV5mtmRL3o8vOAbgumAOU9R2qqKpZaIQ/qa14nTf5FbK7Rnp4wZT+rx23985kFDiLtgT
         vk8OatAMxsiXLaT86dNCnl4fk9cM1Nt4dIBj/K3MZleA1bC6A6FoSHhymw8pXk5WnGJt
         l2OQ==
X-Gm-Message-State: AOAM531cPtlifDMj0E7dr6lWKtWGqGmiZL77DBV5HpUkORBirN5gSkbJ
        1cvE/99UBK+ytzBQCpQL7Q5CjW6lyR7aRLhlOCrSJg8F57m1
X-Google-Smtp-Source: ABdhPJwWYNOMbNsWA5GfputP0sioHrMj6u5hjAsu9S8qTulbslHxOR1/aVa0a6TbDcu2jVOGPDQhhZFLOY2s
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr17607543otq.159.1606761769831;
        Mon, 30 Nov 2020 10:42:49 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:42:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 05/13] misc: bcm-vk: add triggers when host panic or reboots to notify card
Date:   Mon, 30 Nov 2020 10:41:52 -0800
Message-Id: <20201130184200.5095-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass down an interrupt to card in case of panic or reboot so
that card can take appropriate action to perform a clean reset.
Uses kernel notifier block either directly (register on panic list),
or implicitly (add shutdown method for PCI device).

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  2 ++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 0a366db693c8..f428ad9a0c3d 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -223,6 +223,8 @@ struct bcm_vk {
 	unsigned long wq_offload[1]; /* various flags on wq requested */
 	void *tdma_vaddr; /* test dma segment virtual addr */
 	dma_addr_t tdma_addr; /* test dma segment bus addr */
+
+	struct notifier_block panic_nb;
 };
 
 /* wq offload work items bits definitions */
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 4ecd5b5f80d3..09d99bd36e8a 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -635,6 +635,16 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	return 0;
 }
 
+static int bcm_vk_on_panic(struct notifier_block *nb,
+			   unsigned long e, void *p)
+{
+	struct bcm_vk *vk = container_of(nb, struct bcm_vk, panic_nb);
+
+	bcm_to_v_reset_doorbell(vk, VK_BAR0_RESET_DB_HARD);
+
+	return 0;
+}
+
 static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int err;
@@ -748,6 +758,15 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* sync other info */
 	bcm_vk_sync_card_info(vk);
 
+	/* register for panic notifier */
+	vk->panic_nb.notifier_call = bcm_vk_on_panic;
+	err = atomic_notifier_chain_register(&panic_notifier_list,
+					     &vk->panic_nb);
+	if (err) {
+		dev_err(dev, "Fail to register panic notifier\n");
+		goto err_destroy_workqueue;
+	}
+
 	/*
 	 * lets trigger an auto download.  We don't want to do it serially here
 	 * because at probing time, it is not supposed to block for a long time.
@@ -756,7 +775,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (auto_load) {
 		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
 			if (bcm_vk_trigger_autoload(vk))
-				goto err_destroy_workqueue;
+				goto err_unregister_panic_notifier;
 		} else {
 			dev_err(dev,
 				"Auto-load skipped - BROM not in proper state (0x%x)\n",
@@ -768,6 +787,10 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+err_unregister_panic_notifier:
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &vk->panic_nb);
+
 err_destroy_workqueue:
 	destroy_workqueue(vk->wq_thread);
 
@@ -818,6 +841,10 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	bcm_vk_trigger_reset(vk);
 	usleep_range(BCM_VK_UCODE_BOOT_US, BCM_VK_UCODE_BOOT_MAX_US);
 
+	/* unregister panic notifier */
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &vk->panic_nb);
+
 	if (vk->tdma_vaddr)
 		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
 				  vk->tdma_vaddr, vk->tdma_addr);
-- 
2.17.1

