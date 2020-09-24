Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9C2773DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIXOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgIXOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:25:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7DC0613CE;
        Thu, 24 Sep 2020 07:25:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so1749075plt.9;
        Thu, 24 Sep 2020 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BhjXs0X1T6fyEGbqATV3iAKCYDUTserBVGQfsds99Q8=;
        b=lZ2IHLOvUlSzofjJzppCZLACHPsTpIecrUUi9yAxP/p2GvombkArlU1xTZQhAGnnjK
         g2GebQ/478ooEg8r5LWavf20tfUHnei0vBc51EApwiUQoShSyH+V6dwxfT2qcl8s0iSS
         /qXQEn0URynfGfyTDlit78GesAM221oMd2R25Hi9nVYzscs9+9GmmaflqLcEp5ACCvT/
         q2mNkYlPDdTJPfqnwcNgEyRQxXy4CapItbbfWtij9i+M1fCht3TSleY5p+Zb5vH+e6cl
         tghZdra5yDIl1eJHDG5d1wXzyMT90qrJwYHZO22BNM6r+7AMsLHgWTizzxRn/54oshsA
         YJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhjXs0X1T6fyEGbqATV3iAKCYDUTserBVGQfsds99Q8=;
        b=JTHs9vyUBeqLPtWEJXbeHHE17JTfl18RDVDAj/goD8ifyxqpA+M2WcIiifp32Le+mT
         rgd1j0XH3aN8xNtWTq+9sT08rf919PZYGJY1dbKFRotClRjReUYwXp/X9yERIicpjk64
         thXX6d61CSr6j8PpA7UB/mkF0zESspsjQ1/WqYmfQZHMpC+Yzm+brhnRS9mNdX9sdsNn
         5QuJEeR3nt+Ovj3e3FJND7XIyGx/z6UllS29tKNHlNjlXYTCcqrUZuWbJRQoapj0bNTK
         g9Ts8FrLvwTmJXUbiNiSlBl/XA1a43AW1rc+JilDNmorGjHBduAbhQusK66Pb/mCuUqU
         +hlg==
X-Gm-Message-State: AOAM532ZwrcHSvYjcI8llCSfyWEICZ7r8ccyaQOHWM7ybHbRdAFEzzPM
        8Xe0Vj68xz3AkmLIR+CA0w==
X-Google-Smtp-Source: ABdhPJylzhyMM4ZubAhCo7dYA3YL2otZrpcXevMiKCn9wIriHYocj00wslJC0GNCVDoN5qMmkBz98A==
X-Received: by 2002:a17:90b:796:: with SMTP id l22mr4254744pjz.199.1600957534641;
        Thu, 24 Sep 2020 07:25:34 -0700 (PDT)
Received: from PWN (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id gb17sm2667794pjb.15.2020.09.24.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:25:33 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:25:25 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200924142525.GA879276@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924140937.GA749208@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 04:09:37PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2020 at 09:38:22AM -0400, Peilin Ye wrote:
> > Peilin Ye (3):
> >   fbdev, newport_con: Move FONT_EXTRA_WORDS macros into linux/font.h
> >   Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts
> >   fbcon: Fix global-out-of-bounds read in fbcon_get_font()
> > 
> >  drivers/video/console/newport_con.c     |  7 +------
> >  drivers/video/fbdev/core/fbcon.c        | 12 ++++++++++++
> >  drivers/video/fbdev/core/fbcon.h        |  7 -------
> >  drivers/video/fbdev/core/fbcon_rotate.c |  1 +
> >  drivers/video/fbdev/core/tileblit.c     |  1 +
> >  include/linux/font.h                    | 13 +++++++++++++
> >  lib/fonts/font_10x18.c                  |  9 ++++-----
> >  lib/fonts/font_6x10.c                   |  9 +++++----
> >  lib/fonts/font_6x11.c                   |  9 ++++-----
> >  lib/fonts/font_7x14.c                   |  9 ++++-----
> >  lib/fonts/font_8x16.c                   |  9 ++++-----
> >  lib/fonts/font_8x8.c                    |  9 ++++-----
> >  lib/fonts/font_acorn_8x8.c              |  9 ++++++---
> >  lib/fonts/font_mini_4x6.c               |  8 ++++----
> >  lib/fonts/font_pearl_8x8.c              |  9 ++++-----
> >  lib/fonts/font_sun12x22.c               |  9 ++++-----
> >  lib/fonts/font_sun8x16.c                |  7 ++++---
> >  lib/fonts/font_ter16x32.c               |  9 ++++-----
> >  18 files changed, 79 insertions(+), 67 deletions(-)
> 
> Gotta love going backwards in arrays :)
> 
> Nice work, whole series is:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for reviewing it!

Peilin Ye

