Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C928321E1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGMVCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 17:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgGMVCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:02:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98B220849;
        Mon, 13 Jul 2020 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594674164;
        bh=lgVYfTw+dPyNsK/MI5mOujzHg3a6HP/c0Gro5WJjAi4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TflN22Vf15Ct7D1f+Zv5BusoL4CRVO61hhBD8cUYOiJJgeCN0vAlgkhdpXNKW7Lgl
         eyDor2VA4CsJ8JTl5DbYdhbw5DkeHGYQS/hcgFGwe6TSySCK0WYrB3krwr+3cVjKXU
         JuXHd8A43dTcnFC3/t0x67MisXWRnbdji0D0olXQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D622335226AF; Mon, 13 Jul 2020 14:02:44 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:02:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Fix _list_check_srcu() macro
Message-ID: <20200713210244.GL9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:18:46PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the macro _list_check_srcu() for CONFIG_PROVE_RCU_LIST =
> False.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Thank you, Madhuparna!  I am folding this into your original, but
with lowercase "true".

							Thanx, Paul

> ---
>  include/linux/rculist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 516b4feb2682..a435ad62b90b 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>  #define __list_check_rcu(dummy, cond, extra...)				\
>  	({ check_arg_count_one(extra); })
>  
> -#define __list_check_srcu(cond)
> +#define __list_check_srcu(cond)	TRUE
>  #endif
>  
>  /*
> -- 
> 2.17.1
> 
