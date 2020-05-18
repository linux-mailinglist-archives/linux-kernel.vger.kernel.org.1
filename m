Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56801D7321
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgERIll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgERIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:41:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88520C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:41:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so8932817ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW1rAjHfmYzKLo3+HNuQ6JT9ne1hXLbLfKgSgNPGdgg=;
        b=K5EwfpGGJek8HJALQ5BBP4EhM5+TcmvJ0549ZPJXQ1LBqqDkcK7A34/aoz+3/Ha3cU
         BAlungwwWdbRz4uXzKryZ7Th8aWhwLWhiHelsPyZkqwP+W8QP31ScEiVaHOxIrRwSZhL
         IkPW0UgVydkXTjEq8upjCKbEJuBnPzMsb3V+UgDSPAtyxM0ffQ0RrHpSgBRzrk7W2J+y
         gmYRTTe7dn/vzEpwL0bDvGjdrLjhjFjBwOTw2PIj03u5zXIwnNLuTpd3LmYOlRvtvydN
         FodQ/0qYPbzeK4GoENZpUx6XspQKlLcOAhvJw4YlNVFghb+uPUz0VSOODL1YVdeYmp2D
         H6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW1rAjHfmYzKLo3+HNuQ6JT9ne1hXLbLfKgSgNPGdgg=;
        b=ADTN5pKOyVDILD3Akyi44cNKgOMiB1FAa0IIuh3SCIQ7cNmsco3j5D0y8iFAFZn2Mq
         6mu3cMNrR4GfSGyNCdKrJ7SkCoFVW4XqEDtpuLdj9tw7XS5ZiV6ilG+ll1ARiTVXO+S0
         rCeaxJ2owtVm18lW7SUo13ph4sL0u6ukk3ZGIjguHsBTKMYKVRmBUl091e4obgStJ0jb
         MzRwBuUgzF+S1SXK8CSWCobnclL9rVxZZW4obieyyRqxX3pnd2T/AObShPxOGujs5+m7
         T8KGccx/sBU1bL3tarABZS0JtGD/zB2/GqNF24nEC7X21lKAAyZ4Zq9vY7WxCdyKZBUh
         1hkg==
X-Gm-Message-State: AOAM530fK6gatSpmdhqOGT0MaBiN3NHLObZis4R1R3LCC/E2kzDFgKnu
        UDRDv8ygfuY32dN4Sww0c/v3T/dMTnfLmYEIxD8sKg==
X-Google-Smtp-Source: ABdhPJwJqNAucGKak9tmuVXvkrW85iL40m6qGay/OUsbR1TLGL+cqw9EeIxK3o4zm/Fx0/yqOfMZHysGsnS4dRTj5ko=
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr9091003ljd.99.1589791297948;
 Mon, 18 May 2020 01:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200508165821.GA14555@x1> <CACRpkdb+ZP6rfjGg6Ef9_wYvNf6qmSc7LZyYBVKA3XWCtxPfqQ@mail.gmail.com>
 <875zcty7tt.fsf@kernel.org>
In-Reply-To: <875zcty7tt.fsf@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 10:41:27 +0200
Message-ID: <CACRpkdZnnRXwv0-71t93HX42jL-muty4yJx5gW6_P3yOM-sGAg@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: am33xx-bone-common: add gpio-line-names
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:18 AM Felipe Balbi <balbi@kernel.org> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
> >> gpiochip0 - 32 lines:
> >>         line   0:   "ethernet"       unused   input  active-high
> >>         line   1:   "ethernet"       unused   input  active-high
> >
> > Why are the ethernet lines not tagged with respective signal name
> > when right below the SPI lines are explicitly tagged with
> > sclk, cs0 etc?
> >
> > Ethernet is usually RGMII and has signal names like
> > tx_clk, tx_d0, tx_en etc.
> >
> > Also some lines seem to be tagged with the pin number
> > like P9_22, P2_21 below, it seems a bit inconsistent
> > to have much information on some pins and very sketchy
> > information on some.
>
> the pin names match the beagle bone documentation and would help users
> figure out which pins on the expansion headers match to a gpio signal.

OK if it is how it looks in the documentation I agree that is what
users need, maybe the documentation is confusing but there is not
much to do about that.

Yours,
Linus Walleij
