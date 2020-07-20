Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9492259E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGTIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 04:21:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7789 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbgGTIVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:21:00 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CE554F8A41BB1BB5468;
        Mon, 20 Jul 2020 16:20:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 16:20:47 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] dlmfs: add a newline when printing 'capabilities' by sysfs
Date:   Mon, 20 Jul 2020 16:24:33 +0800
Message-ID: <20200720082433.164311-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I cat module parameter 'capabilities' by sysfs, it displays as
follows. It's better to add a newline for easy reading.

root@syzkaller:~# cat /sys/module/ocfs2_dlmfs/parameters/capabilities
bast stackglueroot@syzkaller:~#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 fs/ocfs2/dlmfs/dlmfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index ea868c6f9800..1f9c864ec09b 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -82,8 +82,13 @@ static int param_set_dlmfs_capabilities(const char *val,
 static int param_get_dlmfs_capabilities(char *buffer,
 					const struct kernel_param *kp)
 {
-	return strlcpy(buffer, DLMFS_CAPABILITIES,
+	int cnt;
+
+	cnt = strlcpy(buffer, DLMFS_CAPABILITIES,
 		       strlen(DLMFS_CAPABILITIES) + 1);
+	cnt += sprintf(buffer + cnt, "\n");
+
+	return cnt;
 }
 module_param_call(capabilities, param_set_dlmfs_capabilities,
 		  param_get_dlmfs_capabilities, NULL, 0444);
-- 
2.20.1

