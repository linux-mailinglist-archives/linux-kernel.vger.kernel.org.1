Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A329D4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgJ1Vxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbgJ1Vxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67912AEC4;
        Wed, 28 Oct 2020 19:25:56 +0000 (UTC)
Subject: Re: [PATCH 1/5] fbdev/atafb: Remove unused extern variables
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <4c15a505-9704-9639-aeaa-e865d264c120@suse.de>
Date:   Wed, 28 Oct 2020 20:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 27.10.20 um 17:31 schrieb Peilin Ye:
> Remove 6 unused extern variables to reduce confusion. It is worth
> mentioning that lib/fonts/font_8x8.c and lib/fonts/font_8x16.c also
> declare `fontdata_8x8` and `fontdata_8x16` respectively, and this file
> has nothing to do with them.
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

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
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
