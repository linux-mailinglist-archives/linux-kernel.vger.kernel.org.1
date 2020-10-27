Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B274A29A9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898693AbgJ0KlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:41:18 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:47073 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898664AbgJ0Kkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:40:49 -0400
Received: by mail-ej1-f65.google.com with SMTP id t25so1459036ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTxMRA4/c1G5gjulnxVBfnJK6XAxYI7ClJM6lo1HV0s=;
        b=qqiRWFU+UXC7Zw0SqnNgluYvZSaoqCUfaHtRq7Xma4zW6Pkovsz+14fGyz22X3w+Z4
         d/g7cvlGZ3ZE0hrfhKYmO+b+1VTYuFf/8qW858mqOzo7ILcN/nsEJfMG32SmavwJWj4+
         KrQOJoJrkFz8sMHM0pjWrfjecJxFa9/9YEjoL584XbLBVllpCdxMBhKswzMyCCaPtzfI
         D+x+POJj0RFMYDu14W9uVIoso4ckZSvDDZxgnXvTkeYxhLVYmOkm7w4sSfJels2LKhsN
         gcHgs5eIQ69tQQJ+yaly0nyQmECdEMp3gE48XrjP+guopMxRQJzhr9mSWt2Iw3Zcd/dx
         +cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTxMRA4/c1G5gjulnxVBfnJK6XAxYI7ClJM6lo1HV0s=;
        b=et0QS04VVbfgQjas09pA/57Vs8Zxwl7re08MansokMZsPET+8WS8NYEEFf4bglKnEV
         uJayQXjljBtTKulXZscLb1rEsvRwHgxKwMmg186tripnO4UnxvUix+vb+skK2xYECE9M
         j3E6kuRo13/wL0j8TZCW6f1VBlCU/gZZm0e64n6bPyi/ALvD6yjr9HZYhdX4z6Gph0zi
         h49AHlobjoDxw8wrAybZr7yzyFyXlQnO5PuX4qUHT2jcfHRh/x15vY9YHgsEdGb9M1wr
         BdAFIoQCHnRpnggz7HCIcfgGuyU1KWqC6H4wcTKlrqESST6t9SmZEWxu38uLLjpmQiTG
         +AEg==
X-Gm-Message-State: AOAM532Y8JMEuZK7cTdDl7V1QcYMtKFocMGKabpJc8wEbp1uvV6YMSdU
        /sFzZTXvVAfIEy2BKuLk0hsKzGqksuOfe1q4xalfjA==
X-Google-Smtp-Source: ABdhPJzeY90F2ZT44I1CsbyMJrlcyjfgRa7+QDxzsQKMQ0nX22n4K2iNKsRhc4EwRIy+/lSHaV6EkTIXK0h5XOWQI2I=
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr1708926eju.168.1603795247655;
 Tue, 27 Oct 2020 03:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-3-brgl@bgdev.pl>
 <CAHp75VfeBXszvhrz_YgtX6=HY=TJJXhWdTSTC1=S4UV2cOkJvA@mail.gmail.com>
 <CAMRc=Mf33JMNMT1vcrHx33QK7wj_gPY-CPaPUsqtON8X8S-JtQ@mail.gmail.com> <CAHp75Vf-z8yba-QX4G51PRkMV9VKAczd_79sma96zHRf+bMD2w@mail.gmail.com>
In-Reply-To: <CAHp75Vf-z8yba-QX4G51PRkMV9VKAczd_79sma96zHRf+bMD2w@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 27 Oct 2020 11:40:37 +0100
Message-ID: <CAMpxmJUPsz3o8pDAU9e5x1gD-yGf5Fym2DgYnfpCKEFTj9DSYw@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: xilinx: use devm_krealloc() instead of
 kfree() + kcalloc()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:29 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Oct 27, 2020 at 12:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Tue, Oct 27, 2020 at 10:33 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Mon, Oct 26, 2020 at 4:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > We now have devm_krealloc() in the kernel Use it indstead of calling
> > > > kfree() and kcalloc() separately.
> > >
> > > Which is completely lawful when size > previous_size (I mean, the
> > > additional patch you sent previously seems not related to this).
> > >
> >
> > Sure but devm_krealloc() is cleaner and adds the benefit of resource management.
>
> I meant devm_krealloc(). It should work in this case without your
> additional "fix" patch.
>

I know, this is why I sent the fix separately. The fix is still
correct on its own.

> > > > -       kfree(xadc->data);
> > > > -       xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
> > > > +       xadc->data = devm_krealloc(indio_dev->dev.parent, xadc->data,
> > > > +                                  n * sizeof(*xadc->data),
> > >
> > > I think you need to use something from overflow.h instead of explicit
> > > multiplication here.
> > >
> >
> > Or maybe add devm_krealloc_array() which would perform the checks
> > behind the scenes?
>
> Maybe. But what to do in the cases when you have struct with flexible
> arrays, like
> struct foo {
> ...
>  type bar[];
> };
>
> ?

Just use regular devm_krealloc() with struct_size()?

>
> And you do kzalloc(sizeof(foo)) followed by krealloc(). The above name
> (krealloc_array) may be a bit ambiguous.

But devm_krealloc_array() would only be useful for memory allocated by
kmalloc_array() or kcalloc(). I don't see what's your point.

Bartosz
