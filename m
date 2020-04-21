Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105B41B292F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgDUOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:52196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUOPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:15:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1E0AAEF7;
        Tue, 21 Apr 2020 14:15:35 +0000 (UTC)
Subject: Re: [PATCH] kmalloc_index optimization(add kmalloc max size check)
To:     Bernard Zhao <bernard@vivo.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <1587107376-111722-1-git-send-email-bernard@vivo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <05bedc84-3672-975c-87ee-f094ca766ee8@suse.cz>
Date:   Tue, 21 Apr 2020 16:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587107376-111722-1-git-send-email-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/20 9:09 AM, Bernard Zhao wrote:
> kmalloc size should never exceed KMALLOC_MAX_SIZE.
> kmalloc_index realise if size is exceed KMALLOC_MAX_SIZE, e.g 64M,
> kmalloc_index just return index 26, but never check with OS`s max
> kmalloc config KMALLOC_MAX_SIZE. This index`s kmalloc caches maybe
> not create in function create_kmalloc_caches.
> We can throw an warninginfo in kmalloc at the beginning, instead of
> being guaranteed by the buddy alloc behind.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

kmalloc_index() is only called from kmalloc() and kmalloc_node() for
compile-time constant sizes up to KMALLOC_MAX_CACHE_SIZE, which is smaller
(SLUB, SLOB) or equal (SLAB) than KMALLOC_MAX_SIZE. So your patch is effectively
a no-op and we better shouldn't tease the compiler too much, so that
kmalloc_index() stays fully compile-time evaluated.

> ---
>  include/linux/slab.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6d45488..59b60d2 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -351,6 +351,10 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>  	if (!size)
>  		return 0;
>  
> +	/* size should never exceed KMALLOC_MAX_SIZE. */
> +	if (size > KMALLOC_MAX_SIZE)
> +		WARN(1, "size exceed max kmalloc size!\n");
> +
>  	if (size <= KMALLOC_MIN_SIZE)
>  		return KMALLOC_SHIFT_LOW;
>  
> 

