Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC929D433
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgJ1VuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgJ1VuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:50:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428D9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:50:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so660001lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9BkbuooCI0n768ThkitRHsqLUEbJ24gP+vaNxySeBwg=;
        b=TwZ57T8uWrT4ee/xv/UgV3k0J2vKc/wFx+wAMvRH+1BeKLWw9B+aAvD6EoOb2d09M3
         HLpfUTNR0cl8bGSQqazyzH+h7wm/zmxdppXHPBlWoUyE++5DRLXId4KfPkc2edeAiGnw
         tE5ZN1XAk8u8luHR/85HHYLPttm5czRmV1mLTNr8V9LZIXo4QACn+wAzfNEX8RVeZ6MM
         9wosN8Gp1xgvn0k3XSP271BTNPZ0Q22yYhPoes8+L2RGZh/qPQWqN+tg8UPEGJPoCfQG
         hctS2jJjaaOo5TsSOl7RO99cfz+aBBxX911cwhmNon48DatwDTkBFqAvB1BrCTprdMlN
         jRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9BkbuooCI0n768ThkitRHsqLUEbJ24gP+vaNxySeBwg=;
        b=lK02wp1GBDP5vVjXJMIbj2YtnfyM7ISgvWoUhdvkoHP48Fi6gmIdwshx/5ewpmnqo0
         erTR0PhjNClWuNlXR2K7mqfnfux33wxTKnprrcUbTEX3OfczNGYhH42Ewpu4HnB97deY
         zmGUpgeIj7WbCa6IWiJJEy8AwKfSC+8CGrWHV+eAdQhuxkW73vdHlG/qXG19yWFxcySB
         kNIlLi8wRxA1OaNsQMTDcL889dzIruyHd4TE5qV/UHDmF7z/lgkE4fF/iRAejZKvOXtm
         BDBQ5BFKUdRKXsI7jDL5KjF7RO+XmGQdsc8Fbu1DZ2ufC7vPZOOpQ6KRnGHKnYhV8E7l
         ppVg==
X-Gm-Message-State: AOAM531DjBHRdPJGYwyItQrmw1ZbhfXh1b85QXWhiAVcA2NF8NTheQWS
        YVXsR5s6DsSmc2X71qPGP6OwYkxQQeMnUtKZI1vdOywRZM0FNQ==
X-Google-Smtp-Source: ABdhPJz+I7dct3hsj2r3Rcpd2lCTcuG+4DjTAN0aWpDxsVhUB5wrskoZwb4MAaRrE7QQ17++h/GygH0kCBzUOuFkYcE=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr2824880lfm.333.1603900571005;
 Wed, 28 Oct 2020 08:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201013063731.3618-1-jay.xu@rock-chips.com> <34840448.7XeAIBGaoL@diego>
 <CACRpkdY8kRVJptQxCQNzbumjj-H+t-atJdguF39stukmiTfYyA@mail.gmail.com>
In-Reply-To: <CACRpkdY8kRVJptQxCQNzbumjj-H+t-atJdguF39stukmiTfYyA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Oct 2020 16:56:00 +0100
Message-ID: <CACRpkdZuptedcF5c7fDY8VQBx5ubr9ROrbuRiCtj9eim0AKVMg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rockchip-pinctrl fixes
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 4:55 PM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> On Tue, Oct 13, 2020 at 10:22 AM Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
>
> > > Jianqun Xu (3):
> > >   pinctrl: rockchip: make driver be tristate module
> > >   pinctrl: rockchip: enable gpio pclk for rockchip_gpio_to_irq
> > >   pinctrl: rockchip: create irq mapping in gpio_to_irq
> >
> > looks good to go as fixes.
>
> I record that as Acked-by :)

Aha they are already reviewed-by in the patches. OK then,
sorry for the confusion.

Yours,
Linus Walleij
