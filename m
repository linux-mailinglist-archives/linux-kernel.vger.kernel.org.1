Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39E2CF4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgLDTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:25:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727175AbgLDTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607109813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=niaIGDCDXfXTEqCqwbBQh3Co62h+ONx2LUP6ZS97Ulg=;
        b=ZzWKGv3rVfQi+l3atpQd1obSGvjDdNaHnLvT3J4+LFaJ0ZyDu9YS0BPR+v9ADspfj6u/JW
        EMsgZ5ILptylHwG8teEhqQrzjjFLfl6eepGhcLzpW8m3vzgJDkDShwOTi0vJKp3wa/VhfE
        qPtEMJlgkNNy7mxt1G4m9/Sk4niXXhI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-WlHd_klsP_63E5_uVcPflg-1; Fri, 04 Dec 2020 14:23:32 -0500
X-MC-Unique: WlHd_klsP_63E5_uVcPflg-1
Received: by mail-qk1-f200.google.com with SMTP id d206so6126827qkc.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 11:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=niaIGDCDXfXTEqCqwbBQh3Co62h+ONx2LUP6ZS97Ulg=;
        b=Fbsl/otA9m77c/CY0r4h3MNeeSbW6D2oR/or7VAaDzhfgSTzQnGlhQoiatvaQD3gEL
         xRhalfLvwQmDvK/tq8jNtUnK4iPyzLSYL3Qsyyy0UdmZmOJiz+ABm6fEGRAaZLrUVyri
         OtFLFX6WU7LY8fYXv0VZJCLKH3RieO0KD+p8kbQbrMEQ0seIQNgUlqKC8zjM/meTb2wh
         7UXrwpYpZu9GSlJatKJtP/ZLOCbiLk0fGaezoZM5JO6M64/z4pi9mHQ0KoinrHujejSs
         PFZ/XEBzwHsT9mFVBCIFKuczE1W0AUtPi1oGGi09LqUyCbHPNoCWjmQ4R3QK1WQVpCrJ
         X99g==
X-Gm-Message-State: AOAM530mZs8zxk2FaujfbYeKc/J5mOkAYzN1rU4/zNQmQ3E+VZpmxZur
        vP3LUMENMAuZ5uT1JE428nvtLx/jIoF6nbgMzPpE+w4FAitqBYdXIQW3cVeZqmKmg/ay3Pf6Xqt
        DWzTpyuaWee3sTddCh/Ro/Dzk
X-Received: by 2002:ad4:55ad:: with SMTP id f13mr7064883qvx.22.1607109812101;
        Fri, 04 Dec 2020 11:23:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPwfdWkjrqP22VYjaNLyGNycheU8bKQHrQUx5OO1VxEyQeTSJauNi8O1k47Dz8B+UQQtr8oA==
X-Received: by 2002:ad4:55ad:: with SMTP id f13mr7064861qvx.22.1607109811795;
        Fri, 04 Dec 2020 11:23:31 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id e11sm1321364qka.126.2020.12.04.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:23:30 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:23:29 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201204192329.GP108496@xz-x1>
References: <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
 <20201204023051.GL108496@xz-x1>
 <X8m2qv9h7+e79UjJ@redhat.com>
 <X8p8KNJXD3aK9TkF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8p8KNJXD3aK9TkF@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrea,

On Fri, Dec 04, 2020 at 01:12:56PM -0500, Andrea Arcangeli wrote:
> On Thu, Dec 03, 2020 at 11:10:18PM -0500, Andrea Arcangeli wrote:
> > from the pte, one that cannot ever be set in any swp entry today. I
> > assume it can't be _PAGE_SWP_UFFD_WP since that already can be set but
> > you may want to verify it...
> 
> I thought more about the above, and I think the already existing
> pte_swp_mkuffd_wp will just be enough without having to reserve an
> extra bitflag if we encode it as a non migration entry.
> 
> The check:
> 
> if (!pte_present && !pte_none && pte_swp_uffd_wp && not_anonymous_vma && !is_migration_entry)

[1]

> 
> should be enough to disambiguate it. When setting it, it'd be enough
> to set the pte to the value _PAGE_SWP_UFFD_WP.
> 
> Although if you prefer to check for:
> 
> if (!pte_present && !pte_none && swp_type == 1 && swp_offset == 0 && not_anonymous_vma && !is_migration_entry)

[2]

> 
> that would do as well.
> 
> It's up to you, just my preference is to reuse _PAGE_SWP_UFFD_WP since
> it has already to exist, there are already all the pte_swp_*uffd*
> methods available or uffd-wp cannot work.

Yes, I had the same thought that it would be nice if this special pte can be
still related to _PAGE_SWP_UFFD_WP.

To me, above [2] looks exactly the same as Hugh suggested to check against
swp_type==1 && swp_offset==0, since:

  - do_swap_page() basically already means "!pte_present && !pte_none"

  - "not_anonymous_vma" seems optional if uffd-wp+shmem will be the first user
    of such a swp entry

  - "!is_migration_entry" seems optional since if swp_type==1, it will never be
    a migration entry

While for above [1] that's the thing I asked besides the current type==1 &
offset=0 proposal.  Quotting one of the previous emails:

> So I guess I'll start with type==1 && offset==0.
> 
> (PS: I still think "swp_entry(0, _UFFD_SWP_UFFD_WP) && !vma_is_anonymous(vma)"
>  could also be a good candidate comparing to "swp_entry(1, 0)" considering
>  type==1 here is kind of randomly chosen from all the other numbers except 0;
>  but maybe that's not extremely important - the major logic should be the same)

If we see [1]:

  if (!pte_present && !pte_none && pte_swp_uffd_wp && not_anonymous_vma && !is_migration_entry)

Then it's fundamentally the same as:

  swp_entry(0, _UFFD_SWP_UFFD_WP) && !vma_is_anonymous(vma)

Reasons similar to above.

Thanks!

-- 
Peter Xu

