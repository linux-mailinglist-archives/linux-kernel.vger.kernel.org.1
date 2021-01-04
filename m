Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035FD2E9306
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhADKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:03:23 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:44450 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbhADKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:03:22 -0500
Received: by mail-ot1-f43.google.com with SMTP id r9so25454113otk.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+QLQt9AMoTExNV2CFjcXfC/nhN+V4EBAqQVrUbB+kY=;
        b=j0cT+l9+hA85ZL+ixm/P7CxkFFjUSptdW8AOh4EO4OStoxfkxUdwz5dXIKrybexCST
         L8D3ECxjWFL6cLwxjYPlaV27HCTkHGzNRmQwSNdRui6uVwVWiCADaZFVPTq9O3mAQ2iq
         i3PM86EXegwUQZsjLc3oAMHF46xdNmsbbaDy+AzLewo4VRHBskm22usDKGHJUFmsFEY4
         /0ZrYTEQoL/iIVsAYSfCwM1S9GPt/LaEMwh53OV9EbYywyWklrsbKAOxsgm21vTCy4KM
         fBy+TK7SrpeGby7Shereg6yYf2pP4OmwDtKt78HhGPxpwi+vDdCOtaqfwcyle7Mae6ry
         O9XA==
X-Gm-Message-State: AOAM533Vj/wnHOtSWW0VBLZG5NPnH44ahHKYOOA2dUT20LZ2RV359vES
        zH5GDZJQfSPCEwqSaNq920t59L+nQ3I/RsAzXlWuC7iq35k=
X-Google-Smtp-Source: ABdhPJwpCFyPdn5O4smo+qfY+AlcG3VGixuW+JWhtMeuCCiDzYBwYnmEdR02rhn4P9ans7JbzYu/6a9OHHmQuoVv5Qk=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr52324880oth.250.1609754561777;
 Mon, 04 Jan 2021 02:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20210104095713.1024466-1-geert@linux-m68k.org>
In-Reply-To: <20210104095713.1024466-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 11:02:31 +0100
Message-ID: <CAMuHMdUxVNo8r9UJ1jX6YUDGQoikDV3-66taN2BEBwMLz-yODw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.11-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 10:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.11-rc2[1] to v5.11-rc1[3], the summaries are:
>   - build errors: +2/-0

  + error: modpost: "irq_check_status_bit"
[drivers/perf/arm_spe_pmu.ko] undefined!:  => N/A

arm64-allmodconfig (fixes available)

  + error: rk3399_gru_sound.c: relocation truncated to fit:
R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x6a8)

nds32-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62/ (all 192 configs)

> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5c8fe583cce542aa0b84adc939ce85293de36e5e/ (all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
