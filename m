Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0162C4D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgKZCrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:47:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729649AbgKZCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606358835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sR99PB2o0qcECDBVCtOM3GDdGKKTrzR/ArpxanzOp0=;
        b=Qf59tOcr9jkhfqhkRW02q5fx/K0XXYBYeU1qMJMhVbMXaNejP+o9gJndaxvzNV93Za5oe9
        FsEsLG40SQnDVb8m2BUcW1mAXzOeLq8HdzM1KXSA2Ijb/kVAxuO0PVmzRHEiF+bEgoh7pc
        Ox8MN3RkkBJBmtayaSuSPXXGthadUBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-QyPpSyXXPkycPD4IlZNo3w-1; Wed, 25 Nov 2020 21:47:11 -0500
X-MC-Unique: QyPpSyXXPkycPD4IlZNo3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 789C71005E5B;
        Thu, 26 Nov 2020 02:47:10 +0000 (UTC)
Received: from T590 (ovpn-13-94.pek2.redhat.com [10.72.13.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49C3510023B2;
        Thu, 26 Nov 2020 02:47:02 +0000 (UTC)
Date:   Thu, 26 Nov 2020 10:46:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] sbitmap: remove swap_lock
Message-ID: <20201126024658.GA42718@T590>
References: <cover.1606058975.git.asml.silence@gmail.com>
 <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 03:35:46PM +0000, Pavel Begunkov wrote:
> map->swap_lock protects map->cleared from concurrent modification,
> however sbitmap_deferred_clear() is already atomically drains it, so
> it's guaranteed to not loose bits on concurrent
> sbitmap_deferred_clear().
> 
> A one threaded tag heavy test on top of nullbk showed ~1.5% t-put
> increase, and 3% -> 1% cycle reduction of sbitmap_get() according to perf.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/sbitmap.h |  5 -----
>  lib/sbitmap.c           | 14 +++-----------
>  2 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index e40d019c3d9d..74cc6384715e 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -32,11 +32,6 @@ struct sbitmap_word {
>  	 * @cleared: word holding cleared bits
>  	 */
>  	unsigned long cleared ____cacheline_aligned_in_smp;
> -
> -	/**
> -	 * @swap_lock: Held while swapping word <-> cleared
> -	 */
> -	spinlock_t swap_lock;
>  } ____cacheline_aligned_in_smp;
>  
>  /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index c1c8a4e69325..4fd877048ba8 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -15,13 +15,9 @@
>  static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>  {
>  	unsigned long mask, val;
> -	bool ret = false;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&map->swap_lock, flags);
> -
> -	if (!map->cleared)
> -		goto out_unlock;
> +	if (!READ_ONCE(map->cleared))
> +		return false;

This way might break sbitmap_find_bit_in_index()/sbitmap_get_shallow().
Currently if sbitmap_deferred_clear() returns false, it means nothing
can be allocated from this word. With this patch, even though 'false'
is returned, free bits still might be available because another
sbitmap_deferred_clear() can be run concurrently.

Thanks,
Ming

