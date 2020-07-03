Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4142F213529
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGCHgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 03:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgGCHgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:36:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438E2206B6;
        Fri,  3 Jul 2020 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593761791;
        bh=Oentednt1zT1d2MtszJLU5AGg8bXKnXt96KHFyv+ulk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kF0XAOQMHGdSd0dtXCAyU3O7ghd04gWhLW67VC01rSbCFmq3g6lvehO4yb+gR4clx
         X8il5WYAcNRHbxLEisp2nN1ayH6WM5bHCpIu97WufhBNCFGu087C2GtJCKWJqT6vdM
         +Xn2Zm452MRCul3CBkZnTNd3kUPCMfEZANY7NCL0=
Date:   Fri, 3 Jul 2020 09:36:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodolfo Giometti <giometti@linux.it>,
        "Eurotech S.p.A" <info@eurtech.it>
Subject: Re: [PATCH 23/30] usb: host: oxu210hp-hcd: Move declaration of 'qtd'
 into 'ifdef OXU_URB_TRACE'
Message-ID: <20200703073635.GA2364726@kroah.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-24-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702144625.2533530-24-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:46:18PM +0100, Lee Jones wrote:
> If we assign 'epnum' during the declaration we can also avoid "ISO
> C90 forbids mixed declarations" issues.  So it does looks like we
> can have our cake and eat it in this scenario.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/host/oxu210hp-hcd.c: In function ‘submit_async’:
>  drivers/usb/host/oxu210hp-hcd.c:2040:19: warning: variable ‘qtd’ set but not used [-Wunused-but-set-variable]
>  2040 | struct ehci_qtd *qtd;
>  | ^~~
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Rodolfo Giometti <giometti@linux.it>
> Cc: "Eurotech S.p.A" <info@eurtech.it>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/host/oxu210hp-hcd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
> index 120666a0d5901..b00673295c9fe 100644
> --- a/drivers/usb/host/oxu210hp-hcd.c
> +++ b/drivers/usb/host/oxu210hp-hcd.c
> @@ -2037,16 +2037,15 @@ static struct ehci_qh *qh_append_tds(struct oxu_hcd *oxu,
>  static int submit_async(struct oxu_hcd	*oxu, struct urb *urb,
>  			struct list_head *qtd_list, gfp_t mem_flags)
>  {
> -	struct ehci_qtd	*qtd;
> -	int epnum;
> +	int epnum = urb->ep->desc.bEndpointAddress;
>  	unsigned long flags;
>  	struct ehci_qh *qh = NULL;
>  	int rc = 0;
> +#ifdef OXU_URB_TRACE
> +	struct ehci_qtd	*qtd;
>  
>  	qtd = list_entry(qtd_list->next, struct ehci_qtd, qtd_list);
> -	epnum = urb->ep->desc.bEndpointAddress;
>  
> -#ifdef OXU_URB_TRACE
>  	oxu_dbg(oxu, "%s %s urb %p ep%d%s len %d, qtd %p [qh %p]\n",
>  		__func__, urb->dev->devpath, urb,
>  		epnum & 0x0f, (epnum & USB_DIR_IN) ? "in" : "out",
> -- 
> 2.25.1
> 

Ugh, nice hack, but those OXU_URB_TRACE defines really just need to be
dropped entirely.  I'll take this for now though, thanks.

greg k-h
