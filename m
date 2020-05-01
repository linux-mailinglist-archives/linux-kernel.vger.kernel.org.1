Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A281C208B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgEAWZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 18:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:25:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED82216FD;
        Fri,  1 May 2020 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588371925;
        bh=fAFOAbBKXQ/muqSxf3aq391Xmdkj8QsPanvq7XU+Gd8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LUJ44MnGrBvXaO0Eo1sLi9gTiVGhgIffNg8lHNyVbaW44jdnTHUSukVmnVxa2T2f/
         7/bCwZGAaABbxu46WG6Yn0RBh4yLHAFEd8Sg8aisEVxYrfF4VwDhgwZ/INWq+T+utU
         Q7Tmy43+jCg4awi52SWO67rDlWV6WImvyBxy5hBc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DA41D3522B72; Fri,  1 May 2020 15:25:24 -0700 (PDT)
Date:   Fri, 1 May 2020 15:25:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 10/24] rcu/tree: add rcutree.rcu_min_cached_objs
 description
Message-ID: <20200501222524.GA6283@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-11-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428205903.61704-11-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:58:49PM +0200, Uladzislau Rezki (Sony) wrote:
> Document the rcutree.rcu_min_cached_objs sysfs kernel parameter.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Could you please combine this wtih the patch that created this sysfs
parameter?

							Thanx, Paul

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 828ff975fbc6..b2b7022374af 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3977,6 +3977,14 @@
>  			latencies, which will choose a value aligned
>  			with the appropriate hardware boundaries.
>  
> +	rcutree.rcu_min_cached_objs= [KNL]
> +			Minimum number of objects which are cached and
> +			maintained per one CPU. Object size is equal
> +			to PAGE_SIZE. The cache allows to reduce the
> +			pressure to page allocator, also it makes the
> +			whole algorithm to behave better in low memory
> +			condition.
> +
>  	rcutree.jiffies_till_first_fqs= [KNL]
>  			Set delay from grace-period initialization to
>  			first attempt to force quiescent states.
> -- 
> 2.20.1
> 
