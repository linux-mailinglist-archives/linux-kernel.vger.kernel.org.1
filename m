Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB2C267EEE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgIMJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 05:30:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbgIMJaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:30:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6009F797E9B7686821C7;
        Sun, 13 Sep 2020 17:30:04 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sun, 13 Sep 2020
 17:29:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: mmap: Use helper function allow_write_access() in __remove_shared_vm_struct()
Date:   Sun, 13 Sep 2020 05:28:38 -0400
Message-ID: <20200913092838.27724-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper function allow_write_access() to atomic_inc the i_writecount.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 80ea11bf12fa..a22f1a2fc82e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -143,7 +143,7 @@ static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
 	if (vma->vm_flags & VM_DENYWRITE)
-		atomic_inc(&file_inode(file)->i_writecount);
+		allow_write_access(file);
 	if (vma->vm_flags & VM_SHARED)
 		mapping_unmap_writable(mapping);
 
-- 
2.19.1

