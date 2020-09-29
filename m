Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4D27CE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgI2M7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2M7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:59:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:59:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so5392093lfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh3KJG2w7Yys6UJFQHww2Hj3zhNUGcK2PJZaSQvoL8k=;
        b=pkDwbqFFvv0yf46aTOLZYdoje82yh84sOxJ0zOD1Mo1S9fCTDrdvooZRmXIFWfAyLe
         LuO25Ff8ySbEejdwpHOAQ3GlirPeC4A+dtwBna0OrrDDipAhUh+3M1apNY87dRrbt3am
         XPr/8CfFIPw5rFVMz5r9FNSAlFDXa+EC0/YNidBiRs99dwe0AqHUocXDbXTYbvkKbxMk
         tvDf2UyEucYevFfsHeDNNCQuFoBU2DtvCBu2oTzKTeaI+7YuVBEhyh6lHJSg/b72TBFI
         gYNNjQ6yT0dO2hT6ge1cVWpeO5WCNrCoH/s4Z2JUpFwlwBjE/pnPFB/jczKY5i1WHlFZ
         eOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh3KJG2w7Yys6UJFQHww2Hj3zhNUGcK2PJZaSQvoL8k=;
        b=udYwkxhZboS48WhOeT0agpXrOlISGewPpz6VOAZjglh2+KCfh41Gr68Kg9FFlLV7J1
         Xdq7VSkZe70hno6oCf1fJLIct4N/P9ngqAT0d1/shxdw9bzHMHVcWsUIKwNx46bbmCyB
         VSF+RgfztNTGzKhdHH6szNw6RL7dsW21XJ+9x7jZYP2uXph2beTbbLWfmIZZsn9RhX4n
         FBW/jB4tcgxn/H8cLZd+gZu1kRN2zy2XX9ql5YuwQMANcGxInNy1h5v6wAbH0tGK1S8A
         1gkaYzveEAm3u11HlaMUJMMItI74KVhChukXvOlbpPGrLOYq+jDJXc4tXI7/sMtYuhQ0
         6Hxg==
X-Gm-Message-State: AOAM531ReE6M7hig0Ytzn0xCg4eGQbbcpEs1vfy24D+rbqTE8rPdiukb
        UL//FpxAVWTIuB6EOmtx9JClyEoGmgnaJ2nGQ3MXhw==
X-Google-Smtp-Source: ABdhPJzxjXuvos1X0Emgi+gEyH5ri9cRPCfiatSQQnmAqePCzDD9Gdohy4+kv4rNIHNVz9ZGehnkKSiaz0VvcT/H6h8=
X-Received: by 2002:ac2:4c11:: with SMTP id t17mr1269691lfq.260.1601384393349;
 Tue, 29 Sep 2020 05:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200914144025.371370-1-fazilyildiran@gmail.com>
In-Reply-To: <20200914144025.371370-1-fazilyildiran@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 14:59:42 +0200
Message-ID: <CACRpkdZK1XsrCcmc7yvgff9meRVBtoVmc9R6tirxYeRXgDQWFQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm: fix kconfig dependency warning when !GPIOLIB
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        paul@pgazz.com, jeho@cs.utexas.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 4:41 PM Necip Fazil Yildiran
<fazilyildiran@gmail.com> wrote:

> When PINCTRL_BCM2835 is enabled and GPIOLIB is disabled, it results in the
> following Kbuild warning:
>
> WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
>   Depends on [n]: GPIOLIB [=n]
>   Selected by [y]:
>   - PINCTRL_BCM2835 [=y] && PINCTRL [=y] && OF [=y] && (ARCH_BCM2835 [=n] || ARCH_BRCMSTB [=n] || COMPILE_TEST [=y])
>
> The reason is that PINCTRL_BCM2835 selects GPIOLIB_IRQCHIP without
> depending on or selecting GPIOLIB while GPIOLIB_IRQCHIP is subordinate to
> GPIOLIB.
>
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
>
> Fixes: 85ae9e512f43 ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>

Patch applied to non-critical fixes, thanks!

Yours,
Linus Walleij
