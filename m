Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE612CA180
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgLALgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:36:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:60986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgLALgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:36:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D819ADCF;
        Tue,  1 Dec 2020 11:35:19 +0000 (UTC)
Date:   Tue, 1 Dec 2020 12:35:16 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
Message-ID: <20201201113511.GA22242@linux>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-4-osalvador@suse.de>
 <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:20:33PM +0100, Vlastimil Babka wrote:
> On 11/19/20 11:57 AM, Oscar Salvador wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > The call to get_user_pages_fast is only to get the pointer to a struct
> > page of a given address, pinning it is memory-poisoning handler's job,
> > so drop the refcount grabbed by get_user_pages_fast().
> > 
> > Note that the target page is still pinned after this put_page() because
> > the current process should have refcount from mapping.
> 
> Well, but can't it go away due to reclaim, migration or whatever?

Yes, it can.

> > @@ -900,20 +900,23 @@ static int madvise_inject_error(int behavior,
> >   		 */
> >   		size = page_size(compound_head(page));
> > +		/*
> > +		 * The get_user_pages_fast() is just to get the pfn of the
> > +		 * given address, and the refcount has nothing to do with
> > +		 * what we try to test, so it should be released immediately.
> > +		 * This is racy but it's intended because the real hardware
> > +		 * errors could happen at any moment and memory error handlers
> > +		 * must properly handle the race.
> 
> Sure they have to. We might just be unexpectedly messing with other process'
> memory. Or does anything else prevent that?

No, nothing does, and I have to confess that I managed to confuse myself here.
If we release such page and that page ends up in buddy, nothing prevents someone
else to get that page, and then we would be messing with other process memory.

I guess the right thing to do is just to make sure we got that page and that
that page remains pinned as long as the memory failure handling goes.

I will remove those patches from the patchset and re-submit with only the
refactoring and pcp-disabling.

Thanks Vlastimil

-- 
Oscar Salvador
SUSE L3
