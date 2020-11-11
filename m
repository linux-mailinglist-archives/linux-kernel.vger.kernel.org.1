Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B863B2AEE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgKKJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbgKKJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605088599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XA2Ly6G9+uqaj4t90Nv+OVjOkGfko8/whq+z9+8i7E=;
        b=M26e/h6zs+HjxGVLwJYDHiFz4t27J3kLNajwJBNM7aQHDV++S+AGljnW3f1H6diqcBo7at
        iCIH1vW+r8Oi1DvHVzRDi/JswbRRgOU6xD2v1FrNeoKsMkvPi7TlEYcgMDImb07Fr8bKHn
        l3aYXXAV8zZPFDxIENicIz4gZ2bi0rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-kw35YCLhNA-EYDOl6FMLMQ-1; Wed, 11 Nov 2020 04:56:36 -0500
X-MC-Unique: kw35YCLhNA-EYDOl6FMLMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F3C80476E;
        Wed, 11 Nov 2020 09:56:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B3C6EF5B;
        Wed, 11 Nov 2020 09:56:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0AB9uSqU029365;
        Wed, 11 Nov 2020 04:56:28 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0AB9uSYG029361;
        Wed, 11 Nov 2020 04:56:28 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 11 Nov 2020 04:56:27 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rob Herring <robherring2@gmail.com>,
        clang-built-linux@googlegroups.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dm cache: fix arm link errors with inline"
In-Reply-To: <20201111024140.1483879-1-ndesaulniers@google.com>
Message-ID: <alpine.LRH.2.02.2011110456030.25804@file01.intranet.prod.int.rdu2.redhat.com>
References: <20201111024140.1483879-1-ndesaulniers@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Mikulas Patocka <mpatocka@redhat.com>



On Tue, 10 Nov 2020, Nick Desaulniers wrote:

> This reverts commit 43aeaa29573924df76f44eda2bbd94ca36e407b5.
> 
> Since
> commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
> the minimum supported version of GCC is gcc-4.9. It's now safe to remove
> this code.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/427
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/md/dm-cache-target.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 9644424591da..4bc453f5bbaa 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -712,10 +712,6 @@ static bool block_size_is_power_of_two(struct cache *cache)
>  	return cache->sectors_per_block_shift >= 0;
>  }
>  
> -/* gcc on ARM generates spurious references to __udivdi3 and __umoddi3 */
> -#if defined(CONFIG_ARM) && __GNUC__ == 4 && __GNUC_MINOR__ <= 6
> -__always_inline
> -#endif
>  static dm_block_t block_div(dm_block_t b, uint32_t n)
>  {
>  	do_div(b, n);
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

