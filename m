Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF61AE029
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgDQOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:49:22 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:40726 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgDQOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:49:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 3AA40804D5;
        Fri, 17 Apr 2020 16:49:17 +0200 (CEST)
Date:   Fri, 17 Apr 2020 16:49:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     gregkh@linuxfoundation.org, Adam Borowski <kilobyte@angband.pl>,
        Chen Wandun <chenwandun@huawei.com>, jslaby@suse.com,
        daniel.vetter@ffwll.ch, b.zolnierkie@samsung.com, lukas@wunner.de,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: don't hardcode the mem allocation upper bound
Message-ID: <20200417144915.GA25595@ravnborg.org>
References: <nycvar.YSQ.7.76.2003281702410.2671@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2003281702410.2671@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=dg4UtMH5AAAA:8 a=VwQbUJbxAAAA:8
        a=Zidhv8YuL5__o8oUjuwA:9 a=CjuIK1q_8ugA:10 a=byNfn09xH3PuSfgbYLsR:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg.

I assume you will take this patch.
Not really drm-misc material.

	Sam

On Sat, Mar 28, 2020 at 05:32:42PM -0400, Nicolas Pitre wrote:
> The code in vc_do_resize() bounds the memory allocation size to avoid
> exceeding MAX_ORDER down the kzalloc() call chain and generating a 
> runtime warning triggerable from user space. However, not only is it
> unwise to use a literal value here, but MAX_ORDER may also be
> configurable based on CONFIG_FORCE_MAX_ZONEORDER.
> Let's use KMALLOC_MAX_SIZE instead.
> 
> Note that prior commit bb1107f7c605 ("mm, slab: make sure that 
> KMALLOC_MAX_SIZE will fit into MAX_ORDER") the KMALLOC_MAX_SIZE value
> could not be relied upon.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> Cc: <stable@vger.kernel.org> # v4.10+
> 
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 15d2769805..37c5f21490 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1193,7 +1193,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>  		return 0;
>  
> -	if (new_screen_size > (4 << 20))
> +	if (new_screen_size > KMALLOC_MAX_SIZE)
>  		return -EINVAL;
>  	newscreen = kzalloc(new_screen_size, GFP_USER);
>  	if (!newscreen)
