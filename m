Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8994F2F5084
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAMRA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:00:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:50428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbhAMRA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:00:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D039AB92;
        Wed, 13 Jan 2021 16:59:47 +0000 (UTC)
To:     Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
References: <20210113170931.929f808099d2.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/slub: disable user tracing for kmemleak caches
Message-ID: <1db7c986-25c4-884e-4fbf-9af348bdff6f@suse.cz>
Date:   Wed, 13 Jan 2021 17:59:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113170931.929f808099d2.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 5:09 PM, Johannes Berg wrote:
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

How about stripping away SLAB_STORE_USER only if it's added from the global
slub_debug variable? In case somebody lists one of the kmemleak caches
explicitly in "slub_debug=..." instead of just booting with "slub_debug", we
should honor that.

> ---
> Perhaps instead it should go the other way around, and kmemleak
> could even use/access the stack trace that's already in there ...
> But I don't really care too much, I can just turn off slub debug
> for the kmemleak caches via the command line anyway :-)
> 
> ---
>  mm/slub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 34dcc09e2ec9..625a32a6645b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1446,7 +1446,16 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  		}
>  	}
>  
> -	return flags | slub_debug;
> +	flags |= slub_debug;
> +
> +	/*
> +	 * If the slab cache is for debugging (e.g. kmemleak) then
> +	 * don't store user (stack trace) information.
> +	 */
> +	if (flags & SLAB_NOLEAKTRACE)
> +		flags &= ~SLAB_STORE_USER;
> +
> +	return flags;
>  }
>  #else /* !CONFIG_SLUB_DEBUG */
>  static inline void setup_object_debug(struct kmem_cache *s,
> 

