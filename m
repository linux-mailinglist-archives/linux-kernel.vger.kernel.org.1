Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5559727FAF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgJAIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAIDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:03:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA41C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:03:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so3835439ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYHHGDFcyV7m8A+kwt4Um8hblS35Zy5LrCr00HSCg5U=;
        b=V5dI8k0JGBDJKaUjGkZd5nb7FzKkNjAUGj5Vtz/vwaOkdbsk6Kfj/tmoI9iIZ1EsBr
         aD0K4VFAX8MLbgmH7OLqizXrI8d3P4p+YYeQZX3ae2tdMsL1Vm5bLjDfOYlcP1JcitaB
         Dl0EfsIi5mkBQ4A22FPU8fDnsa9ugjECw+1FE9iQlMUmqxgurQjB+a0knVgjE0yqtyk4
         DtH3WcgwZWwr1QzCBGkMPKAr0RQNrx9OfD+0fOPZwF9SgVqdm8ro/mLu0kaP2NDqbAGu
         1A4zBRIRD6OGp0vlQhTbU5MktfsOzI6rM7rsHzYQnx2GMb3f/R3DeS9Kzc4QPyShlVzI
         3zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYHHGDFcyV7m8A+kwt4Um8hblS35Zy5LrCr00HSCg5U=;
        b=eW34XwvrKGyktvlInI0PGo1tEW/qrZIV3WhfMRnEkfb8UirZ98UUGw8LGBjHFQYYSN
         kO9vAXIlh0TAs7FE/1G6DV0bsXaM7/hq0KW9dGpQkdPAQlqr6uOHu3DbhTXAm7f0+B9w
         oWXtScrHew1dQi2F0IP0xRcEfj5/9t2enlB1nsTR0zH8RSrnGA4ZPPh97ywLG7Li9KYY
         dMRZ3YeAoWD05wk3Hks8qjbqPidrugE0rk1PncsnOuUe2hO8EP4GBEBO+moZ9O5MEWEY
         w5z0wn+TqFYcJ0Z5NvCqhXhjvJ19w6/7E55fqOtWek7aT5FX5MnW5lINE4siQch3FmxI
         jgQA==
X-Gm-Message-State: AOAM5339yIK1UkGdsMAfuaGtdQEYu9tbE2aYPqWHlNbAKOVu8EmEEtKg
        UWbxxQQF5AVav4Wy38zLMpWwgTm9T0JcCc7o34i0ig==
X-Google-Smtp-Source: ABdhPJxObbJWEMCPewD8z+AbY9e15OBPYDfPTz8C51qe9fXmpPzD4vXP4mXTehFmCobLoRIHlfHzT37WBOKXg2KqIaY=
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr2102611lji.283.1601539399825;
 Thu, 01 Oct 2020 01:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200930174839.1308344-1-drew@beagleboard.org>
In-Reply-To: <20200930174839.1308344-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Oct 2020 10:03:08 +0200
Message-ID: <CACRpkdYkxTiC9iMJV8SrMGXHU5jGut8vJ=1WQFK=avXd5PrE_w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: fix pinctrl_spec.args_count bounds check
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Christina Quast <cquast@hanoverdisplays.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 7:51 PM Drew Fustini <drew@beagleboard.org> wrote:

> The property #pinctrl-cells can either be 1 or 2:
>
> - if #pinctrl-cells = <1>, then pinctrl_spec.args_count = 2
> - if #pinctrl-cells = <2>, then pinctrl_spec.args_count = 3
>
> All other values of pinctrl_spec.args_count are incorrect.  This fix
> checks the upper bound instead of just the lower bound.
>
> Fixes: a13395418888 ("pinctrl: single: parse #pinctrl-cells = 2")
> Reported-by: Trent Piepho <tpiepho@gmail.com>
> Link: https://lore.kernel.org/linux-omap/3139716.CMS8C0sQ7x@zen.local/
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v2 change:
> - correct the description as I had previously been mistakenly using the
>   term #pinctrl-cells instead of pinctrl_spec.args_count

Patch applied!

Yours,
Linus Walleij
