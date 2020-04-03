Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0A19DE70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbgDCTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 15:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgDCTOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:14:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3248920719;
        Fri,  3 Apr 2020 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585941260;
        bh=imyyqIJRl5n2TRDy87GoQbmJVeFzTinDt+M5mJkXmns=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rhNsW0F00Iio6KqEe/9izVA5oyGU5i1OI+UDJ1vuq5h3eI7vLhcqQsXHw3yXWb2yz
         MNWghs8tag5eZD+J+Dz9NSnNCoBuETuANZxAL8bNl4867ZKL+aAYsGBOWMlESDmvK+
         J+ugrQJvCD3oFT3x8pwY6tVDJ3wn8VmT1qxTChcA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ED132352275C; Fri,  3 Apr 2020 12:14:19 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:14:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200403191419.GU19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200403173051.4081-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403173051.4081-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:30:51PM +0200, Uladzislau Rezki (Sony) wrote:
> Maintain an emergency pool for each CPU with some
> extra objects. There is read-only sysfs attribute,
> the name is "rcu_nr_emergency_objs". It reflects
> the size of the pool. As for now the default value
> is 3.
> 
> The pool is populated when low memory condition is
> detected. Please note it is only for headless case
> it means when the regular SLAB is not able to serve
> any request, the pool is used.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 133 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 97 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5e26145e9ead..f9f1f935ab0b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -114,6 +114,14 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
>  int rcu_kfree_nowarn;
>  module_param(rcu_kfree_nowarn, int, 0444);
>  
> +/*
> + * For headless variant. Under memory pressure an
> + * emergency pool can be used if the regular SLAB
> + * is not able to serve some memory for us.
> + */
> +int rcu_nr_emergency_objs = 3;
> +module_param(rcu_nr_emergency_objs, int, 0444);

Please document this in Documentation/admin-guide/kernel-parameters.txt.

							Thanx, Paul
