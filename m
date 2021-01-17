Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8659B2F94E3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 20:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbhAQTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 14:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbhAQTZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 14:25:51 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 11:25:11 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x21so10587845iog.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pLg47IHtjgIuqkfQL/LkDun8WZ2s5nhfyGlTRDFDfd4=;
        b=Q7DBI69PMUAiJB4v+FSihZO7JmtKN8sqcOoc6NzgbRUrZMXoheo8KoFdROHc4ZJYhZ
         OoQjssiULjONT5bchKT+Umq1iwuJX+96iZoytDTapeazQHsVFNEWQ1pPRGUCTeQMS6n/
         uB0ys4fRu3IX4Cy5rk37N1/BUs6qCkAscUTAt8o3UNn7lFscIkT6Cb87KWzWVoQ/UbcP
         ctOCAdbISD4t6Y6Ffh+czSaeVPSOXlfdHLWyH9MgW6q/T7SWlGxMwqZlnUJnNTwOUUMI
         VzNx0CoUkDk0YUFIto7buaeaUazkYctCQVz9lIcyjJXoNWAMGn2Kxbk7/K1fIsl/aS8A
         fFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pLg47IHtjgIuqkfQL/LkDun8WZ2s5nhfyGlTRDFDfd4=;
        b=PAQ9n7basL2XT7OMs0eaDzYxetx2Nqo/Sm+AVyuq7717PJX7otLuwfUk6CKU4KnnD/
         Q/5GdmJb1IGR0+ie2Z754hwsjoBmk0deLJetTkGrJRaETvpKKrpMuHuUuhgrSHED4EvE
         A07rfGZjzcb6gQ3Qv8Ok+5QKVvwSZH4nsdQ2vlC8tNcqBQ82xn0CGOtSOY83hv1BTZj4
         GagqD4Xm50xh0eSLESEjOeNQkMtXvk1xxdONeU36x0ZpabHdef7DsCWZW1caVwKY8W1W
         HxSr9R9L3DPVE4zTgCFtyIRgBi3j51jOqwzxoaSUluXdjyIN4u61tFD3XHgLxw7khRi2
         u84Q==
X-Gm-Message-State: AOAM533AGmt9NglTdO1pwgfY6YX7nwZ5LUZ6GSn9hm38CtKNXr6r8GxO
        9FOwjeX3DQK/6HDvtEUP0iK03g==
X-Google-Smtp-Source: ABdhPJwETzWw2jco3rRhjaH5X82Zr385HMTReqfM5dAHan9sqaLU1AS4gX+ZZfW7RDmf/hWLCCbemQ==
X-Received: by 2002:a92:ce09:: with SMTP id b9mr18068716ilo.69.1610911510268;
        Sun, 17 Jan 2021 11:25:10 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4146:6dab:8acb:d876])
        by smtp.gmail.com with ESMTPSA id h19sm284636ilo.21.2021.01.17.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 11:25:09 -0800 (PST)
Date:   Sun, 17 Jan 2021 12:25:05 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>, surenb@google.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
Message-ID: <YASPEYs0QVI88xfM@google.com>
References: <X/3VE64nr91WCtuM@hirez.programming.kicks-ass.net>
 <ec912505-ed4d-a45d-2ed4-7586919da4de@linux.vnet.ibm.com>
 <C7D5A74C-25BF-458A-AAD9-61E484B9F225@gmail.com>
 <X/3+6ZnRCNOwhjGT@google.com>
 <2C7AE23B-ACA3-4D55-A907-AF781C5608F0@gmail.com>
 <20210112214337.GA10434@willie-the-truck>
 <YAO/9YVceghRYo4T@google.com>
 <85DAADF4-2537-40BD-8580-A57C201FF5F3@gmail.com>
 <YAQAhyOFqEdjTRPJ@google.com>
 <1A664155-462A-451D-A21E-D749A0ADBD09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1A664155-462A-451D-A21E-D749A0ADBD09@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 02:13:43AM -0800, Nadav Amit wrote:
> > On Jan 17, 2021, at 1:16 AM, Yu Zhao <yuzhao@google.com> wrote:
> > 
> > On Sat, Jan 16, 2021 at 11:32:22PM -0800, Nadav Amit wrote:
> >>> On Jan 16, 2021, at 8:41 PM, Yu Zhao <yuzhao@google.com> wrote:
> >>> 
> >>> On Tue, Jan 12, 2021 at 09:43:38PM +0000, Will Deacon wrote:
> >>>> On Tue, Jan 12, 2021 at 12:38:34PM -0800, Nadav Amit wrote:
> >>>>>> On Jan 12, 2021, at 11:56 AM, Yu Zhao <yuzhao@google.com> wrote:
> >>>>>> On Tue, Jan 12, 2021 at 11:15:43AM -0800, Nadav Amit wrote:
> >>>>>>> I will send an RFC soon for per-table deferred TLB flushes tracking.
> >>>>>>> The basic idea is to save a generation in the page-struct that tracks
> >>>>>>> when deferred PTE change took place, and track whenever a TLB flush
> >>>>>>> completed. In addition, other users - such as mprotect - would use
> >>>>>>> the tlb_gather interface.
> >>>>>>> 
> >>>>>>> Unfortunately, due to limited space in page-struct this would only
> >>>>>>> be possible for 64-bit (and my implementation is only for x86-64).
> >>>>>> 
> >>>>>> I don't want to discourage you but I don't think this would end up
> >>>>>> well. PPC doesn't necessarily follow one-page-struct-per-table rule,
> >>>>>> and I've run into problems with this before while trying to do
> >>>>>> something similar.
> >>>>> 
> >>>>> Discourage, discourage. Better now than later.
> >>>>> 
> >>>>> It will be relatively easy to extend the scheme to be per-VMA instead of
> >>>>> per-table for architectures that prefer it this way. It does require
> >>>>> TLB-generation tracking though, which Andy only implemented for x86, so I
> >>>>> will focus on x86-64 right now.
> >>>> 
> >>>> Can you remind me of what we're missing on arm64 in this area, please? I'm
> >>>> happy to help get this up and running once you have something I can build
> >>>> on.
> >>> 
> >>> I noticed arm/arm64 don't support ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.
> >>> Would it be something worth pursuing? Arm has been using mm_cpumask,
> >>> so it might not be too difficult I guess?
> >> 
> >> [ +Mel Gorman who implemented ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH ]
> >> 
> >> IIUC, there are at least two bugs in x86 implementation.
> >> 
> >> First, there is a missing memory barrier in tlbbatch_add_mm() between
> >> inc_mm_tlb_gen() and the read of mm_cpumask().
> > 
> > In arch_tlbbatch_add_mm()? inc_mm_tlb_gen() has builtin barrier as its
> > comment says -- atomic update ops that return values are also full
> > memory barriers.
> 
> Yes, you are correct.
> 
> > 
> >> Second, try_to_unmap_flush() clears flush_required after flushing. Another
> >> thread can call set_tlb_ubc_flush_pending() after the flush and before
> >> flush_required is cleared, and the indication that a TLB flush is pending
> >> can be lost.
> > 
> > This isn't a problem either because flush_required is per thread.
> 
> Sorry, I meant mm->tlb_flush_batched . It is not per-thread.
> flush_tlb_batched_pending() clears it after flush and indications that
> set_tlb_ubc_flush_pending() sets in between can be lost.

Hmm, the PTL argument above flush_tlb_batched_pending() doesn't seem
to hold when USE_SPLIT_PTE_PTLOCKS is set. Do you have a reproducer?
KCSAN might be able to help in this case.
