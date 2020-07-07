Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6951B216857
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGGI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:26:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E207C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:26:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so32916926wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qBb3tk+qoeCqQNbIgsA1YmfvrIH4bftpey+P/QTf7zU=;
        b=PaXUAVur/LkNIIW4gTLWzRAfCMGt4wNA3wl7zLKlKGszofmFes4VRd71LrL54Zy+dv
         12Iu2sBGHK8msYfxPRn42uhZSwljXB2iVp0h55LeZLJLJf0mUG+vJ75Hi+R/AgU3S2pO
         igIovoWYwgP2LEPD5jKj4nKc9e3dTr/LUzMbjEJuTgtq2r4emkA7IM+GUM5eK/C9pmuP
         Ad1g+qf7IluAps2x+j5KiK1MNTzL28VnFaS9zfYaIBrKljP9JiKlPx3mYtRgilhw5USS
         AlgC0z9bRI6dGzw8wBwGNp2VlEwvNGzJUdV/SMTqmC90z3BY5ttiCmMwhkmcrQiPKpyz
         TzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qBb3tk+qoeCqQNbIgsA1YmfvrIH4bftpey+P/QTf7zU=;
        b=EaI5Ca+3ZIszFkkBMZqgZKTEsc8Hn5YsU7ErgNMPOD2bfIuy/DyOnbIs8+C8YX6ypu
         /HEVHs8FReT+izktKiE2y+0nsyGSq1pBAHeYKJ+yqOOWhSyDK+RLc2MHn29Jgidwc0NM
         eiVFLPJSEyrNm0rOXBlqUaYc8rBxYpBr231IZvGu/lA1UjD93Zi9WN9wHo+x2mwYxcD/
         BetG2veDcVGmYZFOXrNFUFRP6MqSzSnjb/SZnSt7q47aRj4O9Hl9Easc4IjG5QYIl9AP
         pydMCgqxDHBxUA6QV8qwFBPHmssAxey+f/736M7OIP/gyBJNYUcWgiWJFbesjmTde+J5
         wwkg==
X-Gm-Message-State: AOAM5327ujNrHAilef1HoRPGI8VkW4QSDojI8WZReaLErGlLwRyVMX8C
        zmFWF2zEFIMSO2R5hxr0kWyP5Q==
X-Google-Smtp-Source: ABdhPJxbXSBlQu+qcdR3pRtsP8xOQVgZTwMm3v38IA/dY0vx6B6HIdI+D2MPASrH+jGIIU4XWr3rCQ==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr51931970wrj.273.1594110400958;
        Tue, 07 Jul 2020 01:26:40 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id 207sm66552wme.13.2020.07.07.01.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:26:40 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:26:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/1] crypto: ux500: hash: Add namespacing to hash_init()
Message-ID: <20200707082638.GF3500@dell>
References: <20200629123003.1014387-1-lee.jones@linaro.org>
 <20200630041029.GA20892@gondor.apana.org.au>
 <20200630070727.GD1179328@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630070727.GD1179328@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Lee Jones wrote:
> On Tue, 30 Jun 2020, Herbert Xu wrote:
> > On Mon, Jun 29, 2020 at 01:30:03PM +0100, Lee Jones wrote:
> > > A recent change to the Regulator consumer API (which this driver
> > > utilises) add prototypes for the some suspend functions.  These
> > > functions require including header file include/linux/suspend.h.
> > > 
> > > The following tree of includes affecting this driver will be
> > > present:
> > > 
> > >    In file included from include/linux/elevator.h:6,
> > >                     from include/linux/blkdev.h:288,
> > >                     from include/linux/blk-cgroup.h:23,
> > >                     from include/linux/writeback.h:14,
> > >                     from include/linux/memcontrol.h:22,
> > >                     from include/linux/swap.h:9,
> > >                     from include/linux/suspend.h:5,
> > >                     from include/linux/regulator/consumer.h:35,
> > >                     from drivers/crypto/ux500/hash/hash_core.c:28:
> > > 
> > > include/linux/elevator.h pulls in include/linux/hashtable.h which
> > > contains its own version of hash_init().  This confuses the build
> > > system and results in the following error (amongst others):
> > > 
> > >  drivers/crypto/ux500/hash/hash_core.c:1362:19: error: passing argument 1 of '__hash_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
> > >  1362 |  return hash_init(req);
> > > 
> > > Fix this by namespacing the local hash_init() such that the
> > > source of confusion is removed.
> > > 
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Cc: linux-crypto@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > > 
> > > Ideally this should go into v5.8's -rcs else it runs the risk of
> > > breaking when Linus pulls everything in for v5.9-rc1.
> 
> [...]
> 
> > I have no objections to this patch.  However, I'd rather put
> > it on a topic branch which you could pull rather than pushing
> > it into 5.8 straight away.
> 
> An immutable branch sounds like a sensible solution.  Thanks.

Any movement on this Herbert?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
