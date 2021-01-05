Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C72EB54B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbhAEWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbhAEWRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:17:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A007322DFA;
        Tue,  5 Jan 2021 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609884994;
        bh=8nsD1cY7j4RI32huXupjNeC+ztbwkBuHR0P7SByRyVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZTKdkn6Trle1JstaGd6CGH7IkIqIRBp6RCiTFde/XdLuOXGDxgnlRh5mPAor2BkY
         WGAh3OCEuBZmfCL8tVEQ5CDHn9FvaVr8RIV2heEr5IUx1E22nAVgjt13x7y/FuQQnB
         zHxBF3mWb43JCbdKi020nstM1cEvbDgSJI6nKm39LB+lbrOyoif47Uuv5rQo8wrxh1
         ZecGRB8xkzVFSWdQVPYTRJKE5axzttzKl6iwGdX9g0NNxSTnhAdWMiC+oizkNBqFNK
         cgSkuXoKppkCX9HjZfRyGgCGCWBdkm6wLSO/jyOTOqHmg721MY8rSVPJ9joxkckVgQ
         q2mu2238JzWGQ==
Date:   Tue, 5 Jan 2021 22:16:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
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
Message-ID: <20210105221628.GA12854@willie-the-truck>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
 <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
 <X/TOhyzggcBL64N2@redhat.com>
 <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:22:51PM +0000, Nadav Amit wrote:
> > On Jan 5, 2021, at 12:39 PM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > 
> > On Tue, Jan 05, 2021 at 07:26:43PM +0000, Nadav Amit wrote:
> >>> On Jan 5, 2021, at 10:20 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> >>> 
> >>> On Fri, Dec 25, 2020 at 01:25:29AM -0800, Nadav Amit wrote:
> >>>> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
> >>> 
> >>> Targeting a backport down to 2013 when nothing could wrong in practice
> >>> with page_mapcount sounds backwards and unnecessarily risky.
> >>> 
> >>> In theory it was already broken and in theory
> >>> 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 is absolutely perfect and the
> >>> previous code of 2013 is completely wrong, but in practice the code
> >>> from 2013 worked perfectly until Aug 21 2020.
> >> 
> >> Well… If you consider the bug that Will recently fixed [1], then soft-dirty
> >> was broken (for a different, yet related reason) since 0758cd830494
> >> ("asm-generic/tlb: avoid potential double flush”).
> >> 
> >> This is not to say that I argue that the patch should be backported to 2013,
> >> just to say that memory corruption bugs can be unnoticed.
> >> 
> >> [1] https://patchwork.kernel.org/project/linux-mm/patch/20201210121110.10094-2-will@kernel.org/
> > 
> > Is this a fix or a cleanup?
> > 
> > The above is precisely what I said earlier that tlb_gather had no
> > reason to stay in clear_refs and it had to use inc_tlb_flush_pending
> > as mprotect, but it's not a fix? Is it? I suggested it as a pure
> > cleanup. So again no backport required. The commit says fix this but
> > it means "clean this up".
> 
> It is actually a fix. I think the commit log is not entirely correct and
> should include:
> 
>   Fixes: 0758cd830494 ("asm-generic/tlb: avoid potential double flush”).
> 
> Since 0758cd830494, calling tlb_finish_mmu() without any previous call to
> pte_free_tlb() and friends does not flush the TLB. The soft-dirty bug
> producer that I sent fails without this patch of Will.

Yes, it's a fix, but I didn't rush it for 5.10 because I don't think rushing
this sort of thing does anybody any favours. I agree that the commit log
should be updated; I mentioned this report in the cover letter:

https://lore.kernel.org/linux-mm/CA+32v5zzFYJQ7eHfJP-2OHeR+6p5PZsX=RDJNU6vGF3hLO+j-g@mail.gmail.com/

demonstrating that somebody has independently stumbled over the missing TLB
invalidation in userspace, but it's not as bad as the other issues we've been
discussing in this thread.

Will
