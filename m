Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091F22DFFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLUSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgLUSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:31:31 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C644C061257
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:51 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x13so12226876oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40GBo3X0+Lrvzi5cvjSPDdF0U8u9NgzOSx3DdfzINbI=;
        b=SQEnSB0HBrmaH+UzR0ysajDAvziE8a2bcVt4twrfo+sI8uwNPnXKkZV5VWjAt90+cq
         Kw2K0XfbwcXwe7Ade3h64UR8qas2ooCyt+jvZzwWUAeNZQU7q43lRlrmqvSnDr3y+kL3
         /ZV2gHY52ggE6JCTbJzxAXWmXMvz76WKV3T5dyK23g/rXusg9S5gCNbW/8r2sD7DgbWn
         SCnX9xJsHLoXuHwi5uGC3q2Lg0OLjRwe8cles2Y5nhDhIW0rkBstwzkjfESASimYA2j5
         DUxpg8gI8ROZpBddYKXwy2fyWjYVgUQzqOP3B3BPpQ3ouP8iuL5foHxP3ISE7omH++zf
         SVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=40GBo3X0+Lrvzi5cvjSPDdF0U8u9NgzOSx3DdfzINbI=;
        b=m1g8Jcv/sEULnKnjLhmcRYoticVg/405ezbKia+CSIxS7Wbse0+cihL1T/56tBs48B
         R45Thu6DcZLFiEcJbDZ984Sj5zf1B5wHIZgGcfus14Slbi3Gzya3hGX42Zl5ShJtB0g9
         ruis/xn6J9OIHQqEv4x+cxcvl/LX2ug0b6DNcIh0VGLQis/haZSk1VJEh59OKT7IgNnj
         X+OD9mC7HQo6pXZk7bDtfFUgtcruMlXlzCtJQh3vahpGJUHBTjhe4Ntjzp/LPgLq8x3V
         h1Ju3uRDN4N2bI27wnV32akhu2VujssDkckrCqHKcIQzgAzIlfs9glHVnIilSK7gfHgr
         6mBA==
X-Gm-Message-State: AOAM530JQTSynx8QdT62K7AyfP1pU9wS7JqqpnJ7ogm+ir4G2U5webmL
        Wg9PTxvdYFdhQ5nZ2IPa9731ILEwg48=
X-Google-Smtp-Source: ABdhPJwBFLD8FyWMUfLtymfObKqKVKNdEHUvBnxB2nPRxZsdxQR5SM9zYoT63SLgbhbZp0T7wCPvVg==
X-Received: by 2002:a17:90a:fa8e:: with SMTP id cu14mr18409199pjb.140.1608571444542;
        Mon, 21 Dec 2020 09:24:04 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id z15sm16555935pfn.34.2020.12.21.09.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 09:24:03 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Dec 2020 09:24:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        sergey.senozhatsky.work@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
Message-ID: <X+DaMSJE22nUC0tl@google.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220002228.38697-1-vitaly.wool@konsulko.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> zsmalloc takes bit spinlock in its _map() callback and releases it
> only in unmap() which is unsafe and leads to zswap complaining
> about scheduling in atomic context.
> 
> To fix that and to improve RT properties of zsmalloc, remove that
> bit spinlock completely and use a bit flag instead.

I don't want to use such open code for the lock.

I see from Mike's patch, recent zswap change introduced the lockdep
splat bug and you want to improve zsmalloc to fix the zswap bug and
introduce this patch with allowing preemption enabling.

https://lore.kernel.org/linux-mm/fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de/

zs_[un/map]_object is designed to be used in fast path(i.e.,
zs_map_object/4K page copy/zs_unmap_object) so the spinlock is
perfectly fine for API point of view. However, zswap introduced
using the API with mutex_lock/crypto_wait_req where allowing
preemption, which was wrong.

Furthermore, the zs_map_object already has a few more places where
disablepreemptions(migrate_read_lock, get_cpu_var and kmap_atomic).

Without making those locks preemptible all at once, zswap will still
see the lockdep warning.

> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
>  mm/zsmalloc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 7289f502ffac..ff26546a7fed 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -876,22 +876,25 @@ static unsigned long obj_to_head(struct page *page, void *obj)
>  
>  static inline int testpin_tag(unsigned long handle)
>  {
> -	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
> +	return test_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
>  }
>  
>  static inline int trypin_tag(unsigned long handle)
>  {
> -	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
> +	return !test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
>  }
>  
> -static void pin_tag(unsigned long handle) __acquires(bitlock)
> +static void pin_tag(unsigned long handle)
>  {
> -	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
> +	preempt_disable();
> +	while(test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle))
> +		cpu_relax();
> +	preempt_enable();
>  }
>  
>  static void unpin_tag(unsigned long handle) __releases(bitlock)
>  {
> -	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
> +	clear_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
>  }
>  
>  static void reset_page(struct page *page)
> -- 
> 2.20.1
> 
