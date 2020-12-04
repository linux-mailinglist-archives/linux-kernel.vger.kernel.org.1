Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5002CF260
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgLDQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:52:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729906AbgLDQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607100642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDhBYbRigRgMTSkYx/CVXw2uLJGwUrrBAdj8JD7lMUg=;
        b=LM+W433ez3uAyKLoOEvK6oG4JBEYjr3XtKZn+ZZc6XOBZGSrl0BSN56q5KhPi79t8w0dn9
        ECF9eHpIs31TYeClQcPc3gNXmJWCnfZTnlIZ3U8pLZLBJcITK/caL1HSEp96N0wZjhb0w1
        lo4ZSxvS13aWGSb407QkZdvKoOIU15w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-dqX4lDStPcGuccpBAZOoFg-1; Fri, 04 Dec 2020 11:50:40 -0500
X-MC-Unique: dqX4lDStPcGuccpBAZOoFg-1
Received: by mail-qt1-f200.google.com with SMTP id x3so5091599qti.15
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDhBYbRigRgMTSkYx/CVXw2uLJGwUrrBAdj8JD7lMUg=;
        b=jPvp9AnT9dkvbt7qe8KZoJQPxiv7z57BYga560nmI+X7xlnKUX/cwDiNXmh6vhdf+y
         3SG3sQlEDyb9MOLB1IzRb8hLupmPxWSx0y8c8C8YEw/qz2bzK9pO3MTsIMf6Zd+rvY37
         ktKAFzD8rRWjcl/Hp0kWdcGow5uJ1R2IKU7j5dSOJ/y/qblrKlQ8uJL6dDb8Hg/sH8+X
         Nd4oIMZm3iOI+Nr7tmNVzmQb5+uJiGYKWD7iz1G0AhBad3QUB7oWrRavNV2XvN/L7K43
         Ud0xTY84E+wEFTDNnZzeeXMK0HzWzTJULZNsM6hAwcOJMPTdRGb7tlfYK/zBZJbV3VGx
         CJVQ==
X-Gm-Message-State: AOAM5307idVibp/e4TAG2FjT03MGvRgg4UU3dxsw0PSk8q8l1Xp+T8oa
        nVhmL71MxdJgkXhxgKC9X6qfAdOu6UVxx/FOL0q7BhGFWEPqKneJrIk1hzYJ59G2rSrqGNHGTcQ
        7jfGoq4CyPgbItXSDIHthjhJY
X-Received: by 2002:ad4:4721:: with SMTP id l1mr6291653qvz.30.1607100640396;
        Fri, 04 Dec 2020 08:50:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8W9b0aSUJfDvIEMvltM32sy3kNaRtXFC+CMBz4UfuCjwXh+5TkjCxjHAEajE1cv4frgwCXQ==
X-Received: by 2002:ad4:4721:: with SMTP id l1mr6291629qvz.30.1607100640106;
        Fri, 04 Dec 2020 08:50:40 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id x28sm4200117qtv.8.2020.12.04.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:50:39 -0800 (PST)
Date:   Fri, 4 Dec 2020 11:50:37 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201204165037.GN108496@xz-x1>
References: <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
 <20201204023051.GL108496@xz-x1>
 <X8m2qv9h7+e79UjJ@redhat.com>
 <alpine.LSU.2.11.2012032053440.15141@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012032053440.15141@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:59:50PM -0800, Hugh Dickins wrote:
