Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07AF2E2A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 07:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgLYGuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 01:50:01 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:60115 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLYGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 01:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=q44g5Wp9PwQPDBfj1X
        gltU+ihLSZpsg3RSXqKkWe7jM=; b=qByw22xosoDG+R59qO/VY4DkR+9VHJ8mM/
        adlbmVsj66R909esg93mZpw1WsDnDr9B+cCYlJ/mKr/IJeVsb13xgedOjcZHoIXF
        0641jr24/YupxXDkPidgaZEQkNTJvmCyQ98LdSV7JywsKuBnYxYrvb4I6dl8lUf+
        1Mjup01ZE=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowADX2ORVi+Vf3GKZNA--.62093S2;
        Fri, 25 Dec 2020 14:48:54 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH] dm snap : add sanity checks to snapshot_ctr
Date:   Fri, 25 Dec 2020 14:48:46 +0800
Message-Id: <1608878926-2283057-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowADX2ORVi+Vf3GKZNA--.62093S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1fuw4fCrW8Ww15ZrWxCrg_yoW3urX_C3
        4Fvry7GrW8CF109rWYyw4xZF9xKws5uFn7uF1xKa1fArykZry3CF4jgr13Kr1Du3y2kF4U
        Cr9xG3yrZrnIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUBOJ7UUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiCxYG11x5co4gBwAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<70de2cbd>,there should be a check for argc and argv to prevent Null pointer dereferencing
when the dm_get_device invoked twice on the same device path with differnt mode.

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

