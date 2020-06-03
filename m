Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B891ECAC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 09:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 03:48:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:48:33 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jgO8S-0008I8-SH; Wed, 03 Jun 2020 07:48:29 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     axboe@kernel.dk
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        John Garry <john.garry@huawei.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] libata: Use per port sync for detach
Date:   Wed,  3 Jun 2020 15:48:19 +0800
Message-Id: <20200603074819.21639-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 130f4caf145c ("libata: Ensure ata_port probe has completed before
detach") may cause system freeze during suspend.

Using async_synchronize_full() in PM callbacks is wrong, since async
callbacks that are already scheduled may wait for not-yet-scheduled
callbacks, causes a circular dependency.

Instead of using big hammer like async_synchronize_full(), use async
cookie to make sure port probe are synced, without affecting other
scheduled PM callbacks.

Fixes: 130f4caf145c ("libata: Ensure ata_port probe has completed before detach")
BugLink: https://bugs.launchpad.net/bugs/1867983
Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Move the comment to properly align with the code.

v2:
 - Sync up to cookie + 1.
 - Squash the synchronization into the same loop.

 drivers/ata/libata-core.c | 11 +++++------
 include/linux/libata.h    |  3 +++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 69361ec43db5..b1cd4d97bc2a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -42,7 +42,6 @@
 #include <linux/workqueue.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
-#include <linux/async.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/glob.h>
@@ -5778,7 +5777,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	/* perform each probe asynchronously */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		async_schedule(async_port_probe, ap);
+		ap->cookie = async_schedule(async_port_probe, ap);
 	}
 
 	return 0;
@@ -5920,11 +5919,11 @@ void ata_host_detach(struct ata_host *host)
 {
 	int i;
 
-	/* Ensure ata_port probe has completed */
-	async_synchronize_full();
-
-	for (i = 0; i < host->n_ports; i++)
+	for (i = 0; i < host->n_ports; i++) {
+		/* Ensure ata_port probe has completed */
+		async_synchronize_cookie(host->ports[i]->cookie + 1);
 		ata_port_detach(host->ports[i]);
+	}
 
 	/* the host is dead now, dissociate ACPI */
 	ata_acpi_dissociate(host);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index af832852e620..8a4843704d28 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
+#include <linux/async.h>
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -872,6 +873,8 @@ struct ata_port {
 	struct timer_list	fastdrain_timer;
 	unsigned long		fastdrain_cnt;
 
+	async_cookie_t		cookie;
+
 	int			em_message_type;
 	void			*private_data;
 
-- 
2.17.1

