Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7362EB609
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhAEXTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbhAEXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:19:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51066C061798
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 15:18:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o13so2491045lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1kIGsmlZWUnm0eNGp2YOwyYVCXEP678oYFzp03SZFI=;
        b=rnHdyyVftcEE7l7n8QrU0td4/OZrwidg5QjguzxzL+t8RKl/3VPiOzvTNZ2BoKvWUf
         0oxXbwipp5JliKi76dXXNv/pSOUpi0HSeKdxGq/99f6rmeLB9vVx8D70QVFZg7kDTLse
         f4g0p/PVckCZod9ikA9zvAXf0egHHKIpQRzbghxSX2vclcjBPKgMHngQZgArP4gQGPHd
         GA89XBQTfvpgw3a4rF4geFNVMU418Q/mY7zqALXO9oWkS2LoHpVhf1v4VfmstuMUE3WE
         LJhtYTGElft+/FldH7rg6iUHqvtpnXqJKIJd3Dtcj8xxwH+mKlXa6Q46TcuEknGHL8OP
         Z0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1kIGsmlZWUnm0eNGp2YOwyYVCXEP678oYFzp03SZFI=;
        b=nkCQXPTm+ouCOiPvgr3OaJlNLPs+5/FTXcGWftT9UrqFga3vqj8qY4jkLuql0yWDBV
         zCE47cL4fBrc02JhuaUBtWGc0R2FvFaJNq1/zV4nXxorZ+LGR/u4Sj1ktZcGKy9p9MCF
         hz79WSo5g1m5X8J5L6AeWhz3A2tvYJk1JVVe8fYw73pc1tfKtsShJZMa+2HHXkK/AvN2
         5XGfG7PG7+yBe0EoGov7gEago3LsDg/aOzFpFDRMsmnSyj9ZvLGMfT3ZXtNuZXNyH2yE
         248My5hU8MP454q07JNj3lOHok+uRUzKys+Mv9Y0Z8n2LT+76ZB82qaxaVw59eB4tzUO
         BCoQ==
X-Gm-Message-State: AOAM532m+upWZBx43Aq1BDhqzHZ91XpeBXoBDQPXGCLn2/BPv3ETU1IH
        htkm5lojfWxVCt+vkrXQQVtl9xkUnN/PjX/BCuUTmg==
X-Google-Smtp-Source: ABdhPJwl1fDf3fY4Y+gWKMuQwKAvot59gPqwZ5QoeTO2q/OZcfomVBoDui6Gw4od7ko0KnEExWCilAT9V5Mr25TxCtE=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr614391lfg.649.1609888720651;
 Tue, 05 Jan 2021 15:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20201208085748.3684670-1-vkoul@kernel.org> <20201210135253.GA2405508@robh.at.kernel.org>
 <X/NgUp/pm9T0JlTw@builder.lan> <20210105061415.GA2771@vkoul-mobl>
In-Reply-To: <20210105061415.GA2771@vkoul-mobl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Jan 2021 00:18:29 +0100
Message-ID: <CACRpkdZWRjNt+fRbF2uO8sg551kytM+ZH5Zs_6QUrhRX0a5ATQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add SM8350 pinctrl bindings
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:14 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 04-01-21, 12:37, Bjorn Andersson wrote:
>
> > > > +properties:
> > > > +  compatible:
> > > > +    const: qcom,sm8350-pinctrl
> > >
> > > If this block is called TLMM, then I'd expect that to be in the
> > > compatible string. But I guess this is consistent with the others.
> > >
> >
> > This is my mistake 7 years ago and it bothers me every time we write a
> > new one of these - in particular since we now support a few different
> > "Qualcomm pinctrl" blocks.
> >
> > It would be ugly for a while, but I'm in favor of naming these
> > "qcom,<platform>-tlmm" going forward.
> >
> > PS. And we can solve the ugliness by introducing the "proper" naming
> > (and keeping the old one for backwards compatibility) as we migrate the
> > binding documents to yaml.
>
> Okay I will update this one to qcom,sm8350-tlmm. Also we use
> sm8350_pinctrl few places in the driver, will update that to sm8350_tlmm
> as well

Go for it, it's a much better to the point name.

Yours,
Linus Walleij
