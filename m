Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCB2C86CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgK3ObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgK3ObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:31:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7934C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:30:33 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z14so11427532ilm.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFj5hEo3uguu+PFu88I1aR5fk0AAELT3WI/h/MW8bA8=;
        b=KZe3D3zmWym8lwghcNXEBHILxdmvBpCLGkMnuXfpDRiOpXotYj5k7sIonMk3BPjhuP
         OGSyNW/MN68Y1ss/r3v+7lkuJzUpQuX0imwUTWzhO1iV/gi9nLxN4LLcKvKNRboqMQHd
         1h9lESRaDdfXniNncrk+ityEgDW1XTK68kcA38ABIlMW/IE9f3hBsoS3w4VKkFFyydnG
         oqtsCnHOpJWtU482QmQb3Wa449+TsJF1r5ka3fE7GsMclO19SfBo1zVkuflBN3M8VthY
         iUMYgEEGhRv5GCsYfmot5LCLbATRxahXXWdeB59JhHJ8CMmbGMwkubqetzsZ3s4oNdIv
         ZoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFj5hEo3uguu+PFu88I1aR5fk0AAELT3WI/h/MW8bA8=;
        b=twGj1E9R7+/2y3bss6ll8aJtabHS29i8LNtjjJOXf/evmUSSG7iLS/gvX/pvExVb+Q
         0fhEpuDqzBNjsk2bqUk24ophnzAbTHbs06cDF3HmBNeP/jrd+R9+2MB5mrlmudqVRmae
         x5z9eembFDPRlI+ka5b2OJ4xt66eWNUS38vUJEEme0hjLENeYObVVLOsG0MBfNe/XQLv
         tNG1OcBwyin3XBQ6HyrRwmke9oHYmVlAfgJthCfuT/ahy1yuJ6c1hSe4HO9vGblMnoP6
         LPjraw4RjxhQ98m1j5VaWkkFojT2XEkNz8gTNxHpPr917VN4fZQoqiE6GhYDusT+6OMj
         0yzw==
X-Gm-Message-State: AOAM5310+Gf/dfk/29pgqVZMWEqoq4DgWBMDoxYvwOTjpjG2SpyarqlS
        eH5zkp5ytJRs0Hf6Lrl0gJm70IO6TMze8nDsQtDmXQ==
X-Google-Smtp-Source: ABdhPJy5qhwenvaj2uhWf6lfxNvD6HfnkcG0xYVSqpFWzjRhrZj11S/tvSsGkTW8oTnBVl3cEQ78Bmtoec5qtjf+Nlc=
X-Received: by 2002:a05:6e02:ca5:: with SMTP id 5mr19158887ilg.40.1606746633157;
 Mon, 30 Nov 2020 06:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20201130142759.28216-1-brgl@bgdev.pl> <20201130142759.28216-4-brgl@bgdev.pl>
In-Reply-To: <20201130142759.28216-4-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 30 Nov 2020 15:30:22 +0100
Message-ID: <CAMRc=Mcbzpw4o28NA-19dtWzwQz-DUYocNrD+0_RqRkCVq=PiQ@mail.gmail.com>
Subject: Re: [PATH v3 3/3] iio: adc: xilinx: use more devres helpers and
 remove remove()
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:28 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> In order to simplify resource management and error paths in probe() and
> entirely drop the remove() callback - use devres helpers wherever
> possible. Define devm actions for cancelling the delayed work and
> disabling the clock.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

[snip]

>
>         /* Set thresholds to min/max */
>         for (i = 0; i < 16; i++) {
> @@ -1334,59 +1353,23 @@ static int xadc_probe(struct platform_device *pdev)
>                 ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
>                         xadc->threshold[i]);
>                 if (ret)
> -                       goto err_free_irq;
> +                       return ret;
>         }
>
>         /* Go to non-buffered mode */
>         xadc_postdisable(indio_dev);
>
> -       ret = iio_device_register(indio_dev);
> +       ret = devm_iio_device_register(dev, indio_dev);
>         if (ret)
> -               goto err_free_irq;
> +               return ret;
>
>         platform_set_drvdata(pdev, indio_dev);
>

Cr*p I was supposed to drop this line...

Jonathan: can you drop it when applying?

Bartosz

[snip]
