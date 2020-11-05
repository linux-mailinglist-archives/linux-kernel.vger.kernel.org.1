Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3A2A8257
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgKEPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbgKEPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:38:28 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:38:26 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so1535676qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oe4W/9IIStX5PS7df8SEBHKooPDTXbwCBDTfcyxclaE=;
        b=ibKi6Xco8MbXn0RJgBL8wrtu+4b1FSUNJKWqyMWfWNim4CmEOYuxl+56dpkCSXEp1F
         EKWCuq3aDu78RxAcJc5idAsuNU14Dpg2ZljVY1dm4WShBh7QxwRZAF9efcnsuNUTJlqm
         IbJOUdV5Td1YLwBQcBjIMGxJxu4n9gwVJgVYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oe4W/9IIStX5PS7df8SEBHKooPDTXbwCBDTfcyxclaE=;
        b=VysFUIj+WS6bG6Xzd64qJ3vsWpEBrM/WnNJhD9wwbovqmJkoamqpR9/fGmHzTSGRWj
         02y3OfgVXhAfNd7NeATJaueoRTBZDkP4iuUCxjao0wKkwDSPwPmgc8HJxmoZvOjs0iH4
         y6dwDutPVi4VOm91Lc5tg63TDY+mO5g6a1qJV3uPOCpGaMyDfdkuoj+sKLUYNq1bcJZK
         lCWToStVGopBGDUjwyMK9R4NEFIi9cde5jMiE3SU6xMkxJzjYt9BAP2v/niUSuXShumF
         WtWAGjjT1HDz2o+FiU3zm7Ljqj76mzTck3Vd1Bkp29EdfsCWXzcobQCshFSy9bSyUpiW
         1ScQ==
X-Gm-Message-State: AOAM530oGJUoSlJSXLK7NEnVSatCZFPBzBNJa9+YW/TkbfswgpQGwOxa
        J0sdTNoMLGxdhUQG6iYT8EcjVG6NtjG7RIvp1E0I6k94R95Y5Q==
X-Google-Smtp-Source: ABdhPJxqzr8GwXgp1slRIIYdEd3E4yBt6kDC1cbU1KcQVJm5YduAh2GloUcUEP6vdSccYfzmfa2M85AqTpiEECH58R8=
X-Received: by 2002:a05:620a:1024:: with SMTP id a4mr2677116qkk.390.1604590706076;
 Thu, 05 Nov 2020 07:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20201011024831.3868571-1-daniel@0x0f.com> <20201011024831.3868571-4-daniel@0x0f.com>
 <CACRpkdYmdZ81q_tsXRQ56aFjGsvV3AwJ8_hiu31mD14DGiK84A@mail.gmail.com>
 <CAFr9PXnX7QyM0VUmosFYueSe4ewA7uT2VZMfxFPaFt6-jUhoSw@mail.gmail.com>
 <CACRpkdbx+T3uX9taZNjsURHGc6qVLvGGC2boEC4=NaOi4_uZTQ@mail.gmail.com>
 <20201105093107.GB21245@1wt.eu> <CACRpkdbCB_n_jNJ+wqWWMKHG80du3kqya0vdOu41Cb4vdvOtyg@mail.gmail.com>
In-Reply-To: <CACRpkdbCB_n_jNJ+wqWWMKHG80du3kqya0vdOu41Cb4vdvOtyg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 6 Nov 2020 00:39:13 +0900
Message-ID: <CAFr9PXkZYL0arngaeLcKSjVum2d3ewDL8M66PfPdC5pXAtbuPQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: msc313: MStar MSC313 GPIO driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for all of the comments.

On Thu, 5 Nov 2020 at 18:42, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Nov 5, 2020 at 10:31 AM Willy Tarreau <w@1wt.eu> wrote:
> > On Thu, Nov 05, 2020 at 10:21:27AM +0100, Linus Walleij wrote:
>
> > > If your SoC is only used by OpenWrt (like ixp4xx) then it is fine
> > > to just use bool because that distribution is always built with an
> > > image for a specific hardware, whereas distributions are generic.
> >
.. snip ..
>> It's unlikely that we'll see very
> > generic distros there given the limited storage you'd typically have
> > in an SPI NOR (16-32 MB) and the small RAM (64MB) which tends to
> > discourage anyone from booting a regular distro over other storage
> > anyway.
> >
> > Thus my guess is that most users will keep building their own kernels.
> >
> > But this just emphasizes your points :-)
>
> I think that is a good argument to keep this as bool.

Thanks. I did change it to a tristate for v3 but I'll change it back.

Just a heads up:
There is another GPIO driver for this chip (same functionality,
totally different register layout for no reason) that'll look pretty
similar to this that'll follow soon.
It might be similar enough that people confuse the two series as the same thing.

Thanks,

Daniel
