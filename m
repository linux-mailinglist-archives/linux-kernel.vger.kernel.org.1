Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFE2A3461
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKBTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgKBTkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:40:01 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8CA22268;
        Mon,  2 Nov 2020 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346000;
        bh=IWunD2Cz2xcaCwPBQNJRvEa6f66eGVu+ZtfdVqx9Ivk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSRBOUtkHP+xHtFE878bi0AZQGfo0GAygXV2x1BUU+joBUGj/03cbHOYhxbsOxBoD
         +DrMG+Qro8hQLQ4rlVnq0Xf+SR9GmrAw7nPRFzY3UPRWJWTFIvABJVAz2xF+YU20hr
         SH6n/VG6nEZIsoqBbXt3mmxNdFr+TZdllKa7DAGY=
Date:   Mon, 2 Nov 2020 20:40:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "siddhant gupta(siddhant1223)" <siddhantgupta416@gmail.com>
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        mamatashukla555@gmail.com, linux-arm-kernel@lists.infradead.org,
        himadrispandya@gmail.com
Subject: Re: [PATCH] staging: mt7621-dma: Prefer Using BIT Macro instead of
 left shifting on 1.
Message-ID: <20201102194055.GA2429929@kroah.com>
References: <20201102193402.GA14965@Sleakybeast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102193402.GA14965@Sleakybeast>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:04:02AM +0530, siddhant gupta(siddhant1223) wrote:
> 
> Replace left shifting on 1 by a BIT macro to fix checkpatch warning.
> 
> Signed-off-by: Siddhant Gupta <siddhantgupta416@gmail.com>
> 
> ---
>  drivers/staging/mt7621-dma/mtk-hsdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> index 354536783e1c..a9e1a1b14035 100644
> --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> @@ -72,7 +72,7 @@
>  #define HSDMA_GLO_TX_DMA		BIT(0)
>  
>  #define HSDMA_BT_SIZE_16BYTES		(0 << HSDMA_GLO_BT_SHIFT)
> -#define HSDMA_BT_SIZE_32BYTES		(1 << HSDMA_GLO_BT_SHIFT)
> +#define HSDMA_BT_SIZE_32BYTES		BIT(HSDMA_GLO_BT_SHIFT)
>  #define HSDMA_BT_SIZE_64BYTES		(2 << HSDMA_GLO_BT_SHIFT)
>  #define HSDMA_BT_SIZE_128BYTES		(3 << HSDMA_GLO_BT_SHIFT)

In looking at the code, does this change really make sense?

(hint, I don't think so...)
