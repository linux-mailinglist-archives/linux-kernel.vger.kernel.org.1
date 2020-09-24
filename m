Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883E727709E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgIXMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:06:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgIXMGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:06:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OC3hp4089660;
        Thu, 24 Sep 2020 08:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=V2HPM/eFjC6UZ7YckSVpOnkHlLRlQCxKJD3TO9C078U=;
 b=r+2/xhDiGSbcvRbYkT/w/sKa9nPJT5apngrZYZ7th3cWEluWLCEEKJusNELHH4lAX/NB
 WJ+3yR8AA2eXDqYOuNe0OI0kuK6GR12M5c0d3/HQvGzVkgQw+wg3go15DCFT1yqUkyWB
 3AGNDZ1RakQLF9v5Sr+fobcANImvMmE1j4QPG5iYQtRk2t/JXnLuNRu6iUr3T/Qvihzl
 /SFat/Vd7kxG5DjajWyLJ82kq8WkCucwflIpC9oyPd6EV3hFI/cCzbKhnIofuTnfAgsH
 2nPZucg+qsf3TwTJB/TIlJg0ZOKeX0OFjXYKD8skrkGYZdrMzbXhthPa6BuFe7gI+bTo hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rtnh11u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 08:06:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08OC4Rhe093837;
        Thu, 24 Sep 2020 08:06:45 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rtnh11sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 08:06:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08OC2MTm029894;
        Thu, 24 Sep 2020 12:06:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 33n98gw7tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 12:06:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08OC6ebv30998850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 12:06:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1BAF5204E;
        Thu, 24 Sep 2020 12:06:39 +0000 (GMT)
Received: from thinkpad (unknown [9.171.54.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 8A81552051;
        Thu, 24 Sep 2020 12:06:39 +0000 (GMT)
Date:   Thu, 24 Sep 2020 14:06:38 +0200
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
Message-ID: <20200924140638.7bcb7765@thinkpad>
In-Reply-To: <20200924000226.06298978@thinkpad>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
        <20200922190350.7a0e0ca5@thinkpad>
        <20200923153938.5be5dd2c@thinkpad>
        <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
        <20200923233306.7c5666de@thinkpad>
        <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
        <20200924000226.06298978@thinkpad>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_08:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=2
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 00:02:26 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Wed, 23 Sep 2020 14:50:36 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, Sep 23, 2020 at 2:33 PM Gerald Schaefer
> > <gerald.schaefer@linux.ibm.com> wrote:
> > >
> > > Thanks, very nice walk-through, need some time to digest this. The TLB
> > > aspect is interesting, and we do have our own __tlb_remove_page_size(),
> > > which directly calls free_page_and_swap_cache() instead of the generic
> > > batched approach.
> > 
> > So I don't think it's the free_page_and_swap_cache() itself that is the problem.
> > 
> > As mentioned, the actual pages themselves should be handled by the
> > reference counting being atomic.
> > 
> > The interrupt disable is really about just the page *tables* being
> > free'd - not the final page level.
> > 
> > So the issue is that at least on x86-64, we have the serialization
> > that we will only free the page tables after a cross-CPU IPI has
> > flushed the TLB.
> > 
> > I think s390 just RCU-free's the page tables instead, which should fix it.
> > 
> > So I think this is special, and s390 is very different from x86, but I
> > don't think it's the problem.

Ah of course, I got confused by freeing pagetable pages vs. the pages
themselves. For the pagetable pages we actually use the generic
tlb_remove_table_(sync_)one, including the IPI-synchronizing
smp_call_function (CONFIG_MMU_GATHER_RCU_TABLE_FREE=y).

The "s390 magic" then only starts in our own __tlb_remove_table,
where we take care of the special 2K vs. 4K pagetable stuff.

Thanks a lot for this very valuable abstract of "who is who and why"
in pagetable memory management :-)

> > 
> > In fact, I think you pinpointed the real issue:
> > 
> > > Meanwhile, out of curiosity, while I still fail to comprehend commit
> > > 09854ba94c6a ("mm: do_wp_page() simplification") in its entirety, there
> > > is one detail that I find most confusing: the unlock_page() has moved
> > > behind the wp_page_reuse(), while it was the other way round before.
> > 
> > You know what? That was just a mistake, and I think you may actually
> > have hit the real cause of the problem.
> > 
> > It means that we keep the page locked until after we do the
> > pte_unmap_unlock(), so now we have no guarantees that we hold the page
> > referecne.
> > 
> > And then we unlock it - while somebody else might be freeing it.
> > 
> > So somebody is freeing a locked page just as we're unlocking it, and
> > that matches the problem you see exactly: the debug thing will hit
> > because the last free happened while locked, and then by the time the
> > printout happens it has become unlocked so it doesn't show any more.
> > 
> > Duh.
> > 
> > Would you mind testing just moving the unlock_page() back to before
> > the wp_page_reuse()?
> 
> Sure, I'll give it a try running over the night again.

It's all good now, no more occurrences with unlock_page() before
wp_page_reuse().
