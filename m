Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA312CE7E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLDGAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:00:44 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431CC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 22:00:04 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id y74so4964960oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 22:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xNXU/fg9qR7YcO0v77Hbdwtw8lurqJ8XaFTso5x/UqA=;
        b=EntwtkA7CB23NBt3oa/64IXnIF0MmDDQnaV8RiqZ5e9cpuR4TBFm1QQ8lY4mstt304
         eadZx+22xLz7ZEhEVP9SgOKAkOZXJE7JKZUd+l+XZ647hkNqTfi4w84UZQRjyrV8l2Ty
         LUGIo9tmNtXNQcHv278nDnJzbJ1hcE8sg4eL3s5WfOaTDCf0FJTGeH2Q7cr7g+YA2LRj
         BS/mGQOPNVtigRh1IAt+IrrwUTfPl54LLqvB5zDm2UHt8PW2u3s/K5XcEJw6VMIV0QUV
         1DX9Zho0STqCLR7X22qh8L1atiJr8/4WRqafqLizbKKw/4q7ioAG6WWLh+NgmHXikJU7
         zXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xNXU/fg9qR7YcO0v77Hbdwtw8lurqJ8XaFTso5x/UqA=;
        b=QoNN2IIznEL+3CP03CKmYzgMtDzfBx8O6UofWITNOhyy7heU/btUo9xsQj5pVVUYEs
         ugHPm2lNQY2ojvi+PamtqOPA1ZY1h6wjktQOWrQJ53h8ZsFPVBKwmRE2fgFS2nOYQuUj
         OPsrcqzFwWOR1lx1b2hZ2Ta24fZaVMBUFOpoMaL+ueAehcn8UKhw+uEJinKkWD/N+SGk
         CtxbcR9r9uwlG/gEK7utfDxkPyagmPIkZTo1Blse/VhjPOtGTQlfieVEMWh1pVrNlvdf
         v6dyvzPbMigZaP75r0GkiiWnPNaEQOl+N+GLju912TtXElGXdysDlcM6DzqsB2VZezum
         EsvA==
X-Gm-Message-State: AOAM530MCxHEhevjnoN5i2H4yYkXByhHhJUM5Pu0p/jkNFygneD9k8H/
        SJ1RHVkkcQq1Yh/uIjx9G8B02Q==
X-Google-Smtp-Source: ABdhPJyWjU9WvJxt9OrLHpXjhLXYNHEMlYKGUyyrn+raIUYteHWy2uyW8Qwtn4t+yB/siQZ4Mmh3mw==
X-Received: by 2002:aca:f089:: with SMTP id o131mr2129576oih.88.1607061603385;
        Thu, 03 Dec 2020 22:00:03 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c190sm438618oig.34.2020.12.03.22.00.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2020 22:00:02 -0800 (PST)
Date:   Thu, 3 Dec 2020 21:59:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
In-Reply-To: <X8m2qv9h7+e79UjJ@redhat.com>
Message-ID: <alpine.LSU.2.11.2012032053440.15141@eggly.anvils>
References: <20201130230603.46187-1-peterx@redhat.com> <20201201125927.GB11935@casper.infradead.org> <20201201223033.GG3277@xz-x1> <X8bZk3jTGU8QyJWc@redhat.com> <alpine.LSU.2.11.2012021410260.4989@eggly.anvils> <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils> <20201203180234.GJ108496@xz-x1> <X8lADgHCRqlQi3Xa@redhat.com> <20201204023051.GL108496@xz-x1> <X8m2qv9h7+e79UjJ@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020, Andrea Arcangeli wrote:
> On Thu, Dec 03, 2020 at 09:30:51PM -0500, Peter Xu wrote:
> > I'm just afraid there's no space left for a migration entry, because migration
> > entries fills in the pfn information into swp offset field rather than a real
> > offset (please refer to make_migration_entry())?  I assume PFN can use any bit.
> > Or did I miss anything?
> > 
> > I went back to see the original proposal from Hugh:
> > 
> >   IIUC you only need a single value, no need to carve out another whole
> >   swp_type: could probably be swp_offset 0 of any swp_type other than 0.
> > 
> > Hugh/Andrea, sorry if this is a stupid swap question: could you help explain
> > why swp_offset=0 won't be used by any swap device?  I believe it's correct,
> > it's just that I failed to figure out the reason myself. :(
> > 

It's because swp_offset 0 is the offset of the swap header, and if we
ever used that when allocating swap, then the swap header would get
overwritten, and that swap area become unrecognizable next time.

