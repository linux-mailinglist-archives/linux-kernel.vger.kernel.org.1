Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5627E3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgI3ImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgI3ImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:42:10 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3CDC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:42:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so937311edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD+QRHVRU6u1+rD8tFvnIfeMmBl5eerGMBaWYTeY2Dw=;
        b=hb7bY8ElUVvhPpsRUuoKkcY8k5s6gQhB3SHVhxpmhZdBsFWWwV8E5EVnpO7+ssO7GJ
         5bYBFr/WAyQYJtfw+lHEqI+mnRA44A/1RTDCvMoR4PukmgsvhkMXAZvhqu8NJp0TjfbT
         emD5kVAWTfxhwIIE/Nbm0UD59m4heZWLX03XtI0ab8m6GXSzSvLRBALNdjOGaeJZfle+
         r+tmIlJLvzbDOmbfM9BASD0uXQzgsg3QsYn9U3nKTnkY8Sy6KK3Sw+surbFpN0AxSGF2
         xbkly4d1fgWxfmgAVadEAQI4WckyhNpzy2zTmTwqABzZVNJfi6mzLwuM+WHDOQqNRg5J
         Fbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD+QRHVRU6u1+rD8tFvnIfeMmBl5eerGMBaWYTeY2Dw=;
        b=VaR6/thNYsh487X4XeGzatPmBCJsau//XpOatVi0SO+O9wjHOf+v/tHGUPNHfB9ur3
         kI/sd8rddYKJLeSMThLlcWnxr4zDgBcboL3TvCDYF+qK/K+3NZT7cgLT1tbG6Ohfnnog
         LybLcffrIQFKz7JG5Kje9NCJ3mAQE17vxhYflFttkquBn1I5xQWc5WvUOoquy92vCYps
         t5QHfLSj7yPRpA2JEbG4LXULUDmr5DD2aeqGRfkDKmuRHiosF/mypM0qOSy0GmFGSmKY
         9enJJOHgC5eBw1SmbBTcpsx2RgXwXwoTmS8oe5GBlDux8zP5DyAk/LErU0DQG+o753HA
         6/hg==
X-Gm-Message-State: AOAM530WK4bESeZCOSaxhwfLDu8GBnb7MsyxCyGkd+kQG0a9rkeuLgRL
        QHU4Zu38jQEMkE/7ZPI+94TJCZa+v1SH1bh3468n6z7dZS8=
X-Google-Smtp-Source: ABdhPJzMTuQs57fGeFNaSTqCbGJbitH1AyrupA9dPqPv7eqa93L7lPWy87Dm5XFIXyqmSx2bMIZYNi8NMRMcv41+JLk=
X-Received: by 2002:a50:99d5:: with SMTP id n21mr1557090edb.88.1601455326930;
 Wed, 30 Sep 2020 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200930074211.30886-1-michael@walle.cc>
In-Reply-To: <20200930074211.30886-1-michael@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 30 Sep 2020 10:41:56 +0200
Message-ID: <CAMpxmJXm5DB8hcJ7-sUWM6vNq_D59xN=QKc_EtGKkq_DZ5tMUQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc8xxx: simplify ls1028a/ls1088a support
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 9:42 AM Michael Walle <michael@walle.cc> wrote:
>
> Some Layerscape/QoriQ SoCs have input buffers which needs to be enabled
> first. This was done in two different ways in the driver. Unify it.
>
> This was tested on a LS1028A SoC.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Looks good, applied.

Thanks!
Bartosz
