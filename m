Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493152C606B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405312AbgK0HUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:20:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:43264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389420AbgK0HUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:20:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66E47AC17;
        Fri, 27 Nov 2020 07:20:23 +0000 (UTC)
Date:   Fri, 27 Nov 2020 08:20:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm,hwpoison: Remove drain_all_pages from shake_page
Message-ID: <20201127072021.GA3999@localhost.localdomain>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-8-osalvador@suse.de>
 <4033449e-eb86-e306-81af-d4c6dc823bdf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4033449e-eb86-e306-81af-d4c6dc823bdf@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:52:32PM +0100, Vlastimil Babka wrote:
> > @@ -275,9 +275,6 @@ void shake_page(struct page *p, int access)
> >   		lru_add_drain_all();
> >   		if (PageLRU(p))
> >   			return;
> > -		drain_all_pages(page_zone(p));
> > -		if (PageLRU(p) || is_free_buddy_page(p))
> > -			return;
> 
> I wonder if page in the lru pagevec can in fact become free after draining
> the lru - in that case we could keep the is_free_buddy_page() check.

Uhm, yes, I think it can happen.
After all, once the page hits one of the inactives' LRU it can be
reclaimed.

I am fine with joining the left PageLRU and is_free_buddy_page check.

Will do that in the next revision.

Thanks!

-- 
Oscar Salvador
SUSE L3
