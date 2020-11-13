Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741F12B2660
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgKMVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:16:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899D9C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:16:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so11050807wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q6kjYbgKJcp03AAAsASkHgYE4dtYS5rkSqZBjH66POE=;
        b=Hs2/WAl/6nZID7yAvDh2H4mY+z2Lmu3VAdpuIoceIWU5YRZM95mUCkWugom5d2eZ8+
         fWCgab7nhig+gnERUVjIseX8uZ4AfFZp2Fl2gdUR+N6kRTOBrUPZd1fWJuoFAC88c0Ry
         wEVgLwijyjFrPMUP/lQCi7HFT/V1KaOVX0Ai4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Q6kjYbgKJcp03AAAsASkHgYE4dtYS5rkSqZBjH66POE=;
        b=r7abLZa+GDIKq2/j1BoRVnmKUjUEj0uuVMoMero9NaBJVmuNpp1QsT3k0vVW2PUgeq
         R21JbTOtsf32BYXPHpmIeuEw3jxJmmIluqCOvQ2JVImVgnWrMDPNj6Wjc4puDrtMgy26
         5zIpmla4iUwrxjzTTCcLCG5+DgV8xtGjDRNk++AGpNxItvJ2ZTnT5VWcnxYkbGeR4pub
         noeh59IAdsuDQb17J9btGCTcAekjwNasf8E6wJjDSatsR5EZ7CEd/iKReuUYXhPchkkW
         pW9jd3ozliJvgqdtjIDRtxXDnsfm/O77vlKecsVBnarykLEuxF6w44Y7FWbQhQuFJBU2
         kgYA==
X-Gm-Message-State: AOAM531+AFuIG7XFy/xITS2I3gHIvblpZjHZSlhXeN2Yl7mxVF7NzQ6s
        MitgNzV1O25vd4xjwR2e2INHow==
X-Google-Smtp-Source: ABdhPJx+SYVMOuL6LoOwhFnjptjOKNpAGoEAEWAxuJYZeg/O2xYMiWs31OtHTx1woOxKZxaZ5KRq/A==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr4603342wmf.137.1605302196203;
        Fri, 13 Nov 2020 13:16:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l3sm12960816wmf.0.2020.11.13.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 13:16:35 -0800 (PST)
Date:   Fri, 13 Nov 2020 22:16:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <20201113211633.GY401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605169912.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 07:02:21AM -0500, Peilin Ye wrote:
> Hi all,
> 
> This is a collection of some miscellaneous clean-ups for fbcon and some
> console drivers. Since v2, I rebased them on linux-next, added some
> Reviewed-by: tags from Daniel and Greg, and rewrote the commit messages as
> suggested by Jiri. See [1] for v2 links.
> 
> It does the following:
> 
>   - Garbage collect KD_FONT_OP_COPY callbacks since we disabled it
>     recently. Mark it as obsolete.
>   - Delete dummy con_font_op() callbacks. (Reviewed by Greg)
> 
>   - Add a charcount field to our new font descriptor, `struct font_desc`.
>     (Reviewed by Daniel)
>   - Do not use a hard-coded 256 for built-in font charcount in
>     console/sticore.c, use the new charcount field of `struct font_desc`
>     instead. (Reviewed by Daniel)
>   - Similarly, in fbcon.c, avoid using the magic negative-indexing macro,
>     FNTCHARCNT(). Set `vc->vc_font.charcount` properly and always use that
>     instead.
> 
> Daniel, hopefully [5/5] removes FNTCHARCNT() for ever, but I have not
> tested it sufficiently yet. I remember you mentioned elsewhere that
> "fbtest.c" is insufficient for framebuffer testing, then how should we
> test it? The first 4 patches should be fine.
> 
> Please reference commit messages for more information. Thank you!
> 
> [1] v2 links:
> 
> 2/5: https://lore.kernel.org/lkml/c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com/
> 3/5: https://lore.kernel.org/lkml/20201028060533.1206307-1-yepeilin.cs@gmail.com/
> 4/5: https://lore.kernel.org/lkml/c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com/
> 5/5: https://lore.kernel.org/lkml/20201028155139.1220549-1-yepeilin.cs@gmail.com/
> 
> Peilin Ye (5):
>   console: Delete unused con_font_copy() callback implementations
>   console: Delete dummy con_font_set() and con_font_default() callback implementations
>   Fonts: Add charcount field to font_desc
>   parisc/sticore: Avoid hard-coding built-in font charcount
>   fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount

Patches all look good to me, if Greg is ok with me applying the entire
pile to drm-misc-next I'll do that next week.

Thanks, Daniel

> 
>  drivers/usb/misc/sisusbvga/sisusb_con.c | 21 --------
>  drivers/video/console/dummycon.c        | 20 --------
>  drivers/video/console/sticore.c         |  8 +--
>  drivers/video/fbdev/core/fbcon.c        | 68 ++++++++-----------------
>  drivers/video/fbdev/core/fbcon_rotate.c |  3 +-
>  drivers/video/fbdev/core/tileblit.c     |  4 +-
>  include/linux/console.h                 |  1 -
>  include/linux/font.h                    |  1 +
>  include/uapi/linux/kd.h                 |  2 +-
>  lib/fonts/font_10x18.c                  |  1 +
>  lib/fonts/font_6x10.c                   |  1 +
>  lib/fonts/font_6x11.c                   |  1 +
>  lib/fonts/font_6x8.c                    |  1 +
>  lib/fonts/font_7x14.c                   |  1 +
>  lib/fonts/font_8x16.c                   |  1 +
>  lib/fonts/font_8x8.c                    |  1 +
>  lib/fonts/font_acorn_8x8.c              |  1 +
>  lib/fonts/font_mini_4x6.c               |  1 +
>  lib/fonts/font_pearl_8x8.c              |  1 +
>  lib/fonts/font_sun12x22.c               |  1 +
>  lib/fonts/font_sun8x16.c                |  1 +
>  lib/fonts/font_ter16x32.c               |  1 +
>  22 files changed, 42 insertions(+), 99 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
