Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115D41A1CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 09:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDHHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 03:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHHeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:34:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5244C206A1;
        Wed,  8 Apr 2020 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586331240;
        bh=c2Uzl2X79AqNfnzfAf4v+3E5WKLVF38m2BfHhrwAzsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSUEB3vtoZWkAeQTUpXcWLGRaK8ZRAf4wWtQRCR/j1teZSyvXav3xE9oGRyMv3Xoh
         TuMbnqpXiq0T76nkf1EnokINRz+DPCL2YOUz0JpruI+WwgdFmCFNA0r4hJX8b3lEN7
         zsI/YcvOOu8aisPjg1DrS7ZWl3bpvP5WeGfQj2Yk=
Date:   Wed, 8 Apr 2020 09:33:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     R Veera Kumar <vkor@vkten.in>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-pinctrl: Use correct pointer type
 argument for sizeof
Message-ID: <20200408073358.GA1033546@kroah.com>
References: <20200408071112.11578-1-vkor@vkten.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408071112.11578-1-vkor@vkten.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:41:12PM +0530, R Veera Kumar wrote:
> Use correct pointer type argument for sizeof.
> Found using coccinelle.
> 
> Signed-off-by: R Veera Kumar <vkor@vkten.in>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index d0f06790d38f..62babad5ee0b 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -220,7 +220,7 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
>  	/* allocate our function and group mapping index buffers */
>  	f = p->func = devm_kcalloc(p->dev,
>  				   p->func_count,
> -				   sizeof(struct rt2880_pmx_func),
> +				   sizeof(rt2880_pmx_func),

Did you build this change?

Always do so.

Also, nothing is really wrong with the existing code, remember,
checkpatch is a hint, telling you that maybe something is odd with this
line.  It is not always correct.

thanks,

greg k-h
