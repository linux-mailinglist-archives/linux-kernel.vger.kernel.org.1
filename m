Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D529DA44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbgJ1XSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbgJ1XSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:18:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5372C0613D1;
        Wed, 28 Oct 2020 16:18:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x20so649712qkn.1;
        Wed, 28 Oct 2020 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MykbGw6bHee+sbWD2NGwMwnxeBN9iL5rF1OE9UjJ1Q=;
        b=Tp4mM3D0AUMmouj4W6RXfvIIS810w5N6ZfCPO62M4OTOOqdefYTFMYQvkv8RZjTxbg
         KAwVGVb9sPj2KNyn/uQFfuZFIpk3TCBmrRM/UUX++fbrobzL1xmClclUj417B+x7JZeD
         zg0GOP0R5Nrw9atwCSZjMc4mbSbOk8lUN+0Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MykbGw6bHee+sbWD2NGwMwnxeBN9iL5rF1OE9UjJ1Q=;
        b=ck5v4UJrQ5jSzCpDrDu319IfS2giBoHdjdP7/BYhdksvyyis6klJPyxRf03tNoOL5W
         mexfWtojJ41qOQaibFUFPuamfFOkIMMr3wDzbq2g7Muad15nJyv+rQqTI0F8LTu8DdT1
         1fThSy82iOGVrVaEQiBBLEYdhu5VlxocaYhAJ0rIKcEBSbgYkiFOFbDULJK0EimSDQ4C
         Z/TMm2AXRz9X/S1MujQstEDJtBlup26F1viDkCQUMtQMLQMbTXHYXZWlzGu++ws4hUcO
         B1Vkgbqq27F5WCFOhQ6UE8FEDXgbcAs5D20GxiSIKofEX2XxpKVOAH8/S/RBksZQEaLW
         aB1Q==
X-Gm-Message-State: AOAM531T4Qy5fdKtyeZWs2TVzKWPMl/gKyN2Mkz+/BMUn2r93fP6oo8Q
        zOSfjzPHSFNue+oTVPrV5OjOChaLeyOWBZCLUMC7nxMDCmYAzw==
X-Google-Smtp-Source: ABdhPJwwjgO8IqC8w+C79BxSvAYXYDw1GUHfrT/SZUU3zpmx1+2t9DpDIW5G3LtpRjVBq3ypIaEi6EQ8SBJWcM+Xai0=
X-Received: by 2002:a05:620a:1303:: with SMTP id o3mr5769587qkj.66.1603859902807;
 Tue, 27 Oct 2020 21:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com> <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com> <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
In-Reply-To: <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 04:38:10 +0000
Message-ID: <CACPK8XeGRq2XeJAjdQ=pT1oKk7-wk1==4Byfc50_6+-UijU12w@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        BMC-SW <bmc-sw@aspeedtech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the response Stephen. Sorry it's taken me a while to get back to you.

On Wed, 14 Oct 2020 at 17:16, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Joel Stanley (2020-10-13 22:28:00)
> > On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Ryan Chen (2020-09-28 00:01:08)
> > > > In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
> > > > default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
> > > > eSPI slave channel, those clks can't be disable should keep default,
> > > > otherwise will affect Host side access SuperIO and SPI slave device.
> > > >
> > > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > > ---
> > >
> > > Is there resolution on this thread?
> >
> > Not yet.
> >
> > We have a system where the BMC (management controller) controls some
> > clocks, but the peripherals that it's clocking are outside the BMC's
> > control. In this case, the host processor us using some UARTs and what
> > not independent of any code running on the BMC.
> >
> > Ryan wants to have them marked as critical so the BMC never powers them down.
> >
> > However, there are systems that don't use this part of the soc, so for
> > those implementations they are not critical and Linux on the BMC can
> > turn them off.
> >
> > Do you have any thoughts? Has anyone solved a similar problem already?
> >
>
> Is this critical clocks in DT? Where we want to have different DT for
> different device configurations to indicate that some clks should be
> marked critical so they're never turned off and other times they aren't
> so they're turned off?

Spot on.

> It also sounds sort of like the protected-clocks binding. Where you
> don't want to touch certain clks depending on the usage configuration of
> the SoC. There is a patch to make that generic that I haven't applied
> because it looks wrong at first glance[1].

That binding is exactly what I had in mind. I wasn't aware of it.

The drawbacks outlined in the commit message do sound concerning. I
take it we could avoid those drawbacks by having a driver-specific
implementation of protected-clocks, like qcom does?

> Maybe not registering those
> clks to the framework on the configuration that Ryan has is good enough?

I didn't quite follow here. Did you mean with protected-clocks, or
using a different mechanism?

Cheers,

Joel

>
> [1] https://lore.kernel.org/r/20200903040015.5627-2-samuel@sholland.org
