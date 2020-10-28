Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1429DFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgJ2BE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgJ1WGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:06:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:06:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id p15so891107ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMCdu9Rzb/ndcD48Tcjh9B2LFonFTQlfv9eH4WIE5/E=;
        b=F0MCnNXxvfO8m+8X6ysd9pz9RNST9ee2OunsJBFhJ1jACU0VNPR7jRqTcr42Em1B/N
         4RkfEXr/avMA+O9xcQ2WiJud6Px7h8GMje+np40dqlpRDSKXgimNhQtHUuAPltPhyb11
         5fbAF7gudEUJdH7kFcywq06bqCQv1F5USJd8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nMCdu9Rzb/ndcD48Tcjh9B2LFonFTQlfv9eH4WIE5/E=;
        b=lF+ND2orXBEy+QQVblMsKHPqtyc4cH2yV+Joy0VlaUnnSlV3zfDSBfVuMpApyJpjnb
         HlgkKa9r0JHr9tgGnaJ4M7w0nB2kdnOnvSbHkELypMoOZHaubnE4PJ/DoRQDgGoQflO1
         ETFErC2uoq8vUjC2Q/J9WfVhBb+wxURXQ4o88jA9QXbtfWGvwRgIAzlFdS6g4yplcJwi
         GxsCJ9mWNBFmRyE3kV3roUi4m4fE6jOhTHZkZpgdbhEUWyH0dczFrDKRtjqNz8EG77yb
         85S14YhEKG0CZo3pulbiNJFW33+pkdldsStindiPzPeiNo9YfPY2D1H+Kpk3/Ff99Ulu
         7mOg==
X-Gm-Message-State: AOAM533stDBjL24zJMQeQrlK5m9X0rCDrUmCaofmKomIDCIAjBZr/UI5
        42sA3EdhC08pylHvPKlW1VoGqti0jg/6NE01
X-Google-Smtp-Source: ABdhPJyrBDGD6E9I6oqu06SgLOB/cJ7qVsKtWh9rtNK4o2kg9zioPQMWZFyxGdfWYjPLun8Im926hQ==
X-Received: by 2002:adf:e685:: with SMTP id r5mr841525wrm.340.1603910429440;
        Wed, 28 Oct 2020 11:40:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f7sm597277wrx.64.2020.10.28.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:40:28 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:40:26 +0100
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
Subject: Re: [PATCH v2 2/5] Fonts: Make font size unsigned in font_desc
Message-ID: <20201028184026.GX401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <20201028105647.1210161-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028105647.1210161-1-yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 06:56:47AM -0400, Peilin Ye wrote:
> `width` and `height` are defined as unsigned in our UAPI font descriptor
> `struct console_font`. Make them unsigned in our kernel font descriptor
> `struct font_desc`, too.
> 
> Also, change the corresponding printk() format identifiers from `%d` to
> `%u`, in sti_select_fbfont().
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Pushed to drm-misc-next, thanks for the patch.
-Daniel

> ---
> Change in v2:
>   - Mention `struct console_font` in the commit message. (Suggested by
>     Daniel Vetter <daniel@ffwll.ch>)
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
