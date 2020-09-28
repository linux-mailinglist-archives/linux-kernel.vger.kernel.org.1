Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4927B045
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgI1OtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1OtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:49:06 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B634D2083B;
        Mon, 28 Sep 2020 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601304546;
        bh=9LRxtxjyRy0Tw9U1jNadFJt67c+Ahhm98hMYDQDjTTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ba2fg2veNGOE4aRm0TVbk4dvqABZ5SimbcXc93q824WJMZ/DcSnVw+Xbbdimi9OyV
         38jQWoqDTCsufOg/e1f0Y3D3cX9MGnrdl9Kq54QmCoEtRUbLrtm/hAtcPy1Ub0Urv4
         o7vjAiSM1O5us9js/ynQ9P7xECoEUeXRE94K+HUA=
Date:   Mon, 28 Sep 2020 17:49:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: remove unused early_pfn_valid()
Message-ID: <20200928144900.GA2142832@kernel.org>
References: <20200923162915.26935-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923162915.26935-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Wed, Sep 23, 2020 at 07:29:15PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The early_pfn_valid() macro is defined by it is never used.
> Remove it.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/mmzone.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8379432f4f2f..38264363b0d4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1376,7 +1376,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
>  #define pfn_to_nid(pfn)		(0)
>  #endif
>  
> -#define early_pfn_valid(pfn)	pfn_valid(pfn)
>  void sparse_init(void);
>  #else
>  #define sparse_init()	do {} while (0)
> @@ -1396,10 +1395,6 @@ struct mminit_pfnnid_cache {
>  	int last_nid;
>  };
>  
> -#ifndef early_pfn_valid
> -#define early_pfn_valid(pfn)	(1)
> -#endif
> -
>  /*
>   * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
>   * need to check pfn validity within that MAX_ORDER_NR_PAGES block.
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
