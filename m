Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198282F06FD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAJMEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbhAJMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:04:42 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA3C06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:04:01 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u21so447681lja.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ut3sHTih6SxiYQ+biWzC21Eu6q3g6VnEGiS70Ql4c4Y=;
        b=DyOAZHJiSb32U4MirOJa4gY4mALVQB5fHLxHef478KEpqK9e61jtCZ1epVv7hWIYif
         qhMQLVGv8yAZqtU0u+WA+3AAhHEnAoQHexIj2uD8tuXQJ918Lg4m7XUvtVmTpmngvmto
         sRBGh5GWYi/YzW54ZVil8g1SNqshHdmF74Lf7Ty2RlYZcHa1QDvbBIh8w+eZ4stBoxwx
         WXEdn60XTIUYG2oMofjBGj8fn9R265/6HAJ25bUco8zNIgozQC5PdZIXOZyeLEaf4+Ce
         LKEPaV/JHIG0SW/YZn/T5hu+p9sjJbna3IVhr1b+NGm2C2txXr9v5w1NYBL78cwZShjx
         +nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ut3sHTih6SxiYQ+biWzC21Eu6q3g6VnEGiS70Ql4c4Y=;
        b=sYNAuXu9RTA+HQqQ37EWmCf966MAoW2dNYzZdkU/l9/btm1Ys4dOaUahyWqJ3xbDiK
         f0N4WThQ/hpd2CL5lFFE6miAD5cVDj+rmX2Z+Jpitz/wYPE1L5d+rotjV46rcRyrWNji
         +0ytdD85w1dEkC5W1tiVvwNmKMmzJungfI0rx/Im2C0Eeo2q1jPp5vI2P0GKVVeQvlzN
         jrbbb6ZWwnWK26FNcAUsOsb70yP21BqxyImhD1m7mIUXGu+TkdHC4T1L0aZMHV4WM3XU
         ZZXBqQ+YW6uB7bK3YwaiZdtWitdh+Do0KcfgFfO7KYl+c39vVrPURwczRabPNeAqaVAQ
         E05w==
X-Gm-Message-State: AOAM530gsCQizP4mQ2CSKsOy8zYK8zOknkZ3jMLEUjXSGh3V0sGMohWG
        VxlBpbeDLwFygf10rqtRWQbHLdYA2awuM2YfpO/xVQ==
X-Google-Smtp-Source: ABdhPJwbZ9u9tLy2/XFt0F66+M0igECKW80M19PxEqHVLAIKfq0UPSavkEy7aq2hsE0b3l+YYmRu/8ugnJRO4KjszWA=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr5587855ljo.368.1610280240490;
 Sun, 10 Jan 2021 04:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20210109044622.8312-1-hailongliiu@yeah.net> <CACRpkdb73diprma9Z1-4nm5A9OTQMeGVK=Hcqiwny9VOVdA=QQ@mail.gmail.com>
 <4c009d78.4e1.176ebcf8bc9.Coremail.hailongliiu@yeah.net>
In-Reply-To: <4c009d78.4e1.176ebcf8bc9.Coremail.hailongliiu@yeah.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Jan 2021 13:03:49 +0100
Message-ID: <CACRpkdY7eYyVNvqMRYvTQsLNrXa+fzPsWA5JHDuS4nqry+CHcw@mail.gmail.com>
Subject: Re: Re: [PATCH] arm/kasan:fix the arry size of kasan_early_shadow_pte
To:     hailong <hailongliiu@yeah.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ziliang Guo <guo.ziliang@zte.com.cn>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:21 AM hailong <hailongliiu@yeah.net> wrote:

> >> +#ifndef PTE_HWTABLE_PTRS
> >> +#define PTE_HWTABLE_PTRS 0
> >> +#endif
> >
> >Can this even happen? We have either pgtable-2level.h or
> >pgtable-3level.h, both of which define PTE_HWTABLE_PTRS.
> >
>
> I guess not for arm. But I'm not sure for other ARCHs.

Oh it's a generic include. Sorry for the confusion.

All good then!

Yours,
Linus Walleij
