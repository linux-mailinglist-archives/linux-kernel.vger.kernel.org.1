Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D32C091C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbgKWNEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387604AbgKWMvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:51:18 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE0C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:51:16 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so17963274ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChGGp6ozLF8Hqqacc/T6RB3u8BJrScH/8AVJQ+SJlqc=;
        b=GQmvg0K83WBAgSVzaF5VAtfXr7EQ+BDfUtj6SK+fUpCnpwbNNHQUYIsmOVKpmvYRzq
         V8jgwfAcwElh6TmMc5cXC3anZmJ/tmxGBxCi4OyFTzN1Fvj6vhodrqFnC31G6TG7aWyU
         hoCnwnNzFdcmk9JoLcfDlUdNLwNrM/7emgYFB4F4iXjq7xdnzW6Ex444dC+SNs2k0tRE
         de5kjD/LMtm/LiJjWkJr3o0PAFcPTOZx+G51ZOu1aDAv0u2XC36NFBoBBshUrC1aaIa2
         mH8VZiF3i5CBF1WeoLIX2z9FFuLcvuYcTYSE0KSCTveQ50TkXaRrUKqWUSSfmq/D7uAt
         lGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChGGp6ozLF8Hqqacc/T6RB3u8BJrScH/8AVJQ+SJlqc=;
        b=g/DmNxBahtgw8U7ezxGGj9/VFpkz7gBSgg00SOUb/JD678OY5CzI6/NKs3NtBdq+7W
         KCp0nV+9plJupfRCA2Sv2jE0XH0f5z8RVUsiD8+Ke8QYaE3V6DQdMCuBccYQtUtjEST4
         BZ2ZLXUiijTmhw6LVCcZDPLbllHYuAVJONbz+Pzgyt3ViVVHtxSN1KmSM+eebroft9bU
         XlN5MCupuOEGGgcz7QNQ7H0WJGEuqUsqIqNvAc1gpcqyjP+7BKzi+LVgzN2rDnt4spZG
         bBszjpEH9Mao/UmgyN6wl9I5QI7PKGSEXDvm1mESh+K4at3raORmSk2mjEqtY2n8DeZ1
         K3CQ==
X-Gm-Message-State: AOAM532CLC6dtbf8DZXSJZAE5nxuGlyORvRQ3eJGetQkFYnFtotd9nWV
        v0pv/LKtKpaxXXqTZz+gtj1qnbrBq1vL+3gG/+6qBA==
X-Google-Smtp-Source: ABdhPJwjSDw9+c6uweVEjlqzf4HyZgrTBKpCxM706Ia1w1xFow0qSWfpDisGwGemBzV99rInzODBnf02oD9HTEO1vyk=
X-Received: by 2002:a05:6638:15a:: with SMTP id y26mr28570709jao.57.1606135876154;
 Mon, 23 Nov 2020 04:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20201116104242.19907-1-brgl@bgdev.pl> <CAMRc=Mdkr+65Nu7ddjtMHTbedpNf22w1bE97vipKSdXBYm8=fw@mail.gmail.com>
 <86bf5fda-eeb5-5cb2-901f-a887af7584f6@siemens.com> <4cf1dcf9-93b7-910c-005f-3bf316e0fb64@siemens.com>
In-Reply-To: <4cf1dcf9-93b7-910c-005f-3bf316e0fb64@siemens.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Nov 2020 13:51:05 +0100
Message-ID: <CAMRc=Me49Aoz1zVT-raQ8WyS5xhUTLC72J8+j+mTWJSFairU4Q@mail.gmail.com>
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

On Mon, Nov 23, 2020 at 1:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 23.11.20 12:58, Jan Kiszka wrote:
> > On 23.11.20 12:38, Bartosz Golaszewski wrote:
> >> On Mon, Nov 16, 2020 at 11:42 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>>
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> I just wanted to convert the driver to using simpler IDA API but ended up
> >>> quickly converting it to using regmap. Unfortunately I don't have the HW
> >>> to test it so marking the patches that introduce functional change as RFT
> >>> and Cc'ing the original author.
> >>>
> >>
> >> Hi Jan!
> >>
> >> Could you give this last version a final spin before I merge it?
> >>
> >
> > [   14.250117] exar_serial 0000:02:00.0: enabling device (0000 -> 0002)
> > [   14.336622] 0000:02:00.0: ttyS2 at MMIO 0x90000000 (irq = 44, base_baud = 7812500) is a XR17V35X
> > [   14.391588] 0000:02:00.0: ttyS3 at MMIO 0x90000400 (irq = 44, base_baud = 7812500) is a XR17V35X
> > [   19.250510] gpio_exar: probe of gpio_exar.1.auto failed with error -22
> >
> > That's "new"...
> >
>
> Bisected to "gpio: exar: switch to using regmap" again.
>

I'm not sure if you saw my email which I sent at the same time as you
- but does reverting reg_bits to 16 help?

Bart
