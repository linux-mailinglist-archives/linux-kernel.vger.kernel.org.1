Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8232CE5BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgLDCcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbgLDCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607049058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVAPJHHkDjnvSRi+4FwkKWFPK8l/4hPpLtcZqSoiBb4=;
        b=HP3vLgGDG0pyl4A30c8v/SbAknU7hwuo6HphwjVO39+ptTI8ZFy2JgkwFTTjpYdP1oEZwm
        P0pODcXexdHgbgb/c8XwOwxrBhzz1Z5qHd0z4gi0NbY8tqImZvfsAFRLCiXUGISCByMxcH
        upxgAFZoXOcwfU6AVkqvz8EkpMbX15k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-F7e040vHMFO7HPnDKfVHeA-1; Thu, 03 Dec 2020 21:30:56 -0500
X-MC-Unique: F7e040vHMFO7HPnDKfVHeA-1
Received: by mail-qk1-f197.google.com with SMTP id d132so3804588qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVAPJHHkDjnvSRi+4FwkKWFPK8l/4hPpLtcZqSoiBb4=;
        b=KFbS2y3hykQ++EjsN8uUAFcF2o/V6MZJI5X63F/ZEzamC3T8/zgec/Jrv1vtdZC54k
         N/iaWgbLvQa/FPiACP5VuLeVWRFS8/baZe5Fk/HX0ptrsAjJBFpHucM8cDE01h7LEpwg
         7igj9DIEH1644Vf2PIB3MfAw8Vd36BZGaDDeIc3C0qWREs+7xpRXSoLnUbt3BClvIp2l
         yqZ8gJVN+nTlCBGBywg/fbxx9aLorbUWJ62MDcElXEnbJc/Oza3lsHGmYc+1WfxyXq2h
         4kNGc4Kx4pPItyAPZK4IBoXy5IE3QXRmHaPq/uwZyvk2SzlL256VOp7IXrxO9X1GYN3y
         2pSQ==
X-Gm-Message-State: AOAM531Ws+lOcnumm2UWG46k7V6XEUyTv0PcCQJZVXhlQ19U35O2fD78
        AkqGF41l3fTXZRklPSBCueLg2NjgwIYstYRxAA47KPXy7TDSPw6VBdKEDm/4uB4hpCmiCYHNr+e
        /cxx2TmmJ+K00IIAAc7Dm/Kna
X-Received: by 2002:a37:6384:: with SMTP id x126mr6458837qkb.458.1607049056132;
        Thu, 03 Dec 2020 18:30:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySQ3ZZ6ZbovKMR0bKBXN1OIRc4fUfuPNcsS26sJLTv54JUQE9ojy4e7zWBm6ImUdvprqgptw==
X-Received: by 2002:a37:6384:: with SMTP id x126mr6458818qkb.458.1607049055843;
        Thu, 03 Dec 2020 18:30:55 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id a123sm3709630qkc.52.2020.12.03.18.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:30:54 -0800 (PST)
Date:   Thu, 3 Dec 2020 21:30:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201204023051.GL108496@xz-x1>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8lADgHCRqlQi3Xa@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:44:14PM -0500, Andrea Arcangeli wrote:
> On Thu, Dec 03, 2020 at 01:02:34PM -0500, Peter Xu wrote:
> > On Wed, Dec 02, 2020 at 09:36:45PM -0800, Hugh Dickins wrote:
> > > On Wed, 2 Dec 2020, Peter Xu wrote:
> > > > On Wed, Dec 02, 2020 at 02:37:33PM -0800, Hugh Dickins wrote:
> > > > > On Tue, 1 Dec 2020, Andrea Arcangeli wrote:
> > > > > > 
> > > > > > Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
> > > > > > survive the pte invalidates in a way that remains associated to a
> > > > > > certain vaddr in a single mm (so it can shoot itself in the foot if it
> > > > > > wants, but it can't interfere with all other mm sharing the shmem
> > > > > > file) would be welcome...
> > > > > 
> > > > > I think it has to be a new variety of swap-like non_swap_entry() pte,
> > > > > see include/linux/swapops.h.  Anything else would be more troublesome.
> 
> Agreed. Solving it by changing the unmapping of the ptes is also some
> trouble but less troublesome than adding new bitmaps to the vma to
> handle in vma_merge/vma_split.
> 
> > > But those ptes will be pte_present(), so you must provide a pfn,
> > 
> > Could I ask why?
> 
> _PAGE_PROTNONE exists only for one reason, so pte_present returns true
> and the page is as good as mapped, the pfn is real and mapped,
> everything is up and running fine except _PAGE_PRESENT is not set in
> the pte. _PAGE_PROTNONE doesn't unmap the pte, it only triggers faults
> on a mapped pte.
> 
> When we set _PAGE_PROTNONE and clear _PAGE_PRESENT atomically, nothing
> changes at all for all pte_present and all other VM common code,
> except now you get page faults.
> 
> So numa hinting faults use that and it's a perfect fit for that,
> because you just want to change nothing, but still be notified on
> access.
> 
> Here instead you need to really unmap the page and lose any pfn or
> page reference and everything along with it, just one bit need to
> survive the unmap: the _PAGE_UFFD_WP bit.
> 
> I tend to agree this needs to work more similarly to the migration
> entry like Hugh suggested or an entirely new mechanism to keep "vma
> specific state" alive, for filebacked mappings that get zapped but
> that have still a vma intact.

