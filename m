Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C41A97B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408190AbgDOI5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405268AbgDOI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:57:08 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBAC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z18reNrEyKf1NJjD06HCmDGv5FbGXihQe6KKOmGQo/8=; b=pWNb6KFcsYvhPeAtMzL5R6dC4I
        3wiihazVHIuDUhC1XjYwc2/uTrREiYD1Sfn31kF1RN0LsOC7kGY+ociNXGEJqKw6AUCC5DHw66HI0
        bfI+wqBZf/SW/b55o4UuLKqkkElh5iu51rSsKnmcNR5aATmPpvMXWb7x4zvWKev+c8bpdcnzLdfzl
        ublnKKEpvOKq2iP6c5b7pCCm87PIJmR0mAc1gGUPlTFsacHElIALdEqMGBfeTBNrQASOx4Gi9PYJO
        s2CMwwP9i1bQWSfg+NVd8T6FOc1hqYzF2mRSDrBfffPQcCGkAgj6B294QDPWkZbXImaGHKHDTFgod
        2o11meag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOdqX-0004qd-W9; Wed, 15 Apr 2020 08:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 253A8305EEC;
        Wed, 15 Apr 2020 10:56:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 101EE20B07BFE; Wed, 15 Apr 2020 10:56:35 +0200 (CEST)
Date:   Wed, 15 Apr 2020 10:56:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] Bitmap: Optimized division operation to shift operation
Message-ID: <20200415085634.GA17091@hirez.programming.kicks-ass.net>
References: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 03:27:40PM +0800, Wang Qing wrote:
> On some processors, the / operate will call the compiler`s div lib,
> which is low efficient. Bitmap is performance sensitive, We can
> replace the / operation with shift.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  include/linux/bitmap.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99058eb..85ff982 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -337,7 +337,7 @@ static inline int bitmap_equal(const unsigned long *src1,
>  		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
>  	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
>  	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
> -		return !memcmp(src1, src2, nbits / 8);
> +		return !memcmp(src1, src2, nbits >> 3);
>  	return __bitmap_equal(src1, src2, nbits);
>  }

If your compiler gets this wrong, set it on fire and scatter its remains.
