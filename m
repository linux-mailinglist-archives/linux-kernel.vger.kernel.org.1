Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958D02356D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHBMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 08:00:48 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51426 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHBMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 08:00:48 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7E0CF1C0BD4; Sun,  2 Aug 2020 14:00:45 +0200 (CEST)
Date:   Sun, 2 Aug 2020 14:00:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark usbvision as obsolete
Message-ID: <20200802120031.GB1289@bug>
References: <20200720031608.cujruuzsrfpnt7sh@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720031608.cujruuzsrfpnt7sh@pesu.pes.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-07-19 23:16:08, B K Karthik wrote:
> mark staging/media/usbvision as obsolete so
> checkpatch tells people not to send patches.

Umm... that's not right.

If we do not want people to fix it, it should not be in stagging -- it should 
be dropped.
									Pavel

> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a88bf0759c90..82120c2fcedd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17946,7 +17946,7 @@ F:	include/uapi/linux/uvcvideo.h
>  USB VISION DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
> -S:	Odd Fixes
> +S:	Odd Fixes / Obsolete
>  W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/staging/media/usbvision/
> -- 
> 2.20.1
> 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
