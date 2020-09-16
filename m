Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86326C8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgIPS4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgIPRyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D77C02C2A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:37:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so6483997qtw.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7WcbKUPPxbeQt8ixskzStlnfuFA+V/XJXMjX7yrXV0=;
        b=EgGWh6aOJ5B3yJuM166960CzSqZSsJHZmbE7/UQH+gLJ5HCkxPTKyGhAInuwj2oFRv
         aenvTJYkBQi6rwPR27qeKDvDJHFruKcXOponwJiBLGg8bmteVLlfKlOlGOPAdfC9ninS
         q7sIqTK9cCFeYzYFXhWL4VoRnwuEghVX9Dk7+J3lQdPbUDsO+5hdEPwDN+RoWSdGNApE
         W8WLFgS0MLnuQlbhgH+4W0k/84FbZrO6/VjHIs5WlDVt7Aug5XOvra6zKxq2sqWR+dX9
         C8XbO/Y7vl6zCkqvYZWU2XKwMx+/zzctYz/swKOL2EbyPJNBzEfhhe3E6OJtDE73DdIL
         9mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7WcbKUPPxbeQt8ixskzStlnfuFA+V/XJXMjX7yrXV0=;
        b=cqtv3GFh+woG/hTAq/pdf0vEUnEkRyzH6SPh9llFEdajVPucPFjdtWNBb/kYnA8VHx
         8wi8Fvn7aLOKtya8q/4lwfuD3ebDdfTZ9hk9FKfuGbTkAlKlJRPrPvqiTwgaYQDWEu9g
         fliToaPQ9X/YSX+zpXCFaULI1CsCld8AeNPQLsBVuxYBS3u+JHTgXKntsyKKVXcLNERc
         fP4Vhb1ETtTe6jtCxprRgZXCANXN3ZKiT/aKy+X6HyBP0fGhxM2WhqtsrcoBvu5HmsZE
         UVeV13k2uXo3llajtcrDS5FfZIWwUhnjn8ekwT66484RPlZ1bMDMfUFbDS47iuJteoCk
         fxeg==
X-Gm-Message-State: AOAM532d2gTLT2qAwsW9HA/0rTbQOwIuAntO9Q381ZM/BTIByefpt+yc
        JJ/MSBjP/dyddF9BzCNIRgw=
X-Google-Smtp-Source: ABdhPJwZhqDHNnNTkdlx85xNr1AqH5VaNaGU7Kb8kQzIIfbAWn++79Syq7JYu8rckvtNdQBXoJknDA==
X-Received: by 2002:ac8:4806:: with SMTP id g6mr11113415qtq.380.1600270625931;
        Wed, 16 Sep 2020 08:37:05 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:d54e:5074:9d44:3698])
        by smtp.googlemail.com with ESMTPSA id e90sm19351210qtd.4.2020.09.16.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:37:05 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] nvme: fix doulbe irq free
Date:   Wed, 16 Sep 2020 11:37:00 -0400
Message-Id: <20200916153700.5572-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the irq might already been released before reset work can run

[   81.137630] ------------[ cut here ]------------
[   81.137913] Trying to free already-free IRQ 11
[   81.138145] WARNING: CPU: 1 PID: 7 at kernel/irq/manage.c:1751 free_irq+0x389/0x590
[   81.138525] Modules linked in:
[   81.138681] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.9.0-rc4+ #83
[   81.139579] Workqueue: nvme-reset-wq nvme_reset_work
[   81.139828] RIP: 0010:free_irq+0x389/0x590
[   81.140035] Code: 8b 65 50 e8 69 6d 1d 00 48 83 c4 38 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 8b 74 24 24 48 c7 c7 20 1c 86 8a e8 d7 8e f6 ff <0f0e
[   81.140951] RSP: 0000:ffff88806c06fb18 EFLAGS: 00010082
[   81.141216] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   81.141569] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffed100d80df55
[   81.141924] RBP: ffff88806cac88c0 R08: 0000000000000001 R09: ffffed100d80df29
[   81.142278] R10: 0000000000000003 R11: ffffed100d80df28 R12: ffff88806cac8800
[   81.142632] R13: ffff88806cac8870 R14: ffff88806cac8840 R15: ffff88806cac8960
[   81.142987] FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
[   81.143388] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.143673] CR2: 0000000000000000 CR3: 0000000026c0e000 CR4: 00000000000006e0
[   81.144028] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   81.144382] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   81.144734] Call Trace:
[   81.144862]  ? nvme_start_ctrl+0x180/0x180
[   81.145072]  pci_free_irq+0x13/0x20
[   81.145248]  nvme_reset_work+0xcf2/0x1ec0
[   81.145451]  ? __update_load_avg_cfs_rq+0x1a3/0x530
[   81.145695]  ? __update_load_avg_cfs_rq+0x4b/0x530
[   81.145935]  ? nvme_remove+0x1e0/0x1e0
[   81.146124]  ? ttwu_queue_wakelist+0x12e/0x150
[   81.146348]  ? try_to_wake_up+0x37c/0x900
[   81.146550]  ? migration_cpu_stop+0x1e0/0x1e0
[   81.146769]  ? __schedule+0x581/0xc40
[   81.146954]  ? read_word_at_a_time+0xe/0x20
[   81.147164]  ? strscpy+0xbf/0x190
[   81.147333]  process_one_work+0x4ad/0x7e0
[   81.147535]  worker_thread+0x73/0x690
[   81.147720]  ? process_one_work+0x7e0/0x7e0
[   81.147930]  kthread+0x199/0x1f0
[   81.148094]  ? kthread_create_on_node+0xd0/0xd0
[   81.148321]  ret_from_fork+0x22/0x30
[   81.148502] ---[ end trace 374ff42ced5b661f ]---

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/pci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7ab6..c2b083dcfd17 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2086,6 +2086,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	unsigned int nr_io_queues;
 	unsigned long size;
 	int result;
+	int adminq_irq_enabled = test_bit(NVMEQ_ENABLED, &adminq->flags);
 
 	/*
 	 * Sample the module parameters once at reset time so that we have
@@ -2133,14 +2134,16 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	adminq->q_db = dev->dbs;
 
  retry:
-	/* Deregister the admin queue's interrupt */
-	pci_free_irq(pdev, 0, adminq);
+	if (adminq_irq_enabled) {
+		/* Deregister the admin queue's interrupt */
+		pci_free_irq(pdev, 0, adminq);
 
-	/*
-	 * If we enable msix early due to not intx, disable it again before
-	 * setting up the full range we need.
-	 */
-	pci_free_irq_vectors(pdev);
+		/*
+		 * If we enable msix early due to not intx, disable it again before
+		 * setting up the full range we need.
+		 */
+		pci_free_irq_vectors(pdev);
+	}
 
 	result = nvme_setup_irqs(dev, nr_io_queues);
 	if (result <= 0)
@@ -2160,6 +2163,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result)
 		return result;
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
+	adminq_irq_enabled = 1;
 
 	result = nvme_create_io_queues(dev);
 	if (result || dev->online_queues < 2)
-- 
2.25.1

