Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A190724C35E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgHTQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 12:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgHTQbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:31:45 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457A92054F;
        Thu, 20 Aug 2020 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597941105;
        bh=zKshuG67u0neBiV2f+UNp4wq9lueh8JEmIh5e3uPpXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iM9wJddgOPrLRRmD/eR++hu7vPazQ/1YJpjRnS4NABOuSoe0wTRuArf02stQhI7ef
         fBz57nVzuOb7xjge1sr3YTEYgkdFx98PEJoZs3+NC2yXYlWL312t2BJxEhkxQGTXBg
         yEyFgtpGOalfZE41VHDVKXV6TkMxSyTnCm9XxlWg=
Date:   Thu, 20 Aug 2020 19:31:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: Clean up endif comments
Message-ID: <20200820163138.GC752365@kernel.org>
References: <20200819184635.112579-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184635.112579-1-ira.weiny@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:46:35AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The #endif at the end of the file matches up with the '#if
> defined(HASHED_PAGE_VIRTUAL)' on line 374.  Not the CONFIG_HIGHMEM #if
> earlier.
> 
> Fix comments on both of the #endif's to indicate the correct end of
> blocks for each.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/highmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 64d8dea47dd1..1352a27951e3 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -369,7 +369,7 @@ void kunmap_high(struct page *page)
>  }
>  
>  EXPORT_SYMBOL(kunmap_high);
> -#endif
> +#endif	/* CONFIG_HIGHMEM */
>  
>  #if defined(HASHED_PAGE_VIRTUAL)
>  
> @@ -481,4 +481,4 @@ void __init page_address_init(void)
>  	}
>  }
>  
> -#endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */
> +#endif	/* defined(HASHED_PAGE_VIRTUAL) */
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
