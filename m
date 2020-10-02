Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98682281D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgJBVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:24:27 -0400
Received: from mail-ua1-x963.google.com (mail-ua1-x963.google.com [IPv6:2607:f8b0:4864:20::963])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5CEC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:24:27 -0700 (PDT)
Received: by mail-ua1-x963.google.com with SMTP id d18so758249uav.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LZZPtr16SZgDb1uPYb5GxFp3EpLpzY9q7QFgqcTzhYw=;
        b=IytsHrQVjrTHTdCMe0SWr4xqu9+nwm5pDwcPN7arVvvJjsCI9a3HYhr32LQCna/XUB
         42TVu/QvPxUogwEhK7NzYorobs6HvQJ3pwR+rwqFVavdu1AtO/v6zMBa1VdEP2Seq0hn
         3KrtgguYT0SGuGoYhLiXD0avyp6+xSs3Wevgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LZZPtr16SZgDb1uPYb5GxFp3EpLpzY9q7QFgqcTzhYw=;
        b=MdhKC4+CL/hktKAEOMfHbieWFj2xM3AeXrOLAcgrP40h13mU4GXoEi75aYg4K7DG2m
         uBMlxRe10BFY5RuGMlEzaI5xA6TFMlrHMea4ciyTfYt7juKgjJFlyNe9q/Q+97E4tctU
         drACR3T8bqKvjduIJcKXJJ1lIIY4WfOyDqgqKR+E1L/aOssEsQA5Nk+AMd0Q2jb4U3IC
         bmx3CAZKr+LPfdhBjr02OtiYSi1NMQQOMENDI7AV1f71Mf327nWHXc/7hX563kzx57zS
         G9yXZIrwH9CxH8txAIcC6VmW1RsbwMyRTZb7G9OTPdJmDSyiPPsD8OHxzwc72Nm68/ne
         NPZw==
X-Gm-Message-State: AOAM533j98GyikdF4xMdvzBk5cNWPVcvtfDVqdgBh+QmoeR5Dab6ghlW
        rnTErCj+1V09XcMwR0cdGGW94AC6/k8AwSkKUGhYeIMABeUv
X-Google-Smtp-Source: ABdhPJwaXO3ubiSYkfg3JapP08BkuVuQmSKDY9FOCL4p/245oYphiokClxHebiPaxsA0Xt+69h+jheDjgvJC
X-Received: by 2002:ab0:20b6:: with SMTP id y22mr2375439ual.30.1601673866277;
        Fri, 02 Oct 2020 14:24:26 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:24:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 05/14] misc: bcm-vk: add triggers when host panic or reboots to notify card
Date:   Fri,  2 Oct 2020 14:23:18 -0700
Message-Id: <20201002212327.18393-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002212327.18393-1-scott.branden@broadcom.com>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
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
index c7bedd975609..1755493b3096 100644
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
@@ -743,6 +753,15 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -751,7 +770,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (auto_load) {
 		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
 			if (bcm_vk_trigger_autoload(vk))
-				goto err_destroy_workqueue;
+				goto err_unregister_panic_notifier;
 		} else {
 			dev_err(dev,
 				"Auto-load skipped - BROM not in proper state (0x%x)\n",
@@ -763,6 +782,10 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+err_unregister_panic_notifier:
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &vk->panic_nb);
+
 err_destroy_workqueue:
 	destroy_workqueue(vk->wq_thread);
 
@@ -813,6 +836,10 @@ static void bcm_vk_remove(struct pci_dev *pdev)
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

