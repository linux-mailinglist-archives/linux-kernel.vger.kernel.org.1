Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5782728DB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgJNIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgJNITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C79C05112B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:59:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so691408ejj.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbQ9zezJOZt5q13rquXSx1mp5UXjcu3g5SCKCd2+BGI=;
        b=zXqVtU5tyznYTGXGamMS7R1Z0U+3OWxDZ5rx7TdXTWrbrG9jQSLWHCtsy1BoaGDwV1
         2lfYhnqpt7af6sBlRIHuk5g/r5JFMUNK/kQJaFoL4kh5NkQ2VzXceSHfSrh9zrQWwmSn
         ZtTgFpMRXM6FEBD+yQbkE5B2/vp/Y4WEb5tqWJgcBtiri5bIgcOtziYB2JChbf5mZoMS
         dNVwZP+vGgddtow1WzjrwzPP134g4vR0++jnyg9aCsrlb40lzYLGA72egHRGcRdHSd/L
         R2Vi365QPPg7MDo3sepnTYfQHIqYwY12XzSdJrgLpX8IiqUeLHFtf4kd1EW9M7IFz4Vn
         XYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbQ9zezJOZt5q13rquXSx1mp5UXjcu3g5SCKCd2+BGI=;
        b=liyOG4BkLXNlfpC2VNmeHDM/K4WUh9LrlUgn1lIB2UXID+VZbLTPWcrtlRBe3Fl3aP
         uRe120xoIPtRdwvqjJd9hFnzjBCIC7XUpxE79JqDXWpweJ/h8oZNl9wiPf/QrTRgnMQ6
         vpibthehFAwEA17jfx8hSQGWjgQjUr3gSe0UgV6dz6JBaJ4rgEczvQbCAzMYqY5Nie+7
         6BZobxyS6WCP18RbpzA4ljZ4rs9U8tQjN6dDek+Mc/QAmFw7jBnPKCSXM5JLIeaOCXun
         v8MBt33qdRWTedZnakStB/OsCZWIqmA2+eaSEgwEfrto4RQ/Nq0K4qVAHUkOG/5UQmMK
         J6fQ==
X-Gm-Message-State: AOAM531R8ghcFdbew1P9lRi7wLa4HVRyfkbX2uPOGjIAYF6RdKU2OTrC
        WTacP4yLojp6NmvnxNoWZiEVXcpY6wAB0nSDNQi23g==
X-Google-Smtp-Source: ABdhPJzkQzh/qaNuPB64Ddr441/RAk3dMGcpPwYi6lMJJDMCh/gCShOoRmWm5DeXsA8uu/uIW9HngERTGPhVVcNAnfo=
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr4178974ejb.155.1602662380571;
 Wed, 14 Oct 2020 00:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201014062740.78977-1-warthog618@gmail.com>
In-Reply-To: <20201014062740.78977-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 14 Oct 2020 09:59:30 +0200
Message-ID: <CAMpxmJWkUc-ZnDj56Q7_1ba73RXFFHos3MYas2TZSe-Q2AwhPQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: cdev: allow edge event timestamps to be
 configured as REALTIME
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 8:28 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> This patch set adds the option to select CLOCK_REALTIME as the source
> clock for line events.
>
> The first patch is the core of the change, while the remaining two update
> the GPIO tools to make use of the new option.
>
> Kent Gibson (3):
>   gpiolib: cdev: allow edge event timestamps to be configured as
>     REALTIME
>   tools: gpio: add support for reporting realtime event clock to lsgpio
>   tools: gpio: add option to report wall-clock time to gpio-event-mon
>
>  drivers/gpio/gpiolib-cdev.c | 21 ++++++++++++++++++---
>  drivers/gpio/gpiolib.h      |  1 +
>  include/uapi/linux/gpio.h   | 12 +++++++++---
>  tools/gpio/gpio-event-mon.c |  6 +++++-
>  tools/gpio/lsgpio.c         |  4 ++++
>  5 files changed, 37 insertions(+), 7 deletions(-)
>
> --
> 2.28.0
>

The entire series looks good to me.

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Linus: do you think this can still make it into v5.10 as an
improvement to the new uAPI or do we have to wait until the next merge
window? Will you send another PR in this cycle?

Bartosz
