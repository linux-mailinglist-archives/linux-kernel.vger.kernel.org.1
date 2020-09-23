Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5AA276376
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgIWWCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:02:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgIWWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:02:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NLXCJG152046;
        Wed, 23 Sep 2020 18:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MOA5Cb3J0q1Jlk6LnHHhcVtn6ndT7uYtMK7lsZhXsvQ=;
 b=qeyfrqLAyxRFEk1T4tRecAkiqIsPkqV2hK1PibZUyOPOGkGyi/v+U1XPLRQ99Ei0/jA1
 S6WA9Bbf6s4tmWOoyhvRZkpG/4+Z8aYOiVbQu6S9ZypBx297OqYZXVq79fbnVlxDNZ46
 7b1hhzTpQ9SptbYz+6f4WPTtcV1vLMPNrB9DiQ2ziCTfOX/foogcyfDtvNPYDcFHZfCk
 ygCIgkWu3l9t32lWYQj4I/HnxzH0Ma49p3A3qJ4Fk80MauIesioxu+tK+BsuA970N2Z2
 yVC3P8j1j+WdZErCIQQutX6wmgRWYcS5/BGHIgNngT00xQXXHnktOe1p3HYLsKY4CtAv wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rcunaxqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 18:02:34 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NLsk2w010843;
        Wed, 23 Sep 2020 18:02:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rcunaxpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 18:02:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08NLwNSp027867;
        Wed, 23 Sep 2020 22:02:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33payubb7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 22:02:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08NM2QiH23134540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 22:02:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 404DA11C052;
        Wed, 23 Sep 2020 22:02:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2C0711C050;
        Wed, 23 Sep 2020 22:02:27 +0000 (GMT)
Received: from thinkpad (unknown [9.171.62.28])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 23 Sep 2020 22:02:27 +0000 (GMT)
Date:   Thu, 24 Sep 2020 00:02:26 +0200
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
Message-ID: <20200924000226.06298978@thinkpad>
In-Reply-To: <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
        <20200922190350.7a0e0ca5@thinkpad>
        <20200923153938.5be5dd2c@thinkpad>
        <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
        <20200923233306.7c5666de@thinkpad>
        <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_16:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 14:50:36 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Sep 23, 2020 at 2:33 PM Gerald Schaefer
> <gerald.schaefer@linux.ibm.com> wrote:
> >
> > Thanks, very nice walk-through, need some time to digest this. The TLB
> > aspect is interesting, and we do have our own __tlb_remove_page_size(),
> > which directly calls free_page_and_swap_cache() instead of the generic
> > batched approach.
> 
> So I don't think it's the free_page_and_swap_cache() itself that is the problem.
> 
> As mentioned, the actual pages themselves should be handled by the
> reference counting being atomic.
> 
> The interrupt disable is really about just the page *tables* being
> free'd - not the final page level.
> 
> So the issue is that at least on x86-64, we have the serialization
> that we will only free the page tables after a cross-CPU IPI has
> flushed the TLB.
> 
> I think s390 just RCU-free's the page tables instead, which should fix it.
> 
> So I think this is special, and s390 is very different from x86, but I
> don't think it's the problem.
> 
> In fact, I think you pinpointed the real issue:
> 
> > Meanwhile, out of curiosity, while I still fail to comprehend commit
> > 09854ba94c6a ("mm: do_wp_page() simplification") in its entirety, there
> > is one detail that I find most confusing: the unlock_page() has moved
> > behind the wp_page_reuse(), while it was the other way round before.
> 
> You know what? That was just a mistake, and I think you may actually
> have hit the real cause of the problem.
> 
> It means that we keep the page locked until after we do the
> pte_unmap_unlock(), so now we have no guarantees that we hold the page
> referecne.
> 
> And then we unlock it - while somebody else might be freeing it.
> 
> So somebody is freeing a locked page just as we're unlocking it, and
> that matches the problem you see exactly: the debug thing will hit
> because the last free happened while locked, and then by the time the
> printout happens it has become unlocked so it doesn't show any more.
> 
> Duh.
> 
> Would you mind testing just moving the unlock_page() back to before
> the wp_page_reuse()?

Sure, I'll give it a try running over the night again.
