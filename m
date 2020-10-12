Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BC28AB38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 02:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgJLA1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 20:27:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40681 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726735AbgJLA1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 20:27:11 -0400
Received: (qmail 615163 invoked by uid 1000); 11 Oct 2020 20:27:09 -0400
Date:   Sun, 11 Oct 2020 20:27:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-sched: add comment about find_tt() not
 returning error
Message-ID: <20201012002709.GA614913@rowland.harvard.edu>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 09:50:08PM +0100, Sudip Mukherjee wrote:
> Add a comment explaining why find_tt() will not return error even though
> find_tt() is checking for NULL and other errors.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/usb/host/ehci-sched.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
> index 6dfb242f9a4b..0f85aa9b2fb1 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -244,6 +244,12 @@ static void reserve_release_intr_bandwidth(struct ehci_hcd *ehci,
>  
>  	/* FS/LS bus bandwidth */
>  	if (tt_usecs) {
> +		/*
> +		 * find_tt() will not return any error here as we have
> +		 * already called find_tt() before calling this function
> +		 * and checked for any error return. The previous call
> +		 * would have created the data structure.
> +		 */
>  		tt = find_tt(qh->ps.udev);
>  		if (sign > 0)
>  			list_add_tail(&qh->ps.ps_list, &tt->ps_list);
> @@ -1337,6 +1343,12 @@ static void reserve_release_iso_bandwidth(struct ehci_hcd *ehci,
>  			}
>  		}
>  
> +		/*
> +		 * find_tt() will not return any error here as we have
> +		 * already called find_tt() before calling this function
> +		 * and checked for any error return. The previous call
> +		 * would have created the data structure.
> +		 */
>  		tt = find_tt(stream->ps.udev);
>  		if (sign > 0)
>  			list_add_tail(&stream->ps.ps_list, &tt->ps_list);

Acked-by: Alan Stern <stern@rowland.harvard.edu>
