Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385F30417C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406080AbhAZPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406084AbhAZPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:04:24 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A0C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:03:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t8so12609597ljk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KecQmTVET4kmmQb+nGX7vlSRx0qisPRYWkX9lTkeJwg=;
        b=tMxc7G8wt7liaMOEZUYsU792Zl7DIEWinvwQf01g4C8G/gktlKtYPlb7aVD62qQ31+
         TPPtTaUtCo2l4J5uChJE5wyRijakGYaqqa2MQs3sXeJ6yGWOfzqclxWdEx0HVKMfFDYG
         oHiR5NSBEyR/jx33tUPqlH/vW44cGk0fPXHXZR9gjcaG5aOHK3z9o1IukaoSzqdmfbcs
         jxHfV5wr5/guFDlOmSiARfMcRXavnjpy28Nr9/iIWcrppMd5sTTUSMCd9KS+yvyA13U+
         DaKco1PmEy5DWKAzQVVSEZzTVyl92U1eFp5S26ttUknDtHEL3FVabupf6FM2hcu1x8Yw
         7FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KecQmTVET4kmmQb+nGX7vlSRx0qisPRYWkX9lTkeJwg=;
        b=jD+kaxjY9LyAmK1p5ksSYhcWAuBd4MXPnaIxv0tflXb8/GHr1N/JMj9V8kGGe4AZMW
         vMbZ1WZI8lvrJjTGwvBuD3KZbxeJvjywF3qhpJlvVbYGMdHMw9vFK9PM5svCp4XIed8c
         n5CPpJbz94wOvVW7YNZkAyn52qu5twmKeBTqIhW09aafLLiikcKidc4dI31g2FDmxLy7
         Dwrq36tMCTPbzQNGtSH9Y71mbu5mgviZpSmSzGx/+DFJ668mwTdeoCNtLcWQtGvD2S0i
         AxP9MxFpuKDOlQiXQjP4FDPf3FPggSuxnsK/O8GCR60mJq7dcw1jutLGdCh1ZWH9LTGV
         Hy/g==
X-Gm-Message-State: AOAM533oo4x7NQJeodvwlHxGhgT/ILsJIWo99eInEbMkhaLATrJm0esx
        f4D8rRgYD/fzr4bSKpl82L9/MtlgSGRKCSRj01lLYg==
X-Google-Smtp-Source: ABdhPJwG/6a1Su0120L5C7R1KMmFNO61Pb5eFJNnzViBU06i6BbRAEw7ofQUlMC7EP9ZRYICO8aQcEMFWBxyALLM+7A=
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr3186242ljm.273.1611673422964;
 Tue, 26 Jan 2021 07:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20210119062908.20169-1-liu.xiang@zlingsmart.com>
 <20210121164013.cqfxvach4ugkohm7@gilmour> <CACRpkdb1gn2e9=ip6ipAwW27vmf1FCs_y1Z=w-K8y8Z9MXVBMw@mail.gmail.com>
 <5c4b7a8c-c549-43ae-8ec6-5ae3ed26d321.liu.xiang@zlingsmart.com>
In-Reply-To: <5c4b7a8c-c549-43ae-8ec6-5ae3ed26d321.liu.xiang@zlingsmart.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 16:03:29 +0100
Message-ID: <CACRpkdaJQcuWwS2g4UgRpWb+iHYSmWoNj6gEsvGwtPZq+aJBbQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: fix use-after-free in sunxi_pmx_free()
To:     liu xiang <liu.xiang@zlingsmart.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        liuxiang_1999 <liuxiang_1999@126.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 7:31 AM liu xiang <liu.xiang@zlingsmart.com> wrote:

> > Liu can you make a patch to Kconfig to just select REGULATOR?
> > Possibly even the specific regulator driver this SoC is using
> > if it is very specific for this purpose.
>
> I found that the regulator driver is related to the specific board, not the SoC.
> There is no board config for ARM64 SoC like ARM.
> Is a good idea to select the regulator driver in the pinctrl Konfig? Or just
> select CONFIG_REGULATOR_FIXED_VOLTAGE to avoid the use-after-free warning?

If that regulator is what the board uses to satisfy this driver then that
is what you should select. Write some blurb in the commit message
about what is going on.

You can even add a comment in Kconfig like that:

# Needed to provide power to rails
select REGULATOR_FIXED_VOLTAGE

Yours,
Linus Walleij
