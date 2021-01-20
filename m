Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC872FD782
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbhATRuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbhATRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:48:44 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:48:01 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g15so15665800pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i4lYsnGE+v+tE5l45H+oTDC1o93O3IhagWLh4ZAp+8k=;
        b=V3o/tdTNiMjFvWcboAIMY1AHu9r0V4CGofgz7tX8a9WGa4qbOEaI4Q8K1HUetKujRG
         KU1fHJcAhGO+ZN1MjiRBqqbSykkX24xz6nVUXtIH1JlSPgfvMjq4vlk+GFogTJSIorGs
         bGqK6MIYM2tCbG/9s8mwTDTAeBgz6GbBdnUpd+GX2Dx7+9LYWMKz+4Fxs2jGHlu5bt0L
         WM0xRxzo7cjDx+3UcPseYjhY7yOknrxIkxK+4XugY/TATP7G8r/MSzyE4pzlVco9xIpN
         OFm6isesgtVpZzOnEG8+l6pru5bQhQRp/2CudGh7GAD1tWEGf8qEMkRu1DWD+bz0+WA0
         ay0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i4lYsnGE+v+tE5l45H+oTDC1o93O3IhagWLh4ZAp+8k=;
        b=i88FKYpqJq8uNIPiw+BLmVRVtz7KxC0zWuNlCe2MTUiFLOPtaNs7rVqP6beeLLHCUy
         Jhirgo4L548IOKsIqlP6iGWZcp6Qdfb55BDo8mDQ7f8eynS5enSTZvVn1wqVSqhz3c0q
         QwBLHjGEqIGYKYzGhIY3fISmEyMmCqMEL6ALrMLbIHCyQsLBGbQh4J0kHvH1Dni+EYJP
         VtgjmzctnnMKUK2/Bc/i2P5jhs10PV2WWb1au5sDbm9gK3JXQExV8IqDACmUgXkI3qwn
         tOOFPx45BJ9dXmOvTZdyIizkZx105TX8AjEJlMjrh80Rk0dD3UVzjVj6hYVGs/WcNBXU
         oEoQ==
X-Gm-Message-State: AOAM533l1eLaeC4STwpTQRyHFkqeCjW9S759iFdNAjEzTP5wkUPA1NRu
        HU9ynVtpcBtWtIZZXMEc9evclw==
X-Google-Smtp-Source: ABdhPJzYvFB+UWVM60ozUVDH7qdLtkysL9uR8eekFzRdpp9pddf5Tv9QrPUVhwMb06WYmrF5AB0oEA==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr10489522pgp.68.1611164881166;
        Wed, 20 Jan 2021 09:48:01 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id s23sm2919642pgj.29.2021.01.20.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:48:00 -0800 (PST)
Date:   Wed, 20 Jan 2021 09:47:53 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v2] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
Message-ID: <YAhsyXahEYjV7DZ8@google.com>
References: <20210120035328.19868-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120035328.19868-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021, Tianjia Zhang wrote:
> In this scenario, there is no case where va_page is NULL, and
> the error has been checked. The if condition statement here is
> redundant, so remove the condition detection.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 1c6ecf9fbeff..efad2fb61c76 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -66,9 +66,12 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	va_page = sgx_encl_grow(encl);
>  	if (IS_ERR(va_page))
>  		return PTR_ERR(va_page);
> -	else if (va_page)
> -		list_add(&va_page->list, &encl->va_pages);
> -	/* else the tail page of the VA page list had free slots. */
> +
> +	if (WARN_ONCE(!va_page,
> +		      "the tail page of the VA page list had free slots\n"))

IMO it's worth trimming down the message to keep this on a single line.  The
newline isn't necessary, and this code expects a completely empty list, e.g. it
can be reworded to something like:

	if (WARN_ONCE(!va_page, "non-empty VA page list before ECREATE"))

> +		return -EIO;
> +
> +	list_add(&va_page->list, &encl->va_pages);
>  
>  	/* The extra page goes to SECS. */
>  	encl_size = secs->size + PAGE_SIZE;
> -- 
> 2.19.1.3.ge56e4f7
> 
