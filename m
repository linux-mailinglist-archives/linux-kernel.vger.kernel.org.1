Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3151F27B0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1PWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgI1PWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:22:11 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA4B2100A;
        Mon, 28 Sep 2020 15:22:08 +0000 (UTC)
Date:   Mon, 28 Sep 2020 16:22:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        robin.murphy@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v3 0/2] arm64/mm: Enable color zero pages
Message-ID: <20200928152206.GC27500@gaia>
References: <20200928072256.13098-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928072256.13098-1-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Mon, Sep 28, 2020 at 05:22:54PM +1000, Gavin Shan wrote:
> Testing
> =======
> [1] The experiment reveals how heavily the (L1) data cache miss impacts
>     the overall application's performance. The machine where the test
>     is carried out has the following L1 data cache topology. In the
>     mean while, the host kernel have following configurations.
> 
>     The test case allocates contiguous page frames through HugeTLBfs
>     and reads 4-bytes data from the same offset (0x0) from these (N)
>     contiguous page frames. N is equal to 8 or 9 separately in the
>     following two test cases. This is repeated for one million of
>     times.
> 
>     Note that 8 is number of L1 data cache ways. The experiment is
>     cause L1 cache thrashing on one particular set.
> 
>     Host:      CONFIG_ARM64_PAGE_SHIFT=12
>                DEFAULT_HUGE_PAGE_SIZE=2MB
>     L1 dcache: cache-line-size=64
>                number-of-sets=64
>                number-of-ways=8
> 
>                             N=8           N=9
>     ------------------------------------------------------------------
>     cache-misses:           43,429        9,038,460
>     L1-dcache-load-misses:  43,429        9,038,460
>     seconds time elapsed:   0.299206372   0.722253140   (2.41 times)
> 
> [2] The experiment should have been carried out on machine where the
>     L1 data cache capacity of one particular way is larger than 4KB.
>     However, I'm unable to find such kind of machines. So I have to
>     evaluate the performance impact caused by L2 data cache thrashing.
>     The experiment is carried out on the machine, which has following
>     L1/L2 data cache topology. The host kernel configuration is same
>     to [1].
> 
>     The corresponding test program allocates contiguous page frames
>     through hugeTLBfs and builds VMAs backed by zero pages. These
>     contiguous pages are sequentially read from fixed offset (0) in step
>     of 32KB and by 8 times. After that, the VMA backed by zero pages are
>     sequentially read in step of 4KB and by once. It's repeated by 8
>     millions of times.
> 
>     Note 32KB is the cache capacity in one L2 data cache way and 8 is
>     number of L2 data cache sets. This experiment is to cause L2 data
>     cache thrashing on one particular set.
> 
>     L1 dcache:  <same as [1]>
>     L2 dcache:  cache-line-size=64
>                 number-of-sets=512
>                 number-of-ways=8
> 
>     -----------------------------------------------------------------------
>     cache-references:       1,427,213,737    1,421,394,472
>     cache-misses:              35,804,552       42,636,698
>     L1-dcache-load-misses:     35,804,552       42,636,698
>     seconds time elapsed:   2.602511671      2.098198172      (+19.3%)

No-one is denying a performance improvement in a very specific way but
what's missing here is explaining how these artificial benchmarks relate
to real-world applications.

-- 
Catalin
