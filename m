Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDD27A317
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgI0T4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:56:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10070
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbgI0TzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:16 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169489"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:11 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] [ARM] pata_icside: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:13 +0200
Message-Id: <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/ata/pata_icside.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 08543aeb0093..498383cb6e29 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -202,14 +202,19 @@ static void pata_icside_set_dmamode(struct ata_port *ap, struct ata_device *adev
 	 * Choose the IOMD cycle timing which ensure that the interface
 	 * satisfies the measured active, recovery and cycle times.
 	 */
-	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425)
-		iomd_type = 'D', cycle = 187;
-	else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500)
-		iomd_type = 'C', cycle = 250;
-	else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750)
-		iomd_type = 'B', cycle = 437;
-	else
-		iomd_type = 'A', cycle = 562;
+	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425) {
+		iomd_type = 'D';
+		cycle = 187;
+	} else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500) {
+		iomd_type = 'C';
+		cycle = 250;
+	} else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750) {
+		iomd_type = 'B';
+		cycle = 437;
+	} else {
+		iomd_type = 'A';
+		cycle = 562;
+	}
 
 	ata_dev_info(adev, "timings: act %dns rec %dns cyc %dns (%c)\n",
 		     t.active, t.recover, t.cycle, iomd_type);

