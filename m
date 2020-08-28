Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07D625583A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgH1KDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgH1KCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:02:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F944C061235
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:02:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so658725ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gg8w7FyxS5olNPP0T/p1d8kcV4d3oP7pvIBcK4KxiMA=;
        b=yfZYGfWIaazhZpa4MiIfi8N1UYAwzELWPkKXWkeWzFH0MlcFmqxKiS+EAg2YC5+qd1
         r+P2+8DvIOePVKtMKrUFWOydQlKrMISbi6KPh/K1RN1eF79khiLQGP0aJL4yAEsHZIhu
         mLlsz7S6XqAjgLOoJe2zsL5z8EP92lbJAhoDJ2HAPkQQYf/4PR6erjtyFQvZ69ZDBFo8
         geVZUT/w4DpGsf2+/cq4vAElPCWJeF8mLbiSZcFNQTPNypLVCx/4XEO+h782UOPyvBvx
         6n8lsxYQb+0daon+8trpyWVpJN1BQcYSAou3pR+PM04gn6qcXNkxjP0Uruyr6u8BIUvE
         XuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gg8w7FyxS5olNPP0T/p1d8kcV4d3oP7pvIBcK4KxiMA=;
        b=bbpjoSbUduTusv7Em3rOqJUv9HwOUhi9jf35f5S4bJTJDpstdywfqQMSms3lWxOPJd
         dUqBvUyNRpHu7SgR2GkOhI1cv3V1EoNLfYg54zXIkzv9t/6dgMXHPpdNgV8E/BlXWzHO
         ru8ccVdilCJeZsmtdAur7C6/j6KpmSKz78EmoyNELUMLlvMDRw8ScN7rHDAjj5VwhaDJ
         xB3cjzMcEwYrDNVijf1pHurzjXTgiCQVRt14lPAKtOGzDSsqqTrjFS0zQ4pHx7fuVBE5
         KeGKSlaWm9aVFlpKfE2dYM/ret+agDUv5Vd9waT3Jr1SBHhy1a/8nDNp0LMgOjPjYspt
         TUEA==
X-Gm-Message-State: AOAM531KINV2E3K104ICjFMp2yqso8iBjJ0zRkZT9oUhmjztRQYQyUQF
        pe9gvcfnFdufQtj/RVsK8NqjJK9QSZ2xrjR0lSLuEQ==
X-Google-Smtp-Source: ABdhPJxGBDDIUGKlDHb7X+U9ZlUuxz6OTVqUpjGGNG25WaTWbUK0lfjyuNiH2UpzdtAP231LGoGkSdCBPbtNK7t7yF8=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr556502ljo.286.1598608960272;
 Fri, 28 Aug 2020 03:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595572867.git.frank@allwinnertech.com>
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 12:02:29 +0200
Message-ID: <CACRpkdYOKOj4r-9U2iHCkdB74fWkm2J0xHqsnH_sE81SV5g1=w@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Allwinner A100 Initial support
To:     Frank Lee <frank@allwinnertech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>, bage@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 8:53 AM Frank Lee <frank@allwinnertech.com> wrote:

> This patch set adds initial support for allwinner a100 soc,
> which is a 64-bit tablet chip.

Shall I commit the pinctrl patches (if Maxime ACKed) separately
or not? Once Maxime is happy, I am usually happy too.

Yours,
Linus Walleij
