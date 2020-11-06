Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC042A948E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKFKjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgKFKjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:39:11 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F31C20702;
        Fri,  6 Nov 2020 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604659148;
        bh=f1ZupIgT+0W8r2Fh/UDIIdQVJ33pvudtSun0lDLJ94k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PV5s4CRcGa+xOskrkM363gL5iQmV0vH8CZSTmB8CTlTI55h4rSuV12P18zt+LNS2a
         mZGoMlHsnQWPDVh8WUBkxu4nWIwXVVYYUsRQfF7BkcCYKYlcOIWEUgCqECIhJuphMf
         DrtZmnRwdm3AwqFIj42gqquLHJWful/ae8eyPpRc=
Date:   Fri, 6 Nov 2020 11:39:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106103955.GA2784089@kroah.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
 <20201106101646.GB2063125@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106101646.GB2063125@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:16:46AM +0000, Lee Jones wrote:
> On Fri, 06 Nov 2020, Lee Jones wrote:
> 
> > On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> > 
> > > On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> > > >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > > > 
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > Cc: Mike Hudson <Exoray@isys.ca>
> > > > Cc: linux-serial@vger.kernel.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > And now I get build errors of:
> > > 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> > > 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> > > 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> > > 	make: *** [Makefile:1164: vmlinux] Error 1
> > > 
> > 
> > I *always* test build my sets before posting.
> > 
> > /investigating
> 
> What config failed for you?
> 
> It looks as though SERIAL_8250_CONSOLE is a bool and doesn't appear to
> be compiled with allmodconfig builds for any architecture that I test
> against (Arm, Arm64, MIPS, PPC, x86).

I build on x86, and here's what I have set:

CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_RUNTIME_UARTS=8
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_UNIPHIER=m
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_TEGRA=m


