Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D32A910D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKFILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:11:53 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F6DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:11:53 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so360885pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HHJAJLjMVDY1DujoeUnO+C9eEb3S0JmhzShIpUxjhD8=;
        b=ZnuWFkcZgEedhFpjoe1Fp0i6IZ6b0Wqz4aX+o4pNc6MspP9Q2JW6dBaTYwy80SUGfK
         N0ygQTw/Tf3vhxS6EGHa/t2h1pUaMidMHiZHU3BEs+T0ndrw+N/1gyU7pjY5Y0QEm23l
         AlH/457yuR3r6CmbG7B/2NL2dL0J+FCezdqQ9icfry1c49ym+5vFVptZ7ZkF1hbMCQHc
         X/M1r9KeewCuXJ4iNcshzJ0GsWj14728L/Zv+ndCKRmAQKbSLjmdzDpPi+jRbaGSQ20Y
         qFT3+AaICo6aEoVGZlTScD3gqMFUsqrl/zw8mr14+qGctjfNQ5ExsFOFzZJZ/jO5W1fP
         XOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HHJAJLjMVDY1DujoeUnO+C9eEb3S0JmhzShIpUxjhD8=;
        b=DXMuh2GY3ItX1bHbZCSLxTa0rH/qlVCQevgGNmQG3tp3yQzg0r0WaUs0QrATO0kj/8
         i/kOcQDQcu+sLUbbKWnBaPtotpJ0we1lgkNoZlETaurqLgFXZH9Y1fi2dqDy/Du0lx+B
         uBLsVxrVXNz2675fC4vsOysgkUM/sSX2+2/BkmMTT835OEcPxwf4xLXV3w6XR3iMZ5Nf
         uqT+tEI7YNFHmssv8fXt+2Py/bxGVFu7FajnP0IwUcNE+YErn93BDZLW1i+YWWhhQoRQ
         cr+kDhonZjUQRDxHMlNATrdt5YaO2cVRrtoQX3ZRgdId06qqjK28GnmNkmuESGjUwlix
         P1qg==
X-Gm-Message-State: AOAM532V3hds6mk8n1l7e553Y1NNdupjryMc4A69j1ML+n/NvY4OcLUZ
        s0WUSaK1YM0d/X8TuvnwOqdymA==
X-Google-Smtp-Source: ABdhPJwt5a0y678zPi8K5483EPDvDwp5QyUAH0SCfjKoCBvsK5bMlCVc0O4B5yjQCrzageGZlkrqfA==
X-Received: by 2002:a17:90a:1596:: with SMTP id m22mr1227948pja.189.1604650312541;
        Fri, 06 Nov 2020 00:11:52 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q23sm1021810pfg.192.2020.11.06.00.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:11:51 -0800 (PST)
Date:   Fri, 06 Nov 2020 00:11:51 -0800 (PST)
X-Google-Original-Date: Fri, 06 Nov 2020 00:02:56 PST (-0800)
Subject:     Re: [PATCH 25/36] tty: serial: sifive: Struct headers should start with 'struct <name>'
In-Reply-To: <20201104193549.4026187-26-lee.jones@linaro.org>
CC:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     lee.jones@linaro.org
Message-ID: <mhng-ddfc93f8-d5a0-4f6c-99be-db3c62cc3c24@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Nov 2020 11:35:38 PST (-0800), lee.jones@linaro.org wrote:
> Also supply a missing member description.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/tty/serial/sifive.c:157: warning: cannot understand function prototype: 'struct sifive_serial_port '
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/tty/serial/sifive.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 13eadcb8aec4e..1066eebe3b28b 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -144,12 +144,13 @@
>   */
>
>  /**
> - * sifive_serial_port - driver-specific data extension to struct uart_port
> + * struct sifive_serial_port - driver-specific data extension to struct uart_port
>   * @port: struct uart_port embedded in this struct
>   * @dev: struct device *
>   * @ier: shadowed copy of the interrupt enable register
>   * @clkin_rate: input clock to the UART IP block.
>   * @baud_rate: UART serial line rate (e.g., 115200 baud)
> + * @clk: reference to this device's clock
>   * @clk_notifier: clock rate change notifier for upstream clock changes
>   *
>   * Configuration data specific to this SiFive UART.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
