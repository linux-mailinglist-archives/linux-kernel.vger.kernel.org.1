Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44A286F14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJHHRV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Oct 2020 03:17:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgJHHRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:17:21 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 348A5DFF96053E27784C;
        Thu,  8 Oct 2020 15:17:19 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 8 Oct 2020 15:17:18 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 8 Oct 2020 15:17:18 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Thread-Topic: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Thread-Index: AdadPUUH1xGewDMwTA2vF7DsJG74mw==
Date:   Thu, 8 Oct 2020 07:17:18 +0000
Message-ID: <8d3d451883a44f608173fe651b7e6718@huawei.com>
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

Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 16 Sep 2020 05:07:33 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
>
>> The syzbot reported the below general protection fault:
>> 
>> general protection fault, probably for non-canonical address
>> 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: maybe wild-memory-access in range 
>> [0x00777770000001d8-0x00777770000001df]
>> CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 
>> 5.9.0-rc3-syzkaller #0
>> Trace:
>>  free_pgtables+0x1b3/0x2f0 mm/memory.c:415
>>  exit_mmap+0x2c0/0x530 mm/mmap.c:3184
>>  __mmput+0x122/0x470 kernel/fork.c:1076
>> 
>> It's because the ->mmap() callback can change vma->vm_file and fput 
>> the original file. But the commit d70cec898324 ("mm: mmap: merge vma 
>> after
>> call_mmap() if possible") failed to catch this case and always fput() 
>> the original file, hence add an extra fput().
>> 
>> ...
>>
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1815,7 +1815,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>  			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
>>  				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
>>  			if (merge) {
>> -				fput(file);
>> +				/* ->mmap() can change vma->vm_file and fput the original file. So
>> +				 * fput the vma->vm_file here or we would add an extra fput for file
>> +				 * and cause general protection fault ultimately.
>> +				 */
>> +				fput(vma->vm_file);
>>  				vm_area_free(vma);
>>  				vma = merge;
>>  				/* Update vm_flags and possible addr to pick up the change. We 
>> don't
>
>What about the case where this code block does its `goto unmap_writable'?
>
>	/* Once vma denies write, undo our temporary denial count */
>	if (file) {
>unmap_writable:
>		if (vm_flags & VM_SHARED)
>			mapping_unmap_writable(file->f_mapping);
>		if (vm_flags & VM_DENYWRITE)
>			allow_write_access(file);
>	}
>	file = vma->vm_file;
>
>is this using the correct file?  I think it is, but please do check.
>

Many thanks for your reply.

Yes, I think so too. We do deny_write_access and mapping_map_writable on @file, so we should undo all of this on @file.
Since @file is unchanged over the second vma_merge() time, we'are using the correct @file to undo our temporary denial count.

But how should I check this explicitly ? I can't find out a way to do this. Could you please figure it out for me?
Thanks again.

