Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8129C89F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829663AbgJ0TTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:19:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829603AbgJ0TST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:18:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id y12so3168039wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcIHLAfMrGIWb94gFQbYez2rtiLYhxYGzbhepgOEqhg=;
        b=jZmcXQX1A2S40vjJo/nTH0aljwKjJuAPXb+B36lbyLEdT9egc+lxtWdJnMB+OCR1q/
         z8JXGeDZMMgDs7eEoLuZcbtLb4W4PRiKB7xEFyfMBTPNVjvHVRgf0wKWDBhLE7BeF3Ee
         HdUsFRjxEA01mA8iefIMZVO+toudXuG7t7vSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UcIHLAfMrGIWb94gFQbYez2rtiLYhxYGzbhepgOEqhg=;
        b=rLkZDmwVvam+6GzzCq9ZFU9lMzFUdexkPtCbKKQZwE8laNW90GerGTmPupvupn5j58
         B6NlK7aH9gO6tfibgyliWvRPmLizc2OfcY0xm3MSiTJXL7xv5ld3zOT+eWn5RArGER9y
         EbuRk+joXPq5fFunAkTpsm67ms/rTPS2jsfwuiQLr/4Jwx4bzCtnijHQQ0o4c4ngQdPO
         IyPSta7rLxsCxL1x5KkyS4+E9NohKHTfJ656lP6XentEVoHt60lepxIoyubdjA6E62rZ
         GlUTMhA/8Bny/e9NG6ndkgH+N8mY1FP79StFP7wo4UkrxZ1cvqmKAGeKWWWhDha6DicO
         WObA==
X-Gm-Message-State: AOAM530TgJWSVyBe48z1NMRHp8WOvlBSCGKUqF0A6Sv8+FH3KUN2pH2j
        +lYBJl2muZM4hG4te7WnJnz4Tg==
X-Google-Smtp-Source: ABdhPJwcdYcb/+YbSAqoFdbmEhcuESXU1vQTf/whNx4Mk55hbq+3g75bW6OZn0DeRMXMMRK+am3X9g==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr4781710wrm.419.1603826296987;
        Tue, 27 Oct 2020 12:18:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b7sm3280521wrp.16.2020.10.27.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:18:16 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:18:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] parisc/sticore: Avoid hard-coding built-in font
 charcount
Message-ID: <20201027191814.GP401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
 <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
 <c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:41:02PM -0400, Peilin Ye wrote:
> sti_select_fbfont() and sti_cook_fonts() are hard-coding the number of
> characters of our built-in fonts as 256. Recently, we included that
> information in our kernel font descriptor `struct font_desc`, so use
> `fbfont->charcount` instead of hard-coded values.
> 
> This patch depends on patch "Fonts: Add charcount field to font_desc".
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
> $ # Build-tested (Ubuntu 20.04)
> $ sudo apt-get install binutils-hppa64-linux-gnu gcc-7-hppa64-linux-gnu
> $ cp arch/parisc/configs/generic-64bit_defconfig .config
> $ make -j`nproc` ARCH=parisc CROSS_COMPILE=hppa64-linux-gnu- all
> 
>  drivers/video/console/sticore.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
> index d1bb5915082b..f869b723494f 100644
> --- a/drivers/video/console/sticore.c
> +++ b/drivers/video/console/sticore.c
> @@ -506,7 +506,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
>  			fbfont->width, fbfont->height, fbfont->name);
>  			
>  	bpc = ((fbfont->width+7)/8) * fbfont->height; 
> -	size = bpc * 256;
> +	size = bpc * fbfont->charcount;
>  	size += sizeof(struct sti_rom_font);
>  
>  	nf = kzalloc(size, STI_LOWMEM);
> @@ -514,7 +514,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
>  		return NULL;
>  
>  	nf->first_char = 0;
> -	nf->last_char = 255;
> +	nf->last_char = fbfont->charcount - 1;
>  	nf->width = fbfont->width;
>  	nf->height = fbfont->height;
>  	nf->font_type = STI_FONT_HPROMAN8;
> @@ -525,7 +525,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
>  
>  	dest = nf;
>  	dest += sizeof(struct sti_rom_font);
> -	memcpy(dest, fbfont->data, bpc*256);
> +	memcpy(dest, fbfont->data, bpc * fbfont->charcount);
>  
>  	cooked_font = kzalloc(sizeof(*cooked_font), GFP_KERNEL);
>  	if (!cooked_font) {
> @@ -660,7 +660,7 @@ static int sti_cook_fonts(struct sti_cooked_rom *cooked_rom,
>  void sti_font_convert_bytemode(struct sti_struct *sti, struct sti_cooked_font *f)
>  {
>  	unsigned char *n, *p, *q;
> -	int size = f->raw->bytes_per_char * 256 + sizeof(struct sti_rom_font);
> +	int size = f->raw->bytes_per_char * (f->raw->last_char + 1) + sizeof(struct sti_rom_font);
>  	struct sti_rom_font *old_font;
>  
>  	if (sti->wordmode)
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
