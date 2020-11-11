Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3B2AF549
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKKPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727424AbgKKPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605109429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bw81PsEaDm3tUnrsxO8Odvn+M+fX2gNDcSxC7Tq7e6A=;
        b=P+KZjJwQLOZXyCACtUSBcN9c4R4M9APFn4aRKk482nnGnADx0SO4OyQJKNtHIv81ULeitS
        3on+HuwfZvojO0DnNBnIkuXDNs62e+XTBZ3Mp4jRwc03OPLRpPn0CPBzJZMGCn3IGxUI44
        qJd2oONQ2mtxf8NwfxwN7zPUiSGQfo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-u64_rxA9Pp-OJsGC2d_Qnw-1; Wed, 11 Nov 2020 10:43:47 -0500
X-MC-Unique: u64_rxA9Pp-OJsGC2d_Qnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FEDC188C126;
        Wed, 11 Nov 2020 15:43:46 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 632EA27BC2;
        Wed, 11 Nov 2020 15:43:44 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] mm, page_poison: remove
 CONFIG_PAGE_POISONING_NO_SANITY
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>
References: <20201103152237.9853-1-vbabka@suse.cz>
 <20201103152237.9853-5-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3c331f29-bbbe-709f-a1e3-a3710bbac5ad@redhat.com>
Date:   Wed, 11 Nov 2020 16:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201103152237.9853-5-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.20 16:22, Vlastimil Babka wrote:
> CONFIG_PAGE_POISONING_NO_SANITY skips the check on page alloc whether the
> poison pattern was corrupted, suggesting a use-after-free. The motivation to
> introduce it in commit 8823b1dbc05f ("mm/page_poison.c: enable PAGE_POISONING
> as a separate option") was to simply sanitize freed pages, optimally together
> with CONFIG_PAGE_POISONING_ZERO.
> 
> These days we have an init_on_free=1 boot option, which makes this use case of
> page poisoning redundant. For sanitizing, writing zeroes is sufficient, there
> is pretty much no benefit from writing the 0xAA poison pattern to freed pages,
> without checking it back on alloc. Thus, remove this option and suggest
> init_on_free instead in the main config's help.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   drivers/virtio/virtio_balloon.c |  4 +---
>   mm/Kconfig.debug                | 15 ++++-----------
>   mm/page_poison.c                |  3 ---
>   3 files changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index e53faed6ba93..8985fc2cea86 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1114,9 +1114,7 @@ static int virtballoon_validate(struct virtio_device *vdev)
>   	 * page reporting as it could potentially change the contents
>   	 * of our free pages.
>   	 */
> -	if (!want_init_on_free() &&
> -	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
> -	     !page_poisoning_enabled_static()))
> +	if (!want_init_on_free() && !page_poisoning_enabled_static())
>   		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
>   	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
>   		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index c57786ad5be9..14e29fe5bfa6 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -74,18 +74,11 @@ config PAGE_POISONING
>   	  Note that "poison" here is not the same thing as the "HWPoison"
>   	  for CONFIG_MEMORY_FAILURE. This is software poisoning only.
>   
> -	  If unsure, say N
> +	  If you are only interested in sanitization of freed pages without
> +	  checking the poison pattern on alloc, you can boot the kernel with
> +	  "init_on_free=1" instead of enabling this.
>   
> -config PAGE_POISONING_NO_SANITY
> -	depends on PAGE_POISONING
> -	bool "Only poison, don't sanity check"
> -	help
> -	   Skip the sanity checking on alloc, only fill the pages with
> -	   poison on free. This reduces some of the overhead of the
> -	   poisoning feature.
> -
> -	   If you are only interested in sanitization, say Y. Otherwise
> -	   say N.
> +	  If unsure, say N
>   
>   config PAGE_POISONING_ZERO
>   	bool "Use zero for poisoning instead of debugging value"
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index dd7aeada036f..084fc3ff4c15 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -51,9 +51,6 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
>   	unsigned char *start;
>   	unsigned char *end;
>   
> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY))
> -		return;
> -
>   	start = memchr_inv(mem, PAGE_POISON, bytes);
>   	if (!start)
>   		return;
> 

This clearly simplifies things.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

