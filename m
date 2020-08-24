Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BCC25018C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgHXP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:57:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4966C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:57:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so9248587wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrxa6Z8ALzEuFxZJIIcbsGCrFOHRb7EFnZzL1WDCR2k=;
        b=opPN4+DPMKzVCy6OMKWUjwd6nxWILScUWHODyf/FxxKIHaZHJmgu9gNAHiHDefZjVK
         a8QIC+WR6msx3K1bFtaJ9c+2kfl0e3WRYxycw0GcoWkrX+tRn/64NXbb5fHLEeV5Jcyp
         mMvNJxH+7hbx0ZMZb7bmEVZHAzxQlsD6kPPuXJZ+4l0d8tYmn+mjFic2s6eBe/Em1epw
         uokDIPMODQqlMRPYwdvZU+mLLhbMKz5i4Pf70EX9ACqDrAfB2aNU9Ci4sooxdWCFhATK
         QCgAaM/CzfiRU+6NgElaEhz8NPJxlWLip5Yxv/fsI0zH83QFisqnm6TUaXL/xQbNS0nP
         33Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrxa6Z8ALzEuFxZJIIcbsGCrFOHRb7EFnZzL1WDCR2k=;
        b=C3woP3IiK7D9VzV9vWDbyaj7YkQ3/Xblmw166ewUYhGReMEfeRNlz6iBS6XfCM8aOK
         2zsCXmsG6qvI+ru3dsF5iJppR4EMeFyFEVvAtGMN73EFQzX/IopcazZqw7bROHveXSRf
         3pGxhq6Y7uTskdOgk3wVXNGjwIkCfBc0XNmOB5632IrkKjFCpZ7wRl06MB6Zh5G0nLYB
         TUBOhzkpl2HTiWw0XFBiBxTvukDatLwDgqHbznBn3HqClUFOHECubtBZdFQ/w0jRDc7P
         rr5PmDanzpvg9TmTFKxO7xfLUDqLRleDLcKiSiQZLC6oDZXjf8vdblCBUZQBA3CwVLei
         ul1Q==
X-Gm-Message-State: AOAM5330KBzi705YkxlqNuIGGGs0+TtTUKcVRaw4gnxMaFSKvKy7H2OQ
        b95TaTYQerONWy5U8n+xsqQ=
X-Google-Smtp-Source: ABdhPJwBrCRzx4/MFP1jzZ8EfYaPyIE/Mi2xyX4LCfw4lUCCf7RghVEjdLaUblX7BAX7khcctHPONw==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr6001122wrx.33.1598284635511;
        Mon, 24 Aug 2020 08:57:15 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id e2sm16408164wrt.66.2020.08.24.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:57:14 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Mon, 24 Aug 2020 16:57:12 +0100
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     dan.carpenter@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Javier F. Arias" <jarias.linux@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Magnus Damm <damm+renesas@opensource.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Fix passing of NULL to
 dma_alloc_coherent()
Message-ID: <20200824155712.4kgxwqiufm2ieboz@medion>
References: <20200824142118.GA223827@mwanda>
 <20200824151920.251446-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824151920.251446-1-alex.dewar90@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 04:19:17PM +0100, Alex Dewar wrote:
> In nbu2ss_eq_queue() memory is allocated with dma_alloc_coherent(),
> though, strangely, NULL is passed as the struct device* argument. Pass
> the UDC's device instead.
> 
> Build-tested on x86 only.
> 
> Fixes: 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile USB Gadget driver")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
> 
> So I *think* this is the right fix, but I don't have the hardware so
> I've only been able to build-test it. My worry is that I could be
> passing in the wrong struct device* here, which would squelch the
> warning without fixing the breakage.
> 
> Can someone cleverer than me tell me if this makes sense?
> 
> - Alex

PS -- I meant to put an RFC in the subject line and an extra tag:
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 03929b9d3a8b..09e91449c08c 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -2593,7 +2593,7 @@ static int nbu2ss_ep_queue(struct usb_ep *_ep,
>  
>  	if (req->unaligned) {
>  		if (!ep->virt_buf)
> -			ep->virt_buf = dma_alloc_coherent(NULL, PAGE_SIZE,
> +			ep->virt_buf = dma_alloc_coherent(udc->dev, PAGE_SIZE,
>  							  &ep->phys_buf,
>  							  GFP_ATOMIC | GFP_DMA);
>  		if (ep->epnum > 0)  {
> -- 
> 2.28.0
> 
