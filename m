Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA542D8F11
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406510AbgLMRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 12:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392611AbgLMRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 12:24:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4EAC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=87mGaq6A/2oEflAS9WJMZOfYYxB6mcw5Ht+huFs8tKE=; b=vYNX3O9KkvGqgR6G0YKWCW7pCW
        UoSXOBpnw0NLVnY0A7PVX3XfT4YXpZZDMfD+4fgKw37k7scyG7BlRzqM2DQlY56UYX9mIvXqWoKHc
        pGyDPKGGcchOfSYBOstMybxrQwKk2qf28ku9He3Ryq5U8hlpgXqJEe5ofViUI5dj+uoSbvPgnk/P1
        Bg9qNU9LT+RrJj6j+YHaBc0uXkViwo0Rj+cCCv4xfynQZ5g+RRpsM88UbuVpSidJX6peXZMdYuVkk
        60iYoOgYO5Ji+U7mVnkb6Ww6Yqdp3JzzW3ojktQYY0iu7KgW1kupWDQCOYydQL63BF9EMzTZ9jMXR
        uI1GI9gA==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koV5L-0006zU-S3; Sun, 13 Dec 2020 17:23:04 +0000
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus variant
 for USB)
To:     eli.billauer@gmail.com, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org
References: <20201213170503.59017-1-eli.billauer@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c661c10e-fa21-d3e5-9d94-6f8f2d89f1d0@infradead.org>
Date:   Sun, 13 Dec 2020 09:22:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201213170503.59017-1-eli.billauer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/20 9:05 AM, eli.billauer@gmail.com wrote:
> diff --git a/drivers/char/xillybus/Kconfig b/drivers/char/xillybus/Kconfig
> index 130dbdce858f..18fa99ec1029 100644
> --- a/drivers/char/xillybus/Kconfig
> +++ b/drivers/char/xillybus/Kconfig
> @@ -32,3 +32,14 @@ config XILLYBUS_OF
>  	  system, say M.
>  
>  endif # if XILLYBUS
> +

Hi Eli,

You don't want this new part inside the "if XILLYBUS" block above?
IOW, XILLYUSB does not need XILLYBUS?

> +config XILLYUSB
> +	tristate "XillyUSB: Xillybus generic FPGA interface for USB"
> +	depends on USB
> +	select CRC32
> +	help
> +	  XillyUSB is the Xillybus variant which uses USB for communicating
> +	  with the FPGA.
> +
> +	  Set to M if you want Xillybus to use USB for communicating with
> +	  the FPGA.

thanks.
-- 
~Randy

