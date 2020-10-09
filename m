Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB138289034
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgJIRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:44:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40762 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbgJIRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:43:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099HUQeV174239;
        Fri, 9 Oct 2020 17:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/tMxU3Y/yTDW501bhwkEruJM94fHKEf5tP/XKDOD6CA=;
 b=eCqio3KgC1cwSw2Uemav/8g55vH7IAss/9AHHVHiZ7K4OYvz4J2iybz6oYr43Eimm3rP
 qN9NX5YM7326MVUjGY/X3BfoPfLI31JXuEM2qTMf18XXe7n3Zkc64sM5TzSvWMa9rzNg
 SsxUKdlMNYz34WvSdlOr29jYOq9T9+Cu8yDMCZyDfgjNf4r4cAkPtn79naJ88apIuCNy
 aVNUBdZLwKDoCbJ2TYAW/aKtsnn0jmAqG8zmtKzcw0GwZ/ztg78tR03Z8IZAJpp6NZ+G
 bXXpiNsa0ebPicFI38TU1+t0M24++hLCiwfYChusNkwnIHigWjEYmUzrhfswLBNMkvvI rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3429juvtc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 17:43:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099HV09k156142;
        Fri, 9 Oct 2020 17:43:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3429kbjccn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 17:43:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 099HgvcY023358;
        Fri, 9 Oct 2020 17:42:57 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 10:42:57 -0700
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
To:     Hugh Dickins <hughd@google.com>
Cc:     Qian Cai <cai@lca.pw>, js1304@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
 <20200708012044.GC992@lca.pw>
 <alpine.LSU.2.11.2010071833100.2214@eggly.anvils>
 <cf715524-f30d-634f-2a05-e02c4e52e675@oracle.com>
 <alpine.LSU.2.11.2010082216250.10228@eggly.anvils>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <68e09cac-d2d9-9ddf-6e10-0b8cc0befe82@oracle.com>
