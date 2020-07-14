Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3B21EF40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGNL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 07:29:16 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39646 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:29:16 -0400
Received: by mail-ej1-f65.google.com with SMTP id w6so21197230ejq.6;
        Tue, 14 Jul 2020 04:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xph+e5Wgs29Mq4JQTkkGF6Lc0G5UFxbS0Ft+cUAArB8=;
        b=KW41Zn1LLDT/ZWUkqopfJs5YDzrW29uA6olpaRxRvvqk2gjNUK/pwXOG/heOFygG9l
         mjPFyU10V2dcWuK2kKnsUFohaaVo9Hv76zQUe3GdJA1XuX/B6W9B3gx/TTlsuN6wBC4T
         aJT3i0/ZYgsbUjCeZjGCQBPRxJ/hp0WJe/PdtaWspFdAUpHThW1IJpju+4IexIlqCzwX
         3aS7PP8QGnYd5N99ksyu9Uu+RVu7sBcqP7Lzrg8axam/i6VA9/6exEuz9hLbw457wNwv
         e+LjuObJ/5nKZZq/tLBN2jgprJvhp4zVf1bYfz9PQXjGvMBMojONhBoCwejcqaYLOHpE
         xIyQ==
X-Gm-Message-State: AOAM5333qQCGvItrC9o2szYbNwTg/S/Guyw8WSqC+upnM2+kJT/1rryS
        m2ycw70PkdLSSJUs3/fhJ98/N6rW
X-Google-Smtp-Source: ABdhPJzQnz4VFBFVzpyWoYnkX1YyFcr0HPY6Qzm+Ck/nD6Lb32DImL6L+o1XRZd+9eAAshqPmCMrMw==
X-Received: by 2002:a17:906:375a:: with SMTP id e26mr4208219ejc.324.1594726153373;
        Tue, 14 Jul 2020 04:29:13 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id cq7sm14345902edb.66.2020.07.14.04.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 04:29:12 -0700 (PDT)
Subject: Re: [PATCH v2] serial: mxs-auart: add missed iounmap() in probe
 failure and remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200709135608.68290-1-hslester96@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8fcb4cd4-3a3a-5240-bce4-ef740a243856@kernel.org>
Date:   Tue, 14 Jul 2020 13:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709135608.68290-1-hslester96@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 07. 20, 15:56, Chuhong Yuan wrote:
> This driver calls ioremap() in probe, but it misses calling iounmap() in 
> probe's error handler and remove.
> Add the missed calls to fix it.
> 
> Fixes: 47d37d6f94cc ("serial: Add auart driver for i.MX23/28")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Use iounmap() instead of devm_ioremap() to fix the bugs.

Out of curiosity, what was wrong with devm_ioremap? I seem I cannot find
the reason...

>   - Modify the subject and the description.
> 
>  drivers/tty/serial/mxs-auart.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index b4f835e7de23..b784323a6a7b 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1698,21 +1698,21 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret = irq;
> -		goto out_disable_clks;
> +		goto out_iounmap;
>  	}
>  
>  	s->port.irq = irq;
>  	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
>  			       dev_name(&pdev->dev), s);
>  	if (ret)
> -		goto out_disable_clks;
> +		goto out_iounmap;
>  
>  	platform_set_drvdata(pdev, s);
>  
>  	ret = mxs_auart_init_gpios(s, &pdev->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
> -		goto out_disable_clks;
> +		goto out_iounmap;
>  	}
>  
>  	/*
> @@ -1720,7 +1720,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	 */
>  	ret = mxs_auart_request_gpio_irq(s);
>  	if (ret)
> -		goto out_disable_clks;
> +		goto out_iounmap;
>  
>  	auart_port[s->port.line] = s;
>  
> @@ -1746,6 +1746,9 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  	mxs_auart_free_gpio_irq(s);
>  	auart_port[pdev->id] = NULL;
>  
> +out_iounmap:
> +	iounmap(s->port.membase);
> +
>  out_disable_clks:
>  	if (is_asm9260_auart(s)) {
>  		clk_disable_unprepare(s->clk);
> @@ -1761,6 +1764,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
>  	uart_remove_one_port(&auart_driver, &s->port);
>  	auart_port[pdev->id] = NULL;
>  	mxs_auart_free_gpio_irq(s);
> +	iounmap(s->port.membase);
>  	if (is_asm9260_auart(s)) {
>  		clk_disable_unprepare(s->clk);
>  		clk_disable_unprepare(s->clk_ahb);
> 


-- 
js
suse labs
