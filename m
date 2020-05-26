Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189411A3B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 22:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgDIU7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 16:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDIU7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:59:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963EB20692;
        Thu,  9 Apr 2020 20:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586465964;
        bh=zeSm3VWSkeI0+1hac4vtHaQ4P6AqMkUOps/HKCn16aA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VGxfppb16xM0/UCELIL3TQXBAKKInB3c7R8gWVWdgvE4vwJxPB4kI3ewts8S0qSS+
         MsuaoLQZX9VmoUWyJw09+v/0Br9KP86nFeY0BNBD/rlJfos/gL8eSRZ73NvAbaQcKZ
         FXKM0R8awipSiR2aW3ldVaBYfc3df1YLY1te8TFQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6DB7E3522F44; Thu,  9 Apr 2020 13:59:24 -0700 (PDT)
Date:   Thu, 9 Apr 2020 13:59:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: make rcu_fwds and rcu_fwd_emergency_stop
 static
Message-ID: <20200409205924.GO17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200409114238.39765-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409114238.39765-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 07:42:38PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> kernel/rcu/rcutorture.c:1695:16: warning: symbol 'rcu_fwds' was not
> declared. Should it be static?
> kernel/rcu/rcutorture.c:1696:6: warning: symbol 'rcu_fwd_emergency_stop'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 5453bd557f43..d621a31de8a4 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1692,8 +1692,8 @@ struct rcu_fwd {
>  	unsigned long rcu_launder_gp_seq_start;
>  };
>  
> -struct rcu_fwd *rcu_fwds;
> -bool rcu_fwd_emergency_stop;
> +static struct rcu_fwd *rcu_fwds;
> +static bool rcu_fwd_emergency_stop;
>  
>  static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
>  {
> -- 
> 2.17.2
> 
