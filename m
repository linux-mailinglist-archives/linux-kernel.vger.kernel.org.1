Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8741B38B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:18:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgDVHSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:18:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA23056838887462EB84;
        Wed, 22 Apr 2020 15:18:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:18:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <zohar@linux.ibm.com>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ima: return false in is_ima_appraise_enabled()
Date:   Wed, 22 Apr 2020 15:17:54 +0800
Message-ID: <20200422071754.48672-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

include/linux/ima.h:132:8-9: WARNING: return of 0/1 in function
'is_ima_appraise_enabled' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/linux/ima.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index aefe758f4466..4cb28550fcbc 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -129,7 +129,7 @@ extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
-	return 0;
+	return false;
 }
 
 static inline void ima_inode_post_setattr(struct dentry *dentry)
-- 
2.21.1

