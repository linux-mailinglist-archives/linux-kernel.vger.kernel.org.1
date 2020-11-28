Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C312C6ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 05:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbgK1Eat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 23:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbgK1E0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 23:26:15 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE87822210;
        Sat, 28 Nov 2020 04:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606536139;
        bh=cEMGKa+zaxvHsRTKQlwMDDceDlj0bM6QUnQtUx0U94c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JAALZCsu2JDfiEM8zsNRQXwSeYlLs10hrPu3LQgqgHaCQf7jTRXkxTF+UxLNcJQU9
         fd83a8RvMdiCYjGXuARb2VEaYNdZKJrNzETQjq7U/saO8xsyVSdhWOHW38Cx+8Qmo8
         E+ayM46ekK+b369uO9g7eeBP8IkN7SilD8RrPd1I=
Date:   Fri, 27 Nov 2020 20:02:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: bail out early when !memcg in
 mem_cgroup_lruvec
Message-Id: <20201127200215.dc96a839cdd816361e7093e6@linux-foundation.org>
In-Reply-To: <1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 11:08:35 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
> so we could get out early in the situation to avoid useless checking.
> 
> Also warning if both parameter are NULL.

Why do you think a warning is needed here?

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -613,14 +613,13 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  	struct mem_cgroup_per_node *mz;
>  	struct lruvec *lruvec;
>  
> -	if (mem_cgroup_disabled()) {
> +	VM_WARN_ON_ONCE(!memcg && !pgdat);
> +
> +	if (mem_cgroup_disabled() || !memcg) {
>  		lruvec = &pgdat->__lruvec;
>  		goto out;
>  	}
>  
> -	if (!memcg)
> -		memcg = root_mem_cgroup;
> -

This change isn't obviously equivalent, is it?

>  	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>  	lruvec = &mz->lruvec;
>  out:

And the resulting code is awkward:

	if (mem_cgroup_disabled() || !memcg) {
		lruvec = &pgdat->__lruvec;
		goto out;
	}

	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
	lruvec = &mz->lruvec;
out:


could be

	if (mem_cgroup_disabled() || !memcg) {
		lruvec = &pgdat->__lruvec;
	} else {
		mem_cgroup_per_node mz;

		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
		lruvec = &mz->lruvec;
	}

