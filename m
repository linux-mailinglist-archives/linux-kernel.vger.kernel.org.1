Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45BF28770A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgJHPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:21:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38701 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgJHPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:21:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id c141so313677lfg.5;
        Thu, 08 Oct 2020 08:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdx7FXoulf6+KPVkuCgYPh/M6PGV5WCjB+JKWP2F7cM=;
        b=J20gJy+UhC0NVGIXtG4TrgXsA/qMY4vqAVccPoDoLXAI2ypZaZhrQmUooA3eNshPdI
         eqaoRy3ArHbVk84GCdMRnRogUhYSQ4ZO9GAfBEQ7c95NLIuRVMiumR1AJb9+7ZJMGW7D
         SqYMj+O8ZWQ4eOp37+jdGIEJFBJ2Gdf1tSMe0K+bxzAgmsUoIExwSvG0PHzd2gwfBAze
         M/CXPk+WPejf6qHNH68mYCbOZfHEWhaIn0UqvHvsS5YgxXG8mDe0y/Ir8eXg5RY71pBA
         nMX77nLbla7/EGszRPSHSz/BlaWAYFJzHgWxooppHhJumT4feNQAYWe6lSfUEK4zBY/W
         boBQ==
X-Gm-Message-State: AOAM530ZShypIGd0ckNir/qhdfrTfq+FMjMJLnsLlGYwlSG7gySjMVSZ
        oqdd1acoPEnbsrjIX5f4C5U=
X-Google-Smtp-Source: ABdhPJy+Ly+jsWC46OYzqg9Ez1Qcu80smXv99kE8n47XWxVqqo9MljznCwTRar6pNDX4j0Il5aMkiA==
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr479865lfr.198.1602170468914;
        Thu, 08 Oct 2020 08:21:08 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id z84sm166953lfa.45.2020.10.08.08.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:21:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kQXj5-0007GR-7u; Thu, 08 Oct 2020 17:21:03 +0200
Date:   Thu, 8 Oct 2020 17:21:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: Fix serial port stall after resume
Message-ID: <20201008152103.GK26280@localhost>
References: <20200929193327.GA13987@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929193327.GA13987@ls3530.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 09:33:27PM +0200, Helge Deller wrote:
> With a 4-port serial USB HUB with FT232BM chips the serial ports stop
> working after a software suspend/resume cycle.
> Rewriting the latency timer during the resume phase fixes it.

Hmm. This sounds weird. Why would the latency timer make such a
difference?

> Cc: stable@vger.kernel.org
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 9823bb424abd..8ee6cf6215c1 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1092,6 +1092,7 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
>  static u32 ftdi_232bm_baud_to_divisor(int baud);
>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
>  static u32 ftdi_2232h_baud_to_divisor(int baud);
> +static int ftdi_reset_resume(struct usb_serial *serial);
> 
>  static struct usb_serial_driver ftdi_sio_device = {
>  	.driver = {
> @@ -1122,6 +1123,7 @@ static struct usb_serial_driver ftdi_sio_device = {
>  	.set_termios =		ftdi_set_termios,
>  	.break_ctl =		ftdi_break_ctl,
>  	.tx_empty =		ftdi_tx_empty,
> +	.reset_resume =		ftdi_reset_resume,
>  };
> 
>  static struct usb_serial_driver * const serial_drivers[] = {
> @@ -2379,6 +2381,16 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
>  	return 0;
>  }
> 
> +static int ftdi_reset_resume(struct usb_serial *serial)
> +{
> +	struct usb_serial_port *port = serial->port[0];
> +
> +	if (tty_port_initialized(&port->port))
> +		write_latency_timer(port);

Why are you only doing this for open ports?

> +
> +	return usb_serial_generic_resume(serial);
> +}

And if the device has been reset there may need to reconfigured the
termios settings for open ports.

Could you expand a bit on what the problem is here?

Johan
