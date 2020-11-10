Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA12AD669
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgKJMfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbgKJMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:35:02 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB4C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:35:02 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p10so11808060ile.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ttz5t5j51iRjIDsR5m28r0Ff9+5ns+P1ADoP5uCgfc=;
        b=WTyCVr8qdCBQVbvaCZJmy34bMfLAycp40j6xqpPzsn6yAX38Ugc0kWyvvS0HThpZis
         IU2QS9HD7GDv2zDpGqOsOvbFRz+nfAjAZJ2qyKGeGdaneKI0dhuvdSdTcWxzNFI8yzoT
         3mt1wtvM2JAULAJPy4X66jon+K8UgrsF8wbxXkgn2smbUjRyu5x+oHWvwYPn8YrBF92l
         K/hfwko4k67Izv0LbZz920nzp4M3kMosOpJjMUD3DKxRV5QfAZ2TM+EGCgMor93IlDFD
         bHxi5xT4fEWLivYjHsy9o13zKuXd16AXewkUXBJnb6mYvl9NmvaCdEoU3VLnPewQXV1j
         weKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ttz5t5j51iRjIDsR5m28r0Ff9+5ns+P1ADoP5uCgfc=;
        b=P5W0dbgNVwAu8vfLQgLsnbXdnyYRNFectE2rqvhnZhx0Pd6bfZNGRX59R58nII30wz
         ODkU5qYnxSh8BK4i3As/g1GwnGKO6zC0lmscNEuUAtFevZ5PWGqxKJjNI411CCrfOwEY
         IrVUr5M9Ki0mZYN6b3nuhrysKvY2xIktOtAR5Ymm7GOWA4hmPL9Jj1i4L3a3e32+n8GS
         I/NHaMFJOp1Wrmqoh0Yhy42Db8Q86KWXe2HrDVyGoTd4eomaXjtnlchgqyqlwp10BVqM
         PH+Vski6rK38gJzt/oNWog/8KbSbLOgdUYRWtZDcmeZQJR8Vg/lUXliC9eBPSv1DQ5Tm
         wtcA==
X-Gm-Message-State: AOAM531m38Nxp4wtU9hqWbBoKY8HJtatTfzd2oIRtepSX39opW3R8ask
        V3es3lwHmnMOexj4NfN2RXI3Rlo+XMnbpJcq256WZQ==
X-Google-Smtp-Source: ABdhPJx80UKV42wpmTkABAfWY6rZXe0oFpSgm6r+LzGLSTxbq1RkZIMvigdNQ1/t69agkkpUdI02jGK5IZNb1Iku0cQ=
X-Received: by 2002:a92:d4cc:: with SMTP id o12mr11233176ilm.6.1605011701813;
 Tue, 10 Nov 2020 04:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20201110123342.3166-1-brgl@bgdev.pl>
In-Reply-To: <20201110123342.3166-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Nov 2020 13:34:51 +0100
Message-ID: <CAMRc=McTOeip_TkmO8VpNfGkk8cpJW9x2WLSZYrU1Bn7EW09kA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] gpio: exar: refactor the driver
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 1:33 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I just wanted to convert the driver to using simpler IDA API but ended up
> quickly converting it to using regmap. Unfortunately I don't have the HW
> to test it so marking the patches that introduce functional change as RFT
> and Cc'ing the original author.
>
> v1 -> v2:
> - add new regmap helper: regmap_assign_bits()
> - fix lvl vs sel register access
> - set value in direction_output callback
>
> v2 -> v3:
> - drop the regmap helper from series
>
> Note: I didn't use the fancy method of offset calculation Andy and David
> suggested because this series broke the driver according to Jan - let's
> get it right before we modify it any more. I found a couple problems that
> could maybe cause the crash. Jan: could you give it another spin?
>
> Bartosz Golaszewski (7):
>   gpio: exar: add a newline after the copyright notice
>   gpio: exar: include idr.h
>   gpio: exar: switch to a simpler IDA interface
>   gpio: exar: use a helper variable for &pdev->dev
>   gpio: exar: unduplicate address and offset computation
>   gpio: exar: switch to using regmap
>   gpio: exar: use devm action for freeing the IDA and drop remove()
>
>  drivers/gpio/Kconfig     |   1 +
>  drivers/gpio/gpio-exar.c | 154 +++++++++++++++++++--------------------
>  2 files changed, 77 insertions(+), 78 deletions(-)
>
> --
> 2.29.1
>

Sorry for the noise, I noticed that I included Mark again when I
started sending this series.

Bartosz
