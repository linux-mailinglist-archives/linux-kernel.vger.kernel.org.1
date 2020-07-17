Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8176C223029
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 03:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgGQBE7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jul 2020 21:04:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgGQBE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:04:59 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 37FDBF49E21E86D6E257;
        Fri, 17 Jul 2020 09:04:57 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 17 Jul 2020 09:04:56 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 17 Jul 2020 09:04:56 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Fri, 17 Jul 2020 09:04:56 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Thread-Topic: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Thread-Index: AdZb1cr2oR2Sm1QnnkShPIMChGHNoQ==
Date:   Fri, 17 Jul 2020 01:04:56 +0000
Message-ID: <6de8156c657a42e7a6acc24a5234b637@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:
>On Tue, 14 Jul 2020 11:07:44 +0800 linmiaohe <linmiaohe@huawei.com> wrote:
>
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> 
>> The vm_flags may be changed after call_mmap() because drivers may set 
>> some flags for their own purpose. As a result, we failed to merge the 
>> adjacent vma due to the different vm_flags as userspace can't pass in the same one.
>> Try to merge vma after call_mmap() to fix this issue.
>> 
>> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>> +		/* If vm_flags changed after call_mmap(), we should try merge vma again
>> +		 * as we may succeed this time.
>> +		 */
>> +		if (unlikely(vm_flags != vma->vm_flags && prev)) {
>> +			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
>> +				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
>> +			if (merge) {
>> +				fput(file);
>> +				vm_area_free(vma);
>> +				vma = merge;
>> +				goto unmap_writable;
>
>Shouldn't we update local variable `vm_flags' here, to pick up the change?  And possibly `addr'?

Yes, we should. `vm_flags` and `addr` should be updated to continue the work. Many thanks for your
great review. I will fix it and test again. I will send a patch v2 soon.
