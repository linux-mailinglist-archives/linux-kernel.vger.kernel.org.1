Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E1D2A762F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbgKEDsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388708AbgKEDsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6292E2072C;
        Thu,  5 Nov 2020 03:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604548104;
        bh=HqU1hZ9it/Jd6nRb4F6S3FiwocUkTFhhalGcS4V1/zY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l5vHcDYIz8Xl/sAHZlJakwO7Klh9NVyJHo2gtioWBLNcz86MQlabqOBPaIbFRyskj
         fGiIr1Dh/t2oksqjzJdWoj3NAxj/4TaD5nXz+8uATo3Abmlbm+mYAyAQQsmgQo2Aja
         E/XRfri5SaC9tSoYlyTUkRE8l1g1wjF+sYfTuFog=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 006623522683; Wed,  4 Nov 2020 19:48:23 -0800 (PST)
Date:   Wed, 4 Nov 2020 19:48:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 5/7] rcu/segcblist: Remove useless rcupdate.h include
Message-ID: <20201105034823.GK3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-6-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:26:01AM -0500, Joel Fernandes (Google) wrote:
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This one looks fine, but depends on the earlier "rcu/segcblist: Add
counters to segcblist datastructure" patch, which also changes the list
of #include directives for this file.  It manages to avoid conflicting
with "rcu/trace: Add tracing for how segcb list changes", despite this
one also changing the #include directives.

I am testing it just out of curiosity, but it might make more sense
to fold this one into "rcu/segcblist: Add counters to segcblist
datastructure".

							Thanx, Paul

> ---
>  kernel/rcu/rcu_segcblist.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 2a03949d0b82..e9e72d72f7a6 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -10,7 +10,6 @@
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> -#include <linux/rcupdate.h>
>  #include <linux/types.h>
>  
>  #include "rcu_segcblist.h"
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
