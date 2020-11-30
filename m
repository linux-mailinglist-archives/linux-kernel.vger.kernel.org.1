Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB32C8EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgK3UUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbgK3UUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:20:38 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196652073C;
        Mon, 30 Nov 2020 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606767597;
        bh=IGfehF/9E98izNV6ogBcmtUVEFhRed5sDjeMmkwRLiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQpTPV6tm3Yu5KcNVcP4PzoTXqUem6muQ9GyaE6DXYOfKC6IkFVR1gYI2hOaas/M1
         xw3AyhAioThupDo/Qii4pmFZpMlPPMGUheek/NAj2b5HZ07/LLKFiptQSLSl/jeBva
         XRj4YSDlEGQ289+IOXw2wPsTCi1Bo3ZtwV6VTWUU=
Date:   Mon, 30 Nov 2020 12:19:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mm/memcg: bail out early when !memcg in
 mem_cgroup_lruvec
Message-Id: <20201130121956.d03efaa95d3112d0b91291d6@linux-foundation.org>
In-Reply-To: <67aacbba-7049-bee8-0ad4-ab4db588c841@gmail.com>
References: <1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com>
        <20201127200215.dc96a839cdd816361e7093e6@linux-foundation.org>
        <9ddb17cd-cf5f-15b1-6a7d-986ee44fd5df@linux.alibaba.com>
        <67aacbba-7049-bee8-0ad4-ab4db588c841@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 22:44:11 +0300 Dmitry Osipenko <digetx@gmail.com> wrote:

> > From: Alex Shi <alex.shi@linux.alibaba.com>
> > Date: Wed, 25 Nov 2020 14:06:33 +0800
> > Subject: [PATCH v2] mm/memcg: bail out early when !memcg in mem_cgroup_lruvec
> > 
> > Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
> > so we could get out early in the situation to avoid useless checking.
> > 
> > Polished as Andrew Morton's suggestion.
> > 
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -610,20 +610,17 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> >  static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> >  					       struct pglist_data *pgdat)
> >  {
> > -	struct mem_cgroup_per_node *mz;
> >  	struct lruvec *lruvec;
> >  
> > -	if (mem_cgroup_disabled()) {
> > +	if (mem_cgroup_disabled() || !memcg) {
> >  		lruvec = &pgdat->__lruvec;
> > -		goto out;
> > -	}
> > +	} else {
> > +		struct mem_cgroup_per_node *mz;
> >  
> > -	if (!memcg)
> > -		memcg = root_mem_cgroup;
> > +		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> > +		lruvec = &mz->lruvec;
> > +	}
> >  
> > -	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> > -	lruvec = &mz->lruvec;
> > -out:
> >  	/*
> >  	 * Since a node can be onlined after the mem_cgroup was created,
> >  	 * we have to be prepared to initialize lruvec->pgdat here;
> > 
> 
> Hi,
> 
> This patch causes a hard lock on one of my ARM32 devices using today's
> linux-next, please fix.

Thanks.

This is unexpected.  I assume you've confirmed that reverting this
change from linux-next fixes things?


