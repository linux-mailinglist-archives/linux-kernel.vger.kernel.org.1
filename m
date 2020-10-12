Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2828B5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbgJLNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:18:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43562 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbgJLNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:18:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id l85so18656990oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aMWY9DGRjs+jduT+N0yf7HvNAAtSyYLaBXYdq1dzzY=;
        b=FDBzwDu+KUfZhDtvcrLogW1zgD7dkWuOnBTiCb1Rk7x58mP5EfsR5GpQ+iiIN9g5HP
         fQWjVgV4NPLfD85YkV16RU/ikNXs1jcpvhIbBDSoZnAYBdV/XP5WM863vO+Qx8U5p+Dl
         pn76QllGs5FQ/NxS1B6qVrZJOGbHBe30kZCzgOqEPjG9HKMGT5EhAxbbFh0wLgcvCN0a
         23B/MKeAPa5Tz5RhSqjF02vz6Ysi1tV4I6jsziBEnaW0s4jMLRMCpCbjpjbO+feYkzlm
         xxvmD3tbO3oVXSHuaf4me2ka8nCkhdQgRx0n+2ow83ZEfjKgxOCaOheCIVpwqFSyyDpM
         xlig==
X-Gm-Message-State: AOAM530PUPJSmi6Ugy0AHpEE6rkvjSO9V7hF6XbfyJ2hcrvkGgUcr1Zf
        ffLqW4gRppGww4BEW3BeZpAu+jODSAVXNkDui3r001Y2
X-Google-Smtp-Source: ABdhPJxE8Y4OMEfu8CnqWe2Vd68rfLTLW4vBYd/syOBG4o2qvCFamDMdiPviCEGxqaCAq2EaIlCaQPhdcEamd6RLSq4=
X-Received: by 2002:aca:4441:: with SMTP id r62mr10164517oia.153.1602508735977;
 Mon, 12 Oct 2020 06:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201008123429.1133896-1-arnd@arndb.de>
In-Reply-To: <20201008123429.1133896-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:18:44 +0200
Message-ID: <CAMuHMdUaS=qkGT8YXTHBwW3UJDZay4tt8eOkR0r50-guts6egQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: avoid xchg() warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> gcc warns about the value of xchg()/cmpxchg() being unused
> in some cases:
>
> net/core/filter.c: In function 'bpf_clear_redirect_map':
> arch/m68k/include/asm/cmpxchg.h:137:3: warning: value computed is not used [-Wunused-value]
>   106 | #define cmpxchg(ptr, o, n) cmpxchg_local((ptr), (o), (n))
> net/core/filter.c:3595:4: note: in expansion of macro 'cmpxchg'
>  3595 |    cmpxchg(&ri->map, map, NULL);
>
> Shut up that warning like we do on other architectures, by
> turning the macro into a statement expression.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
