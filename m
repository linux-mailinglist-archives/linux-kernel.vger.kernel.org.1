Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1B28D27F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgJMQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:44:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:55464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgJMQoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:44:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 694EBAB0E;
        Tue, 13 Oct 2020 16:44:16 +0000 (UTC)
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
References: <20201009195411.4018141-1-keescook@chromium.org>
 <20201009195411.4018141-4-keescook@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 3/3] mm/slub: Actually fix freelist pointer vs
 redzoning
Message-ID: <0f7dd7b2-7496-5e2d-9488-2ec9f8e90441@suse.cz>
Date:   Tue, 13 Oct 2020 18:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009195411.4018141-4-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 9:54 PM, Kees Cook wrote:
> It turns out that SLUB redzoning ("slub_debug=Z") checks from
> s->object_size rather than from s->inuse (which is normally bumped to
> make room for the freelist pointer), so a cache created with an object
> size less than 24 would have their freelist pointer written beyond
> s->object_size, causing the redzone to corrupt the freelist pointer.

Is this accurate? Seems to me that redzone is (re)initialized only when 
freepointer is not active. So it is actually freelist pointer corrupting the 
redzone...

> This was very visible with "slub_debug=ZF":

... as this report shows :)

> 
> BUG test (Tainted: G    B            ): Right Redzone overwritten
> -----------------------------------------------------------------------------
> 
> INFO: 0xffff957ead1c05de-0xffff957ead1c05df @offset=1502. First byte 0x1a instead of 0xbb
> INFO: Slab 0xffffef3950b47000 objects=170 used=170 fp=0x0000000000000000 flags=0x8000000000000200
> INFO: Object 0xffff957ead1c05d8 @offset=1496 fp=0xffff957ead1c0620
> 
> Redzone  (____ptrval____): bb bb bb bb bb bb bb bb               ........
> Object   (____ptrval____): 00 00 00 00 00 f6 f4 a5               ........
> Redzone  (____ptrval____): 40 1d e8 1a aa                        @....
> Padding  (____ptrval____): 00 00 00 00 00 00 00 00               ........
> 
> Adjust the offset to stay within s->object_size.
> 
> Reported-by: Marco Elver <elver@google.com>
> Link: https://lore.kernel.org/linux-mm/20200807160627.GA1420741@elver.google.com/
> Fixes: 89b83f282d8b (slub: avoid redzone when choosing freepointer location)
> Tested-by: Marco Elver <elver@google.com>
> Link: https://lore.kernel.org/lkml/CANpmjNOwZ5VpKQn+SYWovTkFB4VsT-RPwyENBmaK0dLcpqStkA@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

This struggle to get it right perhaps calls for some selftests of all 
combinations of flags that affect object layout, e.g. of 
redzone/poison/store_user, on sizes from sizeof(void *) to e.g. 3*sizeof(void 
*), with sanity_checks enabled. Shouldn't be too many tests...

> ---
>   mm/slub.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 752fad36522c..6f115e56c5d0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3637,7 +3637,6 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>   {
>   	slab_flags_t flags = s->flags;
>   	unsigned int size = s->object_size;
> -	unsigned int freepointer_area;
>   	unsigned int order;
>   
>   	/*
> @@ -3646,13 +3645,6 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>   	 * the possible location of the free pointer.
>   	 */
>   	size = ALIGN(size, sizeof(void *));
> -	/*
> -	 * This is the area of the object where a freepointer can be
> -	 * safely written. If redzoning adds more to the inuse size, we
> -	 * can't use that portion for writing the freepointer, so
> -	 * s->offset must be limited within this for the general case.
> -	 */
> -	freepointer_area = size;
>   
>   #ifdef CONFIG_SLUB_DEBUG
>   	/*
> @@ -3678,7 +3670,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>   
>   	/*
>   	 * With that we have determined the number of bytes in actual use
> -	 * by the object. This is the potential offset to the free pointer.
> +	 * by the object and redzoning.
>   	 */
>   	s->inuse = size;
>   
> @@ -3701,13 +3693,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>   		 */
>   		s->offset = size;
>   		size += sizeof(void *);
> -	} else if (freepointer_area > sizeof(void *)) {
> +	} else {
>   		/*
>   		 * Store freelist pointer near middle of object to keep
>   		 * it away from the edges of the object to avoid small
>   		 * sized over/underflows from neighboring allocations.
>   		 */
> -		s->offset = ALIGN(freepointer_area / 2, sizeof(void *));
> +		s->offset = ALIGN_DOWN(s->object_size / 2, sizeof(void *));
>   	}
>   
>   #ifdef CONFIG_SLUB_DEBUG
> 

