Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B2AD235
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgKJJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:17:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:45068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgKJJRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:17:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E22B1AC24;
        Tue, 10 Nov 2020 09:17:44 +0000 (UTC)
Subject: Re: [PATCH] drm/fb_helper: Use min_t() to handle size_t and unsigned
 long
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201110090119.2667326-1-geert+renesas@glider.be>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <cab52bc4-c058-50d0-8048-c67a1ed0da73@suse.de>
Date:   Tue, 10 Nov 2020 10:17:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110090119.2667326-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 10.11.20 um 10:01 schrieb Geert Uytterhoeven:
> On arm32:
> 
>     drivers/gpu/drm/drm_fb_helper.c: In function ‘fb_read_screen_base’:
>     include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
>     ...
>     drivers/gpu/drm/drm_fb_helper.c:2041:22: note: in expansion of macro ‘min’
>      2041 |  size_t alloc_size = min(count, PAGE_SIZE);
> 	  |                      ^~~
>     drivers/gpu/drm/drm_fb_helper.c: In function ‘fb_write_screen_base’:
>     include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
>     ...
>     drivers/gpu/drm/drm_fb_helper.c:2115:22: note: in expansion of macro ‘min’
>      2115 |  size_t alloc_size = min(count, PAGE_SIZE);
> 	  |                      ^~~
> 
> Indeed, on 32-bit size_t is "unsigned int", not "unsigned long".
> 
> Fixes: 222ec45f4c69dfa8 ("drm/fb_helper: Support framebuffers in I/O memory")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot. I'll add the patch to drm-misc-next.

> ---
> Interestingly, the commit log claims v7 changed:
> 
>     use min_t(size_t,) (kernel test robot)

It got fixed in the functions' inner loops, but I missed the other
instances.

Best regards
Thomas

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 01ba1da285116373..25edf670867c6f79 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2038,7 +2038,7 @@ static ssize_t fb_read_screen_base(struct fb_info *info, char __user *buf, size_
>  				   loff_t pos)
>  {
>  	const char __iomem *src = info->screen_base + pos;
> -	size_t alloc_size = min(count, PAGE_SIZE);
> +	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
>  	ssize_t ret = 0;
>  	int err = 0;
>  	char *tmp;
> @@ -2112,7 +2112,7 @@ static ssize_t fb_write_screen_base(struct fb_info *info, const char __user *buf
>  				    loff_t pos)
>  {
>  	char __iomem *dst = info->screen_base + pos;
> -	size_t alloc_size = min(count, PAGE_SIZE);
> +	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
>  	ssize_t ret = 0;
>  	int err = 0;
>  	u8 *tmp;
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
