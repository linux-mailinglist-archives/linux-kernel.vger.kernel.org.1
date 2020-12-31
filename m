Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427BF2E7DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 05:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgLaELq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 23:11:46 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:35578 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgLaELq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 23:11:46 -0500
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id F25971BED;
        Thu, 31 Dec 2020 12:05:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.70])
        by smtp.263.net (postfix) whith ESMTP id P25766T139972080289536S1609387543054560_;
        Thu, 31 Dec 2020 12:05:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bca5b2d8096ff06bf864537c773c2a28>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: joseph.qi@linux.alibaba.com
X-SENDER-IP: 14.18.236.70
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Yi Li <yili@winhong.com>
To:     joseph.qi@linux.alibaba.com
Cc:     mark@fasheh.com, yilikernel@gmail.com, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Yi Li <yili@winhong.com>
Subject: [PATCH] ocfs2: Remove redundant conditional before iput
Date:   Thu, 31 Dec 2020 12:05:35 +0800
Message-Id: <20201231040535.4091761-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput handles NULL pointers gracefully, so there's no need to
check the pointer before the call.

Signed-off-by: Yi Li <yili@winhong.com>
---
 fs/ocfs2/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 2febc76e9de7..079f8826993e 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -973,8 +973,6 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
 		 * quota files */
 		dquot_disable(sb, type, DQUOT_USAGE_ENABLED |
 					DQUOT_LIMITS_ENABLED);
-		if (!inode)
-			continue;
 		iput(inode);
 	}
 }
-- 
2.25.3



