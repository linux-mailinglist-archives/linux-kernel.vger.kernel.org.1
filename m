Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20F625C0A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgICL4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 07:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgICLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:48:30 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B7C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 04:47:59 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v24so798494uaj.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lF+Kc4r9sUDwFZ8bE5xtVYQtO57AZ59ErxR5WiW/3Dw=;
        b=SgES9OtTIMOLLR9GP0CgnxjBl8QnwGm0lnbEOFW3YZ4Umcbth07htLKrbtjPzoJrQN
         riHsXXueEfeQzGreBEqhUgL7qnCZ622H+IqZXNhqcioGKpE1EXPctfh1eMVAndcV4Bhb
         XyHMcTpFpYx8azbD9Jamf1pRcJZZD6V4M+4Rf4ds2nfXvcRcOuYB6EDeBvisP8w90yBY
         drtgRLbuUdVF7V4BNcf3684BR1CPveOvuE1JSePdKmugPHvpeRaojJUAE5IutFeKrTzS
         d32RKGZD2865aakLJfYtpDwq7Nb1hvCzLXd2UiG0wjnuPQaIQSzu2jdLcHapaRGIeRrw
         Spdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lF+Kc4r9sUDwFZ8bE5xtVYQtO57AZ59ErxR5WiW/3Dw=;
        b=ltO479buovRff8qdnvA6Nt7CQs8seY6yjhzgk1q0uV+z+Z18nA9NtyqJxuksh2Y92a
         YkghPPcbIiT9eGiRRp1iv/A1H7WqhT/hmbSfZRectqXk/Ej2Ypfdqgf1PRDSWY4UIdfL
         OTZKVP3gF7jT7LgNLa1SWVjdAqnFcOfYniuU0/bT3SFKEuFHJHv0wenI/HEZdrqih9kX
         +1yUBiRxOVnmX/l+oMllM6EcXxvjS1gkWwKwzs73wrDrjH6SqfpqKoOm0KC9yRt/l229
         3gnUhZhPJymdihgYPKrwb8AwqK2wZjdhEXtoBiy7mL6oYiC7H+7qi7Im+4FvjAxIh95a
         +fcA==
X-Gm-Message-State: AOAM532/tykcrpnmYXcN5hw3t1mdSod3w6ABXp+BqOKtOzkSFZqCHDTF
        9fdGkSV/OfRXnKvVF7AivdTw9DzatHXLg4RBKrZXfA==
X-Google-Smtp-Source: ABdhPJw60X++tc8veDsSpQLnhcJtb/sfDLdknN30k3JsTHwZA+kgY04b4+NZKXDv5kVrAmvgSCiWFjVFdoodQnu3vjE=
X-Received: by 2002:ab0:5e43:: with SMTP id a3mr726376uah.19.1599133678563;
 Thu, 03 Sep 2020 04:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200902193658.20539-1-krzk@kernel.org> <20200902193658.20539-5-krzk@kernel.org>
 <4RW2GQ.J2DD55HCZMCH2@crapouillou.net>
In-Reply-To: <4RW2GQ.J2DD55HCZMCH2@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 13:47:22 +0200
Message-ID: <CAPDyKFoXacPnq5Kv5QEvHjhQz+PN1jAzdGA=TR+e+MwB90Hafw@mail.gmail.com>
Subject: Re: [PATCH 04/11] mmc: jz4740: Simplify with dev_err_probe()
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 at 12:50, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Krzysztof,
>
> Le mer. 2 sept. 2020 =C3=A0 21:36, Krzysztof Kozlowski <krzk@kernel.org> =
a
> =C3=A9crit :
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and the error value gets printed.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/mmc/host/jz4740_mmc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/jz4740_mmc.c
> > b/drivers/mmc/host/jz4740_mmc.c
> > index 81d71010b474..0c5b52b53303 100644
> > --- a/drivers/mmc/host/jz4740_mmc.c
> > +++ b/drivers/mmc/host/jz4740_mmc.c
> > @@ -991,9 +991,8 @@ static int jz4740_mmc_probe(struct
> > platform_device* pdev)
> >
> >       ret =3D mmc_of_parse(mmc);
> >       if (ret) {
> > -             if (ret !=3D -EPROBE_DEFER)
> > -                     dev_err(&pdev->dev,
> > -                             "could not parse device properties: %d\n"=
, ret);
> > +             dev_err_probe(&pdev->dev, ret,
> > +                           "could not parse device properties\n");
>
> I think you can put that on one line.

I can amend the patch when I rebase my branch next week, no need for a rese=
nd.

>
> With that said:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

And I add your tag as well, thanks!

Kind regards
Uffe

>
> Cheers,
> -Paul
>
> >               goto err_free_host;
> >       }
> >
> > --
> > 2.17.1
> >
>
>
