Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A82F2A61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392324AbhALIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbhALIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:53:56 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED27C0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:52:54 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e7so1953168ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JsEm4I1NOjMflpIR4jGgdH1VuxMujPdLvKb9dS5688I=;
        b=Q91v3fKmkv7yHp1jk+4mrPGmxbo1mWWCFs3xqcg8gV6QkcBpp7MYlMrLJMzA6sAk3V
         +oxxHVrn2m9yBMl4cBHI/AtzRTMwdyn5YfhGjKZOcqvX353YR3GlZO3wOkqqoDu84OHp
         UtKzUTaQ3c9AurzzutPndd4sWUqZoDXDNZd+/S/fFRANW38PzxnDJtJxYfj1fA1L8pAp
         3ROnz5lQOdpGRyugwbAyMVZMu0e0vBWa+ogqp/NR40TBd3ZrwcemjrL5HVTHESrkrfzA
         CxE3a+YKPsNMNt8oHMV2Olajf4EUW+eIIVbM5Ohmqil0m/pTkn8loynxCUkWS849IJCu
         lHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JsEm4I1NOjMflpIR4jGgdH1VuxMujPdLvKb9dS5688I=;
        b=VVamxot/6/I6Z4xJFnmFnHm3NCerLdeiKi3NDQHD24QqKBLszh41FGw0WIEYajP4vD
         /8CdCJGDoAYRRPTM12K+vSEszaMtPISK1lqwpOtuF1Dg8S5+GLuyTmM99YKTIhcGUlJX
         j1GTnMNXPwwk87nbkJ5H6cUdsIckGSgfbgR2fUpDp+wLq1h8CD+QEpGCSV3G3s8lsyjV
         DTnJobjE5Udkb8KPQrINZzoxYTAY5pudSce9/aqXMYFUDz3X9SQufP1CNRBJyAVK64Er
         h9GCp+xPDzjqpqAiczaqUwQWsJH1fybFRQYkdyH0m8VIqXbDyXV/ufDVdckwieLgHzkU
         YcRw==
X-Gm-Message-State: AOAM533EDk68aohuC6WBO/kyS/3Y0oGZJPPQH1BPQmotlDaFa5q3eXfT
        iCXBEwb5TWqFGZylC/J+3ilXbhT70zqSf6se5GPrqw==
X-Google-Smtp-Source: ABdhPJxOVHEfMGqQL+Ee1Z/8lgjxVni/8qnA2F4LQjPU+qNuigb/gJQdyNRG9FDpz+vW65Ij7oQxSE3HlbzgqvVsz7Q=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr1556193lja.200.1610441573181;
 Tue, 12 Jan 2021 00:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20201211164801.7838-1-nsaenzjulienne@suse.de> <47b4dbc7a70d8f900789608e753be6faa36cebeb.camel@suse.de>
In-Reply-To: <47b4dbc7a70d8f900789608e753be6faa36cebeb.camel@suse.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jan 2021 09:52:42 +0100
Message-ID: <CACRpkdZCR=_KpPpb2o4e_OvQtJPYZ5qwcxa8MOC7UFvcjm6FUw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Raspberry Pi PoE HAT fan support
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:02 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:

> I'd say at this point the series is pretty clean and, AFAIK, there aren't any
> objections. I'm not so sure who should take it, given that it covers numerous
> subsystems. Any suggestions on how to handle it?

This is one of those cases where I would suggest collect ACKs
from affected subsystem maintainers and send a pull request
to the SoC tree for this hairy bundle.

Yours,
Linus Walleij
