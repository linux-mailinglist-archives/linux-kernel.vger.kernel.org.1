Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1712A94A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKFKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgKFKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:47:38 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250AFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:47:38 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so804879wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IhVZ+A4KRiCIGihQBzTK1F+8fENwN5HNckjBAFh7pqI=;
        b=DwUmvJGplW4EPWDQioy7fIu9doWUiSY/xBgnmwppEIP0No0yjCLu10vgEANIxSVYap
         P0ktDMyQ2MXmkGh900IwzVJz7zPEXcUrkd9NY9jJeutd/xbER3R0NnBpxtxHQMh85Ogx
         vDg+Gs+DFln2l2/JrtpXnx16plEorpHB2gmZjeHSF4dAElsvb6OZ5ycIyeopzAFJHQxD
         bxiPuz0gNKsGHpzR734bPl8DvmVxk0PSUIHMzd1GVsOEZaESvxfOmeHbG/41Y3vB+lhA
         oK3vcdjPoQY4P6wrNz9seGG71pP+6JvYayffHU45/uE4vRt39XGqelFqaqvwPJaOam1M
         LPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IhVZ+A4KRiCIGihQBzTK1F+8fENwN5HNckjBAFh7pqI=;
        b=H1FgNYxx2Er0+O3ytdmnMH5QhYDIixbOQrJ6ZN4RTxhB9wdzKMt6arbIQ8WhJbYynW
         970fbmzNDSlmI43x6BZbbDPxCBwOr4djSM5Dk2693EXKJhsDV99KQJt2NbhKeB/CrBU/
         hrRfPFcRqbFUIxM0wZJG/rkgVMaT6UgG0s0YFxYLWiV00nv4apegDSTIWBufurQf+KG/
         a3dcaWhA5wXxgJbaN7P85bZoCnyAPeRl69QBNMn8KoyD7baZbZZraHGHG2Ii8TutdhJ1
         47LPimYD+W3/Ocp/VvuysCAHqk6bzwY2MxqSKpdUk94k4EEEo5LAF3bMgx9CaTtMq3yq
         Fwqw==
X-Gm-Message-State: AOAM532v0iQW00LlIZR0uy+U5CvtkPnu+6qL9bi+yXCcOeVA9dSgPZgk
        y6wDeGUEulnWGmP07n9MlncyZw==
X-Google-Smtp-Source: ABdhPJy6IpjXkjM3ZMpFCecKIt0/XxHTLVLjYnVCkfvXCmbagqwpuZnZ3hqoo8KpOOeCu9lixhuIYg==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr2090622wrp.210.1604659656817;
        Fri, 06 Nov 2020 02:47:36 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m1sm1653785wme.48.2020.11.06.02.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:47:36 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:47:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106104734.GD2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
 <20201106102030.GA2780243@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106102030.GA2780243@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:

> On Fri, Nov 06, 2020 at 10:05:52AM +0000, Lee Jones wrote:
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
> > > Always test-build your patches, perhaps W=1 was wrong here...
> > 
> > I *always* test build my sets before posting.
> 
> Great, then I should have rephrased it as:
> 	Always test-build your patches and fix the error found in them
> 	before sending.

Yes, very funny! ;)

Obviously, all of that was implied in my first reply.

The problem is not a lack of testing, it's the testing method.

I thought allmodconfig would be enough, but it appears not.

Currently investigating with allyesconfig as a drop-in replacement.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
