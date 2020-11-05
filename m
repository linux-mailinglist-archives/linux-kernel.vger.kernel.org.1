Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076732A7A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKEJON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731212AbgKEJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:14:10 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34710C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:14:10 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 23so784240ljv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5EvDes2mzEH21PsuVHEvhfe9s1+v+vUUboqD8o+qXg=;
        b=yomWPI9E6p8BoxvD0WQ/GtEqnFHq6kGWctspOEorR5UAjdN2kc6Fbi0ko477mQB1pw
         S1u3SSMzOsNlCLmXkU3c7u4W/tdZZWKYHvGjUmvzX61XYIXGjAhyt9XqhE4pdBh9a20y
         xjZqUARJib3p8iTrUVGupUEGnumPCnPBH4q+31xnVo89s4FJ/NvHwuukNJpR9/B05V3R
         GQu23uuePPNNKw/MCQWJi3KAMiDWPGjK2ewynTSoKw2pY5ZOLWQf1N93KT8U+iKOU8ow
         RMYk5XfVtxkzXXVly6BrUYajnzCS/hboKAC9gOba81ME2YgYXGz5XeaYdn8St502qeAi
         dgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5EvDes2mzEH21PsuVHEvhfe9s1+v+vUUboqD8o+qXg=;
        b=hzUd2MuKHM0BKHCLmLY+5ZwDls8pxF7ySDbl/0CWy6KFbw9Dx5+J21eQojku85rZTF
         Io+Te65BipJDoaMsePEDRR/1j/DdYu3uD9+R+IY8WQzvGBUBxc28U7DXZe9K26CV/z4c
         5t34gG4vZC2SpwnAulVXC2o3/DJGX/OT2HOtdRffQJsJ1SU+cAx3nWudPTGO9VG19fBq
         NDpgnkbNS/akHfh+STyR2UvTdRnfyy8B+KKOAUrs2jaPvnSL+JAJ4EoeqphYYqDbgzJl
         FG6sYPO3w1SEaEjJMv7srQiU4+5mew8VTv5yrKLfTi5fBYhAuzp8M2vMhcXhi0MbPN9k
         GmUQ==
X-Gm-Message-State: AOAM5313QxSj6FYJtoz8g2jeAjblIqv0dJIsIBdOtA+OnEq5d5vkUioO
        Nq449dSLosql2dBK6vr0DBQLXycaSFm1e37p07uldg==
X-Google-Smtp-Source: ABdhPJxSzuOlML38xjmjdsVf6SqLQJ5np08U4vhJotjmL21O/pD0Pwm4/jAUucEfTMJSFq/ScyZzijTlTalZWAVxNuI=
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr507459lji.104.1604567648665;
 Thu, 05 Nov 2020 01:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20201011024831.3868571-1-daniel@0x0f.com> <20201011024831.3868571-2-daniel@0x0f.com>
 <CACRpkdZDyp83AiGkX9eFe2_w9eK1NXREFG896DZfPUaHboy+0g@mail.gmail.com> <CAJKOXPecUBTqbyiQQRdSPq_YuBAF+ut3RbM9AcW8nyciJyw8ig@mail.gmail.com>
In-Reply-To: <CAJKOXPecUBTqbyiQQRdSPq_YuBAF+ut3RbM9AcW8nyciJyw8ig@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 10:13:57 +0100
Message-ID: <CACRpkdZDD0zTxBjfSfWXBsA=R2TSJ-J+nt+Y849QNipNhp7a5w@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: gpio: Binding for MStar MSC313 GPIO controller
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 6:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The generic GPIO controller dtschema got dropped because Rob wants it
> to be part of dtschema (outside of kernel) and then
> relicensing/rewriting property descriptions plays a role. Only the
> GPIO hogs went to common dtschema package.
>
> Therefore as of now, one should include all generic properties
> directly in the GPIO controller bindings.

Oh now I am confused.

Rob, what is the plan here?

Am I *not* to create say gpio-controller.yaml for $ref:in into
other controllers?

Yours,
Linus Walleij
