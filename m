Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A874267EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgIMJRb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 05:17:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:52130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgIMJRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:17:30 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id EA43EF3F22477375D622;
        Sun, 13 Sep 2020 17:17:26 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 13 Sep 2020 17:17:26 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Sun, 13 Sep 2020 17:17:26 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaJrTlueAioeGR0Qvi/fuCv5/iZ+g==
Date:   Sun, 13 Sep 2020 09:17:26 +0000
Message-ID: <b79fec71e858499cbd420914da12fcdf@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
Hillf Danton <hdanton@sina.com> wrote:
> Tue, 08 Sep 2020 17:19:17 -0700
>> syzbot found the following issue on:
>> general protection fault, probably for non-canonical address 
>> 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: maybe wild-memory-access in range 
>> [0x00777770000001d8-0x00777770000001df]
...
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>Looks like d70cec898324 ("mm: mmap: merge vma after call_mmap() if possible") added an extra fput.
>
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
>@@ -1781,7 +1781,6 @@ unsigned long mmap_region(struct file *f
> 			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
> 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
> 			if (merge) {
>-				fput(file);
> 				vm_area_free(vma);
> 				vma = merge;
> 				/* Update vm_flags and possible addr to pick up the change. We don't
>

I reviewed the code carefully these days and I found vma_merge() do only fput() the vm_file of the linked vma in remove_next cases.
This gpf is much likely because the ->mmap() callback can change vma->vm_file and fput the original file. But my previous commit
failed to catch this case and always fput() the original file, hence add an extra fput().
The below patch would make the things right:

diff --git a/mm/mmap.c b/mm/mmap.c
index 080f44bcf7a8..80ea11bf12fa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1816,7 +1816,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
                        merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
                                NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
                        if (merge) {
-                               fput(file);
+                               /* ->mmap() can change vma->vm_file and fput the original file. So
+                                * fput the vma->vm_file here or we would add an extra fput for file
+                                * and cause general protection fault ultimately.
+                                */
+                               fput(vma->vm_file);
                                vm_area_free(vma);
                                vma = merge;
                                /* Update vm_flags and possible addr to pick up the change. We don't

It's very nice of you if you could help test this patch as I can't reproduce it in my product environment. And many thanks
for a possible Tested-by tag.

Thanks again.

