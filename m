Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153D62F17C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbhAKOMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbhAKOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:12:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E354C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:11:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ce23so24911599ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVZC7Hwy0sID9sYDNRf3c2kgpntf1fr82m9IY+c7BlU=;
        b=Ib8512zkd50nS7IVCHQp+GRbvpumxwNf9N2PwrwRV/wh72d3zZiOobRA2Nn+w/Uxji
         mmhLqbbiIY3V5vU1QlmalJkPc7LyL1p8cMLvu6HTw8MlGr3fyhd+U8/OandNlQWNOUwW
         M2fz/4drHPlUbiAjL8aFcaP0/+yOr5wr2BuhIyZsAk2Z/LqQI9Wqq3uIUti1hAbeiSDH
         4gHKpw8fzOmuJGFPQ6kDTTkdD9+UpfnKD5h3dZdC2XKrqILfIapC5WxwFdJyTyVJpIj5
         zyYDBIFP0Rgf7699ajXvCzMxnpGQeKkGGbTS6EJPYNgZxzCohF9gtyvnEQnheJlNCFCP
         UbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVZC7Hwy0sID9sYDNRf3c2kgpntf1fr82m9IY+c7BlU=;
        b=Ce6O8rS08L34+wxVkrt1O1zvanYBIlqeg9nAZ4bpcKREIm5FBTW+OX/SW6Nba2dbFS
         8NhlsBdcWWo9yROsRX9D/vNrT5J1A/rJ+gB+sZQdaJ6mK71S1BrF43l0UblJA1uXLp44
         LvI7xVxQBWMtwavqcPB5sJceoMxRmobyQ7DeuAoW5XiJQ0zlPTizqSEVsp/+7pPYXzbj
         JHmAbc2PDko4EZ6lPGp1DrjSF3jQhEiDz/lRRq5IgC78f3A1WJ7DHkQrly5BhuHZFPre
         CDrG85nP++TzZjgMZlZeM1puoDn3r9xw2V/jos768ABDpIRWhcy9UxIgI6jA1tKRnJFM
         JzPA==
X-Gm-Message-State: AOAM530z2aTRYso+CnB6sybbWt/s+UiXmKxfQMKzTDc9eRZEcsT4QNEH
        Xv8KwNszcIqooAuEntgqZO1KpLj1x+idM4hVLkCrlg==
X-Google-Smtp-Source: ABdhPJz6IfLBiFPclFxJ3y3AOA57uKbDMPB7SMWZj3vQH9CWqAEn0YJ9bDdugqVm7l4H/R5Mao3MHYZk4pQudIYqjG8=
X-Received: by 2002:a17:906:b04f:: with SMTP id bj15mr10358264ejb.383.1610374294969;
 Mon, 11 Jan 2021 06:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20210111124027.21586-1-brgl@bgdev.pl> <20210111124027.21586-3-brgl@bgdev.pl>
 <20210111133521.GB34341@kozik-lap>
In-Reply-To: <20210111133521.GB34341@kozik-lap>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Jan 2021 15:11:24 +0100
Message-ID: <CAMRc=MdLAupcMkSEpdVJiBTogbN6G2aqr=kC+0GT6s-igSSL0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rtc: s5m: check the return value of s5m8767_rtc_init_reg()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Jan 11, 2021 at 01:40:26PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This function can fail if regmap operations fail so check its return
> > value in probe().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/rtc/rtc-s5m.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> > index eb9dde4095a9..e0011d3cf61b 100644
> > --- a/drivers/rtc/rtc-s5m.c
> > +++ b/drivers/rtc/rtc-s5m.c
> > @@ -791,6 +791,8 @@ static int s5m_rtc_probe(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, info);
> >
> >       ret = s5m8767_rtc_init_reg(info);
> > +     if (ret)
> > +             return ret;
>
> You leak I2C device.
>

Yes, the next patch fixes it but I changed the order. Actually this
can be moved after 3/3 with no conflicts when applying.

Bartosz
