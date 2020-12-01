Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46E02CAD24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgLAURJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgLAURC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:17:02 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895FBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:16:22 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so1960124pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uBFwb3OZuSbdakxiF8fQLXxc6CSY++H2IglU3K84940=;
        b=cUPK/3Tlklm4xPZ+dbjFbfiufNZtJGI7/4GBGJFaO7b4lcTTNBl6EAz3++pp7swznl
         DPcrcAachdg8MgEZumvbGJe+uAJwv4pz/b0FuIZ4ZGrywRlE1dzedmFROhSDof/0tVkq
         i45SMKWQAWlbGd4UNlRHmE1OFVIajhMjeg+WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBFwb3OZuSbdakxiF8fQLXxc6CSY++H2IglU3K84940=;
        b=ICUrQrhyWUKTFA0/DUQxWN9tcAStCwOXA9B9y7OC4VTD6ib0zCmOLRj4+qsh9z2LaN
         P0nbrI3o0yXDhQo/t51XyfIlYnEu8bY55T6DH9mhIC5y1TnnnwGRx6rv5wvlfDFntiv6
         KbnMS9OJPAefRJaYRb4Pbbfq7yhzfRgVQ59P6l4E/BvJ01hUD8oabLV6DFWSrqGSZB4D
         /8FjubRxg3734KNwhYnk4OTItS5T0djwZsWpHbR1tSnmAf4c9vpbdzZs/BVFqKG5H/S7
         CL1kfCnNdJpj/aYD1yiqmBFYHx4iTda48ZHIYt2CsAGu3kgYI4ATcruzgpi3z3IsLiuq
         omFw==
X-Gm-Message-State: AOAM532VH4Qr46gHJRnwqnYTDn8gHzp3AT2TEMkg/9veOy5j+ch5NSsc
        a213SEzvOQwARS5LY9f+TPyWtQ==
X-Google-Smtp-Source: ABdhPJwwm7NcOXGyjhujLEYKybOkGuLv2p1kTzj9T9BVRQ7zVuLCSkJRWP0VeFkw0YaKpQe7fHav+g==
X-Received: by 2002:a17:902:6b4a:b029:d8:d13d:14f with SMTP id g10-20020a1709026b4ab02900d8d13d014fmr4380272plt.24.1606853782137;
        Tue, 01 Dec 2020 12:16:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm423142pgv.23.2020.12.01.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:16:21 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:16:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Fix passing zero to 'PTR_ERR' warning
Message-ID: <202012011215.B9BF24A6D@keescook>
References: <20201031055931.42844-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031055931.42844-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 01:59:31PM +0800, YueHaibing wrote:
> Fix smatch warning:
> 
> fs/pstore/platform.c:320 allocate_buf_for_compression() warn: passing zero to 'PTR_ERR'
> 
> crypto_alloc_comp() never return NULL, use IS_ERR
> instead of IS_ERR_OR_NULL to fix this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Hmm, well, if I get back a NULL ctx, I still can't use it, so I prefer
to remain overly defensive in this code.

Thanks for looking in to it, though! If you see some more compelling
reason to do this, let me know.

-Kees

> ---
>  fs/pstore/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 36714df37d5d..b7a2a2a31dee 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -315,7 +315,7 @@ static void allocate_buf_for_compression(void)
>  	}
>  
>  	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
> -	if (IS_ERR_OR_NULL(ctx)) {
> +	if (IS_ERR(ctx)) {
>  		kfree(buf);
>  		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
>  		       PTR_ERR(ctx));
> -- 
> 2.17.1
> 

-- 
Kees Cook
