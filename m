Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66002A94A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKFKsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:48:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:48:14 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id n15so835414wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E+sHSfYLgGCrU6540dFl7iBG0+doL0klBJDgQA8Ntl4=;
        b=QN+2dnpswsMcm47QsKMnqXTOzqPxgrEdjed1jz7ldNxmVZo2fKB6jTwc48zMh9hWPE
         xWYYiviApNLTDy5hJp4wWNAoXbmA/HWwJx/opS8m2JG+ANdCM/gSsZ3dyj6ZQ74/Q47b
         CXhQjeFbyzLeWYA9NGj3l9g/qAdP2dvEjSbkKUpcTrz4Ak1ldaIpe7wm9QsUpJ2dxO/r
         kVqUqEPk/pVUHz6utcGk30kiCrreWmmAfnxV7mitLgiRmn1T7j5zt0Ez6bX6LEf8pOGy
         wn8SOyjG7Y6jSMeXKJxYFBwiKrozygFOnRl9769bpl8B0ZBeX8QAgPwUOqVibgleNFZK
         FeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E+sHSfYLgGCrU6540dFl7iBG0+doL0klBJDgQA8Ntl4=;
        b=ELVBtPioOJ5M8SDzM/+veo4gEwkLMQLWZebQzMCPoA/4e0BxBzzJztbofshxKAkqXt
         WzP74X/1XYkBQaSWdZMZuzazyXE0m8VVpwu4YuCytfG1DAmzcM9U3a3Lnett3iGpDOpE
         974GsJMqYXEi6QqHWDKQKpXDNJ7j5nk6MKKd/SP6BT7BZEBT7vksST0Soj10mPxQ/DoF
         0lx7imKreCpLbDW8uyf+mYOz7z+pyIzLvoKKVGf5nrwuqH5utqufUz9Fd+M9xiB8+mt6
         I7zuHcGNGHewKcNhqv9dDxrGCP3s/Su1KZhEPX8QuLDnBceHDwRmmjrWrjPitGAlDVI9
         sZ9w==
X-Gm-Message-State: AOAM533DW0k24hSmb2witrQ6lgYQBN/UFvsKXfZeTPt1aSaBkTIeiETQ
        y0QqCsQdlSesPvkKb1DEYx/LGQ==
X-Google-Smtp-Source: ABdhPJz82Le377x8YfoEtGnZ9L4NvK/u3Kb65oKpVkyrB1p0Clc4jETV4BBQzIvRKM7f91zqRl42eQ==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr1945741wrn.253.1604659692918;
        Fri, 06 Nov 2020 02:48:12 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v67sm1774369wma.17.2020.11.06.02.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:48:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:48:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106104810.GE2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
 <20201106101646.GB2063125@dell>
 <20201106103955.GA2784089@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106103955.GA2784089@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:

> On Fri, Nov 06, 2020 at 10:16:46AM +0000, Lee Jones wrote:
> > On Fri, 06 Nov 2020, Lee Jones wrote:
> > 
> > > On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> > > 
> > > > On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> > > > >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > > > > 
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > Cc: Mike Hudson <Exoray@isys.ca>
> > > > > Cc: linux-serial@vger.kernel.org
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > And now I get build errors of:
> > > > 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> > > > 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> > > > 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> > > > 	make: *** [Makefile:1164: vmlinux] Error 1
> > > > 
> > > 
> > > I *always* test build my sets before posting.
> > > 
> > > /investigating
> > 
> > What config failed for you?
> > 
> > It looks as though SERIAL_8250_CONSOLE is a bool and doesn't appear to
> > be compiled with allmodconfig builds for any architecture that I test
> > against (Arm, Arm64, MIPS, PPC, x86).
> 
> I build on x86, and here's what I have set:
> 
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_16550A_VARIANTS=y
> CONFIG_SERIAL_8250_FINTEK=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=16
> CONFIG_SERIAL_8250_RUNTIME_UARTS=8
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_RSA is not set
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=m
> CONFIG_SERIAL_8250_RT288X=y
> CONFIG_SERIAL_8250_UNIPHIER=m
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_8250_TEGRA=m

Is that from the default defconfig?  Or something bespoke?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
