Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16B42C0540
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgKWMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKWMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:12:50 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC41C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:12:50 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y9so15694497ilb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mT73mHLMFDJTr2xDUrC331kznaIqsGdNipkLA/0W3mE=;
        b=mCdlxOWZqqLAx33f0h9WJ6ssN2ioRqp6uQsDc9bGOhtGXmjX18O5hFeVTML4U1BCbQ
         pZM8BHQxIf5PzzN2mqChV+vb58KSJ6hFkp2ZNXZR4YHkfWeSmouWI9gbLFnptNqjSVaC
         z7R0RFvQdfrEVpSiRvLKh7RJfGujrd2SoNO8Nqcv25kigYXLJBoqazX8jkq6XHcRPqtI
         UXN8tP54k9jz6kNO7G4rE0RbabMFuLJ2Skp+S78/bkU1IIySy7yL0I5R5zyuFYy6/WK8
         JJQqiKa0D8UnPaLMFtPV7JuY7242r7tZk7qLyOb2GFjVkT2t6gxot26GFgRTsfdSo4Z5
         pA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mT73mHLMFDJTr2xDUrC331kznaIqsGdNipkLA/0W3mE=;
        b=Ui8NHEDuIadL7oYffK3f16cmr3lxQ90wN4qzNv5FcvOpDZxV7KxSjgh97jtQqfkLAB
         qPA3Im5e8L5pBhZZ9zHulUZERhnb0ndpTUs8Pa3YezJFl/jpyu/McvmEsajxz6HukM6g
         T2mEWxYdB+dhtshq+xoc9cwllK+yQdVDeDc1EPzszOMP2TZA+kwjTBBjow3r//VNSAcn
         SZGcjwwkLrB2H/+C5TG+yT6GuWldkh7sjnpg/Pp7Ht8ZpS+dxqQyLv3zhfl6LB4BKoZr
         T7VQDmP76kyyCBlLOVzRPfFWlMx/ZwmhVDiU0dGWPhxlWDokyWBiHirroVuGu6B3/oTf
         ZQtQ==
X-Gm-Message-State: AOAM530MKsEAmMQ8IO2AOPkwOnLUUkt2v1zkabg+VZQiQ/wGgSZPCdOv
        3iLGB/e/nnMai312iXWCvCZJ+fcIxBHbnxdZfpT5AA==
X-Google-Smtp-Source: ABdhPJwbGT6Dzol7svQNlmZu1OGWE2QGcC9NBstXoY0Iy6JPXgg0tLpGvP8VWT7fXPaJ+GurG+bXMpFqZ96vAV5jTnw=
X-Received: by 2002:a05:6e02:ca5:: with SMTP id 5mr8735808ilg.40.1606133570262;
 Mon, 23 Nov 2020 04:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20201116104242.19907-1-brgl@bgdev.pl> <CAMRc=Mdkr+65Nu7ddjtMHTbedpNf22w1bE97vipKSdXBYm8=fw@mail.gmail.com>
 <86bf5fda-eeb5-5cb2-901f-a887af7584f6@siemens.com>
In-Reply-To: <86bf5fda-eeb5-5cb2-901f-a887af7584f6@siemens.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Nov 2020 13:12:39 +0100
Message-ID: <CAMRc=MeayB1-hUiNUgKoG5v+CFt-Kxx88s+b-12iZDBfMjvttw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] gpio: exar: refactor the driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!On Mon, Nov 23, 2020 at 1:03 PM Jan Kiszka
<jan.kiszka@siemens.com> wrote:
>
> On 23.11.20 12:38, Bartosz Golaszewski wrote:
> > On Mon, Nov 16, 2020 at 11:42 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> I just wanted to convert the driver to using simpler IDA API but ended up
> >> quickly converting it to using regmap. Unfortunately I don't have the HW
> >> to test it so marking the patches that introduce functional change as RFT
> >> and Cc'ing the original author.
> >>
> >
> > Hi Jan!
> >
> > Could you give this last version a final spin before I merge it?
> >
>
> [   14.250117] exar_serial 0000:02:00.0: enabling device (0000 -> 0002)
> [   14.336622] 0000:02:00.0: ttyS2 at MMIO 0x90000000 (irq = 44, base_baud = 7812500) is a XR17V35X
> [   14.391588] 0000:02:00.0: ttyS3 at MMIO 0x90000400 (irq = 44, base_baud = 7812500) is a XR17V35X
> [   19.250510] gpio_exar: probe of gpio_exar.1.auto failed with error -22
>
> That's "new"...
>

And if you change reg_bits from 11 to 16?

Bartosz
