Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701153018BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 23:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAWWvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 17:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 17:51:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE8C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 14:50:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p21so7538953lfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FMoc4rlspXDa8RwRSPjCdNzMvT7gR3rZeQf96XBACU=;
        b=pbHIGHcB7/lNJJmV0AhwRirB26dYTxu3e31nG5k+1V883Fo3serpCHGlkQjvptzw5V
         jgt+5itvcsdHXwk6ot4vFnyGEHAS+ojZseTkdpm+/KgcJyCqR0wcd4X9ZzF9YqCBRWo5
         jHdgu/hAV9UMV1H6VqC/qljA6s23hMAvIDlLgLI9w+m0U/3080Pudx5ozHB/diXy/fHy
         NDPjNz61WrHQE+PBQnguw3uKznYeJeMWwQmKnoVxNNAV72/1GN4Ep8r43BVvGwvLPuP0
         FqVg19A3UAINYsplzs5ty+R5Nlf4DRxAqlrD8zNVOw1innEqLSKe3o3vd5CS2uBqCNDq
         PXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FMoc4rlspXDa8RwRSPjCdNzMvT7gR3rZeQf96XBACU=;
        b=trHAR8fATYoSk+eJ8hzqJqeiD1vF8xyAHTjQtRbTfGPAC+A4QZ6HiQXjWSTuGm1CHp
         GN/toNm+tiHT5glVCCAlNYNlfX9sLQRqmAhFs0ZxNRJ+60fzf9UjLhKz6eBAIJwFQqrG
         FKRdoSAUdTFpAIt68SyqEPaqj+pxB7Od/fVEPl+16fb+FP5oLHhF4wTtkAf05MGErbNW
         bdhCLVb0m9K+dG72w6zk+FvPxK1Zt41PxoDOOkSqvjlT26WI+pmxTpOcPTA3ag6LWOuE
         1FzIl2LvTHhCCsJ2y8nIko94ngblULTysO37naHVfs4mHwrdBpxQxhNhdUppZsJbk0x2
         rTCA==
X-Gm-Message-State: AOAM530BLuDRrCgcKoY0ahkC0nDtzzM0WGAOGU4tqMTjNJfIW0ffNkXZ
        4e/fYtHfBfSCv/37HrvRUJ17UsNQFGMcmVGGdiigAg==
X-Google-Smtp-Source: ABdhPJz7Cj86RdMSh12IrhlVXOFnQOdiRQMmkZvBPn+guW/2OITi8G0VXT9ofQRUB8w1pTsH++NbMzf6BCL3BQx5gEM=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr826516lfe.29.1611442218331;
 Sat, 23 Jan 2021 14:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20210122185543.16554-1-digetx@gmail.com>
In-Reply-To: <20210122185543.16554-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 23 Jan 2021 23:50:07 +0100
Message-ID: <CACRpkdZTyBuz240iYuvi91k3dLKKXX=4DNxFEBP7mSNB58XtDw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Support building gpio-tegra driver as loadable module
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 7:59 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> This small series adds modularization support to the gpio-tegra driver,
> i.e. driver now could be built as a loadable kernel module.
>
> Dmitry Osipenko (3):
>   gpio: tegra: Use debugfs_create_devm_seqfile()
>   gpio: tegra: Clean up whitespaces in tegra_gpio_driver
>   gpio: tegra: Support building driver as a loadable module

As these three patches clearly make the kernel look better after
than before:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

However when we are doing this I would strongly encourage you
to also make a patch implementing remove() so you can insmod
rmmod the module at runtime.

Yours,
Linus Walleij
