Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5B272361
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIUMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgIUMLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:11:34 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169EA206D9;
        Mon, 21 Sep 2020 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600690294;
        bh=AfC+JMOjrAUECkdEANLpPguMuiHLako5q/hs1b2Ntpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6UyTkaGGK7oMmIfXRfCZCaoKTMwMax4e3MJynfWnN6cFrvASDjHGge0EssaGxxLA
         yDB0QrdFCiN7rNkofzprQhuQdvupIhnaGw4Af+4w2W5OgoLhRcvJn/cYPvlAfgvaRd
         d7YCpnvphmLXkAuD+zL5EfnG6dFjRSwMC4JVFyJM=
Date:   Mon, 21 Sep 2020 15:11:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/madvise: remove duplicate include
Message-ID: <20200921121126.GR2142832@kernel.org>
References: <20200915121550.30584-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915121550.30584-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:15:50PM +0800, YueHaibing wrote:
> Remove duplicate header which is included twice.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  mm/madvise.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c index
> 460e19d60ba3..9bd21f9019d9 100644 --- a/mm/madvise.c +++
> b/mm/madvise.c @@ -30,7 +30,6 @@ #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/mmu_notifier.h>
> -#include <linux/sched/mm.h>

To what version does this apply?
I cannot find duplicate sched/mm.h neither in v5.9-rc6 nor in mmotm

>  
>  #include <asm/tlb.h>
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Sincerely yours,
Mike.
