Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73930229C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAYH5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 02:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbhAYHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:55:08 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E76C061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 23:45:36 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id LvlZ2400R4C55Sk01vlZrr; Mon, 25 Jan 2021 08:45:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l3wZ3-000a4e-6X; Mon, 25 Jan 2021 08:45:33 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l3wZ2-00Chaf-Hm; Mon, 25 Jan 2021 08:45:32 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joshua Thompson <funaho@jurai.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] macintosh/adb-iop: Use big-endian autopoll mask
Date:   Mon, 25 Jan 2021 08:45:24 +0100
Message-Id: <20210125074524.3027452-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

As usual, the available documentation is inadequate and leaves endianness
unspecified for message data. However, testing shows that this patch does
improve correctness. The mistake should have been detected earlier but it
was obscured by other bugs. In testing, this patch reinstated pre-v5.9
behaviour. The old driver bugs remain and ADB input devices may stop
working. But that appears to be unrelated.

Cc: Joshua Thompson <funaho@jurai.org>
Fixes: c66da95a39ec ("macintosh/adb-iop: Implement SRQ autopolling")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Link: https://lore.kernel.org/r/58ba6b4eaf4d27f971f86993039da208129087af.1610778455.git.fthain@telegraphics.com.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Resending on behalf of Finn, as his emails seem to be dropped by vger.

To be queued in the m68k tree for v5.12.

 drivers/macintosh/adb-iop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 0ee3272491501c52..2633bc254935cc49 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -19,6 +19,7 @@
 #include <asm/macints.h>
 #include <asm/mac_iop.h>
 #include <asm/adb_iop.h>
+#include <asm/unaligned.h>
 
 #include <linux/adb.h>
 
@@ -249,7 +250,7 @@ static void adb_iop_set_ap_complete(struct iop_msg *msg)
 {
 	struct adb_iopmsg *amsg = (struct adb_iopmsg *)msg->message;
 
-	autopoll_devs = (amsg->data[1] << 8) | amsg->data[0];
+	autopoll_devs = get_unaligned_be16(amsg->data);
 	if (autopoll_devs & (1 << autopoll_addr))
 		return;
 	autopoll_addr = autopoll_devs ? (ffs(autopoll_devs) - 1) : 0;
@@ -266,8 +267,7 @@ static int adb_iop_autopoll(int devs)
 	amsg.flags = ADB_IOP_SET_AUTOPOLL | (mask ? ADB_IOP_AUTOPOLL : 0);
 	amsg.count = 2;
 	amsg.cmd = 0;
-	amsg.data[0] = mask & 0xFF;
-	amsg.data[1] = (mask >> 8) & 0xFF;
+	put_unaligned_be16(mask, amsg.data);
 
 	iop_send_message(ADB_IOP, ADB_CHAN, NULL, sizeof(amsg), (__u8 *)&amsg,
 			 adb_iop_set_ap_complete);
-- 
2.25.1

