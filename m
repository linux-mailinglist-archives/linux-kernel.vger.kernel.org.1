Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5042E0035
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgLUSmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:42:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLUSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:42:48 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1krQ8E-0000vB-1e; Mon, 21 Dec 2020 18:42:06 +0000
Date:   Mon, 21 Dec 2020 19:42:04 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Guril <alexander.guril02@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel: Fixed two bracket problems in fork.c
Message-ID: <20201221184204.3xq4qgn5z4nnfk5e@wittgenstein>
References: <20201221150502.70290-1-alexander.guril02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221150502.70290-1-alexander.guril02@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 04:05:02PM +0100, Alexander Guril wrote:
> This fixes two bracket problems in kernel/fork.c
> 
> Signed-off-by: Alexander Guril <alexander.guril02@gmail.com>
> ---

Thanks for the patch.
Unfortunately, there's no real rationale for the change in the commit
message. You probably want to mention that our coding-style mandates
that we don't use {} around single-line statements.

Christian

>  kernel/fork.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 41906a52a764..3a5301867297 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -819,9 +819,8 @@ void __init fork_init(void)
>  	init_task.signal->rlim[RLIMIT_SIGPENDING] =
>  		init_task.signal->rlim[RLIMIT_NPROC];
>  
> -	for (i = 0; i < UCOUNT_COUNTS; i++) {
> +	for (i = 0; i < UCOUNT_COUNTS; i++)
>  		init_user_ns.ucount_max[i] = max_threads/2;
> -	}
>  
>  #ifdef CONFIG_VMAP_STACK
>  	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
> @@ -1654,9 +1653,8 @@ static inline void init_task_pid_links(struct task_struct *task)
>  {
>  	enum pid_type type;
>  
> -	for (type = PIDTYPE_PID; type < PIDTYPE_MAX; ++type) {
> +	for (type = PIDTYPE_PID; type < PIDTYPE_MAX; ++type)
>  		INIT_HLIST_NODE(&task->pid_links[type]);
> -	}
>  }
>  
>  static inline void
> -- 
> 2.29.2
> 
