Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4197229A8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897263AbgJ0KFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:05:05 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34637 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897238AbgJ0KE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:04:57 -0400
Received: by mail-il1-f195.google.com with SMTP id v18so975506ilg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1DHuCLMehbCpMeVCXiA9IVd7bv7Jzb8nCFvlPiTlBI=;
        b=bPAQEkL551vUGzj7Vhpa0oB+ZaEBF1GHpc9HjvS3f5+TaI1F3RACJojIh7O712IQ0L
         4b/Oy8bEXirxPPxu+WRdI5uSCfz4K5UIg2WouLADsotYj4HJg3GiXsKtuF8lI8OV0qW6
         qHF0ZJIhsdNkwofVkFpz1ofbcmCPm/9PgPfVHWFfolvOVBmLAgLL/DILHNJ3mOvN9ySa
         EKyS1faIq5vNausUdfcdqDd2xlispV9lT6fpMqPjHSUgf6U3TPoOmkdOR+XGDiYEC+dY
         0rKb7sIUmvwsx5NbbP+Yvikc1sX5FHffVOuIbqBbHxUHeAfBvWPnxB+fmjRlZsql54am
         afNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1DHuCLMehbCpMeVCXiA9IVd7bv7Jzb8nCFvlPiTlBI=;
        b=Uc4eq2nRdvuIUF/QN9BgMZwVfU13j0fPxv9l1NYmOZ6/8GA8XaGyY7WqpqcnEpMA1D
         seO9faepXmTX23IRJ1d4e8nLpQs4EkVBDvTF8gE/92H302HukyxvcBWnSXIPjZMfRhS2
         9Yz+2DU/ELDXr6xaLzjEJ5UCpWPm5IRcyQKkwHyfxb35qeXJJNzL197418JODlT1IFHQ
         zDKEaJo9z+vPE/t6EnO6bxvAiSoOOx/mmJbTlfB7ybrybKAu6kuSqyywLbv8oenIjLgn
         nCuT6HimBN2jPkpqgdCrxaCw6w3lIH4vbu4SrJr6nh5sfzBt7U49AyWvfpGjLOSuw7Rk
         5OSg==
X-Gm-Message-State: AOAM530pLaooVMPAZUUpIKmXG5ZEqkE4St48IyFchmgSezpSaZb2xqK/
        4nnnSFlv82dlow9AsXBKcTxUO8QLrwHK91sqIGLDpQ==
X-Google-Smtp-Source: ABdhPJz/ArLXjB//BECT3UzjnxyAN8RdidHaZhBlxffudwlUO7/RkO6miNNpbYX5/hTmlm9rvycjKgq8YKa6k8tG+Ps=
X-Received: by 2002:a92:b610:: with SMTP id s16mr1201682ili.6.1603793094884;
 Tue, 27 Oct 2020 03:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-3-brgl@bgdev.pl>
 <CAHp75VfeBXszvhrz_YgtX6=HY=TJJXhWdTSTC1=S4UV2cOkJvA@mail.gmail.com>
In-Reply-To: <CAHp75VfeBXszvhrz_YgtX6=HY=TJJXhWdTSTC1=S4UV2cOkJvA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 27 Oct 2020 11:04:44 +0100
Message-ID: <CAMRc=Mf33JMNMT1vcrHx33QK7wj_gPY-CPaPUsqtON8X8S-JtQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: xilinx: use devm_krealloc() instead of
 kfree() + kcalloc()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:33 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Oct 26, 2020 at 4:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We now have devm_krealloc() in the kernel Use it indstead of calling
> > kfree() and kcalloc() separately.
>
> Which is completely lawful when size > previous_size (I mean, the
> additional patch you sent previously seems not related to this).
>

Sure but devm_krealloc() is cleaner and adds the benefit of resource management.

> > -       kfree(xadc->data);
> > -       xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
> > +       xadc->data = devm_krealloc(indio_dev->dev.parent, xadc->data,
> > +                                  n * sizeof(*xadc->data),
>
> I think you need to use something from overflow.h instead of explicit
> multiplication here.
>

Or maybe add devm_krealloc_array() which would perform the checks
behind the scenes?

> > +                                  GFP_KERNEL | __GFP_ZERO);
>
> --
> With Best Regards,
> Andy Shevchenko

Bartosz
