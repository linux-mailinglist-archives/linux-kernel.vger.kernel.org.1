Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECF261CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgIHTZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbgIHQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:01:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650FC06138D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:00:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so11330465pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vpAOYUtfsOyAnKG5VAGbK9i/Ip7+aawrrhrrv5e7Aow=;
        b=DHiHSRmdwnpe9Sg4vtxogrU6LNpUMPIbwowsPQSZ4Qn+mF18yhnFU8kO2aEIWCVtIM
         hnhRKBaS0yLhCwwQ4e0GAkXR2N66ArjCg7+buhT4CQh2X58AbHazwqLau+sjnm7Aw2eT
         cW7BbZ4Qspb8yoskJd9qETBbFq63naV1F8qyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vpAOYUtfsOyAnKG5VAGbK9i/Ip7+aawrrhrrv5e7Aow=;
        b=aTtO5KfegzR1fjO0G6OH5JAUh7ZA6AWZKdBgze4P8IqEhkLKAaZSs0UGzLTxpR1RXa
         eUfsLz80FT/56qz8uVUIGfwIaPrIbfYTDzSZegv0IDub8+bro8ZCIZ3J4YcZB4U4OYlM
         CzYZnsde6oPL0WzYBmO7k2yBBsatITI4CV97maHdCGnNwfGFNX8dHLuc6g1CDuzRH8eR
         Rj2BZkqWdCdO9RQQcdsJIAcgyG1BVyLj/l2SMhBh7aqaustbrvFxCFnJsHitz1IPS6GJ
         pVL9LPqbfb6kO2exSsNW9PzmbTW6XAqPKJKkDAUOd2GlCW7FfHBbEvG4+xDt/gh2PCJK
         SkNw==
X-Gm-Message-State: AOAM532M+VJ9gYHwam5pK2J++Eaf/eTXYv1io80zHttkWFi6pK/BNAYO
        bzjRI79PNs9p93MnUYPnODUnEA==
X-Google-Smtp-Source: ABdhPJxWIMWaWhzEvTVzBuaT+oyuChEp91L5TLAPvVk6VB4cN5C6rNjeqsZ4mBDuySD1iXChOWA8hQ==
X-Received: by 2002:a17:902:ff12:: with SMTP id f18mr24272185plj.118.1599580819032;
        Tue, 08 Sep 2020 09:00:19 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id z4sm3657280pfr.197.2020.09.08.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:00:18 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Scott Teel <scott.teel@microsemi.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: hpsa: fix memory leak in hpsa_init_one
Date:   Tue,  8 Sep 2020 15:59:56 +0000
Message-Id: <20200908155957.18921-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9f7795b2-42c6-426f-12b6-9dfbd4fdb3a9@web.de>
References: <9f7795b2-42c6-426f-12b6-9dfbd4fdb3a9@web.de>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hpsa_scsi_add_host fails, h->lastlogicals is leaked since it lacks
free in the error handler.

Fix this by adding free when hpsa_scsi_add_host fails.

This patch also renames the numbered labels to detailed names.

Fixes: cf47723763a7 ("hpsa: correct initialization order issue")
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/scsi/hpsa.c | 52 +++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 48d5da59262b..4911ca22efe4 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -8691,19 +8691,19 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!h->lockup_detected) {
 		dev_err(&h->pdev->dev, "Failed to allocate lockup detector\n");
 		rc = -ENOMEM;
-		goto clean1;	/* aer/h */
+		goto out_destroy_workqueue;	/* aer/h */
 	}
 	set_lockup_detected_for_all_cpus(h, 0);
 
 	rc = hpsa_pci_init(h);
 	if (rc)
-		goto clean2;	/* lu, aer/h */
+		goto out_free_lockup_detected;	/* lu, aer/h */
 
 	/* relies on h-> settings made by hpsa_pci_init, including
 	 * interrupt_mode h->intr */
 	rc = hpsa_scsi_host_alloc(h);
 	if (rc)
-		goto clean2_5;	/* pci, lu, aer/h */
+		goto out_free_pci_init;	/* pci, lu, aer/h */
 
 	sprintf(h->devname, HPSA "%d", h->scsi_host->host_no);
 	h->ctlr = number_of_controllers;
@@ -8719,7 +8719,7 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			dac = 0;
 		} else {
 			dev_err(&pdev->dev, "no suitable DMA available\n");
-			goto clean3;	/* shost, pci, lu, aer/h */
+			goto out_scsi_host_put;	/* shost, pci, lu, aer/h */
 		}
 	}
 
@@ -8728,13 +8728,13 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = hpsa_request_irqs(h, do_hpsa_intr_msi, do_hpsa_intr_intx);
 	if (rc)
-		goto clean3;	/* shost, pci, lu, aer/h */
+		goto out_scsi_host_put;	/* shost, pci, lu, aer/h */
 	rc = hpsa_alloc_cmd_pool(h);
 	if (rc)
-		goto clean4;	/* irq, shost, pci, lu, aer/h */
+		goto out_free_irqs;	/* irq, shost, pci, lu, aer/h */
 	rc = hpsa_alloc_sg_chain_blocks(h);
 	if (rc)
