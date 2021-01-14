Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E72F5F80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhANLIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:08:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:45842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbhANLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:08:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91D5DB769;
        Thu, 14 Jan 2021 11:07:54 +0000 (UTC)
Subject: Re: [PATCH v2] mm/slub: disable user tracing for kmemleak caches by
 default
To:     Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <31b91946-af43-8795-0d4a-cb93899ccbce@suse.cz>
Date:   Thu, 14 Jan 2021 12:07:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 9:51 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If kmemleak is enabled, it uses a kmem cache for its own objects.
> These objects are used to hold information kmemleak uses, including
> a stack trace. If slub_debug is also turned on, each of them has
> *another* stack trace, so the overhead adds up, and on my tests (on
> ARCH=um, admittedly) 2/3rds of the allocations end up being doing
> the stack tracing.
> 
> Turn off SLAB_STORE_USER if SLAB_NOLEAKTRACE was given, to avoid
> storing the essentially same data twice.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Perhaps instead it should go the other way around, and kmemleak
> could even use/access the stack trace that's already in there ...
> But I don't really care too much, I can just turn off slub debug
> for the kmemleak caches via the command line anyway :-)
> 
> v2:
>  - strip SLAB_STORE_USER only coming from slub_debug so that the
>    command line args always take effect
> 
> ---
>  mm/slub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 34dcc09e2ec9..a66c9948c529 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1412,6 +1412,15 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  	size_t len;
>  	char *next_block;
>  	slab_flags_t block_flags;
> +	slab_flags_t slub_debug_local = slub_debug;
> +
> +	/*
> +	 * If the slab cache is for debugging (e.g. kmemleak) then
> +	 * don't store user (stack trace) information by default,
> +	 * but let the user enable it via the command line below.
> +	 */
> +	if (flags & SLAB_NOLEAKTRACE)
> +		slub_debug_local &= ~SLAB_STORE_USER;
>  
>  	len = strlen(name);
>  	next_block = slub_debug_string;
> @@ -1446,7 +1455,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  		}
>  	}
>  
> -	return flags | slub_debug;
> +	return flags | slub_debug_local;
>  }
>  #else /* !CONFIG_SLUB_DEBUG */
>  static inline void setup_object_debug(struct kmem_cache *s,
> 

