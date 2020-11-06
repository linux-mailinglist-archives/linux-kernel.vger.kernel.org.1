Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264312A936C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKFJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgKFJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:52:40 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1308D20A8B;
        Fri,  6 Nov 2020 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604656359;
        bh=gzACgnfSkG0LSUDd58iI/0YMXdWp4kOzDXiq7luegZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gK9qnRsybkfWNB/IsD2Qnr+tsybVobAY+dujYZU52qtS5swjh1Cqf6R12ez/mmE8x
         12uJaecK4GXKpUpejcB4vNMmX5JDtMcxfWDHHTAJCdxhx81u/FeIs69jwu+vez9+EJ
         suhiQPQjfqulCbRv+vua5dS5vL8dRqCxm3XMxFow=
Date:   Fri, 6 Nov 2020 10:53:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106095326.GA2652562@kroah.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104193549.4026187-14-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
>  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Mike Hudson <Exoray@isys.ca>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

And now I get build errors of:
	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
	make: *** [Makefile:1164: vmlinux] Error 1

Always test-build your patches, perhaps W=1 was wrong here...

thanks,

greg k-h
