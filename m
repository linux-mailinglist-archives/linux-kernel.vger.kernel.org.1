Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EB28DB35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgJNIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgJNITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:35 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B83C051130
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 01:01:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v23so1569325vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 01:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SO3tpo8g36O18u0oTsmNryoKX09AzBl8HzOfu6KgoA=;
        b=DbYbBgZ8S2slO0gKKAwBS1h5tPnC5UOqXpXpJWvJJXORH1syj5Gj4P4kZp4lEtfqvk
         s3VZU45qRfiV88urjqeoUW6VgzhxZs4IFKz1TjSK0mq5+cKW3yFnXPx+k5bGLWHul2yb
         KfWLbpznyIO1QloLKpl3nVaEGUsFxYa5JTRY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SO3tpo8g36O18u0oTsmNryoKX09AzBl8HzOfu6KgoA=;
        b=p9JrJqyLLyhm9GlAfQn6FFTUPOQco8v6NNL5pI5fNFK50RQcIAybC4+L50wyvzClcc
         IRaOGtVlzwxKd4RxT7TOKwUzr9zCGkRN8nxhijpjw9198ol1O9/uH86gFZr9QTzuUfPO
         DvhNE4KTvPkcq00KhgxupFEyZ7RK8VH2ZxGUMSeI846+HabX//N9PZFI1gPdmImqXd5X
         wf6QWjo8mUaHL8/Q9PIT6bZx+IyT68R2p2DJYU9pw71mTd8aeKXgitxVgdp06kzL6P7u
         Ph6XlisKi+HGfGWiLEymwkmlgt3p4iS4Oq8bdpn9zWC0zhV1ASxkOzQFa2MFLPDpfJh6
         t1qw==
X-Gm-Message-State: AOAM5313l/zO9BbDHlUb9anGt+OpkvqLXl4iVFuBOcMUHhByOK93ebkD
        X/Vaj7BLglmJoHzOr3RWrDd0cTLNqPQLwXh+f2+AHg==
X-Google-Smtp-Source: ABdhPJy4vPRWpqm/Lif01f+pNzCo9hDq0DItgcGHT0TGikh9kiap2X7FLHy31dzvgFI2Ge6IgyErPNRyNZXr1kxDxFs=
X-Received: by 2002:a67:7d93:: with SMTP id y141mr2580312vsc.21.1602662509278;
 Wed, 14 Oct 2020 01:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
 <20201012124547.16649-5-wenbin.mei@mediatek.com> <72ae1d89-fe31-4f50-15c0-29119d662ea1@gmail.com>
 <1602642530.11864.3.camel@mhfsdcap03> <CANMq1KBe9u25yDxg8UtmOX4vhr8De=5-pJyMRkSBF4O=FpBN9A@mail.gmail.com>
 <8bcc800b-fa1a-a42c-9fb7-a7546e889694@gmail.com>
In-Reply-To: <8bcc800b-fa1a-a42c-9fb7-a7546e889694@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 14 Oct 2020 16:01:38 +0800
Message-ID: <CANMq1KAnG5Z=GZBqUhz9FdWx9-bSkUs3FgZnURjvzeHTrpTWGw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 3:44 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 14/10/2020 05:06, Nicolas Boichat wrote:
> > On Wed, Oct 14, 2020 at 10:29 AM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
> >>
> >> On Tue, 2020-10-13 at 17:10 +0200, Matthias Brugger wrote:
> >>>
> >>> On 12/10/2020 14:45, Wenbin Mei wrote:
> >>>> MT8192 msdc is an independent sub system, we need control more bus
> >>>> clocks for it.
> >>>> Add support for the additional subsys clocks to allow it to be
> >>>> configured appropriately.
> >>>>
> >>>> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
[...]
> >>>> +   host->bulk_clks[0].id = "pclk_cg";
> >>>> +   host->bulk_clks[1].id = "axi_cg";
> >>>> +   host->bulk_clks[2].id = "ahb_cg";
> >>>
> >>> That looks at least suspicious. The pointers of id point to some strings defined
> >>> in the function. Aren't they out of scope once msdc_of_clock_parse() has returned?
> >>>
> >> These constants are not in stack range, so they will not be lost.
> >> And I have confirmed it after msdc_of_clock_parse() has returned, these
> >> ids still exist.
> >
> > Yes I guess the constants end up in .rodata (or similar section), but
> > I'm not sure if this is absolutely guaranteed.
> >
> > In any case, this is a commonly used pattern, so I'd hope it's fine
> > (just a sample, there are more):
> > https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pcie-qcom.c#L266
> > https://elixir.bootlin.com/linux/latest/source/sound/soc/codecs/wm8994.c#L4638
> > https://elixir.bootlin.com/linux/latest/source/drivers/mfd/madera-core.c#L467
> > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpio-dwapb.c#L675
> >
>
> Alright, then this looks good, sorry for the noise!

To close this in more satisfying way, I asked internally, and +Pi-Hsun
Shih digged out this answer:
"""
C11 standard 6.4.5 String literals says: "The multibyte character
sequence is then used to initialize an array of >>static storage
duration<< and length just sufficient to contain the sequence"
"""

> Matthias
