Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604A32C6687
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgK0NN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:13:57 -0500
Received: from know-smtprelay-omc-5.server.virginmedia.net ([80.0.253.69]:39504
        "EHLO know-smtprelay-omc-5.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgK0NN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:13:56 -0500
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 08:13:55 EST
Received: from localhost.localdomain ([81.111.144.241])
        by cmsmtp with ESMTPA
        id idTwk4wUMJ4GLidTzkC7Tb; Fri, 27 Nov 2020 13:08:21 +0000
X-Originating-IP: [81.111.144.241]
X-Authenticated-User: yevhen.viktorov@virginmedia.com
X-Spam: 0
X-Authority: v=2.3 cv=Wu8Fz+Xv c=1 sm=1 tr=0 a=aPpzF8rvisTCf/6YdwUVag==:117
 a=aPpzF8rvisTCf/6YdwUVag==:17 a=NcN59idvAAAA:8 a=Svj1eyx6_mu90rxhUQgA:9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virginmedia.com;
        s=meg.feb2017; t=1606482501;
        bh=ugDgXZ/mn3X+une9KYM30/NSns80QOQiGUn6HIXILEI=;
        h=From:To:Cc:Subject:Date;
        b=MigVQfWa71ca9d9UgvbO5BnENfCamstPEYyxkMcwThVJiyhTVkMcDvaVsi4iiaUeD
         VHPElBVbROouLNKfGtt2Tx0DgwAY3AnEzmInptroOefEsk96HU7qtAEMJOjGMrv45B
         DsqKoYcQqGsJH6ffuL6QRNqvIabutqwkAa8M29G4gd8OFzjckd+s/u1IN2fsD8ee1i
         VYRR28rZ0+z+FSNDpxPDKla4cVKJl4Y+ZEXqhbwpyCFFnriVofMiQyKeLbo8i32T2y
         9seneB8M4yoVO/mnFCpwE7T+1s8re29TrMdc88E6cvxY6SeTqgr7dQwUKQ5by4Brzb
         KvGKi1xIX0MmA==
From:   Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
To:     maier@linux.ibm.com
Cc:     bblock@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
Subject: [PATCH] scsi: zfcp: fix indentation coding style issue
Date:   Fri, 27 Nov 2020 13:06:46 +0000
Message-Id: <20201127130646.11427-1-yevhen.viktorov@virginmedia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCEBiHQe11O3hO3vti9Bxo3lO2jnNnR+Nb3J4Xb03+SxbGZxZxQEH3pSvzMWZvHpBazyHhI86qXRwksPZcs713S2JXfy4h5XMwJ7ZBqvLB+8X62mj5qq
 dwE+KOUXa5piCnCzruM+kZLR9aPYS8MjHMf1EQSt2uh6u7V87q8N702Vu1InWVHSaKiw68gHs7zAKkDXfZspnXwsJUWZhEukDoVqO+Udh/JU8s1h7Wg9HEHA
 0lhYOK5nnGZcySVy5fX/9kaC8mWmxPezCQLZFx40ofCASygs/8VtqIcEAlOdRwH4nk9CcrDVCTGVtNaqkAUCE1iTTwNYQ9viz15hRnHPMEHZFcOud3r9ngbd
 v+ViTKRJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code indent should use tabs where possible

Signed-off-by: Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
---
 drivers/s390/scsi/zfcp_def.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
index da8a5ceb615c..a2a59cbb330a 100644
--- a/drivers/s390/scsi/zfcp_def.h
+++ b/drivers/s390/scsi/zfcp_def.h
@@ -157,7 +157,7 @@ struct zfcp_adapter {
 	u32			fsf_lic_version;
 	u32			adapter_features;  /* FCP channel features */
 	u32			connection_features; /* host connection features */
-        u32			hardware_version;  /* of FCP channel */
+	u32			hardware_version;  /* of FCP channel */
 	u32			fc_security_algorithms; /* of FCP channel */
 	u32			fc_security_algorithms_old; /* of FCP channel */
 	u16			timer_ticks;       /* time int for a tick */
@@ -181,7 +181,7 @@ struct zfcp_adapter {
 	rwlock_t		erp_lock;
 	wait_queue_head_t	erp_done_wqh;
 	struct zfcp_erp_action	erp_action;	   /* pending error recovery */
-        atomic_t                erp_counter;
+	atomic_t                erp_counter;
 	u32			erp_total_count;   /* total nr of enqueued erp
 						      actions */
 	u32			erp_low_mem_count; /* nr of erp actions waiting
@@ -217,7 +217,7 @@ struct zfcp_port {
 	u32		       d_id;	       /* D_ID */
 	u32		       handle;	       /* handle assigned by FSF */
 	struct zfcp_erp_action erp_action;     /* pending error recovery */
-        atomic_t               erp_counter;
+	atomic_t               erp_counter;
 	u32                    maxframe_size;
 	u32                    supported_classes;
 	u32                    connection_info;
-- 
2.26.2

