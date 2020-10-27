Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4702C29C7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829181AbgJ0SvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:51:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442713AbgJ0SvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:51:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id n6so3051940wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZvOPp8kVilTXiarx7tF8Az0EBe1RW6Y/QV8MotyV8s=;
        b=E+QQVJ6LfsGiPw+sjgvs9YvBaCMf1GKIz7ybqinbvbTMr1KW7mqY4QeBxNzuBdpThA
         5nblxw4cSCvxn53HUmGzrWW56wSRcZpEwRo8h3Il6vyoNnQIHYZG/9MPA2jqo8IOuzOL
         8MTCtvJdUGydgE1zIBJMJEYdbTnFiHIdKO51I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xZvOPp8kVilTXiarx7tF8Az0EBe1RW6Y/QV8MotyV8s=;
        b=uLFUVP4qj4xMSn9FrOD+S7VGc19e58dRXTqFlSpPK5ZaxCkMy4ZZaT/iRwHIChIF7Y
         bFKFNxDT8TBBuoUYmi8wgB+A3MR046DeFU+VNq1vvHkhGmYpwx76iJn2KdA1QsLuHELM
         h9M9CV5nlPw+rf8au5kdMT5D8qYCZckdz3Tky+4BrI2jFkySP14E1JDAbSA/qum0gh0p
         p7SJlJOtJJztTT6jlqjmPKSzFO04tt7iQsrQRJEqFZ9GE+KBiIZswBnTyKjRsGS6V/fF
         +fcxmCaBfc3B0uLkYTrbUE3DNdgAj4kIIWWkaW66xhrS0xVZOeLNeNeiM9CsSeC1zIkv
         V3Wg==
X-Gm-Message-State: AOAM533EUNFNlO0H8/W/FIu6IGn0YFTbeBaVQ30W2vryKCjzefx9SKU3
        m0n/mKPd7kpv6ny/3idfl5NqXA==
X-Google-Smtp-Source: ABdhPJynFNg4Z7kz02rR4kjthPaTiI0vcEd436zZEQWyrQ9iXhwvzQ88EYNHIKOIDvTpL9kSzGn5Jg==
X-Received: by 2002:adf:e446:: with SMTP id t6mr4255615wrm.46.1603824661583;
        Tue, 27 Oct 2020 11:51:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 24sm2884131wmg.8.2020.10.27.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:51:00 -0700 (PDT)
Date:   Tue, 27 Oct 2020 19:50:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Fonts: Make font size unsigned in font_desc
Message-ID: <20201027185058.GM401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:33:05PM -0400, Peilin Ye wrote:
> It is improper to define `width` and `height` as signed in `struct
> font_desc`. Make them unsigned. Also, change the corresponding printk()
> format identifiers from `%d` to `%u`, in sti_select_fbfont().
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

I'm not entirely sure of the motivation here ... height/width should never
ever be even close to the limit here. Or have you seen integer math that
could potentially go wrong if we go with unsigned instead of int?
-Daniel

> ---
> Build-tested.
> 
>  drivers/video/console/sticore.c | 2 +-
>  include/linux/font.h            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
> index 6a26a364f9bd..d1bb5915082b 100644
> --- a/drivers/video/console/sticore.c
> +++ b/drivers/video/console/sticore.c
> @@ -502,7 +502,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
>  	if (!fbfont)
>  		return NULL;
>  
> -	pr_info("STI selected %dx%d framebuffer font %s for sticon\n",
> +	pr_info("STI selected %ux%u framebuffer font %s for sticon\n",
>  			fbfont->width, fbfont->height, fbfont->name);
>  			
>  	bpc = ((fbfont->width+7)/8) * fbfont->height; 
> diff --git a/include/linux/font.h b/include/linux/font.h
> index b5b312c19e46..4f50d736ea72 100644
> --- a/include/linux/font.h
> +++ b/include/linux/font.h
> @@ -16,7 +16,7 @@
>  struct font_desc {
>      int idx;
>      const char *name;
> -    int width, height;
> +    unsigned int width, height;
>      const void *data;
>      int pref;
>  };
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
