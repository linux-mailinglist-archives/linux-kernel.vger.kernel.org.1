Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3730040B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAVNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbhAVNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:21:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A2C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:20:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f2so1270518ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ytvqF/ZqeSdIbyUwKUH9eT2gg+DzZJwumCDEIik8VE=;
        b=vTHteLhf3Hc4M8GUMorykIr4Fz8V7IhlXaOyz/Jl2vc8CI3f4b9YSoLVdUimaykGab
         zdaUNTg2TPxiSyNXl9LR+gCD9OUqmJkZ19NKD1obMt1T2554FBeKW3aCkJwJPl1KeTEC
         Lyq7yFbl5a5lQtEnT+PuHFOhTdn8umLYSlyuvyczo3gZYfA6TmcFXkMXP14U31WqgdqQ
         vyA/dZkU8gL2XpwJfA9IrL7+dpdeDjafr+pHKRS40xl9PqWKg6ZEHymCOZmUFORVtFoL
         xJ07KMfj5Xx8pCwXE680tiDtIMVs+F28zYlQEC7WNjSlKHNswp5D90xKpDNOXJG+ZaJk
         lEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ytvqF/ZqeSdIbyUwKUH9eT2gg+DzZJwumCDEIik8VE=;
        b=ThJ4IwRHKtYqhfE0KzwNHBZBQpHGb8axzBR5YP8Ip29PioPzlsFZzeRsfKQ/8QK5HR
         Zi1fQzNbZr1bb3QxFA1MOtDe4il1PfaXALOnvtB4eF9/hRclzuHwO99C3xtcgKLr5Tsj
         xpqX2XUH3TbeCKdb3do6lBZ5pVtXAYaIqAnhB1JEbX5m34FG7FXmxy7B6g3bwMH37YD2
         WTite8C8s7mqpNf0UAq5ddheDLWZFKnm5WLh88WRPpZw/R+MA0Elt3ZnzdtnGJDGtChT
         4+VEBvccSuEZybGKy2pnVRw+FmNGfM+P5s9PO7KhLkbLzUYtNZQAmHvhJhi+5CuzBkj2
         AP5Q==
X-Gm-Message-State: AOAM530jbhY4j3Wfy6hD9Yng3/sYM8zKVM/+eYmxEunAifmvt+B2IVmJ
        kDXLRNy1lgFZNEl5xk7etw0C80yj+DJ4133pWddj0w==
X-Google-Smtp-Source: ABdhPJz2obQCjwabSzHHW28CA6Zz2X57g2dz9ds/UhMqC/vA4Af8AKjfdgsI4a+HItN2SazQGOStl6xwxxDpujPiGIA=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr782769ljj.326.1611321640829;
 Fri, 22 Jan 2021 05:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20210120050342.320704-1-drew@beagleboard.org>
In-Reply-To: <20210120050342.320704-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 14:20:30 +0100
Message-ID: <CACRpkdYnKcMyqj00_uVxhHVUva1W12Pd2sjmVbwXVz-Jy8xrBA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: clarify #pinctrl-cells for pinctrl-single,pins
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Emmanuel Vadot <manu@bidouilliste.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 6:04 AM Drew Fustini <drew@beagleboard.org> wrote:

> Document that #pinctrl-cells can be 1 or 2 for pinctrl-single,pins
>
> Fixes: 27c90e5e48d0 ("ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2")
> Reported-by: Emmanuel Vadot <manu@bidouilliste.com>
> Link: https://lore.kernel.org/linux-gpio/20210115190201.9273b637a7f967e7e55bc740@bidouilliste.com/
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Patch applied!

Yours,
Linus Walleij
