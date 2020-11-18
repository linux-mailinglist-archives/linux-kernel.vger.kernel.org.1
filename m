Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC02B7E24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKRNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:13:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:13:52 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kfNHK-0001Bs-DQ; Wed, 18 Nov 2020 13:13:42 +0000
Date:   Wed, 18 Nov 2020 14:13:41 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hui Su <sh_def@163.com>
Cc:     serge@hallyn.com, avagin@openvz.org, 0x7f454c46@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nsproxy: use put_nsproxy() in switch_task_namespaces()
Message-ID: <20201118131341.jxmqocn2vr3hyftt@wittgenstein>
References: <20201115180054.GA371317@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201115180054.GA371317@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:00:54AM +0800, Hui Su wrote:
> Use put_nsproxy() instead of '
> if (atomic_dec_and_test(&ns->count)) {
> 	free_nsproxy(ns);
> }' in switch_task_namespaces().
> 
> and remove the whitespace by the way.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Thanks! I'm picking this up now.

I'll add to the commit message though sm like:

"We already have a dedicated helper that handles reference count
checking so stop open-coding the reference count check in
switch_task_namespaces() and use the dedicated put_nsproxy() helper
instead."

(Looking at put_nsproxy() I feel we should probably start mandating that
all free()/put() helpers should gracefully handle when passed NULL to
avoid:
if (ns)
	put()
calls. But that's independent of this fix.)

>  kernel/nsproxy.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 12dd41b39a7f..3ebfd090398a 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -173,7 +173,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>  	 * it along with CLONE_NEWIPC.
>  	 */
>  	if ((flags & (CLONE_NEWIPC | CLONE_SYSVSEM)) ==
> -		(CLONE_NEWIPC | CLONE_SYSVSEM)) 
> +		(CLONE_NEWIPC | CLONE_SYSVSEM))
>  		return -EINVAL;
>  
>  	new_ns = create_new_namespaces(flags, tsk, user_ns, tsk->fs);
> @@ -250,8 +250,8 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
>  	p->nsproxy = new;
>  	task_unlock(p);
>  
> -	if (ns && atomic_dec_and_test(&ns->count))
> -		free_nsproxy(ns);
> +	if (ns)
> +		put_nsproxy(ns);
>  }
>  
>  void exit_task_namespaces(struct task_struct *p)
> -- 
> 2.29.0
> 
> 
