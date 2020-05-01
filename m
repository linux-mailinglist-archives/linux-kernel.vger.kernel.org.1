Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481561C20C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEAWfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 18:35:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:19389 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgEAWfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:35:31 -0400
IronPort-SDR: EIP4cVNGmzGNIJSn9wjxmL4DVRTFEA6Vt0vwHsE3U/lRGevqMUnXZbs2zUXNRBk26Ug7jkV9G/
 NMyHJ1d63/MA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 15:35:30 -0700
IronPort-SDR: UNgRkzx638fo1l4ebhI3DztWLWC8sss7yytwj3kuQf5HvXKhrllpZBjTnxH9XKYdo/j53vHHsz
 T0g92LcC0P0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="283310281"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.53.33])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 15:35:28 -0700
Subject: Re: [PATCH 3/3] mm/swap: remove redundant check for
 swap_slot_cache_initialized
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200430061143.450-1-thunder.leizhen@huawei.com>
 <20200430061143.450-4-thunder.leizhen@huawei.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <9b45c120-e369-d436-a369-6c80e3d6ee2e@linux.intel.com>
Date:   Fri, 1 May 2020 15:35:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430061143.450-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/20 11:11 PM, Zhen Lei wrote:
> Because enable_swap_slots_cache can only become true in
> enable_swap_slots_cache(), and depends on swap_slot_cache_initialized is
> true before. That means, when enable_swap_slots_cache is true,
> swap_slot_cache_initialized is true also.
> 
> So the condition:
> "swap_slot_cache_enabled && swap_slot_cache_initialized"
> can be reduced to "swap_slot_cache_enabled"
> 
> And in mathematics:
> "!swap_slot_cache_enabled || !swap_slot_cache_initialized"
> is equal to "!(swap_slot_cache_enabled && swap_slot_cache_initialized)"
> 
> So no functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  mm/swap_slots.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index b40394473a3c..3e6453573a89 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -46,8 +46,7 @@ static void __drain_swap_slots_cache(unsigned int type);
>  static void deactivate_swap_slots_cache(void);
>  static void reactivate_swap_slots_cache(void);
>  
> -#define use_swap_slot_cache (swap_slot_cache_active && \
> -		swap_slot_cache_enabled && swap_slot_cache_initialized)
> +#define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)

Yes, swap_slot_cache_enabled does imply swap_slot_cache_initialized
in current code.  So checking swap_slot_cache_enabled is
enough here.

>  #define SLOTS_CACHE 0x1
>  #define SLOTS_CACHE_RET 0x2
>  
> @@ -94,7 +93,7 @@ static bool check_cache_active(void)
>  {
>  	long pages;
>  
> -	if (!swap_slot_cache_enabled || !swap_slot_cache_initialized)
> +	if (!swap_slot_cache_enabled)

This simplification is okay.   !swap_slot_cache_initialize implies !swap_slot_cache_enabled.
So only !swap_slot_cache_enabled needs to be checked.

>  		return false;
>  
>  	pages = get_nr_swap_pages();
> 

Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
