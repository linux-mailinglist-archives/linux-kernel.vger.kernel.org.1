Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F594300000
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbhAVKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbhAVKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:12:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E355C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:11:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v24so6767785lfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOu+RxXJN+4OhrFI6NTPhZZGkmgivIcoBaZ/RLKaTvA=;
        b=idrTmYNIOTLYYdtsDG4l/fXS2cUDMfdiAcdfc21Xb0HgeOE4og7+Zgp+UqWnAfVYWi
         kSnXZfzOUt+QgNqdGTbfehauS6nPj5a69PoToZzCz5jcxNENMQ5np9t+6dc2ExfWPjp2
         wDN7HUmb38I3BPc1GS+0ViuPBzVwmz9OH/Qo8a0P0KUVjPzm6ToQuOWYrV2L97ueBlvh
         4TVm1+hwwjHdT2s9cskX8f+vV+qLahxo4CEAoYCIUouKQzAMHVD21L2AJyj8pMd9LVdt
         2d8XDa0/mwveSMP1vCfcokjeXQxntvSWbmpd+ooL7ot2nE9pefrcKFvqpBRbjg9pzS92
         T8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOu+RxXJN+4OhrFI6NTPhZZGkmgivIcoBaZ/RLKaTvA=;
        b=G8Mw+iPjcvoiSRjaXPdr+kMxMn23Of26psKb2oBeLxYhNUQKCnceRqZOurtNRGy1bK
         zygK9lSDR7mwAPFEAq0oS/HOx8gBRWDizUm3Wb9Y/hdlBRDsTc7Wsg5Td5CVvsYx0PSY
         GT24vB40U6oQJpWdQZqmdOrSFWVFzOe37fSznLRp0wwYMtxbPFp8V6fqGfioS1oveCMf
         VUIOIfWAF9FDVmEDU40NLHBZFdSTJyQe2jA7mml0kgMzz5ggIorKVXhEmcf4MRGf8N2q
         ZwPeHs9dyHQT3Z5BaPr7MnTAZAhBOYAeICt2WqdQ69UfwcH7O17pdH/NwpXIaEuKVjq3
         +yNg==
X-Gm-Message-State: AOAM532c17bWzcV5PvlouhNTskNXXWmOqRx0pVsbmyARSvnuLvAsAgEf
        gqVf3/sqGlUahZERVNVa5vb0KvE60RIJtt7yAve37w==
X-Google-Smtp-Source: ABdhPJxEt9RB1slVYkdfacaH8jtnPKQQoQaIrMhoczGcGDy+84p8NIqJ61gTqB7wiE/Vt8kuzFxxScq0yJ4MmBWtq2M=
X-Received: by 2002:a19:495d:: with SMTP id l29mr58766lfj.465.1611310307749;
 Fri, 22 Jan 2021 02:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20210119133320.8557-1-carver4lio@163.com>
In-Reply-To: <20210119133320.8557-1-carver4lio@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 11:11:36 +0100
Message-ID: <CACRpkdbVwjJygak+tqjLXtqs-kwVH4VbqWp23NUgs=8wFepSPg@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mm/mmu.c: Remove duplicate header
To:     Hailong liu <carver4lio@163.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hailong Liu <liu.hailong6@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 2:34 PM Hailong liu <carver4lio@163.com> wrote:

> From: Hailong Liu <liu.hailong6@zte.com.cn>
>
> Remove asm/fixmap.h which is included more than once.
>
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker so he can merge it.

Yours,
Linus Walleij
