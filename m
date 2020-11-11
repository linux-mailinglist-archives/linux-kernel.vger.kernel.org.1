Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257562AEEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKKKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:22:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:51850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgKKKWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:22:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605090128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+FgVHMqBJs4furNlk1cgKhyuSztd7sXKKlBmYQRo1c=;
        b=osf+oSbz9lreiTXfBzuci84LdyjoGJD0wyFWV779eb05JbuCj2QlPn2Jt3iFXAXPquCQ2X
        h22Gs+uDTYmzzzL5JCRiACxwfI2B4jikaTvb1kmemEa073f3HdgCgQBjhZ0s/wyAwmIC4E
        SEecI+yMq1t+LfOVckAbnvH6XepmSMg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D94DBABD6;
        Wed, 11 Nov 2020 10:22:07 +0000 (UTC)
Date:   Wed, 11 Nov 2020 11:22:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
Message-ID: <20201111102207.GV12240@dhcp22.suse.cz>
References: <20201110193240.25401-1-david@redhat.com>
 <20201111084738.GT12240@dhcp22.suse.cz>
 <4ebc711e-7fbc-62aa-b88f-3d6ffa9379ff@redhat.com>
 <b2d29dc2-cfe9-415d-7037-402dcc0c0f17@suse.cz>
 <5e104380-c0b1-4911-b484-b6e1e1c46f7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e104380-c0b1-4911-b484-b6e1e1c46f7d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-11-20 11:05:21, David Hildenbrand wrote:
> On 11.11.20 10:58, Vlastimil Babka wrote:
> > On 11/11/20 10:06 AM, David Hildenbrand wrote:
> > > On 11.11.20 09:47, Michal Hocko wrote:
> > > > On Tue 10-11-20 20:32:40, David Hildenbrand wrote:
> > > > > commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> > > > > init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
> > > > > leaving the buddy via alloc_pages() and friends to be
> > > > > initialized/cleared/zeroed on allocation.
> > > > > 
> > > > > However, the same logic is currently not applied to
> > > > > alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
> > > > > with init_on_alloc=1 and init_on_free=0. Let's also properly clear
> > > > > pages on that allocation path and add support for __GFP_ZERO.
> > > > 
> > > > AFAIR we do not have any user for __GFP_ZERO right? Not that this is
> > > 
> > > Sorry, I had extended information under "---" but accidentally
> > > regenerated the patch before sending it out.
> > > 
> > > __GFP_ZERO is not used yet. It's intended to be used in
> > > https://lkml.kernel.org/r/20201029162718.29910-1-david@redhat.com
> > > and I can move that change into a separate patch if desired.

OK, it would make sense to add it with its user.

> > > > harmful but it is better to call that explicitly because a missing
> > > > implementation would be a real problem and as such a bug fix.
> > > > 
> > > > I am also not sure handling init_on_free at the higher level is good.
> > > > As we have discussed recently the primary point of this feature is to
> > > > add clearing at very few well defined entry points rather than spill it over
> > > > many places. In this case the entry point for the allocator is
> > > > __isolate_free_page which removes pages from the page allocator. I
> > > > haven't checked how much this is used elsewhere but I would expect
> > > > init_on_alloc to be handled there.
> > > 
> > > Well, this is the entry point to our range allocator, which lives in
> > > page_alloc.c - used by actual high-level allocators (CMA, gigantic
> > > pages, etc). It's just a matter of taste where we want to have that
> > > handling exactly inside our allocator.

Yes I completely agree here. I just believe it should the lowest we can
achieve.

> > I agree alloc_contig_range() is fine as an entry point.
> 
> Thanks, let's see if Michal insists of having this somewhere inside
> isolate_freepages_range() instead.
 
It's not that I would be insisting. I am just pointing out that changes
like this one go against the idea of init_on_alloc because it is adding
more special casing and long term more places to be really careful about
when one has to be really careful to not undermine the security aspect
of the feature. I haven't really checked why compaction is not the
problem but I suspect it is the fact that it unconditionally copy the
full page content to the isolated page so there is no way to sneak
any data leak there. That is fine. We should however make that clear by
using a special cased function which skips this particular
initialization and make sure everybody else will just do the right thing
without much thinking.

-- 
Michal Hocko
SUSE Labs
