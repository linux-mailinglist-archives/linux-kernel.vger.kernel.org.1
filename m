Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5246E2EB6EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbhAFAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbhAFAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609893001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCbjpgDmnTMB324ACAGwgrr0FLk5GHKNaJCMbIN6Iis=;
        b=ddueGisfsbi4oVDMHMmp9/1IyTsuNeseF/XHhFethlBUMsvJx30zUnUxR2DI0yYmefh7H3
        qikQl2gxj2uaAcV8HatKeOS5aOihIz2Y3hyLrO59hsvBVMEf5bTIY1eOx5/MPRERlbKKGZ
        uZr/7htg8iLkTQGmf6t4WlEMz9yLZ2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-ickF_wgCNsCRvbalVRc8Jg-1; Tue, 05 Jan 2021 19:29:58 -0500
X-MC-Unique: ickF_wgCNsCRvbalVRc8Jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66871107ACE3;
        Wed,  6 Jan 2021 00:29:56 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5FCA50DD5;
        Wed,  6 Jan 2021 00:29:52 +0000 (UTC)
Date:   Tue, 5 Jan 2021 19:29:52 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Message-ID: <X/UEgCkJLtYwORov@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
 <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
 <X/TOhyzggcBL64N2@redhat.com>
 <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210105221628.GA12854@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105221628.GA12854@willie-the-truck>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 10:16:29PM +0000, Will Deacon wrote:
> On Tue, Jan 05, 2021 at 09:22:51PM +0000, Nadav Amit wrote:
> > > On Jan 5, 2021, at 12:39 PM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > > 
> > > On Tue, Jan 05, 2021 at 07:26:43PM +0000, Nadav Amit wrote:
> > >>> On Jan 5, 2021, at 10:20 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > >>> 
> > >>> On Fri, Dec 25, 2020 at 01:25:29AM -0800, Nadav Amit wrote:
> > >>>> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
> > >>> 
> > >>> Targeting a backport down to 2013 when nothing could wrong in practice
> > >>> with page_mapcount sounds backwards and unnecessarily risky.
> > >>> 
> > >>> In theory it was already broken and in theory
> > >>> 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 is absolutely perfect and the
> > >>> previous code of 2013 is completely wrong, but in practice the code
> > >>> from 2013 worked perfectly until Aug 21 2020.
> > >> 
> > >> Well… If you consider the bug that Will recently fixed [1], then soft-dirty
> > >> was broken (for a different, yet related reason) since 0758cd830494
> > >> ("asm-generic/tlb: avoid potential double flush”).
> > >> 
> > >> This is not to say that I argue that the patch should be backported to 2013,
> > >> just to say that memory corruption bugs can be unnoticed.
> > >> 
> > >> [1] https://patchwork.kernel.org/project/linux-mm/patch/20201210121110.10094-2-will@kernel.org/
> > > 
> > > Is this a fix or a cleanup?
> > > 
> > > The above is precisely what I said earlier that tlb_gather had no
> > > reason to stay in clear_refs and it had to use inc_tlb_flush_pending
> > > as mprotect, but it's not a fix? Is it? I suggested it as a pure
> > > cleanup. So again no backport required. The commit says fix this but
> > > it means "clean this up".
> > 
> > It is actually a fix. I think the commit log is not entirely correct and
> > should include:
> > 
> >   Fixes: 0758cd830494 ("asm-generic/tlb: avoid potential double flush”).

Agreed.

> > 
> > Since 0758cd830494, calling tlb_finish_mmu() without any previous call to
> > pte_free_tlb() and friends does not flush the TLB. The soft-dirty bug
> > producer that I sent fails without this patch of Will.
> 
> Yes, it's a fix, but I didn't rush it for 5.10 because I don't think rushing
> this sort of thing does anybody any favours. I agree that the commit log
> should be updated; I mentioned this report in the cover letter:
> 
> https://lore.kernel.org/linux-mm/CA+32v5zzFYJQ7eHfJP-2OHeR+6p5PZsX=RDJNU6vGF3hLO+j-g@mail.gmail.com/
> 
> demonstrating that somebody has independently stumbled over the missing TLB
> invalidation in userspace, but it's not as bad as the other issues we've been
> discussing in this thread.

Thanks for the explanation Nadav and Will.

The fact the code was a 100% match to the cleanup I independently
suggested a few weeks ago to reduce the confusion in clear_refs, made
me overlook the difference 0758cd830494 made. I didn't realize the
flush got optimized away if no gathering happened.

Backporting this sort of thing with Fixes I guess tends to give the
same kind of favors as rushing it for 5.10, but then in general the
Fixes is accurate here.

Overall it looks obviously safe cleanup and it is also a fix starting
in v5.6, so I don't think this can cause more issues than what it
sure fixes at least.

The cleanup was needed anyway, even before it become a fix, since if
it was mandatory to use tlb_gather when you purely need
inc_tlb_flush_pending, then mprotect couldn't get away with it.

I guess the the optimization in 0758cd830494 just made it more
explicit that no code should use tlb_gather if it doesn't need to
gather any page. Maybe adding some commentary in the comment on top of
tlb_gather_mmu about the new behavior wouldn't hurt.

