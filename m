Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54896304583
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391604AbhAZRkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:34774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389672AbhAZIBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:01:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611648061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9slJ+Ud3Qp4uGdxPfooc/fvRWSdUmMjQcd1zwclQhNE=;
        b=BqSNfuQw+L7EsMgvK+5Nq1aDStIFDn3EWnzSOTHH+JyJ+5H6YFgje+4FqkNJHtZg6w7OU4
        hTRElZv2hMncP46wT1TZJGUYN0tZ/ab9xRlu8BHxw5UUs4p0GJZwzNOyRQxVGcAi/oq5yY
        6cP3FJDMFNjT45b6GZ3jBF1neXenBOo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 762F5ADD6;
        Tue, 26 Jan 2021 08:01:01 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:01:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
Message-ID: <20210126080100.GC827@dhcp22.suse.cz>
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125092815.GB827@dhcp22.suse.cz>
 <de87d009-985a-87d3-08fb-c688e23d60a9@redhat.com>
 <20210125160328.GP827@dhcp22.suse.cz>
 <20210125162506.GF308988@casper.infradead.org>
 <20210125164118.GS827@dhcp22.suse.cz>
 <20210125181436.GV827@dhcp22.suse.cz>
 <53eb7692-e559-a914-e103-adfe951d7a7c@redhat.com>
 <YA8TcICO1OpFwKsj@cmpxchg.org>
 <bbc6c5d0-bcc9-f538-af4c-166b0d2d1c04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbc6c5d0-bcc9-f538-af4c-166b0d2d1c04@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-01-21 13:57:18, Waiman Long wrote:
> On 1/25/21 1:52 PM, Johannes Weiner wrote:
> > On Mon, Jan 25, 2021 at 01:23:58PM -0500, Waiman Long wrote:
> > > On 1/25/21 1:14 PM, Michal Hocko wrote:
[...]
> > > > With the proposed simplification by Willy
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Thank for the ack. However, I am a bit confused about what you mean by
> > > simplification. There is another linux-next patch that changes the condition
> > > for mem_cgroup_charge() to
> > > 
> > > -       if (!huge) {
> > > +       if (!huge && !page_is_secretmem(page)) {
> > >                  error = mem_cgroup_charge(page, current->mm, gfp);
> > > 
> > > That is the main reason why I introduced the boolean variable as I don't
> > > want to call the external page_is_secretmem() function twice.
> > The variable works for me.
> > 
> > On the other hand, as Michal points out, the uncharge function will be
> > called again on the page when it's being freed (in non-fscache cases),
> > so you're already relying on being able to call it on any page -
> > charged, uncharged, never charged. It would be fine to call it
> > unconditionally in the error path. Aesthetic preference, I guess.

Yes aesthetic preference... Just compare to 
diff --git a/mm/filemap.c b/mm/filemap.c
index 5c9d564317a5..7aa05420107e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -896,11 +896,14 @@ noinline int __add_to_page_cache_locked(struct page *page,
 
 	if (xas_error(&xas)) {
 		error = xas_error(&xas);
-		goto error;
+		goto error_uncharge;
 	}
 
 	trace_mm_filemap_add_to_page_cache(page);
 	return 0;
+error_uncharge:
+	/* memcg will ignore uncharged pages */
+	mem_cgroup_uncharge(page);
 error:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */

which resembles our usual state unwinding style much more.

> That may be true. However, I haven't fully studied how the huge page memory
> accounting work to make sure the uncharge function can be called for huge
> pages.

... but this is rather lame argument to make, don't you think. This
sounds like a ducktaping engineering to me. Over time this leads to a
terrible code. Seriously!

All that being said I do not want to block this or bother people with
more emails but geez
-- 
Michal Hocko
SUSE Labs
