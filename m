Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBCF2EEF15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhAHJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbhAHJEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:04:22 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2062C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 01:03:41 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j12so9025144ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Vdt966ZQ+bhnlfBJJTQZef6ngeUx7tP6w5riL86+M8=;
        b=X0dLTcNKymzgCBzMaRSOBtI+U2p3V3K3/ehfN+azQEBhATiIGQti2npPvJGvOoL+DC
         9F0+yjCFfl7/VSDY6CllDykE21frhSmSj5fOyIZZv7bJpcqw09MxD01aowyNMsw2KtcP
         jwA0zGhsFFt9aeU7UgUPNowfxCDAZYDmBekyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Vdt966ZQ+bhnlfBJJTQZef6ngeUx7tP6w5riL86+M8=;
        b=iSPdxtbsq8VRIhB7+X+iyM0BkWAKEVxTFv/yOaJNI+RLrnLZR30OabgzigRztvNw0V
         vHNjTe2Yh1uprECnnoJbjiAzFj88TQ+eMtp7wWIDRe/WkSO1Wl3Tg2Agsx4MC9Ltgfh8
         csqT57Z/7RepLX9YBw1DIa1YgNzTGPrVrHhueXQm+pk5i/CP3/Ktx+TY/d2DqQT9xc04
         aW4nHWbOn/LbEmZchHZEWb3w6pWd81IkqHIiRwtrJhM7omkQ1ioqf7qGdQ8yG9h+iU+p
         9TfIOOmT0bFw3B6S5YdypL1Z0WiQTdjkG2UYtj4lXMLsdM6CpoY0lk8jkmWG4V9namYp
         e4IQ==
X-Gm-Message-State: AOAM531EVRcc39QLJRmZiwiC8h+n0fuPmQfPXDH5slE4zdhH4J5R7tHg
        Bm43Nil70mbbK3G8Zs5k5KFyWd5R7rvWRPmmEDQhWA==
X-Google-Smtp-Source: ABdhPJzLB5NlYV45pIJuUMVagY3L6xMxbUFIq2s+ZNpP1onBVgqJSX6FdxQ7mdxdsTZ9Lnv8pd7hqCa1JK4jWk9XWz4=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr1903105otb.281.1610096621321;
 Fri, 08 Jan 2021 01:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20210107140103.0cca6432@canb.auug.org.au> <e1042fe6-10e9-b62c-fae9-0d3b66e42866@infradead.org>
In-Reply-To: <e1042fe6-10e9-b62c-fae9-0d3b66e42866@infradead.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 8 Jan 2021 10:03:30 +0100
Message-ID: <CAKMK7uGP6tmmSx8jFcGK_kLDYQO6PBy-TYMEj=WWh5VRTJ7cFQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jan 7 (drivers/gpu/drm/imx/parallel-display.o)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 9:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/6/21 7:01 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20210106:
> >
>
> on x86_64:
>
> ld: drivers/gpu/drm/imx/parallel-display.o: in function `imx_pd_connector_get_modes':
> parallel-display.c:(.text+0x8d): undefined reference to `of_get_drm_display_mode'

Probably something in the pull from philipp that I just merged
yesterday. Philip, can you pls take care?
-Daniel

>
>
> Full randconfig file is attached.
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
