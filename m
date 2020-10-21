Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C318294D40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442883AbgJUNLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442873AbgJUNLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603285879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzVVwuDe6daNRiICBNR+zrE+NYuI/ByjjSt1x9o6UL8=;
        b=ErKoedAkeD2Hbk3C1Omx6xObriQL46X+BCbcjAq3jUgn0+N4zw/D16sUcNGVDT5Nk91xUe
        Rn3ZqfJ+dnHeaVNCrUeKgo0MXn8RLy/S3cgaGK8cXNa+aeujqQYMZ8eUE1Cr0H4KuXJJzR
        m+sKlGpLMp0RU215KqmCqg8aOu2uTDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-BjenbXK2ORaQTYjkDHc3FA-1; Wed, 21 Oct 2020 09:11:17 -0400
X-MC-Unique: BjenbXK2ORaQTYjkDHc3FA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B8E804024;
        Wed, 21 Oct 2020 13:11:15 +0000 (UTC)
Received: from [10.36.114.138] (ovpn-114-138.ams2.redhat.com [10.36.114.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE44E60C15;
        Wed, 21 Oct 2020 13:11:09 +0000 (UTC)
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     Michal Privoznik <mprivozn@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com>
 <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
 <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
 <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
 <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
 <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
 <b24380ad-b87c-a3a1-d25e-ee30c10ed0d2@redhat.com>
 <312246f4-4e5f-1425-1bc2-1b356db0fbad@oracle.com>
 <df406c04-b0f4-367f-d675-87e0231500d0@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9ad697d7-ed64-24f3-17cf-fa8dbbdcf86a@redhat.com>
Date:   Wed, 21 Oct 2020 15:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <df406c04-b0f4-367f-d675-87e0231500d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.20 14:57, Michal Privoznik wrote:
> On 10/21/20 5:35 AM, Mike Kravetz wrote:
>> On 10/20/20 6:38 AM, David Hildenbrand wrote:
>>>
>>> I'm bisecting the warning right now. Looks like it was introduced in v5.7.
>>
>> I found the following bugs in the cgroup reservation accounting.  The ones
>> in region_del are pretty obvious as the number of pages to uncharge would
>> always be zero.  The one on alloc_huge_page needs racing code to expose.
>>
>> With these fixes, my testing is showing consistent/correct results for
>> hugetlb reservation cgroup accounting.
>>
>> It would be good if Mina (at least) would look these over.  Would also
>> be interesting to know if these fixes address the bug seen with the qemu
>> use case.
>>
>> I'm still doing more testing and code inspection to look for other issues.
>>
>>  From 861bcd7d0443f18a5fed3c3ddc5f1c71e78c4ef4 Mon Sep 17 00:00:00 2001
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Tue, 20 Oct 2020 20:21:42 -0700
>> Subject: [PATCH] hugetlb_cgroup: fix reservation accounting
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/hugetlb.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 67fc6383995b..c92366313780 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -685,17 +685,17 @@ static long region_del(struct resv_map *resv, long f, long t)
>>   		}
>>   
>>   		if (f <= rg->from) {	/* Trim beginning of region */
>> -			del += t - rg->from;
>> -			rg->from = t;
>> -
>>   			hugetlb_cgroup_uncharge_file_region(resv, rg,
>>   							    t - rg->from);
>> -		} else {		/* Trim end of region */
>> -			del += rg->to - f;
>> -			rg->to = f;
>>   
>> +			del += t - rg->from;
>> +			rg->from = t;
>> +		} else {		/* Trim end of region */
>>   			hugetlb_cgroup_uncharge_file_region(resv, rg,
>>   							    rg->to - f);
>> +
>> +			del += rg->to - f;
>> +			rg->to = f;
>>   		}
>>   	}
>>   
>> @@ -2454,6 +2454,9 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>>   
>>   		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
>>   		hugetlb_acct_memory(h, -rsv_adjust);
>> +		if (deferred_reserve)
>> +			hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
>> +					pages_per_huge_page(h), page);
>>   	}
>>   	return page;
>>   
>>
> 
> I've applied, rebuilt and tested, but unfortunately I still hit the problem:
> [ 6472.719047] ------------[ cut here ]------------
> [ 6472.719052] WARNING: CPU: 6 PID: 11773 at mm/page_counter.c:57 
> page_counter_uncharge+0x33/0x40
> [ 6472.719052] Modules linked in: kvm_amd amdgpu kvm btusb sp5100_tco 
> btrtl watchdog k10temp btbcm btintel mfd_core gpu_sched ttm
> [ 6472.719057] CPU: 6 PID: 11773 Comm: CPU 3/KVM Not tainted 
> 5.9.1-gentoo-x86_64 #1
> [ 6472.719057] Hardware name: System manufacturer System Product 
> Name/PRIME X570-PRO, BIOS 1005 08/01/2019
> [ 6472.719059] RIP: 0010:page_counter_uncharge+0x33/0x40
> [ 6472.719060] Code: 48 85 ff 74 24 4c 89 c8 f0 48 0f c1 07 4c 29 c0 48 
> 89 c1 48 89 c6 e8 7c fe ff ff 48 85 c9 78 0a 48 8b 7f 28 48 85 ff 75 dc 
> c3 <0f> 0b eb f2 66 0f 1f 84 00 00 00 00 00 48 8b 17 48 39 d6 72 41 41
> [ 6472.719061] RSP: 0018:ffffc90000b77b40 EFLAGS: 00010286
> [ 6472.719061] RAX: fffffffffffe9200 RBX: ffff888fb3b97b40 RCX: 
> fffffffffffe9200
> [ 6472.719062] RDX: 0000000000000221 RSI: fffffffffffe9200 RDI: 
> ffff888fd8451dd0
> [ 6472.719062] RBP: ffff888fb6990420 R08: 0000000000044200 R09: 
> fffffffffffbbe00
> [ 6472.719062] R10: ffff888fb3b97b40 R11: 000000000000000a R12: 
> 0000000000000001
> [ 6472.719063] R13: 00000000000005df R14: 00000000000005de R15: 
> ffff888fb3b97b40
> [ 6472.719063] FS:  00007fbd175fe700(0000) GS:ffff888fde980000(0000) 
> knlGS:0000000000000000
> [ 6472.719064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6472.719064] CR2: 00007fbd825101f0 CR3: 0000000fb5e41000 CR4: 
> 0000000000350ee0
> [ 6472.719065] Call Trace:
> [ 6472.719067]  hugetlb_cgroup_uncharge_file_region+0x46/0x70
> [ 6472.719069]  region_del+0x1ae/0x270
> [ 6472.719070]  hugetlb_unreserve_pages+0x32/0xa0
> [ 6472.719072]  remove_inode_hugepages+0x19d/0x3a0
> [ 6472.719079]  ? writeback_registers+0x45/0x60 [kvm]
> [ 6472.719080]  hugetlbfs_fallocate+0x3f2/0x4a0
> [ 6472.719081]  ? __mod_lruvec_state+0x1d/0x40
> [ 6472.719081]  ? __mod_memcg_lruvec_state+0x1b/0xe0
> [ 6472.719083]  ? __seccomp_filter+0x75/0x6a0
> [ 6472.719084]  vfs_fallocate+0x122/0x260
> [ 6472.719085]  __x64_sys_fallocate+0x39/0x60
> [ 6472.719086]  do_syscall_64+0x2d/0x40
> [ 6472.719088]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 6472.719089] RIP: 0033:0x7fbe3cefcde7
> [ 6472.719089] Code: 89 7c 24 08 48 89 4c 24 18 e8 45 fc f8 ff 41 89 c0 
> 4c 8b 54 24 18 48 8b 54 24 10 b8 1d 01 00 00 8b 74 24 0c 8b 7c 24 08 0f 
> 05 <48> 3d 00 f0 ff ff 77 41 44 89 c7 89 44 24 08 e8 75 fc f8 ff 8b 44
> [ 6472.719090] RSP: 002b:00007fbd175fc7a0 EFLAGS: 00000293 ORIG_RAX: 
> 000000000000011d
> [ 6472.719090] RAX: ffffffffffffffda RBX: 00000000bbe00000 RCX: 
> 00007fbe3cefcde7
> [ 6472.719091] RDX: 00000000bbc00000 RSI: 0000000000000003 RDI: 
> 000000000000001d
> [ 6472.719091] RBP: 00007fbd175fc800 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 6472.719091] R10: 0000000000200000 R11: 0000000000000293 R12: 
> 00007ffeea066d2e
> [ 6472.719092] R13: 00007ffeea066d2f R14: 00007fbd175fe700 R15: 
> 00007fbd175fcdc0
> [ 6472.719092] ---[ end trace c97dc6281a861980 ]---

Agreed, same over here. :(

-- 
Thanks,

David / dhildenb