Date:   Fri, 9 Oct 2020 10:42:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2010082216250.10228@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=27 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=27 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 10:50 PM, Hugh Dickins wrote:
> On Thu, 8 Oct 2020, Mike Kravetz wrote:
>> On 10/7/20 8:21 PM, Hugh Dickins wrote:
>>>
>>> Mike, j'accuse... your 5.7 commit c0d0381ade79 ("hugetlbfs:
>>> use i_mmap_rwsem for more pmd sharing synchronization"), in which
>>> unmap_and_move_huge_page() now passes the TTU_RMAP_LOCKED flag to
>>> try_to_unmap(), because it's already holding mapping->i_mmap_rwsem:
>>> but that is not the right lock to secure an anon_vma lookup.
>>
>> Thanks Hugh!  Your analysis is correct and the code in that commit is
>> not correct.  I was so focused on the file mapping case, I overlooked
>> (actually introduced) this issue for anon mappings.
>>
>> Let me verify that this indeed is the root cause.  However, since
>> move_pages12 migrated anon hugetlb pages it certainly does look to be
>> the case.
>>
>>> I intended to send a patch, passing TTU_RMAP_LOCKED only in the
>>> !PageAnon case (and, see vma_adjust(), anon_vma lock conveniently
>>> nests inside i_mmap_rwsem); but then wondered if i_mmap_rwsem was
>>> needed in that case or not, so looked deeper into c0d0381ade79.
>>>
>>> Hmm, not even you liked it!  But the worst of it looks simply
>>> unnecessary to me, and I hope can be deleted - but better by you
>>> than by me (in particular, you were trying to kill 1) and 2) birds
>>> with one stone, and I've always given up on understanding hugetlb's
>>> reservations: I suspect that side of it is irrelevant here,
>>> but I wouldn't pretend to be sure).
>>>
>>> How could you ever find a PageAnon page in a vma_shareable() area?
>>>
>>> It is all rather confusing (vma_shareable() depending on VM_MAYSHARE,
>>> whereas is_cow_mapping() on VM_SHARED and VM_MAYWRITE: they have to
>>> be studied together with do_mmap()'s 
>>> 			vm_flags |= VM_SHARED | VM_MAYSHARE;
>>> 			if (!(file->f_mode & FMODE_WRITE))
>>> 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
>>>
>>> (And let me add to the confusion by admitting that, prior to 3.15's
>>> cda540ace6a1 "mm: get_user_pages(write,force) refuse to COW in
>>> shared areas", maybe it was possible to find a PageAnon there.)
>>>
>>> But my belief (best confirmed by you running your tests with a
>>> suitably placed BUG_ON or WARN_ON) is that you'll never find a
>>> PageAnon in a vma_shareable() area, so will never need try_to_unmap()
>>> to unshare a pagetable in the PageAnon case, so won't need i_mmap_rwsem
>>> for PageAnon there, and _get_hugetlb_page_mapping() (your function that
>>> deduces an address_space from an anon_vma) can just be deleted.
>>
>> Yes, it is confusing.  Let me look into this.  I would be really happy
>> to delete that ugly function.
>>
>>> (And in passing, may I ask what hugetlb_page_mapping_lock_write()'s
>>> hpage->_mapcount inc and dec are for?  You comment it as a hack,
>>> but don't explain what needs that hack, and I don't see it.)
>>
>> We are trying to lock the mapping (mapping->i_mmap_rwsem).  We know
>> mapping is valid, because we obtained it from page_mapping() and it
>> will remain valid because we have the page locked.  Page needs to be
>> unlocked to unmap.  However, we have to drop page lock in order to
>> acquire i_mmap_rwsem.  Once we drop page lock, mapping could become
>> invalid.  So, the code code artifically incs mapcount so that mapping
>> will remain valid when upmapping page.
> 
> No, unless you can point me to some other hugetlbfs-does-it-differently
> (and I didn't see it there in that commit), raising _mapcount does not
> provide any such protection; but does add the possiblility of a
> "BUG: Bad page cache" and leak from unaccount_page_cache_page().
> 
> Earlier in the day I was trying to work out what to recommend instead,
> but had to turn aside to something else: I'll try again tomorrow.
> 
> It's a problem I've faced before in tmpfs, keeping a hold on the
> mapping while page lock is dropped.  Quite awkward: igrab() looks as
> if it's the right thing to use, but turns out to give no protection
> against umount.  Last time around, I ended up with a stop_eviction
> count in the shmem inode, which shmem_evict_inode() waits on if
> necessary.  Something like that could be done for hugetlbfs too,
> but I'd prefer to do it without adding extra, if there is a way.

Thanks.

>>
>> As mentioned above, I hope all this can be removed.
> 
> If you continue to nest page lock inside i_mmap_rwsem for hugetlbfs,
> then I think that part of hugetlb_page_mapping_lock_write() has to
> remain.  I'd much prefer that hugetlbfs did not reverse the usual
> nesting, but accept that you had reasons for doing it that way.

Yes, that is necessary with the change to lock order.

Yesterday I found another issue/case to handle in the hugetlb COW code
caused by the difference in lock nesting.  As a result, I am rethinking
the decision to change the locking order.

The primary reason for changing the lock order was to make the hugetlb
page fault code not have to worry about pte pointers changing.  The issue
is that the pte pointer you get (or create) while walking the table
without the page table lock could go away due to unsharing the PMD.  We
can walk the table again after acquiring the lock and validate and possibly
retry.  However, the backout code in this area which previously had to
deal with truncation as well, was quite fragile and did not work in all
corner cases.  This was mostly due to lovely huge page reservations.
I thought that adding more complexity to the backout code was going to
cause more issues.  Changing the locking order eliminated the pte pointer
race as well as truncation.  However, it created new locking issues. :(

In parallel to working the locking issue, I am also exploring enhanced
backout code to handle all the needed cases.
-- 
Mike Kravetz
