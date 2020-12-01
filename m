Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8AE2CA931
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgLAQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgLAQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:59:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1943208C3;
        Tue,  1 Dec 2020 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841925;
        bh=WcSb3KO2/IZlX+vecqi55OYxlZdJEyDtEMQzf2fA0mk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CoMFJYJWi+jpgW4eAYuegXZMyot1LmRSdExtxuPJ5qox32Z/pgs+vdcA5664Sdd9u
         eXxS6j0QzWuYA8+BfIYoGNvvfvIZnxuKtb68AfcNJFdWx/yTytGPbrbDK8NCLV3OPB
         I3BJ//rnhU4KajoFCb2t1tpDV667oY8NYW3S0YK0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8F1E935225C2; Tue,  1 Dec 2020 08:58:44 -0800 (PST)
Date:   Tue, 1 Dec 2020 08:58:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, mark.rutland@arm.com, boqun.feng@gmail.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] random32: Re-enable KCSAN instrumentation
Message-ID: <20201201165844.GH1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201124110210.495616-1-elver@google.com>
 <20201124110210.495616-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124110210.495616-2-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:02:10PM +0100, Marco Elver wrote:
> Re-enable KCSAN instrumentation, now that KCSAN no longer relies on code
> in lib/random32.c.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued and pushed both, thank you!

							Thanx, Paul

> ---
> v3:
> * Add patch to series, since KCSAN no longer needs lib/random32.c.
> ---
>  lib/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index ce45af50983a..301020c49533 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -27,9 +27,6 @@ KASAN_SANITIZE_string.o := n
>  CFLAGS_string.o += -fno-stack-protector
>  endif
>  
> -# Used by KCSAN while enabled, avoid recursion.
> -KCSAN_SANITIZE_random32.o := n
> -
>  lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 rbtree.o radix-tree.o timerqueue.o xarray.o \
>  	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
