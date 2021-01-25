Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841AE30285C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbhAYRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbhAYQ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:59:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D20220658;
        Mon, 25 Jan 2021 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611593893;
        bh=kxggTNC3zOxhHV9GLTZJpYh6V/gkPDghPdf7uj5wkPw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jVMuSN0SY61xCC7u0zDSn/jSnsFgzsTUGp5JSDTBzhcWaCMIQ2MoYwXM5QE2EJUPn
         NV83zDvBtzkSXiPReR9PAmDaJYHAXizXKfbIqpIGK8twTqxVDuJ87MEJkdtK8RJelH
         EbVeMxySK4W7qFsCnKnYo/Na/YJtr3+vXRg8JcV/zy7dl/eiQV3nAGBMHZ6PXZiGE/
         IT7BT9Oew/elXI8lF7EP6M2r2M/EGIMvqstXGIrgq0Ww5XuNttUiqkkoYRWQPhliud
         DQhOTNx1/fcbSR++lvsfMHWKDtiK/rqTJ8Wp/FjeKLWZ9vYY2HRadkgXTIExYLmNUT
         nFKE1MGqvlm8g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F2A0B3523742; Mon, 25 Jan 2021 08:58:12 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:58:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: rectify kernel-doc for struct rcu_tasks
Message-ID: <20210125165812.GZ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210125074105.29038-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125074105.29038-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 08:41:05AM +0100, Lukas Bulwahn wrote:
> The command 'find ./kernel/rcu/ | xargs ./scripts/kernel-doc -none'
> reported an issue with the kernel-doc of struct rcu_tasks.
> 
> Rectify the kernel-doc, such that no issues remain for ./kernel/rcu/.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied for the v5.13 merge window with the usual wordsmithing, thank you!

							Thanx, Paul

> ---
> applies cleanly on v5.11-rc5 and next-20210122
> 
> Paul, please pick this minor kerneldoc cleanup.
> 
>  kernel/rcu/tasks.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index af7c19439f4e..17c8ebe131af 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -20,7 +20,7 @@ typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
>  typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>  
>  /**
> - * Definition for a Tasks-RCU-like mechanism.
> + * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
>   * @cbs_head: Head of callback list.
>   * @cbs_tail: Tail pointer for callback list.
>   * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
> @@ -38,7 +38,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>   * @pregp_func: This flavor's pre-grace-period function (optional).
>   * @pertask_func: This flavor's per-task scan function (optional).
>   * @postscan_func: This flavor's post-task scan function (optional).
> - * @holdout_func: This flavor's holdout-list scan function (optional).
> + * @holdouts_func: This flavor's holdout-list scan function (optional).
>   * @postgp_func: This flavor's post-grace-period function (optional).
>   * @call_func: This flavor's call_rcu()-equivalent function.
>   * @name: This flavor's textual name.
> -- 
> 2.17.1
> 
