Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C21ADAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgDQKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbgDQKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:24:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B56C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:24:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so1492452ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6xh3Ld/pBCZAhJ90aiDZksEp/qEQMXBOJcsAfbBaK6Q=;
        b=giTjFL1BiCXWrEM5RhSWRQHK+eCIEd03IIa+pZLSNQ6mZ5hlVXL+3m9hNrY0Dh+d/U
         qzZG+Lfmrhxyx6obIpthYnt7Kp/Z+30Wk/pTkX8gr2I+715AtgWRPxE3gObmhY7Vts/I
         2FQOHSGb2Gk9aP+GdM73Q/sfvuBDHhl9P9Eg6hD3lJ1FKOOivu0vXsjd08zu7u7wQfFx
         WgbSi0FoHO8groeHDLrLrsZ89++T+6dwZzotBwa7uU+qgNuz5XwLb3yFZkSRUYqki2bq
         LXyRC5jDcaNGJ6Mgmr5craGz2R++HWjBAD9J0zvEPc4kcIOZ2rW1LFPr/hjZog3Na6a5
         1Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6xh3Ld/pBCZAhJ90aiDZksEp/qEQMXBOJcsAfbBaK6Q=;
        b=bz0K7sgaV6jU9dYgzYO8jbZSp8c0etQAtmjTWTZWJzVpMAtvHirRQcqEFaC8OPcree
         2e4XjvE9n3Qs+/nWaz/OgARwELDv2IcZjMozGxxJ7hBEmef7scnIpel9sl2kIGSpSDaM
         0mxk2Efwwqs9pIQWOWHiJoJjEai07olyGAM9mSzcUlSk43eKlLjavS3qlYUby6uFJa9R
         TMZ8kJs3aHLdmzwIxw8PKFzcHOr1QmuiQ+zOuHLXRGHVko8DJ5SdUm5UwIKyiWI6IniZ
         OlIffrR2dXI7GdrtMmRxq0y38ei1GcbkJzYsBIFGmu5hdzztxpKHv3RGW0SJmDEBd6r3
         XDxg==
X-Gm-Message-State: AGi0PuaLkoMsb+tKSeHP/UVLrHZXHdUHjveF6RkJuA2KRIfNGaeYDjrp
        9KNhXNqKJSp/ynKdl8T0KUNT/3tAzba2ABn4pCtXTg==
X-Google-Smtp-Source: APiQypLMpKkzuNPY8HzZEB9HxFgfYPLTA1H77q6Vzn3sQ1X+S/jz3oLiktC6wGnFEluk6hq3vA9ZVhj1wuoaPBU6rrU=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr1569503ljd.99.1587119045618;
 Fri, 17 Apr 2020 03:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200417122758.54637c13@canb.auug.org.au>
In-Reply-To: <20200417122758.54637c13@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Apr 2020 12:23:54 +0200
Message-ID: <CACRpkdbfuFbu4POkNG+jm6eGwqJbT+G=xEGUL=snnM1KNfA9Kw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 4:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:

> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pinctrl-mcp=
23s08.o
> see include/linux/module.h for more information
>
> Introduced by commit
>
>   0f04a81784fe ("pinctrl: mcp23s08: Split to three parts: core, I=C2=B2C,=
 SPI")

Thanks I got a patch to fix it up and applied.

Yours,
Linus Walleij