-		goto clean5;	/* cmd, irq, shost, pci, lu, aer/h */
+		goto out_free_cmd_pool;	/* cmd, irq, shost, pci, lu, aer/h */
 	init_waitqueue_head(&h->scan_wait_queue);
 	init_waitqueue_head(&h->event_sync_wait_queue);
 	mutex_init(&h->reset_mutex);
@@ -8747,25 +8747,25 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	spin_lock_init(&h->devlock);
 	rc = hpsa_put_ctlr_into_performant_mode(h);
 	if (rc)
-		goto clean6; /* sg, cmd, irq, shost, pci, lu, aer/h */
+		goto out_free_sg_chain_blocks; /* sg, cmd, irq, shost, pci, lu, aer/h */
 
 	/* create the resubmit workqueue */
 	h->rescan_ctlr_wq = hpsa_create_controller_wq(h, "rescan");
 	if (!h->rescan_ctlr_wq) {
 		rc = -ENOMEM;
-		goto clean7;
+		goto out_free_performant_mode;
 	}
 
 	h->resubmit_wq = hpsa_create_controller_wq(h, "resubmit");
 	if (!h->resubmit_wq) {
 		rc = -ENOMEM;
-		goto clean7;	/* aer/h */
+		goto out_free_performant_mode;	/* aer/h */
 	}
 
 	h->monitor_ctlr_wq = hpsa_create_controller_wq(h, "monitor");
 	if (!h->monitor_ctlr_wq) {
 		rc = -ENOMEM;
-		goto clean7;
+		goto out_free_performant_mode;
 	}
 
 	/*
@@ -8795,20 +8795,20 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			 * cannot goto clean7 or free_irqs will be called
 			 * again. Instead, do its work
 			 */
-			hpsa_free_performant_mode(h);	/* clean7 */
-			hpsa_free_sg_chain_blocks(h);	/* clean6 */
-			hpsa_free_cmd_pool(h);		/* clean5 */
+			hpsa_free_performant_mode(h);	/* out_free_performant_mode */
+			hpsa_free_sg_chain_blocks(h);	/* out_free_sg_chain_blocks */
+			hpsa_free_cmd_pool(h);		/* out_free_cmd_pool */
 			/*
 			 * skip hpsa_free_irqs(h) clean4 since that
 			 * was just called before request_irqs failed
 			 */
-			goto clean3;
+			goto out_scsi_host_put;
 		}
 
 		rc = hpsa_kdump_soft_reset(h);
 		if (rc)
 			/* Neither hard nor soft reset worked, we're hosed. */
-			goto clean7;
+			goto out_free_performant_mode;
 
 		dev_info(&h->pdev->dev, "Board READY.\n");
 		dev_info(&h->pdev->dev,
@@ -8854,7 +8854,7 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* hook into SCSI subsystem */
 	rc = hpsa_scsi_add_host(h);
 	if (rc)
-		goto clean7; /* perf, sg, cmd, irq, shost, pci, lu, aer/h */
+		goto out_free_lastlogicals; /* ll, perf, sg, cmd, irq, shost, pci, lu, aer/h */
 
 	/* Monitor the controller for firmware lockups */
 	h->heartbeat_sample_interval = HEARTBEAT_SAMPLE_INTERVAL;
@@ -8869,26 +8869,28 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				HPSA_EVENT_MONITOR_INTERVAL);
 	return 0;
 
-clean7: /* perf, sg, cmd, irq, shost, pci, lu, aer/h */
+out_free_lastlogicals: /* ll, perf, sg, cmd, irq, shost, pci, lu, aer/h */
+	kfree(h->lastlogicals);
+out_free_performant_mode: /* perf, sg, cmd, irq, shost, pci, lu, aer/h */
 	hpsa_free_performant_mode(h);
 	h->access.set_intr_mask(h, HPSA_INTR_OFF);
-clean6: /* sg, cmd, irq, pci, lockup, wq/aer/h */
+out_free_sg_chain_blocks: /* sg, cmd, irq, pci, lockup, wq/aer/h */
 	hpsa_free_sg_chain_blocks(h);
-clean5: /* cmd, irq, shost, pci, lu, aer/h */
+out_free_cmd_pool: /* cmd, irq, shost, pci, lu, aer/h */
 	hpsa_free_cmd_pool(h);
-clean4: /* irq, shost, pci, lu, aer/h */
+out_free_irqs: /* irq, shost, pci, lu, aer/h */
 	hpsa_free_irqs(h);
-clean3: /* shost, pci, lu, aer/h */
+out_scsi_host_put: /* shost, pci, lu, aer/h */
 	scsi_host_put(h->scsi_host);
 	h->scsi_host = NULL;
-clean2_5: /* pci, lu, aer/h */
+out_free_pci_init: /* pci, lu, aer/h */
 	hpsa_free_pci_init(h);
-clean2: /* lu, aer/h */
+out_free_lockup_detected: /* lu, aer/h */
 	if (h->lockup_detected) {
 		free_percpu(h->lockup_detected);
 		h->lockup_detected = NULL;
 	}
-clean1:	/* wq/aer/h */
+out_destroy_workqueue:	/* wq/aer/h */
 	if (h->resubmit_wq) {
 		destroy_workqueue(h->resubmit_wq);
 		h->resubmit_wq = NULL;
-- 
2.17.1

