Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABED2CC69D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbgLBT0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLBT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:26:35 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:25:49 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o4so1721736pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ihXn3eXulGTXz8oOPMrKv9li6WLwdD/NiffDRntD8oA=;
        b=jrqcN+DMdh6JlKBJ39HHn9HnOOrFK7MZy8yfjOq2DBliM2RKzv7NdG2zGnx9ZIMbCH
         PT5x6hlNBHkVQ1w9WKf06qjoqsEVUMV0SyszraqOBikGl5x1WLQlK+zoGmiMtxlCX1EB
         UyGgCEY29gImempSgNAknKxNua+MhFlIpab2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ihXn3eXulGTXz8oOPMrKv9li6WLwdD/NiffDRntD8oA=;
        b=XwUJGWYkQ+I8QeUaE8bXFpKuuN898ONG2ieZ6W8ow0jC7CpEjNzUPvhRZRQ1mRFWW8
         fDI5wrgoz+oBCtPZQODdzSptVRvSfzbnA7JheknynjDi7hemrvEpwZw+FN9jM34VS1/R
         xrGA7n5QzRpQbI5dxX3/gWrJXrySNdytEqyC9YEx6R5Swx1h7+ZM0K+u6Y89ps5aaxsf
         wVed8zHAncKwIG6H3oSKgVU5atFzqWyKgcI+5+TXBL5IchBWuuo5/dFRgkz+B9jI8oKQ
         VgeDlu7rfx8xE81/EIB8MSG2PMEbiMLvvNwRpNk7egkHqsJI3Brw7LskhD1Ok4/wyKxU
         RO8A==
X-Gm-Message-State: AOAM532FiPzu+ofbwzFFBehadbm6FOzoS1/e1+rP6TyCHEtxDv6KYkSW
        iJb66KOoThqDVyHqrDmCmRHxZpnmtok2dqOo
X-Google-Smtp-Source: ABdhPJw/l8VVJcMN/WEipg8NC0NIi+wftvB/ocrtVPoYemUX3GTbPwv/bTzffroBG8aqyArc5qxV6A==
X-Received: by 2002:a65:44c2:: with SMTP id g2mr1258558pgs.256.1606937148288;
        Wed, 02 Dec 2020 11:25:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v17sm458655pga.58.2020.12.02.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:25:47 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:25:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pstore: Tidy up an error check
Message-ID: <202012021124.ADBFCE999@keescook>
References: <X8c4C2q6qaZ8qX6L@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8c4C2q6qaZ8qX6L@mwanda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:45:31AM +0300, Dan Carpenter wrote:
> The crypto_alloc_comp() function never returns NULL, it returns error
> pointers on error.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I replied to an identical patch yesterday, actually:
https://lore.kernel.org/lkml/202012011215.B9BF24A6D@keescook/

Using IS_ERR_OR_NULL() is more robust, and this isn't fast path, so I'd
prefer to keep it that way.

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
> 2.29.2
> 

-- 
Kees Cook
