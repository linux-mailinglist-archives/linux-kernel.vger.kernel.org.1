Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED11C26B2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgEBP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 11:57:34 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40314 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgEBP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:57:34 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 073AB20035;
        Sat,  2 May 2020 17:57:30 +0200 (CEST)
Date:   Sat, 2 May 2020 17:57:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: fix unicode console freeing with a common interface
Message-ID: <20200502155729.GA12824@ravnborg.org>
References: <nycvar.YSQ.7.76.2005021043110.2671@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2005021043110.2671@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=dg4UtMH5AAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
        a=7gkXJVJtAAAA:8 a=3-pTkGgL0d8xpduKzdIA:9 a=CjuIK1q_8ugA:10
        a=byNfn09xH3PuSfgbYLsR:22 a=cQPPKAXgyycSBL8etih5:22
        a=AjGcO6oz07-iQ99wixmX:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas

On Sat, May 02, 2020 at 11:01:07AM -0400, Nicolas Pitre wrote:
> By directly using kfree() in different places we risk missing one if
> it is switched to using vfree(), especially if the corresponding
> vmalloc() is hidden away within a common abstraction.
> 
> Oh wait, that's exactly what happened here.
> 
> So let's fix this by creating a common abstraction for the free case
> as well.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> Reported-by: syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com
> Fixes: 9a98e7a80f95 ("vt: don't use kmalloc() for the unicode screen buffer")
> Cc: <stable@vger.kernel.org>

Looks good.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Not the I know the code, but verified that no more kfree() was
used for vc_uni_screen.

	Sam

> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index e5ffed795e..48a8199f78 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -365,9 +365,14 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
>  	return uniscr;
>  }
>  
> +static void vc_uniscr_free(struct uni_screen *uniscr)
> +{
> +	vfree(uniscr);
> +}
> +
>  static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
>  {
> -	vfree(vc->vc_uni_screen);
> +	vc_uniscr_free(vc->vc_uni_screen);
>  	vc->vc_uni_screen = new_uniscr;
>  }
>  
> @@ -1230,7 +1235,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	err = resize_screen(vc, new_cols, new_rows, user);
>  	if (err) {
>  		kfree(newscreen);
> -		kfree(new_uniscr);
> +		vc_uniscr_free(new_uniscr);
>  		return err;
>  	}
>  
