Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54362102F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 06:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGAEaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 00:30:04 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:37271 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:30:04 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1954E280038A9;
        Wed,  1 Jul 2020 06:30:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A44C71940B1; Wed,  1 Jul 2020 06:30:01 +0200 (CEST)
Date:   Wed, 1 Jul 2020 06:30:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Daniel Winkler <danielwinkler@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "serial: 8250: Fix max baud limit in generic 8250
 port"
Message-ID: <20200701043001.73qhxyyjx6bayn2m@wunner.de>
References: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:42:11PM -0700, Daniel Winkler wrote:
> This reverts commit 0eeaf62981ecc79e8395ca8caa1570eaf3a12257.

That is not an upstream commit.  You probably mean:

    commit 7b668c064ec33f3d687c3a413d05e355172e6c92
    Author: Serge Semin <Sergey.Semin@baikalelectronics.ru>
    Date:   Thu May 7 02:31:32 2020 +0300

    serial: 8250: Fix max baud limit in generic 8250 port

And you didn't cc the commit author (hereby fixed).

Thanks,

Lukas

> 
> The change regresses the QCA6174A-3 bluetooth chip, preventing
> firmware from being properly loaded. We have verified that without
> this patch, the chip works as intended.
> 
> Signed-off-by: Daniel Winkler <danielwinkler@google.com>
> ---
> 
>  drivers/tty/serial/8250/8250_port.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 1632f7d25acca..e057c65ac1580 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2618,8 +2618,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  					     struct ktermios *termios,
>  					     struct ktermios *old)
>  {
> -	unsigned int tolerance = port->uartclk / 100;
> -
>  	/*
>  	 * Ask the core to calculate the divisor for us.
>  	 * Allow 1% tolerance at the upper limit so uart clks marginally
> @@ -2628,7 +2626,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  	 */
>  	return uart_get_baud_rate(port, termios, old,
>  				  port->uartclk / 16 / UART_DIV_MAX,
> -				  (port->uartclk + tolerance) / 16);
> +				  port->uartclk);
>  }
>  
>  void
> -- 
> 2.27.0.212.ge8ba1cc988-goog
