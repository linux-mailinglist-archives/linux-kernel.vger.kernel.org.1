Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243429C7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829027AbgJ0SqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:46:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35026 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899684AbgJ0Sos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:44:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id h22so2501041wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yq3mNzKnnS784nsQFC2uDIJSO3VSvUZkuyXz2yHmGdg=;
        b=IACCIP29UjFLYDYxCaky7/HBTtI2UNwwbCcpjcks7uKU4tAvtd5mGAnvGHmjidVDwH
         zP9iwtcti5gtYzQkactAV1pPQ4L2E0iotqMM1GS/1KXB6pzebnPe1RL7UfhRVRcHl7GD
         X8AcNVcDBhj3fsVeK3Wxl5L2lGS2fr21qPFWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yq3mNzKnnS784nsQFC2uDIJSO3VSvUZkuyXz2yHmGdg=;
        b=a4v2dwfEOD9Q7Tmo257aZqke1zIdWU1f5U+7DtNmw1ziHwzayiqoSUK3ctR/HA8WN1
         GWO2y5pNvdB4lsZUOPiRhE/2m2PPtfCfqC4L+v44+yycFxRpEUKvsXGiwtUf5Pyo0cJu
         ToszCITFSFggPvjylwA4mvBaupZgmitA9aEC+lVsalfjc0kG9EHeDvaFa0UWhvYybSqw
         Hu0eW0B6KNkdiefyPRBLielYBDaE640/kgD5l6FzTpNLV8JCRv1EktGoVY89rbtXsq4/
         n+cgEaKUtVQ3ZfuWGX7/+IvxkBiMOVpqnVCq3CcECDnt1RAvHQuQQxJAgacetqn6w+H7
         BgwQ==
X-Gm-Message-State: AOAM530giljhjRQzrv02CKCRGD3w3I/isrcOEEeJboorfAeBX29NvZTH
        vU67aSLYcDQF8jxXxq18RytUoA==
X-Google-Smtp-Source: ABdhPJyNv9utLUbtl13nhVFLMe2DbQzNiipDgdzSnVahx9c+HevjO+Z5XoZ2J7OZUBZRFF03CNYYtg==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr4109018wmh.93.1603824285879;
        Tue, 27 Oct 2020 11:44:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l26sm2755765wmi.41.2020.10.27.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:44:44 -0700 (PDT)
Date:   Tue, 27 Oct 2020 19:44:42 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] fbdev/atafb: Remove unused extern variables
Message-ID: <20201027184442.GL401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:31:08PM -0400, Peilin Ye wrote:
> Remove 6 unused extern variables to reduce confusion. It is worth
> mentioning that lib/fonts/font_8x8.c and lib/fonts/font_8x16.c also
> declare `fontdata_8x8` and `fontdata_8x16` respectively, and this file
> has nothing to do with them.
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

This was unused ever since this driver was merged into 2.1.67 (I looked at
historical linux git trees quickly). Save to delete I'd say, probably just
copypasted from some outdated driver template that was even older.

Applied to drm-misc-next.
-Daniel
> ---
> $ # Build-tested (Ubuntu 20.04)
> $ sudo apt install gcc-m68k-linux-gnu
> $ cp arch/m68k/configs/atari_defconfig .config
> $ make ARCH=m68k menuconfig
> $ make ARCH=m68k CROSS_COMPILE=m68k-linux-gnu- -j`nproc` all
> 
>  drivers/video/fbdev/atafb.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> index f253daa05d9d..e3812a8ff55a 100644
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -240,14 +240,6 @@ static int *MV300_reg = MV300_reg_8bit;
>  
>  static int inverse;
>  
> -extern int fontheight_8x8;
> -extern int fontwidth_8x8;
> -extern unsigned char fontdata_8x8[];
> -
> -extern int fontheight_8x16;
> -extern int fontwidth_8x16;
> -extern unsigned char fontdata_8x16[];
> -
>  /*
>   * struct fb_ops {
>   *	* open/release and usage marking
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
