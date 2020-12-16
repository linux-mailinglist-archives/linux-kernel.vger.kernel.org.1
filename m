Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C422DC7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgLPUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:44:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40716 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgLPUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGKeMpi024579;
        Wed, 16 Dec 2020 20:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8g83cshHTOeHPycQMAVV7DPppJWYoxT4WZ0MJJjcpek=;
 b=TAohFtw9gk5julYBPCdorya+Thi8CMZMW1LJUgIA2U5W1TOt4HpuS4+lDRZ+r77nJG0J
 HvtVgBpyTznIXAqtGuGzfj6KRfvpwwJyW+2YlLZC0KWOheYiB8hFyO+A/qImX6gJm71T
 1gUmE07cGqyNe5UlyBqkBvbkWgpxS0TUlsgdQRZlNtjsltviPbWuYDXzjm4dOGIZrZQo
 2zkhPOxnvCH5hDDKA3V6MRoD/bj0vEIooqVwa3tcz8X9+XJmJGOivWzelqH85bNuCgU8
 8bpwbL1fDSqBJTckMZOle+cf9Z/gTauxIEXlC0qYKQhSfbIEqNHrDVIWFOgHajs9ou8b 4A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35cn9rje0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 20:43:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGKaD0Y048865;
        Wed, 16 Dec 2020 20:43:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35d7sycgrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 20:43:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGKhCTc024166;
        Wed, 16 Dec 2020 20:43:12 GMT
Received: from revolver (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 12:43:12 -0800
Date:   Wed, 16 Dec 2020 15:42:52 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm/mmap: Don't unlock VMAs in remap_file_pages()
Message-ID: <20201216204252.vh3zadk4ghbzufqz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
References: <20201215155441.1497432-1-Liam.Howlett@Oracle.com>
 <413ffbe0-959d-c2ad-95d8-80104adac089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413ffbe0-959d-c2ad-95d8-80104adac089@redhat.com>
User-Agent: NeoMutt/20200320
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for looking at this.  I appreciate the scrutiny.

* David Hildenbrand <david@redhat.com> [201216 09:58]:
> On 15.12.20 16:54, Liam R. Howlett wrote:
> > do_mmap() will unlock the necessary VMAs.  There is also a bug in the
> > loop which will evaluate as false and not unlock any VMAs anyways.
> 
> If there is a BUG, do we have a Fixes: tag? Also

The bug would never show up as it is masked by do_mmap() unlocking the
necessary range.  Although there is a bug in this code, the code does
not cause an issue as it won't execute so should I have a Fixes tag?
The code works and what I've done is remove a chunk of code that never
runs.

> 
> 1. Can we fix the bug separately first?

I think it is safer to remove unexecuted code than enable it and then
remove it.

> 2. Can we have a better description on what the bug actually is
> "evaluate as false"? What is the result of the bug?

The bug is in the for loop test expression that I removed in the patch.
Here is the long explaination of why the loop has never run.


Line 2982: if (start + size <= start
Line 2983: 	goto out;

size is positive.

Line 2992: vma = find_vma(mm, start);
Look up the first VMA which satisfies start < vm_end

Line 2997: if (start < vma->vm_start)
Line 2998: 	goto out;

So now vma->vm_start >= start.
If vma->vm_start > start, then there are no VMAs in that area, otherwise
it would have been returned by find_vma().
So we can say that vma->vm_start == start.

Line 3033: for (tmp = vma; tmp->vm_start >= start + size;
Line 3034:                 tmp = tmp->vm_next) {
This is the for loop with the error in the test expression.

tmp->vm_start == start which cannot be >= (start + size).

I believe the intention was to loop through vmas in the range of start
to (start + size) and unlock them.


The result of the bug is no VMA is unlocked in this fuction.  But that
doesn't matter as they are unlocked later in the call chain - which is
why this code works as intended.


> 
> CCing some people that might know if this is actually a sane change.
> Skimming over do_mmap(), it's not immediately clear to me that
> "do_mmap() will unlock the necessary VMAs".

Ah, yes.  That is understandable.

do_mmap() L1583 -> mmap_region() L1752 -> munmap_vma_range() ->
do_munmap() -> __do_munmap() loop at 2891 to unlock the range.

Would you like me to add this call chain to the changelog?

> 
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 18 +-----------------
> >  1 file changed, 1 insertion(+), 17 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 5c8b4485860de..f7fecb77f84fd 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3025,25 +3025,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> >  
> >  	flags &= MAP_NONBLOCK;
> >  	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> > -	if (vma->vm_flags & VM_LOCKED) {
> > -		struct vm_area_struct *tmp;
> > +	if (vma->vm_flags & VM_LOCKED)
> >  		flags |= MAP_LOCKED;
> >  
> > -		/* drop PG_Mlocked flag for over-mapped range */
> > -		for (tmp = vma; tmp->vm_start >= start + size;
         This should probably be less than ---^

> > -				tmp = tmp->vm_next) {
> > -			/*
> > -			 * Split pmd and munlock page on the border
> > -			 * of the range.
> > -			 */
> > -			vma_adjust_trans_huge(tmp, start, start + size, 0);
> > -
> > -			munlock_vma_pages_range(tmp,
> > -					max(tmp->vm_start, start),
> > -					min(tmp->vm_end, start + size));
> > -		}
> > -	}
> > -
> >  	file = get_file(vma->vm_file);
> >  	ret = do_mmap(vma->vm_file, start, size,
> >  			prot, flags, pgoff, &populate, NULL);
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
