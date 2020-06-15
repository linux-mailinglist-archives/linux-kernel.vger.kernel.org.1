Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DED1FA1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgFOUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbgFOUj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:39:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7562078E;
        Mon, 15 Jun 2020 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592253569;
        bh=2+d8H2ywb+0qKARzrvVBm2CI7cwKXvv7iW6tH0Dy0JM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0sgqzxpn+vbStGQyYcnJfrRm07ezVEf7CHxezj6jvDiFVYSiGLjHzA3rTTeqDM2w6
         90XAl3nXJ2OH30d6vZS9clyMLqro2D8fdnL145Lq0ZP7IJyZuend/Finhepf0yGIuA
         jHIPFIWROHDiV7ZziaxaGdL9kSJtC6RkHLlgkqOA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 853D235218F0; Mon, 15 Jun 2020 13:39:29 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:39:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] <linux/rculist.h>: fix kernel-doc notation & warning
Message-ID: <20200615203929.GQ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 08:45:07PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a kernel-doc warning due to missing a beginning '*' on the
> comment line.
> 
> ../include/linux/rculist.h:515: warning: bad line:                           [@right ][node2 ... ]
> 
> Fixes: 35fc0e3b0bd5 ("rculist: Add hlists_swap_heads_rcu")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: rcu@vger.kernel.org

Good eyes, but I took Mauro's similar patch.

							Thanx, Paul

> ---
>  include/linux/rculist.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-58-rc1.orig/include/linux/rculist.h
> +++ lnx-58-rc1/include/linux/rculist.h
> @@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(str
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */
> 
