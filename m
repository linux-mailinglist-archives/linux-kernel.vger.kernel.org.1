Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39942E6F64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgL2JdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgL2JdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:33:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B507207D1;
        Tue, 29 Dec 2020 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609234353;
        bh=LK3HmT4kNURptxv6F4CvJHafEmL+opWIk8yZiiYTdRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0G1UczJxFCtepc9TqrliOlWah8cpnjjZTsIkUtonornNQuzIUFXDWEfarxzENSUdp
         C920NIoCfuAYyp562ID251qUGL+6EgSRZb7xShhx5Bwbz1GlNqF0nBYVdTHi93cVpq
         Qz4l6JjE8rPAwioDUhSS1+1XEOJUsYX5bR3p0oB4=
Date:   Tue, 29 Dec 2020 10:33:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: make pl011 serial port driver support 485 mode
Message-ID: <X+r4APypFfjOIUmV@kroah.com>
References: <1609232164-26271-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609232164-26271-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 04:56:04PM +0800, zhangqiumiao1@huawei.com wrote:
> From: zhangqiumiao <zhangqiumiao1@huawei.com>
> 
> make pl011 serial port support 485 mode full duplex communication
> 
> Signed-off-by: zhangqiumiao <zhangqiumiao1@huawei.com>

Can you please use your "real name" or one you sign documents with?

> ---
>  drivers/tty/serial/amba-pl011.c | 38 +++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c255476cce28..f6a7fe61e699 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -44,6 +44,7 @@
> 
>  #include "amba-pl011.h"
> 
> +#define ISEMPTY			1
>  #define UART_NR			14
> 
>  #define SERIAL_AMBA_MAJOR	204
> @@ -1284,14 +1285,33 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  #define pl011_dma_flush_buffer	NULL
>  #endif
> 
> +static unsigned int pl011_tx_empty(struct uart_port *port);
> +
>  static void pl011_stop_tx(struct uart_port *port)
>  {
> +	unsigned int cr;
> +	unsigned int result;
>  	struct uart_amba_port *uap =
> 
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +	if (port->rs485.flags & SER_RS485_ENABLEED) {
> +		whiel(1) {

You obviously never built this code :(
