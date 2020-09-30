Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94EB27F27D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgI3TTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgI3TTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:19:46 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868EE2072E;
        Wed, 30 Sep 2020 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601493585;
        bh=fZufF4dJibYyJ+APC1E7Djuqmyfd29wIvWK7vFGlPm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MG/7szeTPm9XpHUd4rQxTtlXCwBrAwQolwCeLusoKte6K9LzmyHcveS2gfDZXvxus
         jUFky2fRvV799QgnN/wVGFGbxRWMXu4trw83DxxkZDY4/qkEAegMV5ZBcSrfr99IRk
         Ldu/ikXq48K22x0mwBX8J1hRLbgbORCS0Jt2cAks=
Received: by mail-oi1-f182.google.com with SMTP id u126so2907432oif.13;
        Wed, 30 Sep 2020 12:19:45 -0700 (PDT)
X-Gm-Message-State: AOAM533SkbNfNwfmcGY9UsJwNQFwiJps85QuKmvq6FuCXZHaBDVECeVL
        I+jhRiuLALbgyysk5+TeYB5DGRXWyI7D8DU95w==
X-Google-Smtp-Source: ABdhPJzKagbQ9f0a5yAOpKvGRRh4OS6BBTe354t6krqtZzLAVeMgvqgHhM3wSc0iOJ4QrlahmI42O3nA4tGNXqxb/n8=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2334101oie.152.1601493584741;
 Wed, 30 Sep 2020 12:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com> <CAD=FV=WhowcppEhmd=QG7YFk5iSVaCKsfGJkGBQJTwMs=bwekA@mail.gmail.com>
In-Reply-To: <CAD=FV=WhowcppEhmd=QG7YFk5iSVaCKsfGJkGBQJTwMs=bwekA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Sep 2020 14:19:32 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mzUV53U1h6YixT=d+Q6oouNNNeFGHvpauMh054x-3Jg@mail.gmail.com>
Message-ID: <CAL_Jsq+mzUV53U1h6YixT=d+Q6oouNNNeFGHvpauMh054x-3Jg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 1:00 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> > On Wed, Sep 30, 2020 at 7:44 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > We already have hubs in DT. See [1][2][3][4]. What's new here?
>
> After I sent my response I kept thinking about this and I realized
> that I have prior art I can point out too!  :-)  Check out
> "smsc,usb3503a".  That is describing a USB hub too and, at least on
> "exynos5250-spring.dts" is is a top level node.  Since "smsc,usb3503a"
> can be optionally connected to an i2c bus too, it could be listed
> under an i2c controller as well (I believe it wasn't hooked up to i2c
> on spring).
>
> Interestingly enough, the USB Hub that Matthias is trying to add
> support for can _also_ be hooked up to i2c.  We don't actually have
> i2c hooked up on our board, but conceivably it could be.  Presumably,
> if i2c was hooked up, we would have no other choice but to represent
> this chip as several device tree nodes: at least one under the i2c
> controller and one (or two) under the USB controller.  Just because
> (on this board) i2c isn't hooked up doesn't change the fact that there
> is some extra control logic that could be represented in its own
> device tree node.  To me, this seems to give extra evidence that the
> correct way to model this device in device tree is with several nodes.
>
> I'll point out that on "exynos5250-spring.dts" we didn't have to solve
> the problem that Matthias is trying to solve here because we never
> actually supported waking up from USB devices there.  Thus the
> regulator for the hub on spring can be unconditionally powered off in
> suspend.  On newer boards we'd like to support waking up from USB
> devices but also to save power if no wakeup devices are plugged into
> USB.  In order to achieve this we need some type of link from the
> top-level hub device to the actual USB devices that were enumerated.

Yes, in a prior version I mentioned we already had 2 ways to describe
hubs. I view this as a 3rd way.

There's prior art in how we reference an i2c bus for a slave device
that's already on another bus. That's 'i2c-bus' and 'ddc-i2c-bus'. But
that's not really this case.

Rob
