Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76F6271CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIUICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:02:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbgIUICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DDEAA75F753DD7AEB02D;
        Mon, 21 Sep 2020 16:02:09 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:01:59 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "Hridya Valsaraju" <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] binder: simplify the return expression of binder_mmap
Date:   Mon, 21 Sep 2020 16:24:23 +0800
Message-ID: <20200921082423.2590938-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/android/binder.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 37a505c41dec..1f929e0cf39f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5204,10 +5204,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_ops = &binder_vm_ops;
 	vma->vm_private_data = proc;
 
-	ret = binder_alloc_mmap_handler(&proc->alloc, vma);
-	if (ret)
-		return ret;
-	return 0;
+	return binder_alloc_mmap_handler(&proc->alloc, vma);
 
 err_bad_arg:
 	pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
-- 
2.25.1