> On Thu, 3 Dec 2020, Andrea Arcangeli wrote:
> > On Thu, Dec 03, 2020 at 09:30:51PM -0500, Peter Xu wrote:
> > > I'm just afraid there's no space left for a migration entry, because migration
> > > entries fills in the pfn information into swp offset field rather than a real
> > > offset (please refer to make_migration_entry())?  I assume PFN can use any bit.
> > > Or did I miss anything?
> > > 
> > > I went back to see the original proposal from Hugh:
> > > 
> > >   IIUC you only need a single value, no need to carve out another whole
> > >   swp_type: could probably be swp_offset 0 of any swp_type other than 0.
> > > 
> > > Hugh/Andrea, sorry if this is a stupid swap question: could you help explain
> > > why swp_offset=0 won't be used by any swap device?  I believe it's correct,
> > > it's just that I failed to figure out the reason myself. :(
> > > 
> 
> It's because swp_offset 0 is the offset of the swap header, and if we
> ever used that when allocating swap, then the swap header would get
> overwritten, and that swap area become unrecognizable next time.
> 
> But I said it would be usable for UFFD with any swp_type other than 0,
> because a swap entry of type 0, offset 0 is simply 0, which looks just
> like no swap entry at all, and there are (or were: I might not be
> up-to-date) benign races where a swap entry might get passed down but
> then found to be 0, and that was understandable and permitted (yes,
> I still see the "if (!entry.val) goto out;" in __swap_info_get()).
> 
> And that might be related to pte_none() being 0 on most architectures
> (not s390 IIRC): we need to distinguish none from swap.  Though that
> all gets complicated by the way the swp_entry is munged before being
> put into a pte, and the x86 swap munging got more complicated when
> L1TF was revealed (and accompanied by prot none munging too) -
> search git log of v4.19 for x86/speculation/l1tf if you need to.

My thanks to both of you for explaining the details.

> 
> > 
> > Hugh may want to review if I got it wrong, but there's basically three
> > ways.
> > 
> > swp_type would mean adding one more reserved value in addition of
> > SWP_MIGRATION_READ and SWP_MIGRATION_WRITE (kind of increasing
> > SWP_MIGRATION_NUM to 3).
> 
> I'm not very keen on actually using any of the SWP_MIGRATION defines,
> partly because in principle UFFD should not depend on CONFIG_MIGRATION,
> partly because the uffd_wp entry would not behave anything like a
> migration entry (whose pfn should always indicate a locked page).
> 
> swp_offset 0 of swp_type 1 perhaps?
> 
> > 
> > swp_offset = 0 works in combination of SWP_MIGRATION_WRITE and
> > SWP_MIGRATION_READ if we enforce pfn 0 is never used by the kernel
> > (I'd feel safer with pfn value -1UL truncated to the bits of the swp
> > offset, since the swp_entry format is common code).
> > 
> > The bit I was suggesting is just one more bit like _PAGE_SWP_UFFD_WP
> > from the pte, one that cannot ever be set in any swp entry today. I
> > assume it can't be _PAGE_SWP_UFFD_WP since that already can be set but
> > you may want to verify it...
> 
> I don't see why you would need another bit for this.
> 
> The code that checks non-present non-none entries in page table,
> for whether they are actually swap or migration entries or whatever,
> would now also check for swp_offset 0 of swp_type 1 and go off to
> the UFFD WP processing if so.
> 
> I didn't pay much attention to below, it seemed over-complicated.
> And I don't think Peter's PROT_NONE alternative was unworkable,
> but would have to be more careful about pfn and L1TF than shown.
> And I am more comfortable to focus on the swap-like direction,
> than think in two directions at once - never my strength!

Yes, I think both of them may work, but I'll follow your advise on using swap
entries, assuming easier and cleaner than _PAGE_PROTNONE.  For example, current
pte_present() does make more sense to return false for such an uffd-wp reserved
pte.  Then I won't make _PAGE_PROTNONE even more complicated too.

So I guess I'll start with type==1 && offset==0.

(PS: I still think "swp_entry(0, _UFFD_SWP_UFFD_WP) && !vma_is_anonymous(vma)"
 could also be a good candidate comparing to "swp_entry(1, 0)" considering
 type==1 here is kind of randomly chosen from all the other numbers except 0;
 but maybe that's not extremely important - the major logic should be the same)

Thanks!

-- 
Peter Xu

