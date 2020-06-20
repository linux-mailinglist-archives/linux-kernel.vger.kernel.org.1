Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA50202358
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgFTL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 07:27:25 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50632 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFTL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 07:27:23 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B4AC220020;
        Sat, 20 Jun 2020 13:27:20 +0200 (CEST)
Date:   Sat, 20 Jun 2020 13:27:19 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] fbdev/fb.h: Use struct_size() helper in kzalloc()
Message-ID: <20200620112719.GC16901@ravnborg.org>
References: <20200617175647.GA26370@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617175647.GA26370@embeddedor>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=edQTgYMH c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
        a=eQAgsu64IDNOz3FtGqwA:9 a=KgSf4rBJBTyy23aL:21 a=eSvgJIpcUDpWB52b:21
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo.

On Wed, Jun 17, 2020 at 12:56:47PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

struct_size is defined in overflow.h - which is not included by fs.h.
So we rely on overflow.h being pulled in by some other header - maybe
slab.h in this case.
Seems fragile, should this patch add an include of overflow.h?

	Sam

> ---
>  include/linux/fb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 3b4b2f0c6994..2b530e6d86e4 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -506,8 +506,9 @@ struct fb_info {
>  };
>  
>  static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
> -	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
> -			+ max_num * sizeof(struct aperture), GFP_KERNEL);
> +	struct apertures_struct *a;
> +
> +	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
>  	if (!a)
>  		return NULL;
>  	a->count = max_num;
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
