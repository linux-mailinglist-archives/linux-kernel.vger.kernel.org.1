Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D12C89D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgK3Qp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgK3Qp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:45:57 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33747C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:45:11 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id pg6so12661273ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csW5Okzb+d7/XjdZG/181RS4HEEQEs1xG8M5YQE4Ixg=;
        b=h3/FN3tNEwWcGXV2ggdTozioW4OHsshyNLkzNIxhIAgHslEqrZbusPw13uCAojgDle
         PYzdLtdXGc0ms8e95nWq9dx/EJ8rIEE2Lxt9A50T4xVx3PR839552Ip2wEEmqaSyety5
         p/whdUqat5UMVHd8EFzzLBiO+vHgNzBx3Kpi68BcRSIfshBxy188sbYUnmLxGIythHd9
         fuL7sbLr5KohaGmRcBoftsC25pZ94lEtoGgF+eP0t0p9s8fwTYhhMWP9itBn3gm8vpxJ
         60M+JFO+J00+xCMl0IZrZ7cNWocfK/3DqQmE0p1LFKF2YBPTSbDFtsngdSYC9n07081P
         uvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csW5Okzb+d7/XjdZG/181RS4HEEQEs1xG8M5YQE4Ixg=;
        b=QENawHOrY66kUdcWHYbToMdwPqZkw02lmqc3YXEkO0/M9OlO+6I7KL75sVqggJjxBh
         SXnjHCvsD+pZAVJ8UebI2yOk3wWriNMPl3o6xAH4DBzaoM9V+hO6JWww5o8FOiM4fBse
         KRSJDMz3YCKw3DKZmHE5o5FcKJy9snBKQNfdgT430sGGmG55O4/YjWCv0DjUTVp8hp3t
         rSYqBJQkz0d0U3/Cgz3mnDd7NJQcGgQ65C9mSg564SEEGpYhFtgfrIAUQf3z/ggOMDwg
         8k5858deHgpEogSNIHwlG6PpsJty3hB8+oVTK1RZUeVTGSB/zzXV7swlyqbpljtGz3Bg
         /X8A==
X-Gm-Message-State: AOAM530m2bSgeB2xzohbFdFKLsmiZyS4D3rufl2TK7A37nybScru2Zl0
        bB6ktTUaMCgopurZSv4+QcT1ho8sH4ae8t8QLlwvmQ==
X-Google-Smtp-Source: ABdhPJwjKFzcjTHuclSGUXiGSm1TtHMkIAKvy2SN+VYZh3uPCY6M+sZ8EYO2SB68yJoTjWM9CObFbwQv2WXgHapqU3M=
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr7191416ejl.155.1606754709982;
 Mon, 30 Nov 2020 08:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20201127094445.121232-1-miaoqinglang@huawei.com>
In-Reply-To: <20201127094445.121232-1-miaoqinglang@huawei.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 30 Nov 2020 17:44:59 +0100
Message-ID: <CAMpxmJXxibU_i__GnCOktxPct9drrLKvf4Oo6jpXrhiJWt7QZA@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: fix reference leak in zynq_gpio functions
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:40 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to putting operation will result in a
> reference leak here.
>
> A new function pm_runtime_resume_and_get is introduced in
> [0] to keep usage counter balanced. So We fix the reference
> leak by replacing it with new funtion.
>
> [0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal with usage counter")

Is this upstream yet?

Bartosz
