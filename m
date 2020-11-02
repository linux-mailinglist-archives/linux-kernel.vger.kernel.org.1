Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF322A2D84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKBPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:01:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A89C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:01:12 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so14973737wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiKxYzK+jbj0BuX+QRcJTUAvMklQZTPB1Oi95Mt8zqU=;
        b=VJfz9q4AgyrOyX3slQP+GydH6MLnuK7fuRp7qc+U7anvOtX32v9wPX4OhypDOQWRGa
         TN53cCg5TYwhCm3g/scOOC/F8eqICxcTEUcXKAXpIbkn7T6UO4e/DdW62rzHIJHUxFiS
         N4jCTkxnqGHWiTKuVnw0XCp2yGwKU3uZZQbzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WiKxYzK+jbj0BuX+QRcJTUAvMklQZTPB1Oi95Mt8zqU=;
        b=mJcIOcntoobwo5ew8N1LbpMRto8qKg05pwVFUf9OpeFBWfO+OTgEIPo15qKYCtdMtq
         uL1x9y5sd3KDSm6q26QIdPlK5USKW3k1ii0r69/n+ZquBEKtktV/LSSuV+bvm3sEAWcx
         Kt6uw/GrLKNxD+C/r8kspC/7aFAUBaFWI3VgZ7uTRRWjO/tQnkEFZxcfeTusHI1qUGW9
         4aNLb0VVw0sPn60JLxgBYcDR24JIE/TKbG8DBsbT0OD1dCzdN8NwfkrXW8TOp8UwbVvg
         MPmeZf9OjzIVg2Wb5N9fk0XrmbqGfvf+Ozx/eaE0cvCvVgmS3WehmJC4kQ+OGz/OXXMm
         1vuQ==
X-Gm-Message-State: AOAM5328j+6Tt+bZbjpQMJQD7bVNAxbWh0UwSZn32KNa0xFNvyggSbcS
        h9tHQGj3bjGVkruPaA5LiAbkRd0/Mnfii71C
X-Google-Smtp-Source: ABdhPJxbkH5RpRNzyZyYob/58tkcuhXAZIJ26Wq9kMXmqkZN8byLcKycFNmqrLorrMhHL4N7nkHUIg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr21310992wrl.415.1604329270887;
        Mon, 02 Nov 2020 07:01:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f4sm22491807wrq.54.2020.11.02.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:01:09 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:01:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Preparation work for using font_desc in vc_data
Message-ID: <20201102150107.GT401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603788511.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:27:35PM -0400, Peilin Ye wrote:
> Hi Daniel, Hi Greg, Hi all,
> 
> We are planning to use `font_desc` instead of `console_font` in `vc_data`,
> and this is just some prep work for it. It doesn't do much, but at least
> it removes two "FIXME"s in fbcon.c :)

Btw nitpeek on how you submit patches: The threading you're using here is
"deep" i.e. every patch is  reply to the previous patch. The usual thing
is flat, i.e. all patches are replies to the cover letter.

I think only very old versions of git had the former as a default, so not
sure what's going on. But the deep threading makes piecing the
conversation together quite a bit harder, at least here in mutt.
-Daniel


