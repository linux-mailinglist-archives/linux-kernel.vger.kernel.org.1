Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2929C8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829512AbgJ0TOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:14:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50750 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829503AbgJ0TN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:13:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 13so2431431wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3J/+0GiuC41DT0MOvT+FF9RAHnRvTVHa938Xwr2s1o=;
        b=iAotOM6WKIuDQ6FgXb5rOAYby/U4SAR7GX1dfobxCt0NUEUYvR3JU5IbXXXzzEzb+x
         NVw1W6NV+zW7ZjBUjaeVYKNjF3on3pNs1Hgp6GQgb8ezNmvtVbTVJ9+wG1SxiBt1nZ0N
         E1jWM77BDsGkX6UGDdQshv1RZmgj9/9Fqg5Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=P3J/+0GiuC41DT0MOvT+FF9RAHnRvTVHa938Xwr2s1o=;
        b=ZNe4rvsor4ShO6HWf+jZ7vnkrd+VNOK/5M0GE06vTtprdgFBy3v+JTz3YlK0BPY7MP
         PC+Sb6cvmyqN2cc9Zy+Ab2KDHLuKkAOdWkneblErAChbse6SX3OCjWPZgMO8OOkRZhpw
         EqSIskfCHRvifuq7MRl6rn3mQshuYerT4I3Ne6SGQoW/gZWpczuwUipDuIu7cWggw8WW
         ckqZd4B2jfjzmtjdu46qthQF3WpUA0f1wAeOgnVpNbwDuKTS8Fatfyybxk0H+pdJeayQ
         g0I9IlPXWPdCfqnjh8yTP/Oqo/7S7djCXJpT+AyFSL/WqMY1nGUH23xh+fCY58QVCxGW
         AEew==
X-Gm-Message-State: AOAM532BnDGrz2YXTaz4JmdMmF40CyosngQmLL9JQBoOMYFR9DKZoL3d
        vVSFKBWzkUjNcdMf/cCJeVEYbA==
X-Google-Smtp-Source: ABdhPJxjvWUPnbB7pc9K8JYx7BBlTro1Je2YY0UCsz4EPGzzcVzaADg0zmoo0CDvgaDra903bJTkUw==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr4233791wmc.142.1603826035820;
        Tue, 27 Oct 2020 12:13:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m1sm3070487wmm.34.2020.10.27.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:13:55 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:13:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] fbcon: Avoid hard-coding built-in font charcount
Message-ID: <20201027191353.GO401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
 <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:37:29PM -0400, Peilin Ye wrote:
> fbcon_startup() and fbcon_init() are hard-coding the number of characters
> of our built-in fonts as 256. Recently, we included that information in
> our kernel font descriptor `struct font_desc`, so use `font->charcount`
> instead of a hard-coded value.
> 
> This patch depends on patch "Fonts: Add charcount field to font_desc".
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

So I think this is correct, but it also doesn't do a hole lot yet. fbcon.c
still has tons of hard-coded 256 all over, and if (p->userfont).

I think if we instead set vc->vc_font.charcount both in fbcon_init and in
fbcon_do_set_font (probably just replace the userfont parameter with
font_charcount for now), then we could replace these all with
vc->vc_font.charcount. And the code would already improve quite a bit I
think.

With just this change here I think we have even more inconsistency, since
for built-in fonts vc->vc_font.charcount is now set correctly, but for
userfonts we need to instead look at FNTCHARCNT(vc->vc_font.data).

We'd still need to maintain p->userfont because of the refcount chaos, but
that is much more work.

Or do I miss something here?
-Daniel

> ---
>  drivers/video/fbdev/core/fbcon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index cef437817b0d..e563847991b7 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1004,7 +1004,7 @@ static const char *fbcon_startup(void)
>  		vc->vc_font.width = font->width;
>  		vc->vc_font.height = font->height;
>  		vc->vc_font.data = (void *)(p->fontdata = font->data);
> -		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
> +		vc->vc_font.charcount = font->charcount;
>  	} else {
>  		p->fontdata = vc->vc_font.data;
>  	}
> @@ -1083,8 +1083,7 @@ static void fbcon_init(struct vc_data *vc, int init)
>  			vc->vc_font.width = font->width;
>  			vc->vc_font.height = font->height;
>  			vc->vc_font.data = (void *)(p->fontdata = font->data);
> -			vc->vc_font.charcount = 256; /* FIXME  Need to
> -							support more fonts */
> +			vc->vc_font.charcount = font->charcount;
>  		}
>  	}
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
