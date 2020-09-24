Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E92773ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgIXO3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgIXO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:29:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60443C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:29:18 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q4so3522129iop.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyenqVgWWi4hktsJwzPOHau41VJA6ADzsTIaBtagdwg=;
        b=oGg+bfbV8u4czH/xcGWFrzD+5g+KopuhOxjfyLeiZw8qjVXfh1Kwq1IaAeS12RdXOD
         ulf9INUO+pqdf0SA8o2iNjo7d3TRsEqAseOjvAt0RRURntqGkEkP5SxTy6setnBoP0m8
         rlPjYioEGWS15IuamLyhe5+3YvrWYyH01/F9KzhdBDA+emLdTvgDQkZMTb0g+z3SGSPB
         hzKcJAUse6H86OUeRe2CPbhH+owjg3Uyh82JiAd4q+qjaHXo7kCU0eWwIKJGBHNrvz05
         5vTyOV6dG+zxUAEolmH6czPcmkVL16E6BDfdEBmGuumIaQ5HQNX971xEl/XSLk/zSHIy
         9n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyenqVgWWi4hktsJwzPOHau41VJA6ADzsTIaBtagdwg=;
        b=YOgZ91G+9Q0M/nyBxt3VDKZU0Kw5QezHNVKcynR8HAb4S1zeUz2KmOxg1aWUMF+uat
         P1ce78V3hW+wgOsvOY4quLBy64U/PU2EQAeSY+LF3PSFj8yv7wJrMTx8sgMEpNsFfwXw
         ptZZpx04Vofaa8nrGPI9WSJEkKbByTgEt604IWKyjMv/kDFJBxpxlVL1sEFRREQQuNqX
         qL4MJBbhDhhNCSXApSuhMnOREWn9MpFX5iF1+CZ/CHgI6WgdHpqlkJB1V0ydu4i3SSSQ
         wXWyD5nADoQhBFuTRV97b/ZGI693xfhs/pk++xD5yk6ylOmbBNSXAi3RM5Z/eM+uKDNM
         2k+g==
X-Gm-Message-State: AOAM530umqhJ1nGMg4/IRaJOL7xwl9pwJZde9qV583wo1tHmqysajPBa
        xaftIgc8B5zJnk6rcmpdh6eCozKh0qMfxm8HD1ef8g==
X-Google-Smtp-Source: ABdhPJzYNUqUV8xyQOKrL4HXS0V0PPSLAPlzGnB4IK2KXvxpsmapbyAG6PHdjXWYNecoB4DIrDoX5BxT7IZbG/Bh02o=
X-Received: by 2002:a5d:8352:: with SMTP id q18mr3623282ior.31.1600957757687;
 Thu, 24 Sep 2020 07:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200922023151.387447-1-warthog618@gmail.com> <20200922023151.387447-8-warthog618@gmail.com>
 <CAHp75VdQUbDnjQEr5X5q6WdU6rD=uBNznNn5=Vy=pvdwVj_hEA@mail.gmail.com>
In-Reply-To: <CAHp75VdQUbDnjQEr5X5q6WdU6rD=uBNznNn5=Vy=pvdwVj_hEA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Sep 2020 16:29:06 +0200
Message-ID: <CAMRc=Mc7O2FGT3ZHLbNozQpK6bTei=Y0DLrvDSViqG49xUY4Ew@mail.gmail.com>
Subject: Re: [PATCH v9 07/20] gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL
 and GPIO_V2_LINE_GET_VALUES_IOCTL
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 1:12 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>

[snip!]

>
> > +       /* Bias requires explicit direction. */
> > +       if ((flags & GPIO_V2_LINE_BIAS_FLAGS) &&
> > +           !(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
> > +               return -EINVAL;
>
> Okay, since this is strict we probably may relax it in the future if
> it will be a use case.
> ...
>
> > +       /* Only one bias flag can be set. */
>
> Ditto. (Some controllers allow to set both simultaneously, though I
> can't imagine good use case for that)
>

This is an abstraction layer. Only because some controllers allow
this, doesn't mean we should reflect this in our abstraction layer -
especially if we know well that this has no purpose.

Bartosz
