Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C210627B8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgI2AMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgI2AMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:12:51 -0400
Received: from mail-pj1-x1061.google.com (mail-pj1-x1061.google.com [IPv6:2607:f8b0:4864:20::1061])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1319C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:51 -0700 (PDT)
Received: by mail-pj1-x1061.google.com with SMTP id fa1so1699821pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6JeUyT1Z8rPrwNHJT24kJktODFrDt8FRwi/0sWykrY=;
        b=c/Tfn3JN/UgKQpSpG5aTmC4mfgGlLMtE1IOyJt3YCL5eoHcriuef/R9p9RbW1ZIUTm
         WZdM0rUiEnLYwVOGBlKqRzUePh5Q8RkcSLyDEDlHVc4sIkawX7KAo5he6b7gWoQRvJio
         +56FH/4mXbbOqTgjESdtCfu/LK5gCTPLhzJ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6JeUyT1Z8rPrwNHJT24kJktODFrDt8FRwi/0sWykrY=;
        b=ZKbaS4JB2+UC84G76T+rjwAWBJoc4cuEZeCt7ZbF1HlgFIPiymOM2PnWIwvLsZNHVm
         xIq76ICjDRpK+4+i523eHsCXNy/WBMgpnLoDNPlkG4JP/d29g7PxQIBFGkCehuBch0yf
         Rk9f7NzvUtotSs5rzVLOAaznV+qN6v/3c6lxZi9UIKB8U8bIKtd8QrOH4rKd3eQw68Md
         43VQEIBcYeMfc5qg62w+YzCnRwg/2kriTcor5nYtuFZ0e53FRccQCtxMblQefKv8DvUw
         GhslLTzOgtJmP5P+ssHQjR/Inro6C2vd9kfaBNt3sEiOAUxlo8fgs9vd8daGRmxnC2gp
         zVPA==
X-Gm-Message-State: AOAM531agIJrSgWVr6Z9IO7Ln8QlApSI3tdhRA0ihpKwyZlMLo6IN4fM
        +ccYNH4hp2kMS+9G9DYPDXFVK7w44dmUtrxFUBxyNS874pvn
X-Google-Smtp-Source: ABdhPJzVA9XQs2o16uLNVjoYnSjkzUI6aBwQ0b/M/dh+Eq9l36viREcbCpDtrhWo7FuRmPxhW3fH2gDx802D
X-Received: by 2002:a17:90a:de87:: with SMTP id n7mr1446942pjv.208.1601338371313;
        Mon, 28 Sep 2020 17:12:51 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:12:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v4 05/16] misc: bcm-vk: add triggers when host panic or reboots to notify card
Date:   Mon, 28 Sep 2020 17:11:58 -0700
Message-Id: <20200929001209.16393-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
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
index cb2e315881d6..0782e2cff36d 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -630,6 +630,16 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
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
@@ -742,6 +752,15 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -750,7 +769,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (auto_load) {
 		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
 			if (bcm_vk_trigger_autoload(vk))
-				goto err_destroy_workqueue;
+				goto err_unregister_panic_notifier;
 		} else {
 			dev_err(dev,
 				"Auto-load skipped - BROM not in proper state (0x%x)\n",
@@ -762,6 +781,10 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+err_unregister_panic_notifier:
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &vk->panic_nb);
+
 err_destroy_workqueue:
 	destroy_workqueue(vk->wq_thread);
 
@@ -809,6 +832,10 @@ static void bcm_vk_remove(struct pci_dev *pdev)
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

