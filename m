Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9A2ADDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgKJSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJSQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:16:12 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AF920781;
        Tue, 10 Nov 2020 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605032171;
        bh=UyILU+nPWtEG2lkYm08D82WracQenImj1C2c66W0WzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2QI3PJRPOJ8NOtvl4kIvcbBiVS+L5hqqaAt3KOkei45F7Of6tn/iveJe3A5onR4O
         1rUm6e4n7ekCbmNfXeqfhSl64wl8qVls/OFPtTobiJ3mCPn/efDHmFYFsaBN6s3E48
         u3qLAUypl41JS7XjizEg1Msh15FUm1vOHGrEC4wA=
Date:   Tue, 10 Nov 2020 20:16:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: memblock: add more debug logs
Message-ID: <20201110181605.GC4758@kernel.org>
References: <1605010798-17545-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605010798-17545-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 10, 2020 at 05:49:58PM +0530, Faiyaz Mohammed wrote:
> Exact caller of memblock_phys_alloc_range is not available with
> "memblock=debug". Below information is not enough for memory accounting.
> for example:
> [    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188
> 
> To enhance the memblock_dbg information or to get the exact owner of the
> memblock_reserve, add debug logs in memblock_phys_alloc_range function.

Why would you want to use memblock=debug for memory accounting or for
tracking of the owners of the reserved memory?

> After adding logs:
> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 early_pgtable_alloc+0x24/0x178
> [    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 049df41..f65af9f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1419,6 +1419,9 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  					     phys_addr_t start,
>  					     phys_addr_t end)
>  {
> +	memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
> +			__func__, (u64)size, (u64)align, &start, &end,
> +			(void *)_RET_IP_);
>  	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
>  					false);
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
Sincerely yours,
Mike.
