Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC41D29DA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbgJ1XM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgJ1XMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:12:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0423C0613CF;
        Wed, 28 Oct 2020 16:11:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x20so639081qkn.1;
        Wed, 28 Oct 2020 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELimXLIjFFEyZU/ch1CMaoy2YuMN5MJVjff2er+s7NQ=;
        b=HM99HBk83YvD2YeS+eQsdX3b8HsDJPHH2RUbI86H++j7WB8wVMh0dqhupICJ4TmMd+
         JHaTXnKkRz33Mz2ZhTVPwiICOg0FYj7XW93kWewABTZf9Fp5rOlUwYQ2/tV+lQGFTRtk
         v6z4LQ92auwCat4tQ5JI+JVoxqgPR9uiC5nbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELimXLIjFFEyZU/ch1CMaoy2YuMN5MJVjff2er+s7NQ=;
        b=U77akUT5S+Ok8qtefUwpMPBXbS/bs6UqVqLWrcbEh939n7ZiDisJj9eTaFQLbtQzBL
         1SYOTRygFQsQegx9acCi+vo5lUG8wChwRq4oEUTJ3hc1vTHC0eXicOqqcvBIWQ39JbuS
         Ms0zyVQ6Bk157eFocZWYIASIyLpIZPrLp+jBtPJPzyPl+L5lafBpRQqlmDSDi6ncgBMS
         aMT+dzsjpohU5z6c1R/D8gt5MCBFK+jMl6s2PGsQcRONGC1CN3tctNOotQ4eRA9iAn7R
         DSBurzV3znI50C7ZSJXU5zbXS4uUhEdfexRF3KEqCW2C0Uk7hrWK7+ikfjNQKbTqcHLE
         U8HQ==
X-Gm-Message-State: AOAM5309WgVIW23np2xSm1D+P9QkKlFJRli8qyaIjDgQnYZuv4aTGPI2
        Km6gMxdkMk/PZ3bc32HSKhaNGaUwJ3+fuoczHavmYK052Qs=
X-Google-Smtp-Source: ABdhPJw4sL0/a9JoSrIwywzd8l+q04n/V4qcoRQ1usL9+UKdAACMkTARtNb9rBqxdCnSCJBOQ/U2QBCJqcZJxGf9rjM=
X-Received: by 2002:ac8:794f:: with SMTP id r15mr409042qtt.385.1603859268783;
 Tue, 27 Oct 2020 21:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201008015106.3198-1-billy_tsai@aspeedtech.com>
 <20201008015106.3198-3-billy_tsai@aspeedtech.com> <CACPK8XeKdmvVB_CTND7mSRvtTRz8i+Zw1=E06OP-=r3=pnh9gw@mail.gmail.com>
 <D35132A5-2676-4806-AF35-9110DF0CC88B@aspeedtech.com>
In-Reply-To: <D35132A5-2676-4806-AF35-9110DF0CC88B@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 04:27:36 +0000
Message-ID: <CACPK8XccGJgd4eNiRyE8D2VphpuONZC4CmiC4tDk0pFYmaTdJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Arm: dts: aspeed-g6: Add sgpio node and pinctrl setting
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 at 05:25, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> Hi Joel,
>
> On 2020/10/8, 11:49 AM, Joel Stanley wrote:
>
>     On Thu, 8 Oct 2020 at 01:51, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>     > >
>     > > This patch is used to add sgpiom and sgpios nodes and add pinctrl setting
>     > > for sgpiom1
>     >
>     > The code looks good Billy.
>     >
>     > Please split the change in two: device tree changes (arch/arm/dts) in
>     > one, and pinctrl in the second, as they go through different
>     > maintainers.
>     >
>
>     If I split the change in two, the patch of dts will have a compiler error.
>     Because that the sgpiom1 node needs the pinctrl symbol "&pinctrl_sgpm2_default".

The drivers/pinctrl/ changes should be split from the
arch/arm/boot/dts/ changes.

You should keep the arch/arm/boot/dts/ changes in the same patch.

Cheers,

Joel
