Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410842F53C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbhAMUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:00:34 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:61233 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhAMUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:00:33 -0500
Received: from [84.39.76.69] (helo=thinkstation.fritz.box)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <vogelchr@vogel.cx>)
        id 1kzm9z-0006Vv-Go; Wed, 13 Jan 2021 20:50:27 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, vogelchr@vogel.cx, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] w1/masters/ds2490: queue up found IDs during scan
Date:   Wed, 13 Jan 2021 20:50:18 +0100
Message-Id: <20210113195018.7498-3-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113195018.7498-1-vogelchr@vogel.cx>
References: <20210113195018.7498-1-vogelchr@vogel.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queue up found IDs in a buffer and run the callback once for each found ID
at the end. This is necessary because we hold the bus_mutex during the
whole scan, and some of the "add-device" callbacks deadlock as they
themselves want to mutex_lock(bus_mutex).

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
---
 drivers/w1/masters/ds2490.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index e17c8f70dcd0..cd8821580f71 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -688,12 +688,22 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	 * packet size.
 	 */
 	const size_t bufsize = 2 * 64;
-	u64 *buf;
+	u64 *buf, *found_ids;
 
 	buf = kmalloc(bufsize, GFP_KERNEL);
 	if (!buf)
 		return;
 
+	/*
+	 * We are holding the bus mutex during the scan, but adding devices via the
+	 * callback needs the bus to be unlocked. So we queue up found ids here.
+	 */
+	found_ids = kmalloc_array(master->max_slave_count, sizeof(u64), GFP_KERNEL);
+	if (!found_ids) {
+		kfree(buf);
+		return;
+	}
+
 	mutex_lock(&master->bus_mutex);
 
 	/* address to start searching at */
@@ -729,13 +739,13 @@ static void ds9490r_search(void *data, struct w1_master *master,
 			if (err < 0)
 				break;
 			for (i = 0; i < err/8; ++i) {
-				++found;
-				if (found <= search_limit)
-					callback(master, buf[i]);
+				found_ids[found++] = buf[i];
 				/* can't know if there will be a discrepancy
 				 * value after until the next id */
-				if (found == search_limit)
+				if (found == search_limit) {
 					master->search_id = buf[i];
+					break;
+				}
 			}
 		}
 
@@ -759,9 +769,14 @@ static void ds9490r_search(void *data, struct w1_master *master,
 			master->max_slave_count);
 		set_bit(W1_WARN_MAX_COUNT, &master->flags);
 	}
+
 search_out:
 	mutex_unlock(&master->bus_mutex);
 	kfree(buf);
+
+	for (i = 0; i < found; i++) /* run callback for all queued up IDs */
+		callback(master, found_ids[i]);
+	kfree(found_ids);
 }
 
 #if 0
-- 
2.30.0

