Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D4B2856C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgJGCvR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Oct 2020 22:51:17 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3973 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbgJGCvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:51:16 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id AC98011ED6A3023FB1B1;
        Wed,  7 Oct 2020 10:51:15 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 7 Oct 2020 10:51:15 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 7 Oct 2020 10:51:15 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Thread-Topic: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Thread-Index: AdacVJ5fEj92vdCBS6uaM8UKNp7qsg==
Date:   Wed, 7 Oct 2020 02:51:15 +0000
Message-ID: <d06c6c0652e64ae79a55951e94df3610@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.
> The syzbot reported the below general protection fault:
>
> general protection fault, probably for non-canonical address
> 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
> KASAN: maybe wild-memory-access in range [0x00777770000001d8-0x00777770000001df]
> CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 5.9.0-rc3-syzkaller #0
>
> It's because the ->mmap() callback can change vma->vm_file and fput the original file. But the commit d70cec898324 ("mm: mmap: merge vma after
> call_mmap() if possible") failed to catch this case and always fput() the original file, hence add an extra fput().
>
> [ Thanks Hillf for pointing this extra fput() out. ]
>
> @@ -1815,7 +1815,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
>  				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
>  			if (merge) {
> -				fput(file);
> +				/* ->mmap() can change vma->vm_file and fput the original file. So
> +				 * fput the vma->vm_file here or we would add an extra fput for file
> +				 * and cause general protection fault ultimately.
> +				 */
> +				fput(vma->vm_file);
>  				vm_area_free(vma);
>  				vma = merge;
>  				/* Update vm_flags and possible addr to pick up the change. We don't
> --
> 2.19.1
>