But I said it would be usable for UFFD with any swp_type other than 0,
because a swap entry of type 0, offset 0 is simply 0, which looks just
like no swap entry at all, and there are (or were: I might not be
up-to-date) benign races where a swap entry might get passed down but
then found to be 0, and that was understandable and permitted (yes,
I still see the "if (!entry.val) goto out;" in __swap_info_get()).

And that might be related to pte_none() being 0 on most architectures
(not s390 IIRC): we need to distinguish none from swap.  Though that
all gets complicated by the way the swp_entry is munged before being
put into a pte, and the x86 swap munging got more complicated when
L1TF was revealed (and accompanied by prot none munging too) -
search git log of v4.19 for x86/speculation/l1tf if you need to.

> 
> Hugh may want to review if I got it wrong, but there's basically three
> ways.
> 
> swp_type would mean adding one more reserved value in addition of
> SWP_MIGRATION_READ and SWP_MIGRATION_WRITE (kind of increasing
> SWP_MIGRATION_NUM to 3).

I'm not very keen on actually using any of the SWP_MIGRATION defines,
partly because in principle UFFD should not depend on CONFIG_MIGRATION,
partly because the uffd_wp entry would not behave anything like a
migration entry (whose pfn should always indicate a locked page).

swp_offset 0 of swp_type 1 perhaps?

> 
> swp_offset = 0 works in combination of SWP_MIGRATION_WRITE and
> SWP_MIGRATION_READ if we enforce pfn 0 is never used by the kernel
> (I'd feel safer with pfn value -1UL truncated to the bits of the swp
> offset, since the swp_entry format is common code).
> 
> The bit I was suggesting is just one more bit like _PAGE_SWP_UFFD_WP
> from the pte, one that cannot ever be set in any swp entry today. I
> assume it can't be _PAGE_SWP_UFFD_WP since that already can be set but
> you may want to verify it...

I don't see why you would need another bit for this.

The code that checks non-present non-none entries in page table,
for whether they are actually swap or migration entries or whatever,
would now also check for swp_offset 0 of swp_type 1 and go off to
the UFFD WP processing if so.

I didn't pay much attention to below, it seemed over-complicated.
And I don't think Peter's PROT_NONE alternative was unworkable,
but would have to be more careful about pfn and L1TF than shown.
And I am more comfortable to focus on the swap-like direction,
than think in two directions at once - never my strength!

Hugh

> 
> It'd be set on the pte (not in the swap entry), then it doesn't matter
> much what's inside the swp_entry anymore. The pte value would be
> generated with this:
> 
>  pte_swp_uffd_wp_unmap(swp_entry_to_pte(swp_entry(SWP_MIGRATION_READ, 0)))
> 
> (maybe SWP_MIGRATION_READ could also be 0 and then it can be just
> enough to set that single bit in the pte and nothing else, all other
> bits zero)
> 
> We never store a raw swp entry in the pte (the raw swp entry is stored
> in the xarray, it's the index of the swapcache).
> 
> To solve our unmap issue we only deal with pte storage (no xarray
> index storage). This is why it can also be in the arch specific pte
> representation of the swp entry, it doesn't need to be a special value
> defined in the swp entry common code.
> 
> Being the swap entry to pte conversion arch dependent, such bit needs
> to be defined by each arch (reserving a offset or type value in swp
> entry would solve it in the common code).
> 
> #define SWP_OFFSET_FIRST_BIT	(_PAGE_BIT_PROTNONE + 1)
> 
> All bits below PROTNONE are available for software use and we use bit
> 1 (soft dirty) 2 (uffd_wp). protnone bit 8 itself (global bit) must
> not be set or it'll look protnone and pte_present will be true. Bit 7
> is PSE so it's also not available because pte_present checks that
> too.
> 
> It appears you can pick between bit 3 4 5 6 at your own choice and it
> doesn't look like we're running out of those yet (if we were there
> would be a bigger incentive to encode it as part of the swp entry
> format). Example:
> 
> #define _PAGE_SWP_UFFD_WP_UNMAP	_PAGE_PWT
> 
> If that bit it set and pte_present is false, then everything else in
> that that pte is meaningless and it means uffd wrprotected
> pte_none.
> 
> So in the migration-entry/swapin page fault path, you could go one
> step back and check the pte for such bit, if it's set it's not a
> migration entry.
> 
> If there's a read access it should fill the page mark with
> shmem_fault, keep the pte wrprotected and then set _PAGE_UFFD_WP on
> the pte. If there's a write access it should invoke handle_userfault.
> 
> If there's any reason where the swp_entry reservation is simpler
> that's ok too, you'll see an huge lot of more details once you try to
> implement it so you'll be better able to judje later. I'm greatly
> simplifying everything but this is not simple feat...
> 
> Thanks,
> Andrea
