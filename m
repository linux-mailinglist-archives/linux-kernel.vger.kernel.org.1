Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF7828CDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgJMMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgJMMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:02:46 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132CE206D9;
        Tue, 13 Oct 2020 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590566;
        bh=TDZn7whmFHZ7mrQRSKL+Shf6LpSB+qKaiSmTZfuhXGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1lTKRo9Fkbx5SS+0a7Ss0Z9OpBU9P5lfkmHgFBdwWd5HZbvbbRcfTtYYqO3NT98MG
         kQNIss+PV0qOGJsL4V/igBwzEJNjnuDRxSEe2+rhC0Yp9kADgwU70grmtdaYaFHV1s
         40BaXgmJgEF+UQyaudOBACm7e/ioGiGLeYRu6mQs=
Date:   Tue, 13 Oct 2020 15:02:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 55/80] memblock: get rid of a :c:type leftover
Message-ID: <20201013120238.GE4251@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <4d161da11361ce386e7885873f6f4e014f0f2c99.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d161da11361ce386e7885873f6f4e014f0f2c99.1602589096.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:54:10PM +0200, Mauro Carvalho Chehab wrote:
> chanseset b3a7bb1851c8 ("docs: get rid of :c:type explicit declarations for structs")
> removed several :c:type: markups, except by one.
> 
> Now, Sphinx 3.x complains about it:
> 
> 	.../Documentation/core-api/boot-time-mm:26: ../mm/memblock.c:51: WARNING: Unparseable C cross-reference: 'struct\nmemblock_type'
> 	Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
> 	  struct
> 	memblock_type
> 	  ------^
> 
> As, on Sphinx 3.x, the right markup is c:struct:`foo`.
> 
> So, let's remove it, relying on automarkup.py to convert it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/memblock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 670216826940..a06e68b1e5a0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -50,8 +50,8 @@
>   *
>   * Each region is represented by struct memblock_region that
>   * defines the region extents, its attributes and NUMA node id on NUMA
> - * systems. Every memory type is described by the :c:type:`struct
> - * memblock_type` which contains an array of memory regions along with
> + * systems. Every memory type is described by the struct memblock_type
> + * which contains an array of memory regions along with
>   * the allocator metadata. The "memory" and "reserved" types are nicely
>   * wrapped with struct memblock. This structure is statically
>   * initialized at build time. The region arrays are initially sized to
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
