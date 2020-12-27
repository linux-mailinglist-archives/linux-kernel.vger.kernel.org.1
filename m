Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFAF2E32F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgL0V1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgL0V1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:27:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD12C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:27:02 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so20014738lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fNNMeMsDX+KMdTJKOWKCmiuHFsgTtoldwNdvHV6/s0=;
        b=JJTJm7i0Hty7RNHlYIB74FhQqKLhFuTow5+931XSlVEzXh7GV+F0w6zOneBYBRMjrk
         7rAs0TLQb/UJ5A17jmn//BinJOQR0iFoCyGKt+iQYTGydYYLWTrkmCuyWxeGzKuXa7TI
         lpVCUUbib62NasLegWV0u4vdGiimceePc/++j/E4hlf30ebnwFn/DAoxPPA8c2o+k0MA
         G02YoMbP2skpzdabNNYpTrPfcV+jY4m4PlvRsSaoudzVej033TZWNmYCqWnsTPH0/+tf
         94OVCXgPCKS8d+pR0xaNSLucgEtQ2bNkGGkpMTxXYe7oAgJGy5m/tEYRJNl4NonhDE2R
         pXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fNNMeMsDX+KMdTJKOWKCmiuHFsgTtoldwNdvHV6/s0=;
        b=ZaSjR3msLM3AviV1LdTGgWv6QDSgp8j/mx29GnjIMnle/H0sXxMfb+NC57n33SUn7N
         K5A8q7ozJElTSETQqR3rthD2s4lDLzQnh3Yvexj6sOsHLcVvRGl4kKLygZv8Z/Bl4hSK
         8o/0jW3Uk7xAIhYDvMNw2+VZMrlcA/WglWtmD0ERFQxmqzjAEbjgDm8hrQX+77HZjVWU
         Q1zXolYXYQZBkP2aqvrpX1Djwdy/RBB4TK/FYu6AvUmA6MKtbx73bzWkOnbtcttLgciU
         nOwsihhpOq39rCC2lYYeBOGtpiKTTGPwKMjql+b9yd0L2o/VfE83uJ8L13WpNzNYWb9Y
         cM+A==
X-Gm-Message-State: AOAM532dG1l3edYqUW3PaaE72ecU3GWv3vSlMBynuGRLkniUGxHenIdt
        XhqZrL9Gw6IocXAMctBVOHY7Mi4xpqJcK3TMas5ltw==
X-Google-Smtp-Source: ABdhPJy0lPeONSJURfAKDMUz+ZZeo3R8wEYL5Q9bU6JXiaD4wg6UOfeyOA3q3+nMgoteGVD8G4mN8A4G19m5SmHIHNo=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr21225639ljo.368.1609104420978;
 Sun, 27 Dec 2020 13:27:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com>
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:26:50 +0100
Message-ID: <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 7:41 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?

Actually Bartosz is handling the GPIO patches for v5.12.
I tried to merge the patch series before but failed for
various reasons.

Yours,
Linus Walleij
