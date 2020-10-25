Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93830298098
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 07:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767690AbgJYGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 02:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1767682AbgJYGej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 02:34:39 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05242208E4;
        Sun, 25 Oct 2020 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603607678;
        bh=DHAVWPlJGJCTJZ9CsWCzA3rvA+lIusM3kKdx+tyX6fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmlbfxZ+j/q/hY5jRPyNMUzRnNLx3K5+FS4fKo03SqXlwZP2qAGonHLVfqCKDGYN+
         /z1iR03p5ZHcqBYge+UYXQvjID6/3t5D3rvEI6rvTAoViG+16CK5/jmGpE0R73XoRY
         1zPQraL3j4U9GZeQX8B/w8dx9JaYQcaLEUOQa7ck=
Date:   Sun, 25 Oct 2020 08:34:31 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 47/56] memblock: fix kernel-doc markups
Message-ID: <20201025063431.GD392079@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <90f921afef8f60498a997a4a243bcf839b9142ca.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f921afef8f60498a997a4a243bcf839b9142ca.1603469755.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:34PM +0200, Mauro Carvalho Chehab wrote:
> Some identifiers have different names between their prototypes
> and the kernel-doc markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/memblock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index ef131255cedc..95fe3cb71c54 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -272,7 +272,7 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>  				  unsigned long *out_spfn,
>  				  unsigned long *out_epfn);
>  /**
> - * for_each_free_mem_range_in_zone - iterate through zone specific free
> + * for_each_free_mem_pfn_range_in_zone - iterate through zone specific free
>   * memblock areas
>   * @i: u64 used as loop variable
>   * @zone: zone in which all of the memory blocks reside
> @@ -292,7 +292,7 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>  	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
>  
>  /**
> - * for_each_free_mem_range_in_zone_from - iterate through zone specific
> + * for_each_free_mem_pfn_range_in_zone_from - iterate through zone specific
>   * free memblock areas from a given point
>   * @i: u64 used as loop variable
>   * @zone: zone in which all of the memory blocks reside
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
