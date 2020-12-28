Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64A2E358C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgL1Jlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 04:41:46 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43080 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgL1Jlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 04:41:45 -0500
Received: by mail-ot1-f41.google.com with SMTP id q25so8666598otn.10;
        Mon, 28 Dec 2020 01:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZS9a88Scl53N05Sj13evYPqONiaARLlh+dxiXCJPwIU=;
        b=T48CJwz0CGkUjiAZd/ztQclvnTiT0F0PyqritehKMhRR2NhXJPULlusn4TU+e2HHXs
         EMLOQJYMKp6vMZv3DeXiwSI1lDYCYroMGZJZuaLCWj+eSRSnZ1mbr832mxpCU4HXXFEw
         DgmtMFMJC99oDg26+rQCNIMvSSclbaUa4IeJhBHsEb7U2kRxxKIZK0HOIL+JNHfAlJd3
         Cr1ah1Wt7Dg3ULKvtF6T/gZ57sskm5LYbeFCmM7eTyxCTkxVk3bvcuQCKwaaQBh5TyOH
         vOlHkigAzIx6nM5IqX+kGp5DAqI3oUs8Jlf+UmY5VnHqofhkmcvLmUDjFYqIZKL+CciU
         Wl7g==
X-Gm-Message-State: AOAM532QjEKzAS6cU8FSu610S7OeuP2bClNz4Ti7ZgMWw9CF0EzGhZjY
        SREflNZ3bK6IAKuRlVMYQr1ReRvqKNfD+bGlq3EIZjHR
X-Google-Smtp-Source: ABdhPJzJe671dEE7/2qZKeiNG/rmbNcU++vGT457O4SxJbXgJ2WBkuqdzzR0x5UwphjBMZUtrJWf0my//P50M30O4uY=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr32360322otc.145.1609148464742;
 Mon, 28 Dec 2020 01:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20201228093636.893535-1-geert@linux-m68k.org>
In-Reply-To: <20201228093636.893535-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Dec 2020 10:40:53 +0100
Message-ID: <CAMuHMdURjQ0pTaOoj1zQEz6_Z4F0X6zxqskmo=_AppTapUkY6A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.11-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:38 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.11-rc1[1] compared to v5.10[2].
>
> Summarized:
>   - build errors: +1/-3
>   - build warnings: +12/-132
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5c8fe583cce542aa0b84adc939ce85293de36e5e/ (all 192 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2c85ebc57b3e1817b6ce1a6b703928e113a90442/ (all 192 configs)
>
>
> *** ERRORS ***
>
> 1 error regressions:
>   + /kisskb/src/include/linux/mmzone.h: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE:  => 1156:2

ia64-defconfig (fix available)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