> 
> Peilin Ye (5):
> [1/5] fbdev/atafb: Remove unused extern variables
> 
>   Searching for `fontdata` gave me this in fbdev/atafb.c:
> 
>   extern unsigned char fontdata_8x8[];
>   extern unsigned char fontdata_8x16[];
> 
>   ...which freaked me out, since in 6735b4632def ("Fonts: Support
>   FONT_EXTRA_WORDS macros for built-in fonts") I changed them from char
>   arrays to structures, in lib/fonts/. Fortunately it turns out these
>   extern variables have nothing to do with lib/fonts/, and are not being
>   used anywhere, so remove them for less confusion.
> 
>   m68k cross-compiled.
> 
> [2/5] Fonts: Make font size unsigned in font_desc
> 
>   Our goal is to use `font_desc` "everywhere" in the kernel, and signed
>   `width` and `height` is inappropriate.
> 
>   Also, change some printk() format identifiers in console/sticore.c from
>   `%d` to `%u`. parisc cross-compiled.
> 
> [3/5] Fonts: Add charcount field to font_desc
> 
>   Add `unsigned int charcount` to `font_desc`, and update each of our 13
>   built-in fonts.
> 
> [4/5] fbcon: Avoid hard-coding built-in font charcount
> [5/5] parisc/sticore: Avoid hard-coding built-in font charcount
> 
>   Everyone (tty, fbcon, sticore, etc.) is assuming that all built-in fonts
>   have 256 characters, and is using hard-coded 256 or 255 everywhere.
>   These two patches removes some of them. [5/5] is parisc cross-compiled.
> 
>   Now is a good time to review all find_font() and get_default_font()
>   callers:
> 
>   drivers/media/pci/solo6x10/solo6x10-enc.c      133 const struct font_desc *vga = find_font("VGA8x16");
>   drivers/media/test-drivers/vimc/vimc-core.c    268 const struct font_desc *font = find_font("VGA8x16");
>   drivers/media/test-drivers/vivid/vivid-core.c 1928 const struct font_desc *font = find_font("VGA8x16");
>   drivers/usb/misc/sisusbvga/sisusb.c           2285 myfont = find_font("VGA8x16");
>     * These 4 only care about font VGA8x16, so let them be for now;
> 
>   drivers/video/console/sticore.c                499 fbfont = find_font(fbfont_name);
>   drivers/video/console/sticore.c                501 fbfont = get_default_font(1024,768, ~(u32)0, ~(u32)0);
>     * Uses 255 and 256, (hopefully) cleaned up by [5/5];
> 
>   drivers/video/fbdev/core/fbcon.c               999 if (!fontname[0] || !(font = find_font(fontname)))
>   drivers/video/fbdev/core/fbcon.c              1000 font = get_default_font(info->var.xres,
>   drivers/video/fbdev/core/fbcon.c              1078 if (!fontname[0] || !(font = find_font(fontname)))
>   drivers/video/fbdev/core/fbcon.c              1079 font = get_default_font(info->var.xres,
>     * Use 256, cleaned up by [4/5];
> 
>   drivers/video/fbdev/core/fbcon.c              2548 else if (!(f = find_font(name)))
>   drivers/video/fbdev/core/fbcon.c              2546 f = get_default_font(info->var.xres, info->var.yres,
>     * Uses 256 but no easy fix. I'll clean this up after making
>       fbcon_do_set_font() pass a `font_desc` as parameter;
> 
>   drivers/firmware/efi/earlycon.c               234 font = get_default_font(xres, yres, -1, -1);
>     * Does not care about charcount.
> 
> Thank you!
> Peilin Ye
> 
>  drivers/video/console/sticore.c  | 10 +++++-----
>  drivers/video/fbdev/atafb.c      |  8 --------
>  drivers/video/fbdev/core/fbcon.c |  5 ++---
>  include/linux/font.h             |  3 ++-
>  lib/fonts/font_10x18.c           |  1 +
>  lib/fonts/font_6x10.c            |  1 +
>  lib/fonts/font_6x11.c            |  1 +
>  lib/fonts/font_6x8.c             |  1 +
>  lib/fonts/font_7x14.c            |  1 +
>  lib/fonts/font_8x16.c            |  1 +
>  lib/fonts/font_8x8.c             |  1 +
>  lib/fonts/font_acorn_8x8.c       |  1 +
>  lib/fonts/font_mini_4x6.c        |  1 +
>  lib/fonts/font_pearl_8x8.c       |  1 +
>  lib/fonts/font_sun12x22.c        |  1 +
>  lib/fonts/font_sun8x16.c         |  1 +
>  lib/fonts/font_ter16x32.c        |  1 +
>  17 files changed, 22 insertions(+), 17 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
