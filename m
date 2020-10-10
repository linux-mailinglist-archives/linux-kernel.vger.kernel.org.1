Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC51289CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgJJAqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:46:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgJJA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:28:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09A0Nvgd053004;
        Sat, 10 Oct 2020 00:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4fKNdKIqf1iGj5xmYh9zFDIz+HZsFUsTT3Ow/eINcEg=;
 b=SlrkoHNC7yGBjmBfB+4/R2y1FA+pibSh0nQNToE+QQHcYpBKi7I/b5Yl106RemagcGDo
 RDXGd22SbATtgIcUxouJsU8n5Kf8AzdZjtPGJk77+5LtUUvoeXtVkxiJZaw6+bddSB4R
 88yzyA6tSK7w+3MSFeTHWQV6WJEidwiY5wfrRfyWvEacUWKNcx44yCeSd/iscYDeOjSs
 6RhbCtuS27cKAv/FIE29+0Q4pA1i6r90KmrrlkMyr9A5ur6JF8Ej2NyjgqGeN0OdGcJU
 oE+r9PifdtQHfm/UDjvB29bk6TSd3b9gvGXG3clllysEcvrM2MegMTgi7tRErXQ3tsMZ kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3429jmnxt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 10 Oct 2020 00:27:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09A0KIT4148964;
        Sat, 10 Oct 2020 00:25:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34322qgdbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Oct 2020 00:25:37 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09A0PWo9030356;
        Sat, 10 Oct 2020 00:25:33 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 17:25:32 -0700
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
 <68e09cac-d2d9-9ddf-6e10-0b8cc0befe82@oracle.com>
 <alpine.LSU.2.11.2010091521460.12013@eggly.anvils>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <42779a0b-d174-a4e5-abbf-4a77879d1e51@oracle.com>
Date:   Fri, 9 Oct 2020 17:25:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2010091521460.12013@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=2 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010100001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=2
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010100001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 3:23 PM, Hugh Dickins wrote:
> On Fri, 9 Oct 2020, Mike Kravetz wrote:
>> On 10/8/20 10:50 PM, Hugh Dickins wrote:
>>>
>>> It's a problem I've faced before in tmpfs, keeping a hold on the
>>> mapping while page lock is dropped.  Quite awkward: igrab() looks as
>>> if it's the right thing to use, but turns out to give no protection
>>> against umount.  Last time around, I ended up with a stop_eviction
>>> count in the shmem inode, which shmem_evict_inode() waits on if
>>> necessary.  Something like that could be done for hugetlbfs too,
>>> but I'd prefer to do it without adding extra, if there is a way.
>>
>> Thanks.
> 
> I failed to come up with anything neater than a stop_eviction count
> in the hugetlbfs inode.
> 
> But that's not unlike a very special purpose rwsem added into the
> hugetlbfs inode: and now that you're reconsidering how i_mmap_rwsem
> got repurposed, perhaps you will end up with an rwsem of your own in
> the hugetlbfs inode.

We have this in the Oracle UEK kernel.
https://github.com/oracle/linux-uek/commit/89260f55df008bb01c841714fb2ad26c300c8c88
Usage has been expanded to cover more cases.

When I proposed the same upstream, the suggestion was to try and use
i_mmap_rwsem.  That is what I have been trying to do.  Certainly, a
hugetlbfs specific rwsem is easier to manage and less disruptive.

> So I won't distract you with a stop_eviction patch unless you ask:
> that's easy, what you're looking into is hard - good luck!

Thanks Hugh!

>> In parallel to working the locking issue, I am also exploring enhanced
>> backout code to handle all the needed cases.

I'm now confident that we need this or some other locking in place.  Why?

I went back to a code base before locking changes.  My idea was to check
for races and backout changes as necessary.  Page fault handling code will
do something like this:

ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
... do some stuff, possibly allocate a page ...
ptl = huge_pte_lock(h, mm, ptep);

Because of pmd sharing, we can not be sure the ptep is valid until
after holding the ptl.  So, I was going to add something like this
after obtaining the ptl.

while(ptep != huge_pte_offset(mm, haddr, huge_page_size(h))) {
	spin_unlock(ptl);
	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
	if (!ptep) {
		ret = VM_FAULT_OOM;
		goto backout_unlocked;
	}
	ptl = huge_pte_lock(h, mm, ptep);
}

Unfortunately, the problem is worse than I thought.  I knew the PMD
pointed to by the ptep could be unshared before attempting to acquire
the ptl.  However, it is possible that the page which was the PMD may
be repurposed before we even try to acquire the ptl.  Since the ptl is
a spinlock within the struct page of what was the PMD, it may no longer
be valid.  I actually experienced addressing exceptions in the spinlock
code within huge_pte_lock. :(

So, it seems that we need some way to prevent PMD unsharing between the
huge_pte_alloc() and huge_pte_lock().  It is going to have to be
i_mmap_rwsem or some other rwsem.
-- 
Mike Kravetz
