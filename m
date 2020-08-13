Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF9243D66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 12:31:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgHMQa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:30:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B28CAD63;
        Thu, 13 Aug 2020 16:31:17 +0000 (UTC)
Date:   Thu, 13 Aug 2020 18:30:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
Message-ID: <20200813163054.GR9477@dhcp22.suse.cz>
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <20200813114105.GI9477@dhcp22.suse.cz>
 <9ca76893-dfe8-9a46-f2ec-6b3c663e848e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca76893-dfe8-9a46-f2ec-6b3c663e848e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-08-20 21:51:29, Charan Teja Kalla wrote:
> Thanks Michal for comments.
> 
> On 8/13/2020 5:11 PM, Michal Hocko wrote:
> > On Tue 11-08-20 18:28:23, Charan Teja Reddy wrote:
> > [...]
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index e4896e6..839039f 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >>  	struct page *page, *tmp;
> >>  	LIST_HEAD(head);
> >>  
> >> +	/*
> >> +	 * Ensure proper count is passed which otherwise would stuck in the
> >> +	 * below while (list_empty(list)) loop.
> >> +	 */
> >> +	count = min(pcp->count, count);
> >>  	while (count) {
> >>  		struct list_head *list;
> > 
> > 
> > How does this prevent the race actually?
> 
> This doesn't prevent the race. This only fixes the core hung(as this is
> called with spin_lock_irq()) caused by the race condition. This core
> hung is because of incorrect count value is passed to the
> free_pcppages_bulk() function.

Let me ask differently. What does enforce that the count and lists do
not get out of sync in the loop. Your changelog says that the fix is to
use the proper value without any specifics.

-- 
Michal Hocko
SUSE Labs
