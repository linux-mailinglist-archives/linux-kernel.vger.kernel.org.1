Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4927B40A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgI1SEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:04:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:17839 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgI1SEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:04:36 -0400
IronPort-SDR: mZw0iolsOjcK0PIk8SsVmuXOlg73Sm9i1Twx/fY5oIhqyaJCGyROH6od1o7AD3gQJ8EUOuX4G8
 pObk2+AMfknw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="161265931"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="161265931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:04:35 -0700
IronPort-SDR: tPGu1sWjNahQoAI85wJKtVMgkG/nWazOLlj63NYMTNCGfhPJYBQHsA4D26sML3CMv60sKTLiE7
 rlk2KgWYB8uA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456935981"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:04:35 -0700
Date:   Mon, 28 Sep 2020 11:04:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc.c: check the addr first
Message-ID: <20200928180434.GD458519@iweiny-DESK2.sc.intel.com>
References: <20200927163337.GA5472@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927163337.GA5472@rlk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:33:37AM +0800, Hui Su wrote:
> As the comments said, if @addr is NULL, no operation
> is performed, check the addr first in vfree() and
> vfree_atomic() maybe a better choice.

I don't see how this change helps anything.  kmemleak_free() checks addr so no
danger there.  Also kmemleak_free() contains a pr_debug() which some might find
useful.

Ira

> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  mm/vmalloc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index be4724b916b3..1cf50749a209 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2305,10 +2305,11 @@ void vfree_atomic(const void *addr)
>  {
>  	BUG_ON(in_nmi());
>  
> -	kmemleak_free(addr);
> -
>  	if (!addr)
>  		return;
> +
> +	kmemleak_free(addr);
> +
>  	__vfree_deferred(addr);
>  }
>  
> @@ -2340,13 +2341,13 @@ void vfree(const void *addr)
>  {
>  	BUG_ON(in_nmi());
>  
> +	if (!addr)
> +		return;
> +
>  	kmemleak_free(addr);
>  
>  	might_sleep_if(!in_interrupt());
>  
> -	if (!addr)
> -		return;
> -
>  	__vfree(addr);
>  }
>  EXPORT_SYMBOL(vfree);
> -- 
> 2.25.1
> 
> 
> 
