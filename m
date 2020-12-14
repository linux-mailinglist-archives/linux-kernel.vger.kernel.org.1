Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88D2D97DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438836AbgLNMFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731381AbgLNME5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:04:57 -0500
Date:   Mon, 14 Dec 2020 13:05:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607947456;
        bh=/zOYosf9OQG2h8LPMbK40g0Rf7i8gWLhYVSwdcnUXJ4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oe6NnjfNRkdkhcaCP18EWC1UVQsi/Pr6RgH9GD4wp4h4xCuJkICFLZyNO/NY0dTuB
         qgIgjXUD42PBTkrBH1qOfBImeqrlH+xFveEYG3yzLuOpyxaG+Ninve6ykmXazJVGtJ
         x5vXxqfCqao6A282886Ga8HvKuMbqI/hkUGuXKkg=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: xhci: remove unused variable
Message-ID: <X9dVAl/Zbi1DM0JC@kroah.com>
References: <1607945531-15059-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607945531-15059-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 07:32:11PM +0800, Zou Wei wrote:
> Fix variable set but not used compilation warnings:
> 
> drivers/usb/host/xhci.c:1338:15: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
>   unsigned int len;
>                ^~~
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/usb/host/xhci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 91ab81c..24e5a0f 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1335,7 +1335,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
>  
>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  {
> -	unsigned int len;
>  	unsigned int buf_len;
>  	enum dma_data_direction dir;
>  
> @@ -1351,10 +1350,10 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  				 dir);
>  
>  	if (usb_urb_dir_in(urb))
> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> -					   urb->transfer_buffer,
> -					   buf_len,
> -					   0);
> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> +				     urb->transfer_buffer,
> +				     buf_len,
> +				     0);

Why not test that this worked properly?

thanks,

greg k-h
