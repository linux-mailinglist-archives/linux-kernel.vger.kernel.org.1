Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D772F0F99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbhAKKAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbhAKKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:00:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:59:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u19so18172348edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7r6VuPBKQigjoyxyE9moxapiWhf8PXnfSot3BszutPM=;
        b=CkDTMfWTDfFLgj8ve+EItETtX2GIofV8zoXCWnLGUux+rvizG3TdJIWF/R457wvOsm
         UuDd2fwPodyn5rBN/3nPGXFUKtESz6RxRJl733ZzKkAxbdBbYXI+lnZUr59h4dVD4KpH
         6nXDaUMqyAcyxQ0D2vkng0idT8eYgdFD5GYb2Igky2rqtpkXEnvS10bdBL51oApYIEQj
         J2JAd73gJg4BNhGbW7j6jp1gXqijd0IysniL3o0K9oMPOX5eUVfct/trn/yawJyGDbCT
         gjsN2itW0LOYXNys9x0Ghhasr/kv5GW0bLDSthhaioKoKd/2K/EQPK+hvjFOo4agkxFm
         yQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7r6VuPBKQigjoyxyE9moxapiWhf8PXnfSot3BszutPM=;
        b=pLYnEpxpbh0Zj5cv1Y4fYaTmmPXKps7xXI+EPI8xoqo94hJt+n+vDu7PnGsKIM9g3m
         ipTmfRvTUxMSbUOPix4dIc4iOG2bX0qscbyHvvBrvkIeexE77EvoE5ePjbTkRpke/Qcr
         07grQIm19y5ZJCQDDMoGVAJo5+fU6cu5/o69BPIg/wnH8rVZmajcGYTV2QIMVEBl73lc
         GloVlEWbXrdqXFbtGnkjYa9E8cpTBpmtoPKbIustGIvtL785V5KlvBlz8crGPr0k9Ls/
         7K2dgMGyV0EMsadx8snbr1CIwA2ZolPaKLbatQ+JacqTkj4nmJS32bh5ysCjgm0Z4lG0
         0S3Q==
X-Gm-Message-State: AOAM531Ye9WtfHYCvmEKuMwUdyiwsa81V6F2LdtnPnKvYyWmhh8iSGz0
        5eQOY5pk6RScAdg7nf+JYdKcH5jOU0evg4qG6BgfVA==
X-Google-Smtp-Source: ABdhPJzX1NZOrDEKGrHw76vQzEuSktC8dH+VSQnOTGEU4cpxzLrdVZMlkuwjAjc/V1Q6p9v7ChK3XsSC4EIJmFV7f3Q=
X-Received: by 2002:a50:b742:: with SMTP id g60mr13230007ede.113.1610359171797;
 Mon, 11 Jan 2021 01:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20210107040020.257671-1-warthog618@gmail.com>
In-Reply-To: <20210107040020.257671-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Jan 2021 10:59:21 +0100
Message-ID: <CAMpxmJV4SnGnL1Z04q3dHs5S5qZjXBMk-8=piPm2yOVbHb7y7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools: gpio: fix %llu warnings
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 5:00 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Fix a couple of warnings that I ran across while testing selftest changes.
>
> Sorry about the repetition in the checkin comments, but as the problem was
> introduced to the two files separately it seemed more appropriate than
> tying their history together.
>
> Cheers,
> Kent.
>
> Kent Gibson (2):
>   tools: gpio: fix %llu warning in gpio-event-mon.c
>   tools: gpio: fix %llu warning in gpio-watch.c
>
>  tools/gpio/gpio-event-mon.c | 4 ++--
>  tools/gpio/gpio-watch.c     | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> --
> 2.30.0
>

Applied both patches for fixes.

Thanks!
Bartosz
