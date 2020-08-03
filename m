Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C106123A926
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgHCPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 11:09:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHCPJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:09:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87089AF76;
        Mon,  3 Aug 2020 15:09:14 +0000 (UTC)
Date:   Mon, 3 Aug 2020 17:08:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/19] mm: memcontrol: decouple reference counting
 from page accounting
Message-ID: <20200803150858.GW5174@dhcp22.suse.cz>
References: <20200623174037.3951353-1-guro@fb.com>
 <20200623174037.3951353-6-guro@fb.com>
 <20200803090033.GE5174@dhcp22.suse.cz>
 <20200803150349.GA502356@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803150349.GA502356@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-08-20 11:03:49, Johannes Weiner wrote:
> On Mon, Aug 03, 2020 at 11:00:33AM +0200, Michal Hocko wrote:
> > On Tue 23-06-20 10:40:23, Roman Gushchin wrote:
> > > @@ -5456,7 +5460,10 @@ static int mem_cgroup_move_account(struct page *page,
> > >  	 */
> > >  	smp_mb();
> > >  
> > > -	page->mem_cgroup = to; 	/* caller should have done css_get */
> > > +	css_get(&to->css);
> > > +	css_put(&from->css);
> > > +
> > > +	page->mem_cgroup = to;
> > >  
> > >  	__unlock_page_memcg(from);
> > 
> > What prevents from memcg to be released here?
> 
> ->attach_task() and kill_css() are exclusive through the cgroup_mutex,
> so the base ref cannot disappear from under us during this operation.

OK, is this worth a comment? Reference counting before other operation
on the object always makes me worried and those details are hidden
elsewhere.

Btw. with the follow up fix from Hugh
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
