Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F32E116A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgLWBgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgLWBgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:36:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74B432253D;
        Wed, 23 Dec 2020 01:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608687334;
        bh=E2/QufhUm5QbmYYkwMorAN26mVOwdusNezXD+EAiCGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=186twYlo93vGO50+xqZTCkfaB/dX2+7v+d92AN2wFsjVS8riTovtFkjJnMgPrqrjZ
         3ZfzsfU5hKw/vVM+Y9a459VBhSWC3jdGogKAF+SSxK0QbgaPYaTtMDSf7bz2pPIrvj
         0jCuFeanGFCE8O3q8qjosQvOyINhV7KNgXBP7FLg=
Date:   Tue, 22 Dec 2020 17:35:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/2] mm: readahead: handle LARGE input to
 get_init_ra_size()
Message-Id: <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
In-Reply-To: <20201220211051.1416-1-rdunlap@infradead.org>
References: <20201220211051.1416-1-rdunlap@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Dec 2020 13:10:51 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:

> Add a test to detect if the input ra request size has its high order
> bit set (is negative when tested as a signed long). This would be a
> really Huge readahead.
> 
> If so, WARN() with the value and a stack trace so that we can see
> where this is happening and then make further corrections later.
> Then adjust the size value so that it is not so Huge (although
> this may not be needed).

What motivates this change?  Is there any reason to think this can
happen?

Also, everything in there *should* be unsigned, because a negative
readahead is semantically nonsensical.  Is our handling of this
inherently unsigned quantity incorrect somewhere?

> --- linux-5.10.1.orig/mm/readahead.c
> +++ linux-5.10.1/mm/readahead.c
> 
> ...
>
> @@ -303,14 +304,21 @@ void force_page_cache_ra(struct readahea
>  }
>  
>  /*
> - * Set the initial window size, round to next power of 2 and square
> + * Set the initial window size, round to next power of 2
>   * for small size, x 4 for medium, and x 2 for large
>   * for 128k (32 page) max ra
>   * 1-8 page = 32k initial, > 8 page = 128k initial
>   */
>  static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>  {
> -	unsigned long newsize = roundup_pow_of_two(size);
> +	unsigned long newsize;
> +
> +	if ((signed long)size < 0) { /* high bit is set: ultra-large ra req */
> +		WARN_ONCE(1, "%s: size=0x%lx\n", __func__, size);
> +		size = -size;	/* really only need to flip the high/sign bit */
> +	}
> +
> +	newsize = roundup_pow_of_two(size);

Is there any way in which userspace can deliberately trigger warning?
Via sys_readadhead() or procfs tuning or whatever?

I guess that permitting a user-triggerable WARN_ONCE() isn't a huuuuge
problem - it isn't a DoS if it only triggers a single time.  It does
permit the malicious user to disable future valid warnings, but I don't
see what incentive there would be for this.  But still, it seems
desirable to avoid it.

