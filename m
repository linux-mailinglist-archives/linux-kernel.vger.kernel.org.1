Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED3A2DCEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgLQKBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:01:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E0C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:00:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x20so36307136lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zp+lOAZKeRzjBsyGhBdKFVh1GtYpejMM+fmxfduzjck=;
        b=jabPh2d2O1OM1VRZirwMfkdY7G7tEbOrpLncUOnVV7ZoipYG6tN4Wy56G74iv/ZaW6
         vuhVcFg1e24jo+wW4jkWF6r06/w7LICfASOVtbqqIQf054Dh0+RTttl4CRAba6j8g2Qe
         iywYlEqXX8ojFS/ovE6OMS+kSVc9+GntwBECfTSVPx4ZvwI90pN2i2KKZowRH85jeQww
         3JrdHOnDK8mdrmbewVHY2wEVpjNJiTDbArY8+jo5KHuqF++ZUUUHfvkOzTSp3dnGIa/b
         Vme1Xf9qze9Firq682xdRXkODf3nMJQPNQnYkhU063rtWuIntgZpFoh6cnChlEw2txDX
         Bx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zp+lOAZKeRzjBsyGhBdKFVh1GtYpejMM+fmxfduzjck=;
        b=RZfyxsyCsj7EOqW0+cPqqA2vb/Mje3DDUefLnJIKn0LQpRlIySkyuKryHT5ikEuwUg
         lhdg55G56P3BMdeuXitnCsydYDzjWw7TcgCRNb3U1tSPZPI7eSJoWemUWdQBNHF9Ewv+
         ooDbTOk1dN5zh3IUG9FsNmGUBDsXEWFnq4JZTqTvuQth0ZS70AxKc8Bk6joK+5XWs1Kh
         WnWI2gOM7RU5AjxJJg6/3uDAy8eHU3OhlmQ7Yty2JqIc6o1eTbwvgs0jOFfguLpVs1US
         iNztRf3CKZlsuG1nREnSJS12W8UfYHykTv7gIEhtaZ0D3KONMYZlhiiOcOumt7h4INxt
         V5cQ==
X-Gm-Message-State: AOAM533TNaiCcJC4V3e4TsoCTYKOaJVTuGisdAzpQDxbFtUmP1xRCSbt
        at14JIqfCJHLXoiu7RTJDMfjtiD6ATin4nIiXHTq1w==
X-Google-Smtp-Source: ABdhPJy6Yohv7aunK4LueT5l/ODL4AiIO5cUTcigvNmSfAqVU7pK5cpPqgG8WSjKw6GtX+zSexztYVhuGIuYVTro7p8=
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr15892558ljj.438.1608199226806;
 Thu, 17 Dec 2020 02:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-5-uwe@kleine-koenig.org> <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
 <20201214204046.xopipytz4ws7j72f@pengutronix.de>
In-Reply-To: <20201214204046.xopipytz4ws7j72f@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Dec 2020 11:00:15 +0100
Message-ID: <CACRpkdaoouaKk=9GFudR7pHiU97zefs0i9E6_jGkHEBa9ujA4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] amba: Make the remove callback return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:41 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Technically there are still some maintainers' ack missing but I'd really
> like to get this series applied.  As I don't want to make people angry
> I'm asking once more for your Acks.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for taking so long, it's nice work.

Yours,
Linus Walleij
