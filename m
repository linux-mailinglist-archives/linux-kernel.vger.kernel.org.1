Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07FB19D05F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 08:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgDCGmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 02:42:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387677AbgDCGmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:42:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D37F9E26563865F4D2F7;
        Fri,  3 Apr 2020 14:41:07 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 14:40:56 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <akpm@linux-foundation.org>, <manfred@colorfullife.com>,
        <sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ipc: shm: make compat_ksys_shmctl() static
Date:   Fri, 3 Apr 2020 14:39:33 +0800
Message-ID: <20200403063933.24785-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

ipc/shm.c:1335:6: warning: symbol 'compat_ksys_shmctl' was not declared.
Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 ipc/shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index ce1ca9f7c6e9..0ba6add05b35 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1332,7 +1332,7 @@ static int copy_compat_shmid_from_user(struct shmid64_ds *out, void __user *buf,
 	}
 }
 
-long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr, int version)
+static long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr, int version)
 {
 	struct ipc_namespace *ns;
 	struct shmid64_ds sem64;
-- 
2.17.2

