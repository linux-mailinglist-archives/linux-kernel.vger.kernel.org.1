Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF6300099
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbhAVKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbhAVKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:40:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06EBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:38:51 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ke15so6929604ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3DouesvZQi7NDprULxAHaPbqcBI6rl6oPqO3bsAvcs=;
        b=LwTntAJItH6vUwW4po6DmaPmrMskpMAJ2PicjpA0PP8rNdxU8P4+6ZyMwyIt0iSPmD
         MOidqVQ0kn9f/uUGQ7Hsl8/laF6ZJfVbhUjtPrMObZfyABW0x6StmXq04oC7uG2/roFh
         JMDeUzxQRa4Ry7m8EK+KtuiJS1dUkantKgEYxSUxhsNOgpAMwMgYcm7J2f5e70zpYZDj
         e24ESdcRubLawx1EJuJzWRcA4Y+kZocivEW4aB44gLbXDMgrEc7nljWPWD2/iRkVRcQh
         W+V1LUZRCS2ZMo8vlMw9Np2oTZZOZTDBimPeb4qc4TnVlczQ03lhTSqRpqQ3q2GYChCM
         5yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3DouesvZQi7NDprULxAHaPbqcBI6rl6oPqO3bsAvcs=;
        b=p8VyLbMorOXuXfmeanCuY08D8rYSatjlKkmMS1xWc4qFHIR6H+UXNbEyRW1q6W99GH
         QPWhUl8GY+R4kCWhC75I65JNN1dHW7TR3snHY7qh/CPWnCaCSZnTa/JChKcMFf7KJ1c9
         1e0Bunrxj9XlDRkONYb7UcOpRmhrTTP6QJKXFLO17VPBSvPoIHSkAiYofwMEWUfSltIJ
         aJBv/wNmQPl58rcs4CbXyRBuotWCz2gNDmqVdRnrydxddkVPJZoYkJ7S7AaJkcksMVie
         pF0MMliwkXe7ImKLozLkC6DZFVapkVZzkT1HkTEr6gSzhVxhXHbIkhFpun5RgjU/n+r7
         Pv4A==
X-Gm-Message-State: AOAM530nQ2tSwk3Fq/KJ39APGLroVfYNP4gbrTayOBWgkBcPPHxX6Na5
        eFNdEEzSbwAhg+ybFoo2fPIuTVUoQWkXZVXVsU4AlQ==
X-Google-Smtp-Source: ABdhPJzM/Q2vzYPXFR3mjBikbUJSBxHl9Hmy/en54CimR9SepJ9dEPeV4YG+4DO1zogAKtCnnK5v6lhYTk/3HBM+JfY=
X-Received: by 2002:a17:906:2617:: with SMTP id h23mr2560181ejc.168.1611311930778;
 Fri, 22 Jan 2021 02:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20210120132045.2127659-1-arnd@kernel.org> <20210120132045.2127659-2-arnd@kernel.org>
In-Reply-To: <20210120132045.2127659-2-arnd@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 22 Jan 2021 11:38:40 +0100
Message-ID: <CAMpxmJWrxfcLjqm9F-7_wAb1=qftU8OQ3hc6AUo1PzkUGnxFKg@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: remove zte zx driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:20 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The zte zx platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Bartosz
