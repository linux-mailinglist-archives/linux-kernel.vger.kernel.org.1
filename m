Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0662A9BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgKFSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:24:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:24780 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgKFSYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:24:10 -0500
IronPort-SDR: JRkc+iGhttzyzE6Gk7X4UrkVlwQo2h5bvZ0EPhiWovkffCRT4W69rDY9mvd9RFV5Jhr66YPFIL
 dAMaumiIT89A==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149433600"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="149433600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:24:10 -0800
IronPort-SDR: Kp6DFPqEfo2PjMsWFbyMNabIjKMmRlMsXXBJYEc2XgfImDO+fPrUARSHD0E8dveJMl+91XYvXh
 TYN12/ObkSMg==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="539937984"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:24:09 -0800
Date:   Fri, 6 Nov 2020 10:24:09 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-ID: <20201106182409.GC3976735@iweiny-DESK2.sc.intel.com>
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 07:24:55PM +0800, Alex Shi wrote:
> Otherwise it cause gcc warning:
>           ^~~~~~~~~~~~~~~
> ../mm/filemap.c:830:14: warning: no previous prototype for
> ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
>  noinline int __add_to_page_cache_locked(struct page *page,
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>

Does this affect the use in:

kernel/bpf/verifier.c|11478| BTF_ID(func, __add_to_page_cache_locked)                                                                           

?

It does not look like that calls the function but I'm not sure what BTF_ID
does?

Ira

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: linux-mm@kvack.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d90614f501da..249cf489f5df 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
>  
> -noinline int __add_to_page_cache_locked(struct page *page,
> +static noinline int __add_to_page_cache_locked(struct page *page,
>  					struct address_space *mapping,
>  					pgoff_t offset, gfp_t gfp,
>  					void **shadowp)
> -- 
> 1.8.3.1
> 
