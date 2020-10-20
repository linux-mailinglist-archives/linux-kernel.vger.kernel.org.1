Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD02912BA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438576AbgJQPi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 11:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411790AbgJQPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 11:38:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ACB22074A;
        Sat, 17 Oct 2020 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602949107;
        bh=Ul+2WFNOLHdtkthH8bHfAg3CW6qX6LsLPlT9WQ+AMWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HTaAOAHYcuYPqR2uYqLDNzQxN06tv21hyNwxlMrtYe5nU6lIzbIr6qT+IHM52BHV5
         MUtI9n2DYyzQHx6feo7ZowZrjjfGDUwzQa9c2L4z9qjy+GtTuHSbCL8GPhXnvDE8VN
         D31Kq5WGcCY+pf7nzrTd4qaQJoscFcbWR5lgEkSE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F104135225E7; Sat, 17 Oct 2020 08:38:26 -0700 (PDT)
Date:   Sat, 17 Oct 2020 08:38:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Add missing inline to
 show_rcu_tasks_rude_gp_kthread() dummy
Message-ID: <20201017153826.GA3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201016103144.23491-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016103144.23491-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:31:44PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_TINY_RCU=y:
> 
>     In file included from kernel/rcu/update.c:591:
>     kernel/rcu/tasks.h:710:13: warning: ‘show_rcu_tasks_rude_gp_kthread’ defined but not used [-Wunused-function]
>      static void show_rcu_tasks_rude_gp_kthread(void) {}
> 		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by marking show_rcu_tasks_rude_gp_kthread() inline.
> 
> Fixes: e21408ceec2de5be ("rcu-tasks: Add RCU tasks to rcutorture writer stall output")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Good catch, but commit 2cf0c4b5 ("rcutorture: Make grace-period kthread
report match RCU flavor being tested") beat you to it, though apparently
by accident.

Either way, thank you for your time and attention!

							Thanx, Paul

> ---
> Exposed by commit 1e6c62a882155772 ("bpf: Introduce sleepable BPF
> programs"), which selects TASKS_TRACE_RCU.
> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d5d9f2d03e8a0ac9..8c290cc45e6fc63a 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -707,7 +707,7 @@ static void show_rcu_tasks_rude_gp_kthread(void)
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
>  #else /* #ifdef CONFIG_TASKS_RUDE_RCU */
> -static void show_rcu_tasks_rude_gp_kthread(void) {}
> +static inline void show_rcu_tasks_rude_gp_kthread(void) {}
>  #endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
>  
>  ////////////////////////////////////////////////////////////////////////
> -- 
> 2.17.1
> 
