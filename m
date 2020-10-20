Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2752932A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbgJTBXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgJTBXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:23:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FBC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:23:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b1so2336772lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=th+0/xxF/HYzACvmXr4ANHX6lzaHPNa8gNsU1Dv2cks=;
        b=XT9cVlUl5V/Jok3V7qXUik9lPh6fCuMWC/y1Ah87IFWy21nO8EzPWi/CZfy2FCENiE
         xsZJrGyN+6SxhgfBcNUctdGLOanQ1LzV0Ryh2zh09jZGWcbLDlpdmjKES+QJHUT7fXpQ
         rkt8GsElNUbHRpX3TW6+b6HKBO0cjwvw70sJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th+0/xxF/HYzACvmXr4ANHX6lzaHPNa8gNsU1Dv2cks=;
        b=W8M81/YyQaMId/5Czbhxs3O1PsHT3sBTp+iIZ6VG9zw+jRNjlWq9EAdoGVkNL3yk7v
         MBd9fbNfDZqJIVU3N0m6nhhpsyGl0GnOqlbJiSyY9el9hab3I3z8PiUSvuqwK+yBqy03
         i+ZsTkJsyPFHIMnO/fuGHnoU6C8/ZxQNGGdpGuMlueeO39a+iWhy6Uoh+CttOQQCTY0X
         6FCJ5ceU+b/M8FS5ScF4Mo6nDoWL/DQZvkQRM+fQH5acXHGJAPdIoiTmEeLJfeGztt36
         aTS70nuQWhRfy9heLmdbYr9rx8BG5884oqSqN9Hw8vEbNlYPjMCBSFck+T0njINQp74p
         ESOw==
X-Gm-Message-State: AOAM532mcvgQoaL9Xpdc27vMk4QkaY8s6y7DMrKl95nNOqH2R2Mc+RhW
        279z3DOPRS7em+GGeKbC6wvrR8p8Gn2Qwg==
X-Google-Smtp-Source: ABdhPJx3qDdkeoinZAFcS3veZdqQyhJU7kb9Woz71KouIaEmJEACwCSeCCsYMrQZ3/3td2nrG0JQ/A==
X-Received: by 2002:a05:6512:3143:: with SMTP id s3mr124815lfi.2.1603157013793;
        Mon, 19 Oct 2020 18:23:33 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v16sm34217lfq.68.2020.10.19.18.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 18:23:32 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id c141so1924lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:23:32 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr119497lfz.344.1603157012012;
 Mon, 19 Oct 2020 18:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Oct 2020 18:23:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFoT7wKiGDui4zt1xCcXq14KovYzoZd_3iujy2ksr1Jg@mail.gmail.com>
Message-ID: <CAHk-=wiFoT7wKiGDui4zt1xCcXq14KovYzoZd_3iujy2ksr1Jg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:08 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> There is one merge conflict, which is between my fixes and for-next branches:
>
>     diff --cc arch/riscv/kernel/vmlinux.lds.S
>     index 67db80e12d1f,9795359cb9da..ffaa3da375c2
>     --- a/arch/riscv/kernel/vmlinux.lds.S
>     +++ b/arch/riscv/kernel/vmlinux.lds.S
>     @@@ -66,8 -71,11 +70,13 @@@ SECTION
>                     _etext = .;
>             }
>
>      +      INIT_DATA_SECTION(16)
>      +
>     + #ifdef CONFIG_EFI
>     +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
>     +       __pecoff_text_end = .;
>     + #endif
>     +
>             /* Start of data section */
>             _sdata = .;
>             RO_DATA(SECTION_ALIGN)

Hmm.

I put the INIT_DATA_SECTION after the __pecoff_text_end symbol. I
don't think INIT_DATA_SECTION should be considered text

I suspect it doesn't matter, but if there is some odd dependency that
I missed, this is a heads-up that my resolution doesn't look exactly
like the above.

               Linus
