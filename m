Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2495C299A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406501AbgJZXdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406482AbgJZXdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:33:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770AB207F7;
        Mon, 26 Oct 2020 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755234;
        bh=h5PlIxa4ZroXjXOWgcwrmR9enb6Ft9n2YfGjVCy91xk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yr68WEiluw82hwtVZxkXmux5uN59xgHlKXToFRvPOT5v0RIyGTM+Efu2zXoUcofsM
         lJZ+0jzzuFvQUXow7IxBXoL+b/aC75S6imFLO1mva0V5NS4DNHODxv7ePUaDQKZYF7
         IcOKF6LU9zgQcQ97u7tpv+amWfvk7pDIAlqvTpnc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 41A9135226C8; Mon, 26 Oct 2020 16:33:54 -0700 (PDT)
Date:   Mon, 26 Oct 2020 16:33:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     mark.rutland@arm.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Fix encoding masks and regain address bit
Message-ID: <20201026233354.GV3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201023121224.3630272-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023121224.3630272-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:12:24PM +0200, Marco Elver wrote:
> The watchpoint encoding masks for size and address were off-by-one bit
> each, with the size mask using 1 unnecessary bit and the address mask
> missing 1 bit. However, due to the way the size is shifted into the
> encoded watchpoint, we were effectively wasting and never using the
> extra bit.
> 
> For example, on x86 with PAGE_SIZE==4K, we have 1 bit for the is-write
> bit, 14 bits for the size bits, and then 49 bits left for the address.
> Prior to this fix we would end up with this usage:
> 
> 	[ write<1> | size<14> | wasted<1> | address<48> ]
> 
> Fix it by subtracting 1 bit from the GENMASK() end and start ranges of
> size and address respectively. The added static_assert()s verify that
> the masks are as expected. With the fixed version, we get the expected
> usage:
> 
> 	[ write<1> | size<14> |             address<49> ]
> 
> Functionally no change is expected, since that extra address bit is
> insignificant for enabled architectures.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued and pushed, thank you!!!

							Thanx, Paul

> ---
>  kernel/kcsan/encoding.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index 64b3c0f2a685..fc5154dd2475 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -37,14 +37,12 @@
>   */
>  #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
>  
> -/*
> - * Masks to set/retrieve the encoded data.
> - */
> -#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
> -#define WATCHPOINT_SIZE_MASK                                                   \
> -	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
> -#define WATCHPOINT_ADDR_MASK                                                   \
> -	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
> +/* Bitmasks for the encoded watchpoint access information. */
> +#define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
> +#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> +#define WATCHPOINT_ADDR_MASK	GENMASK(BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS, 0)
> +static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
> +static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
>  
>  static inline bool check_encodable(unsigned long addr, size_t size)
>  {
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog
> 
