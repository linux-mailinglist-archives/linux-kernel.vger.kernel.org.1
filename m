Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE50727E561
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgI3Jkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgI3Jkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:40:35 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:40:33 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w1so1108224edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxwl6vJ7NlP3+dTWpMovM7e1DudeEOjt0JB5STP1e8w=;
        b=ZitIgb1o3RtIlUrhpJ50PCc/UK8UVLIRyv79th9TeWsA8csJknxt1K/sb9Ht6tYoTx
         BLtAWOb+pSfZDkg+9pRWdog0HwUnFm+uL/WMhoxcOffuEKjIbluG4WHAJ3qXvKiKzYIh
         3TJvXpz0sSfCNGC0TkdOtY5jd0duQ+r0RlVqXXG6P8EqcaezSN3KIIM9c8YfDK1MBaht
         do4yJAVcsApOJYZ5TBHdmoJJ3BXniQcBifxCWLVrb53mwJVQ5t67v0T6xkjsLw6FiBix
         xwHg9y1q51Hc41LthumOPD2TbOVFjIvYk+kgItPFb4RwJzD49bMDP83q1xfWheTB49EK
         aCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxwl6vJ7NlP3+dTWpMovM7e1DudeEOjt0JB5STP1e8w=;
        b=EigxQhmitHSKSdT348nax0i0GR19bAt0XnP21gzjyV/ukE1MmlyVAZFJ05BR3/oU1g
         J2Hl/6LHFwvVU38d3NZAojXnsr4PyW1n57i9cx02Rtl+4RcPazwo9c9Oj4BBotzF6Y18
         OdgdqC3PSp+FSxSjZYo46qI2DW9+hNaq8rRgmdiFhkfSbYgoykDjLyr7+5WgBs/2QWvc
         HHI1T6JxNBpJ3WYrryVQZHEaLHrt5XELIY/sCUaXjLawBMncuRNEk1efQbkUd/roKyA8
         H1koxBBZ7oLLAnFrLpIFnMxHpWmWvVFmdjUJOrHQ95VeQ0A8e8y6vVhNS+KMbGQkRIld
         Kbvw==
X-Gm-Message-State: AOAM530qSxUOMPq3WuUrG9Qz6/ZG8NMBcw38/roPDGhuyNEBR+CrX9+V
        NdjbOZ1EJUVG+vhpFKWyqJy69AxYgWUrRJIjX9fJyw==
X-Google-Smtp-Source: ABdhPJzwbGBzKP6VvMUQcxMG01XenJjUKeVs2qSsw3fsj4YoYAy9TZVtvNOrKyJwfTgT8Op4iITpLqXD7NLusQrUxfc=
X-Received: by 2002:a50:e442:: with SMTP id e2mr1802575edm.186.1601458832682;
 Wed, 30 Sep 2020 02:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200930092053.2114-1-mike.looijmans@topic.nl>
In-Reply-To: <20200930092053.2114-1-mike.looijmans@topic.nl>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 30 Sep 2020 11:40:22 +0200
Message-ID: <CAMpxmJVdRfJJ_Wvf-fVdpvbnEWvpOtiYhRwkoASZnvFAjTDmGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: pca953x: Add support for the
 NXP PCAL9554B/C
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:21 AM Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
> The NXP PCAL9554B is a variant of the PCA953x GPIO expander,
> with 8 GPIOs, latched interrupts and some advanced configuration
> options. The "C" version only differs in I2C address.
>
> This adds the entry to the devicetree bindings.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Split devicetree and code into separate patches
>
>  Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> index 3126c3817e2a..99dc1936f633 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> @@ -20,6 +20,7 @@ Required properties:
>         nxp,pcal6416
>         nxp,pcal6524
>         nxp,pcal9535
> +       nxp,pcal9554b
>         nxp,pcal9555a
>         maxim,max7310
>         maxim,max7312
> --
> 2.17.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
