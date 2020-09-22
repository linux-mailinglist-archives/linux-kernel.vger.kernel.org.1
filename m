Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E72747FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIVSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600798527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3l0rBljR/kZ/ov9FS2rhng6LmUSlhlNsXbHtLgNw0c=;
        b=VtPX8bgEnf7jZCkrOJ+oF7D0OfheAT15srEAqZyEPvwrSFGZt1QxO+mVDnqbIHzTEGyo19
        dQYqWeUfOKoSa1sS4cIMXsCBNzCiXxjNZYhCfFie0FJzY6G63aILaDtjtnh8ZpFHphOp8i
        nQ6azOmboC4G9s3zTmyLSDHujVi6vjE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-qWMHu1ZDOuOEZK-obVAs-A-1; Tue, 22 Sep 2020 14:15:25 -0400
X-MC-Unique: qWMHu1ZDOuOEZK-obVAs-A-1
Received: by mail-qk1-f198.google.com with SMTP id s141so14437017qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3l0rBljR/kZ/ov9FS2rhng6LmUSlhlNsXbHtLgNw0c=;
        b=WBtwxlCX3Ji+VC78txYGX//Qa0jq4MVmNB8r2PIGtJU2AjXfbM0+Ob8Uk0BpvgJLH/
         yz/cwg0y7Zxre3aXYm94O21ItW3Mzhy+pTi0CvXAbgCFLS1WfKf+5xAmS5/HkQ9yzURk
         df4Q+zLH3xejVSGzG9dKrKZkhU3Z4VWbukqQqGYEWVgSk3UWCRJnjWMAlBxAyVjaocZN
         AHi4lirKhOZC5APg+oSFLXNHHuSBum/X6xjLsFZ9Fp7/yKm6RPbR8sLf3i/T6+dAPMV3
         B3TrVXaWgUtqLc/IyQHHevMQXBkTjphcEODysaXER86m7qlA4p70aax/U5vBnpHypfzb
         pMNA==
X-Gm-Message-State: AOAM531uvnw+kOUrwsinQhJnF+l92GOX2I+9bRTsdRws932budDnlNqF
        dECGPZypBTCcoSLPn1f7Ldjw8MRcMLv8UJsBf+uPsm8QzK0FrAU3n5GkLUcspYdyw9Ky85cjChR
        Gdw+nrkMp9IXSWr7W8ukyeoIy
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr6193363qtj.148.1600798524743;
        Tue, 22 Sep 2020 11:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5RZxf+jdVFnmcfF4QmpuiQvcdBFQtD/E68HLrbqxk5hc3ELvpCf5wLHsz32pseUsijk2RIA==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr6193332qtj.148.1600798524459;
        Tue, 22 Sep 2020 11:15:24 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id 5sm12146971qkj.135.2020.09.22.11.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:15:23 -0700 (PDT)
Date:   Tue, 22 Sep 2020 14:15:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200922181522.GK19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <3d17619c-36b4-b080-08ff-26b3e9acb616@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d17619c-36b4-b080-08ff-26b3e9acb616@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:02:03AM -0700, John Hubbard wrote:
> On 9/22/20 8:17 AM, Peter Xu wrote:
> > On Mon, Sep 21, 2020 at 04:53:38PM -0700, John Hubbard wrote:
> > > On 9/21/20 2:17 PM, Peter Xu wrote:
> > > > (Commit message collected from Jason Gunthorpe)
> > > > 
> > > > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> > > 
> > > Not yet, it doesn't. :)  More:
> > > 
> > > > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > > > that have never been passed to pin_user_pages() cannot have a positive
> > > > page_maybe_dma_pinned() by definition. This allows cases that might drive up
> > > > the page ref_count to avoid any penalty from handling dma_pinned pages.
> > > > 
> > > > Due to complexities with unpining this trivial version is a permanent sticky
> > > > bit, future work will be needed to make this a counter.
> > > 
> > > How about this instead:
> > > 
> > > Subsequent patches intend to reduce the chance of false positives from
> > > page_maybe_dma_pinned(), by also considering whether or not a page has
> > > even been part of an mm struct that has ever had pin_user_pages*()
> > > applied to any of its pages.
> > > 
> > > In order to allow that, provide a boolean value (even though it's not
> > > implemented exactly as a boolean type) within the mm struct, that is
> > > simply set once and never cleared. This will suffice for an early, rough
> > > implementation that fixes a few problems.
> > > 
> > > Future work is planned, to provide a more sophisticated solution, likely
> > > involving a counter, and *not* involving something that is set and never
> > > cleared.
> > 
> > This looks good, thanks.  Though I think Jason's version is good too (as long
> > as we remove the confusing sentence, that's the one starting with "mm_structs
> > that have never been passed... ").  Before I drop Jason's version, I think I'd
> > better figure out what's the major thing we missed so that maybe we can add
> > another paragraph.  E.g., "future work will be needed to make this a counter"
> > already means "involving a counter, and *not* involving something that is set
> > and never cleared" to me... Because otherwise it won't be called a counter..
> > 
> 
> That's just a bit of harmless redundancy, intended to help clarify where this
> is going. But if the redundancy isn't actually helping, you could simply
> truncate it to the first half of the sentence, like this:
> 
> "Future work is planned, to provide a more sophisticated solution, likely
> involving a counter."

Will do.  Thanks.

-- 
Peter Xu

