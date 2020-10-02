Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0907F281694
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbgJBP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:28:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D5C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 08:28:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so2529456ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLBFqOLPIIeVNrecDqmKe5pDCo6M469dtuJMB6uozXY=;
        b=1VfqE7IhuhjWt2NxSpY15JryJ4J2/wHwj6pro6Ab90rqqm8/jnAVHYuhYtDTCzQj27
         qCVkiPCKG0thGXfpo43leTkloWXb4f+aSyC/GcOJlqBMlYqh+AGg849MK067CQU5ldCf
         y7tpVFmABANjpGYnFo5WLqmYQ41qC+ME8ppKzuX3BRgQSNWxZ0GJ9CEMFB40/B1wXST9
         n23jsNHX38mqMVu5SbLFKT0BduDAckW26cEGXunyhSdVex7tpB2jYLTevLOdJEkx6aFp
         ZszJ9hK9yZsFo8UmiOMKW5ggGe40u1a3gIBFv2GPKBSZ3yIKQdfnYDCIHMrxaA9ZVlK3
         xXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLBFqOLPIIeVNrecDqmKe5pDCo6M469dtuJMB6uozXY=;
        b=K5mty3CJxn5TFAKeXIWcQWesQkXNd/zanYvoyBzaN+RDDYsodIkmYa3gnS2c+2kGF/
         FMkgSNW+cpAJuBvKRhy1IXiIwP4DnOUFoUJMYmATKPZu3cYnlocEbo39JluahqEkkE+i
         fN16VYhQxTjEx3oNfJOrpjrDZIdVZWzEICXciCkAqtOA7CgpoYL+lKmPFf7qE5dsKwu+
         qL9oUXy/uvLQqKYh6dYY5Q1yaEd2wN9oCbRH2z13ICOTmOBjhhQ4lw1LoF8XbpSGolRV
         0Wr2xUnIP1r15AbskTwd0RVAsL4pclHPtw2GUE62ZhyHO/N1Y6Yw3nbF263LqqPP8tX8
         tkGw==
X-Gm-Message-State: AOAM532Cg0vWUzIT65RMj/v+AOSP0bK+n1uH32Jl2TkfBwRm9vN4Y6FR
        cg5FtUkZaPu7ayzb6cYcJMWf7BwyoU2NdHkpgWxRmw==
X-Google-Smtp-Source: ABdhPJyvVLldlJNq+Qx04LRovUfTW9uBVrkIrXj2nd3NucyIIBNdVg8NpMeAvgfX8qFLTRRUYxH+2khsTnKfRz5NXLI=
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr2948371ejb.155.1601652496574;
 Fri, 02 Oct 2020 08:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601616399.git.mchehab+huawei@kernel.org> <bad4d85c218d59c1bf69157df8e1012577680d88.1601616399.git.mchehab+huawei@kernel.org>
In-Reply-To: <bad4d85c218d59c1bf69157df8e1012577680d88.1601616399.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 2 Oct 2020 17:28:05 +0200
Message-ID: <CAMpxmJV8jkktBuHB=1r=twm2QhxT+DaB0DaCJ=0A3sBi2huQgg@mail.gmail.com>
Subject: Re: [PATCH 6/6] docs: gpio: add a new document to its index.rst
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 7:49 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> There's now a new ReST file. Add it to the index.rst file.
>
> Fixes: ce7a2f77f976 ("docs: gpio: Add GPIO Aggregator documentation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/gpio/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
> index ef2838638e96..7db367572f30 100644
> --- a/Documentation/admin-guide/gpio/index.rst
> +++ b/Documentation/admin-guide/gpio/index.rst
> @@ -9,6 +9,7 @@ gpio
>
>      gpio-aggregator
>      sysfs
> +    gpio-mockup
>
>  .. only::  subproject and html
>
> --
> 2.26.2
>

Good catch, thanks!

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
