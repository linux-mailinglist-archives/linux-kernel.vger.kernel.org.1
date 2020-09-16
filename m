Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D231726CA65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgIPT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgIPRgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:36:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D45821655;
        Wed, 16 Sep 2020 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600254684;
        bh=nT/vmCGFfmSFgpzah3Ct0QpHS6z8WSZoQrZ6dGKhyXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pB3ubzTyE8/ykxSVzAiSm6ewVDfdniIBUsWAjrJAKC/6jxW48ijVQjrUCLVyEWeX
         8bNITgFrub12hJB9JZMDySfXplhT4bYeBfier33GUOHRasNSq6TSYp/tm9sWmBK5Sg
         JMg95DQcs9GeroP7nEv0lMwrhr4rbOE8eYUxE6ac=
Date:   Wed, 16 Sep 2020 13:11:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: simplify virt_addr_valid call
Message-ID: <20200916111159.GA923212@kroah.com>
References: <20200912144719.13929-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912144719.13929-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 07:47:19AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Reviewing sram_write_dma_safe(), there are two
> identical calls to virt_addr_valid().  The second
> call can be simplified by a comparison of variables
> set from the first call.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/staging/wfx/fwio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/fwio.c b/drivers/staging/wfx/fwio.c
> index 22d3b684f04f..c99adb0c99f1 100644
> --- a/drivers/staging/wfx/fwio.c
> +++ b/drivers/staging/wfx/fwio.c
> @@ -94,7 +94,7 @@ static int sram_write_dma_safe(struct wfx_dev *wdev, u32 addr, const u8 *buf,
>  		tmp = buf;
>  	}
>  	ret = sram_buf_write(wdev, addr, tmp, len);
> -	if (!virt_addr_valid(buf))
> +	if (tmp != buf)
>  		kfree(tmp);
>  	return ret;
>  }

Jerome, any thoughts?

thanks,

greg k-h
