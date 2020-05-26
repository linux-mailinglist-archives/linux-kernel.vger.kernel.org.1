Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B91D7F13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgERQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:48:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E534D207E8;
        Mon, 18 May 2020 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820536;
        bh=Jx8nf/EgIhxGdlg3HG0ckJca5UAE0ipauKjQ6fAvZPU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m2/es2Gix1aoeKoJ28NAr5em74Q0a/xT3EGpqwsbMXU36F0NuEhKWZZo4L0RCPUyh
         TL+Z4YDbGZwG3shMOBnyvYXCVlt2zv9l+J7EInMQ93nI7Zh5fOJZI9nXXghBDswbut
         QOeT9QZo+2qy6SY4wrqa/k6GGvQc0Py0Xy1BeS0U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CC1FB3522764; Mon, 18 May 2020 09:48:55 -0700 (PDT)
Date:   Mon, 18 May 2020 09:48:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: fix some kernel-doc warnings
Message-ID: <20200518164855.GA2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <de9528975d99606936d4c5f7d1ab29ded03e8ade.1588595698.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9528975d99606936d4c5f7d1ab29ded03e8ade.1588595698.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 02:35:00PM +0200, Mauro Carvalho Chehab wrote:
> There are some kernel-doc warnings:
> 
> 	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
> 	./include/linux/rculist.h:517: warning: bad line:                           [@right ][node2 ... ]
> 	./include/linux/rculist.h:2: WARNING: Unexpected indentation.
> 
> Move the comment for "count" to the kernel-doc markup and add
> a missing "*" on one kernel-doc continuation line.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/rculist.h | 2 +-
>  kernel/rcu/tree.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 2ebd112f86f7..7a6fc9956510 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -514,7 +514,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */

This one has a prerequisite not in my tree, so I dropped this hunk.
Please point me at the prerequisite if it is something that I should
be queueing.

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ed0fe57d5fb..ada4f914fa60 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2895,6 +2895,7 @@ struct kfree_rcu_cpu_work {
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
>   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>   * @initialized: The @lock and @rcu_work fields have been initialized
> + * @count: Number of objects for which GP not started
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
>   * the rcu_data structure is to permit this code to be extracted from
> @@ -2910,7 +2911,6 @@ struct kfree_rcu_cpu {
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
>  	bool initialized;
> -	// Number of objects for which GP not started
>  	int count;
>  };
>  

I queued this one.

If this is going up some other path, please feel free to add:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

And let me know so that I can drop my version.

							Thanx, Paul
