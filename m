Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCED2E34BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 08:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgL1HbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 02:31:16 -0500
Received: from m15112.mail.126.com ([220.181.15.112]:57632 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgL1HbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4bN5TazYP/jykDtSj/
        f9oCTklehR20y16aUvrC+oRXo=; b=CARTJhxtjUsz6iaV4RIFDFjiS+fb0wRbBh
        PJTIaMDNLeh04DzyZt4BvNIkPYO9X0ksg+MIQO+9he4Kw2xf1oUObxcVPtkqdNZf
        xS5f5zyukrSgVEN95Af4yTAH4VZgsVsbZV5CVzCAGZ+Ux0mOFRanbc5SayKkzfLy
        JFi4J3fZU=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp2 (Coremail) with SMTP id DMmowAB3fqonSelfE1NwKg--.26949S2;
        Mon, 28 Dec 2020 10:55:35 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH] dm snap : add sanity checks to snapshot_ctr
Date:   Mon, 28 Dec 2020 10:55:23 +0800
Message-Id: <1609124123-232214-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowAB3fqonSelfE1NwKg--.26949S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4DXFW7CF43tF1DKrW7Arb_yoWfArc_Cw
        1Svry7Gr48Gr1j9rW5Ar48ZF9rKws5uF1kZF1Ikw1fArykZry3Ar4jgr12qr1Duw42kF15
        ur9xG3yrArnFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUfHUPUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiaQcJ11pEBDLf1AAAsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<70de2cbda8a5>("dm thin: add sanity checks
to thin-pool and external snapshot creation"),there should be a check
for argc and argv to prevent Null pointer dereferencing when the dm_get_device
invoked twice on the same device path with differnt mode.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/md/dm-snap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 4668b2c..dccce8b 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1258,6 +1258,13 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	as.argc = argc;
 	as.argv = argv;
+
+	if (!strcmp(argv[0], argv[1])) {
+		ti->error = "Error setting metadata or data device";
+		r = -EINVAL;
+		goto bad;
+	}
+
 	dm_consume_args(&as, 4);
 	r = parse_snapshot_features(&as, s, ti);
 	if (r)
-- 
2.7.4

