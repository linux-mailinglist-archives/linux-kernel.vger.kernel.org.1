Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5B28DC55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgJNJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgJNJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:04:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B5C04585B;
        Tue, 13 Oct 2020 22:28:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so1544478qtp.2;
        Tue, 13 Oct 2020 22:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kB//nqoMYrgFKVVbmCReUvvlCp/OH9pTFa1D0WvNeK8=;
        b=Gl6vpxUKtK+nwjlLO+SvrSUeR2dC+PEV5wmiGiSO4POlCr4RCSIgQ3LSh9oI8d/GvE
         3SCz5zqjFohPG3bpCgc3pDGJbq7kbxfM78TQRlzSzCwMCDAMEbi7r8gN5Lx7EeR9WFzp
         ASIh0sC7J1hK0xf8PHJlMZ3xfkynkx3r+Txrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kB//nqoMYrgFKVVbmCReUvvlCp/OH9pTFa1D0WvNeK8=;
        b=U5oVH4eVCkdJEGqiktlNj6whxDVekGeblMKmTDVtzwKqiP6PnPYJVOGrncCcPuc0m0
         W7FU8Cf/cE6L6mVIWhJaM90U7TOroh05mPCgABeR6iKoQ0foPQoSA4W+XRtDKkOkGt8v
         wEPxx+9c8B8aEywKFgqEDFH0iMD4ckYBntGEQXYzQ3003OQT1sPp6VkdlRPNF97Z2fMI
         gE1EQCI23EIiXxicJgt+xKDxPXoDY8AXnhXqGhAYLVyOVGuOlZb14i7sYycxYXDWhxUH
         kJeBvt/vAPpWTcbnSl1n7hm0qmYv6kNzbZ4zLkXKzS4X8si7phpgQE5f8xpWj7vOaCv6
         4M7Q==
X-Gm-Message-State: AOAM5326xXarde5RpqrbPuLKPZaLWCoNcjZSTV1T/57HTtJazosN3KuF
        hVE/YuDWIpMW3BpcPRf+d3BAchzN0n5cXoR1Fug=
X-Google-Smtp-Source: ABdhPJw24gb5jxVKjUGFnb8ILFTaJiae+ZhEB+sYFIQ/Gi83c+wIbHiQ4g4hFhDiM1oYPQWMGp2dm2s2NPDIVlvVANQ=
X-Received: by 2002:ac8:3674:: with SMTP id n49mr3177077qtb.385.1602653292820;
 Tue, 13 Oct 2020 22:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com> <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
In-Reply-To: <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 14 Oct 2020 05:28:00 +0000
Message-ID: <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
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

On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Ryan Chen (2020-09-28 00:01:08)
> > In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
> > default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
> > eSPI slave channel, those clks can't be disable should keep default,
> > otherwise will affect Host side access SuperIO and SPI slave device.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
>
> Is there resolution on this thread?

Not yet.

We have a system where the BMC (management controller) controls some
clocks, but the peripherals that it's clocking are outside the BMC's
control. In this case, the host processor us using some UARTs and what
not independent of any code running on the BMC.

Ryan wants to have them marked as critical so the BMC never powers them down.

However, there are systems that don't use this part of the soc, so for
those implementations they are not critical and Linux on the BMC can
turn them off.

Do you have any thoughts? Has anyone solved a similar problem already?

Cheers,

Joel
