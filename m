Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF02A93A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKFKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgKFKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:05:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:05:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y12so687128wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DkOMBYzaOwwm2Jd4/IVOn7Fh7gujV7pgKKL98OyiWYQ=;
        b=SIg/BQUZz5FWQOLNcgKYKq8fHjskRqU7XPO/fP2fxTZwsuJh0ch/jlPnZ6hheJLqwy
         Dmm7yN3XvMGy9mu+m6z2DRvZU20NwkyGtgBCOa17nu3GzLrBmaTRokbGuH66HA2jBD/X
         fXD8ZnV8Y/YHMCsfiwBOvgtILfozV5Lc/m55z+af8AGZqsaZ8HyGT4SV69HblhlL0wmL
         6LjsSlf9OFJdEfYgGy7HB9iDaXvLtM06c2I5XP48pfEvrlUYU1Wch92TvZNof9cx3q/D
         7ySUv7YTWauTe6pud2LchDntLSP+sAfjtSmyS4CngaXzRFmJzCXofqjjQ9ROiZ32bNh9
         sqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DkOMBYzaOwwm2Jd4/IVOn7Fh7gujV7pgKKL98OyiWYQ=;
        b=AImxhg8BeG5aCdK+DrGuOhMvGZR5Lqq29FR7QmS/iiOwwrFsUiOuH8StgTqWvimRDW
         tWVQqpduQYK05EHAduSlti5CIkR03nv0lY9W6w4FzKXy2oa19b/rhFdsocZdsneBWlMB
         toShMKrpgT/Jzu2L4XMDMNwg+D3/nFU5pr6tBuBEagrAztOM9eDt1FG6b6QT+L2GCLs4
         THiNihwbEm4Jv/IsIjCmxfI6knD5PWIfcwR5sdjtf/mOFSdrF1wIsO3dQiE/epafgeIE
         EokTbOHBy1sdRTbGe7srRQVHzYa0GEhk173K9CPMkx3erOIHJn5yS6fWWLPuiuzJ8QOo
         u5ug==
X-Gm-Message-State: AOAM531n2Sokh3s7nEyI48z2qFcPmhc0ZD0+w7W/580tnV6l3A7UEBc9
        SKqK4q0zelsfvj+UyqvUQIvG8Q==
X-Google-Smtp-Source: ABdhPJwHj2fg//pEOyB/buDzK/+24CtEz7dehCHNHqpW2EFLPtIMEVfH+fNlHdz4nZTPs4eXP0yofw==
X-Received: by 2002:adf:f644:: with SMTP id x4mr1793072wrp.5.1604657155384;
        Fri, 06 Nov 2020 02:05:55 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id n9sm1542082wmd.4.2020.11.06.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:05:54 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:05:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106100552.GA2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106095326.GA2652562@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:

> On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Mike Hudson <Exoray@isys.ca>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> And now I get build errors of:
> 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> 	make: *** [Makefile:1164: vmlinux] Error 1
> 
> Always test-build your patches, perhaps W=1 was wrong here...

I *always* test build my sets before posting.

/investigating

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
