Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6795F1BC04E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgD1NzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgD1Ny7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:54:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98898C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:54:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so24726537wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y4R3VnlEi2z5e9sIaP90X1Xt8ogqQzWAFd5IDdJculE=;
        b=JJM3sOrRHFZiVfnWGdSakzblHcv7JX3BvvX2/h97d8aeprfJN//zyI26TJIp+jtPY/
         4HrFhR9QrEYH/p29K7RIUSoJD1T2OjM2lOFlOMnu//pAHmVUeH7A2eAAsKNYpO9ueAs2
         4fPfQ8vAiUAjgVg/2Jmw82zkQUuPHpMlOUmxJV1bH+cU4i399cjjXdoFdq3pFPmYUx1T
         vT7vGj3l1YiC3xMJUfq9baoMdoKeUm4a421T8WL45h90URhKfiBrzFOZmSodBEo3ITRd
         TvHpZAOX9Bj7TlhU21ea3qZG4n6hRRWDiHFWfDAier17llPtDdbRVBJmUbFwPStooCFh
         /dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y4R3VnlEi2z5e9sIaP90X1Xt8ogqQzWAFd5IDdJculE=;
        b=q8Jj3TXS7TCeFCp0+wy4pzACfzdtzY2BWCzonRmKqpQZ+HlRo6nZtTSk3CHFF74cUe
         E74ihAxaSmdQmtfBdcQ/1MGy8ppe3rH0Bd0Rpzvngeanm62HU56IJzS4wPYREUy3FQJA
         DKNMd1KisJ0C9R98zktFlTJCZ42da87FQpaASs4oYi/LdNlEpmHaj2IO83h8J5WL3Q5Z
         72UDLTus/TRUPNJYZrkU8bmvTOXBYIpzzHzOYG87JZhPAC98vTycF5DoMQvBN0IiTJ4G
         JxPEyShkZcDbnqGo2azg4NFE8cYRBcWe2DuOYt3pnvmppLYr57T64A57z3GyceyxofcE
         j4RA==
X-Gm-Message-State: AGi0PuaqTeTol1iC2qbiP4VuEDGRjEoa5UduZbQJ/E41YsXsY54IRPqh
        XNOttggHi0duh7QnWwDjUeOy9Q==
X-Google-Smtp-Source: APiQypIgyNgC6uyVKLvHFUkGnGak2AElpTZPwJhrf3lsXoErO6m8fGbfE7BWOG5yBnFfbrAITeMsxQ==
X-Received: by 2002:adf:e586:: with SMTP id l6mr32840757wrm.184.1588082098287;
        Tue, 28 Apr 2020 06:54:58 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d143sm3330771wmd.16.2020.04.28.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 06:54:57 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:54:56 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     dianders@chromium.org, linux-serial@vger.kernel.org,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.com,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: Support earlycon_kgdboc
Message-ID: <20200428135456.2d7zxz2mdte5kclk@holly.lan>
References: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:43:51PM +0530, Sumit Garg wrote:
> Implement the read() function in the early console driver. With
> recently added earlycon_kgdboc feature, this allows you to use kgdb
> to debug fairly early into the system boot.
> 
> We only bother implementing this if polling is enabled since kgdb can't
> be enabled without that.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> 
> Depends on kgdb patch series: https://lkml.org/lkml/2020/4/21/1179
> 
>  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2296bb0..c010f63 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2435,6 +2435,37 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
>  	uart_console_write(&dev->port, s, n, pl011_putc);
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +static int pl011_getc(struct uart_port *port)
> +{
> +	if (readl(port->membase + UART01x_FR) & UART01x_FR_RXFE)
> +		return NO_POLL_CHAR;
> +
> +	if (port->iotype == UPIO_MEM32)
> +		return readl(port->membase + UART01x_DR);
> +	else
> +		return readb(port->membase + UART01x_DR);
> +}
> +
> +static int pl011_early_read(struct console *con, char *s, unsigned int n)
> +{
> +	struct earlycon_device *dev = con->data;
> +	int ch, num_read = 0;
> +
> +	while (num_read < n) {
> +		ch = pl011_getc(&dev->port);
> +		if (ch == NO_POLL_CHAR)
> +			break;
> +
> +		s[num_read++] = ch;
> +	}
> +
> +	return num_read;
> +}
> +#else
> +#define pl011_early_read NULL
> +#endif
> +
>  /*
>   * On non-ACPI systems, earlycon is enabled by specifying
>   * "earlycon=pl011,<address>" on the kernel command line.
> @@ -2454,6 +2485,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>  		return -ENODEV;
>  
>  	device->con->write = pl011_early_write;
> +	device->con->read = pl011_early_read;
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