Thanks Andrea & Hugh. I think I get the point now.

I guess missed the fact that !pte_present() means it's a swap entry by
definition...  So my previous thoughts on using either _PAGE_PROTNONE or
_PAGE_SPECIAL could be a bit silly because if without pte_present() they'll
just be misunderstood as swp entries, then all the _PAGE_* bits won't make any
sense any more, since they could mean some strange (type, offset) tuple of swp
entries.

So yes, I think we need a swp entry, with some special format.

> 
> The vma removal in munmap() syscall, is then the only point where the
> pte is only allowed to be cleared for good and only then the pte can
> be freed.
> 
> Not even MADV_DONTNEED should be allowed to zero out the pte, it can
> drop everything but that single bit.

Right.  Ideally I wouldn't expect any sane userspace that uses uffd-wp with
shmem to MADV_DONTNEED a page right under wr-protection, because it really
shouldn't do that... However from the semantics of MADV_DONTNEED, indeed it
should be the same case as the shmem fallocate code where there's a pre-unmap,
so we should be prepared for that too.

> 
> > Meanwhile, this reminded me another option - besides _PAGE_PROTNONE, can we use
> > _PAGE_SPECIAL?  That sounds better at least from its naming that it tells it's
> > a special page already. We can also leverage existing pte_special() checks here
> > and there, then mimic what we do with pte_devmap(), maybe?
> 
> That's also for mapped pages VM_PFNMAP or similar I think.
> 
> By memory the !pte_present case for filebacked vmas only exists as
> migration entry so I think we'll just add a branch to that case so
> that it can disambiguate the migration entry from the _PAGE_UFFDP_WP
> bit.
> 
> So we can reserve one bit in the migration entry that is always
> enforced zero when it is a migration entry.
> 
> When that bit is set on a non-present page in a filebacked vma, it
> will mean _UFFD_PAGE_WP is set for that vaddr in that mm.

I'm just afraid there's no space left for a migration entry, because migration
entries fills in the pfn information into swp offset field rather than a real
offset (please refer to make_migration_entry())?  I assume PFN can use any bit.
Or did I miss anything?

I went back to see the original proposal from Hugh:

  IIUC you only need a single value, no need to carve out another whole
  swp_type: could probably be swp_offset 0 of any swp_type other than 0.

Hugh/Andrea, sorry if this is a stupid swap question: could you help explain
why swp_offset=0 won't be used by any swap device?  I believe it's correct,
it's just that I failed to figure out the reason myself. :(

Besides above, to reuse the _PAGE_SWP_UFFD_WP (as it's already there), maybe we
can also define the special swp entry as:

  swp_entry(0, _PAGE_SWP_UFFD_WP)

Then as long as we check this against the vma so that we know it's not
anonymous memory, then it's the special pte.  Combined as:

    vma_is_anonymous(vma)==false && swp_entry(0, _PAGE_SWP_UFFD_WP);

> 
> Then we need to pass a parameter in all pte zapping operations to tell
> if the unmap event is happening because the vma has been truncated, or
> if it's happening for any other reason.
> 
> If it's happening for any other reasons (page truncate, MADV_DONTNEED,
> memory pressure to swap/writepage) we just convert any present pte
> with _UFFD_PAGE_WP set, to the non-migration entry non-present pte
> with the reserved migration entry bit set.
> 
> If the present pte has no _UFFD_PAGE_WP then it'll be zapped as usual
> regardless of VM_UFFD_WP in the vma or not.
> 
> If the pte zapping is instead invoked because of a vma truncation, and
> it means it's the last unmap operation on that vaddr, the pte zap
> logic will be told to ignore the _UFFD_PAGE_WP in any present pte so
> the ptes will be zeroed out and later freed as needed.

Agreed.

Thanks,

-- 
Peter Xu

