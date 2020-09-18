Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A326FB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIRLQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgIRLQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:16:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C6D21D42;
        Fri, 18 Sep 2020 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600427798;
        bh=/trmjTSDzEldFLahTa6wXbQQnt3+yLKlT199IEmqxEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvvgHWuqDTM0kwxTIjkdN8BFLxw5uQXVQi8r6YPxmozIQAvvQ0d3jfzRxHxZiMV9a
         pzkmW+QUyrXQqDCiYDWlrJg9l9WaoVUtzvZBXQ2zwbzY6S9CDjAGaqIKDKCfHdzHWr
         v4TWaXdZzdMdSnwULlUT8OlFCB5XLkxDAS1O+ml0=
Date:   Fri, 18 Sep 2020 13:17:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty: hvc: fix link error with
 CONFIG_SERIAL_CORE_CONSOLE=n
Message-ID: <20200918111708.GC2242974@kroah.com>
References: <20200918092030.3855438-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918092030.3855438-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 05:20:30PM +0800, Yang Yingliang wrote:
> Fix the link error by selecting SERIAL_CORE_CONSOLE.
> 
> aarch64-linux-gnu-ld: drivers/tty/hvc/hvc_dcc.o: in function `dcc_early_write':
> hvc_dcc.c:(.text+0x164): undefined reference to `uart_console_write'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tty/hvc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index d1b27b0522a3..8d60e0ff67b4 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -81,6 +81,7 @@ config HVC_DCC
>  	bool "ARM JTAG DCC console"
>  	depends on ARM || ARM64
>  	select HVC_DRIVER
> +	select SERIAL_CORE_CONSOLE
>  	help
>  	  This console uses the JTAG DCC on ARM to create a console under the HVC
>  	  driver. This console is used through a JTAG only on ARM. If you don't have
> -- 
> 2.25.1
> 

Same question here, what caused this problem to happen?

thanks,

greg k-h
