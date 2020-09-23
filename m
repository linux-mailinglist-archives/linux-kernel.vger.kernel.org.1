Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B527632A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWVdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:33:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbgIWVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:33:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NLWBAS088224;
        Wed, 23 Sep 2020 17:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=sNGc7AEYpsb6fMt12GzlIzOFIEfRHZcBQwY48KatS7U=;
 b=gRTEdHLSxmzfoCawjo9nevxXfnbXIytxlKzwBSDINeeJVtxsWqlmIuwHTpLgod6b6xS9
 kM6lxb0BIqgkaf6Is40tdrQg4Q5IUXLoH5viY7kKR2QnZx00Rf0hoaemx5pYKbcMbExL
 9D/Rp+0OpHgn/GUXt8xluk6SRIxLHJzOsmdAaZo2QaAU3U/A0J/DnJXc5HTxjF+7fDxP
 SQSAi20mPZ3kYnwqxLnPHlpk5leS5fEVyNfu+N4LWjo5fV/k8ogePUSIQarNBoUm8in7
 c2WRae/e4Tjl5rJqN3QFBF98x2oW68HNQd6gnDovIDViB8ZZCvW79mE4dM8ra7nVuE+i 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33reber116-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:33:19 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NLXIxa090930;
        Wed, 23 Sep 2020 17:33:18 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33reber10p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:33:18 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08NLTVdC008568;
        Wed, 23 Sep 2020 21:33:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 33n98gvkbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 21:33:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08NLXECr20447518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 21:33:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 250B742042;
        Wed, 23 Sep 2020 21:33:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B366542041;
        Wed, 23 Sep 2020 21:33:13 +0000 (GMT)
Received: from thinkpad (unknown [9.171.62.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 23 Sep 2020 21:33:13 +0000 (GMT)
Date:   Wed, 23 Sep 2020 23:33:06 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Qian Cai <cai@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Message-ID: <20200923233306.7c5666de@thinkpad>
In-Reply-To: <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
        <20200922190350.7a0e0ca5@thinkpad>
        <20200923153938.5be5dd2c@thinkpad>
        <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_16:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=779
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 13:00:45 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

[...]
> 
> Ooh. One thing that is *very* different about s390 is that it frees
> the page directly, and doesn't batch things up to happen after the TLB
> flush.
> 
> Maybe THAT is the difference? Not that I can tell why it should
> matter, for all the reasons outlines above. But on x86-64, the
> __tlb_remove_page() function just adds the page to the "free this
> later" TLB flush structure, and if it fills up it does the TLB flush
> and then does the actual batched page freeing outside the page table
> lock.
> 
> And that *has* been one of the things that the fast-gup code depended
> on. We even have a big comment about it:
> 
>         /*
>          * Disable interrupts. The nested form is used, in order to allow
>          * full, general purpose use of this routine.
>          *
>          * With interrupts disabled, we block page table pages from being
>          * freed from under us. See struct mmu_table_batch comments in
>          * include/asm-generic/tlb.h for more details.
>          *
>          * We do not adopt an rcu_read_lock(.) here as we also want to
>          * block IPIs that come from THPs splitting.
>          */
> 
> and maybe that whole thing doesn't hold true for s390 at all.

Thanks, very nice walk-through, need some time to digest this. The TLB
aspect is interesting, and we do have our own __tlb_remove_page_size(),
which directly calls free_page_and_swap_cache() instead of the generic
batched approach.

I faintly remember that we also did have some batched and rcu_sched based
approach. It seems there was some rework with commit 9de7d833e370
("s390/tlb: Convert to generic mmu_gather") and discussion in
https://lore.kernel.org/linux-arch/20180918125151.31744-1-schwidefsky@de.ibm.com/

Given the comment you mentioned and also this one from mm/gup.c:

/*
 * Fast GUP
 *
 * get_user_pages_fast attempts to pin user pages by walking the page
 * tables directly and avoids taking locks. Thus the walker needs to be
 * protected from page table pages being freed from under it, and should
 * block any THP splits.
 *
 * One way to achieve this is to have the walker disable interrupts, and
 * rely on IPIs from the TLB flushing code blocking before the page table
 * pages are freed. This is unsuitable for architectures that do not need
 * to broadcast an IPI when invalidating TLBs.
 *
 * Another way to achieve this is to batch up page table containing pages
 * belonging to more than one mm_user, then rcu_sched a callback to free those
 * pages. Disabling interrupts will allow the fast_gup walker to both block
 * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
 * (which is a relatively rare event). The code below adopts this strategy.

It really sounds like we might have yet another issue with (common code)
gup_fast, and non-batched freeing of pagetable pages, though I wonder how
that would have worked with the s390-specific version of gup_fast before.

Certainly worth investigating, thanks a lot for the hint!

Meanwhile, out of curiosity, while I still fail to comprehend commit
09854ba94c6a ("mm: do_wp_page() simplification") in its entirety, there
is one detail that I find most confusing: the unlock_page() has moved
behind the wp_page_reuse(), while it was the other way round before.

Does it simply not really matter, or was it done on purpose, possibly
related to the "get rid of the nasty serialization on the page lock"
description?
