Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14711BE327
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2Px1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 11:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2Px1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:53:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8786221D91;
        Wed, 29 Apr 2020 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588175606;
        bh=lM+jf92e2hWloNhGNv0OCFyAzm6HTRAHqrzHcxhYL40=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PAwfHGKpdCLYERO8SixsSL4SZwJ4f4MNKIMQQWlNZ1vaaa+PwQ8OeE784qTy3XzGg
         3Y8ZBcgbnZNTDZQdhyRs3AQsD5xf1DcgcvL7q9Rp4LhEO1kmh/OSKFeWECPN2rh1pL
         GTU+6jdibZn+ZBQbNCAGAP0RWpsnLXkQXtUEk+78=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 57DE335226DB; Wed, 29 Apr 2020 08:53:26 -0700 (PDT)
Date:   Wed, 29 Apr 2020 08:53:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix error codes in
 rcu_torture_read_exit_init()
Message-ID: <20200429155326.GD7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200429132235.GA815283@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429132235.GA815283@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:22:35PM +0300, Dan Carpenter wrote:
> The rcu_torture_read_exit_init() function is supposed to return negative
> error codes which get propagated back down the call tree but the current
> code returns true on failure.
> 
> Fixes: e02882cd57e3 ("rcutorture: Add races with task-exit processing")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch!  Talk about code sort of working by accident!!!

Thank you, and I folded this into the original commit with attribution.

						Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 269881e51dc6d..5270674128029 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2434,10 +2434,10 @@ static int rcu_torture_read_exit(void *unused)
>  	return 0;
>  }
>  
> -static bool rcu_torture_read_exit_init(void)
> +static int rcu_torture_read_exit_init(void)
>  {
>  	if (read_exit <= 0)
> -		return true;
> +		return -EINVAL;
>  	init_waitqueue_head(&read_exit_wq);
>  	read_exit_child_stop = false;
>  	read_exit_child_stopped = false;
> -- 
> 2.26.2
> 
