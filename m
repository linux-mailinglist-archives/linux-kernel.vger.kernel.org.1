Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF9298A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391552AbgJZJuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:50:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36245 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768495AbgJZJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:49:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id 32so7454661otm.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 02:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=314b+EPeJu8ztEUHKiEyh7Fe1KfnldWCCkTh7+28WEo=;
        b=MBkxKzJlGhlYEorrO9mTKT5Mia7+2Kg9f5Q39oEsxUyOX5uf05X/wwkqY4iu9sRjP5
         rvuJGffrwVE5voEyZ/MlYjMRV+BWYpkHX5aZ5WWDkladi1Hhdn4nHMS2aS8mVL62l0aZ
         131Lqw7lnJypyeQuvk2v7ohSalC2JsifM8z+ANcK01t1zdXZTzkLGkomALetLCnFQMd7
         0UKBO6RCtnsVE06XJU6kSfwU1xfwCTX8hIB6+YdLU2yZEzcRiPTekqfoTippPB1cue7m
         poCtFnFr744jtiQyki4CORn7EWAhaYvXXPt+tL+4yqvfX/uu73gPTaIgjwaqW/95U/fc
         Ah/Q==
X-Gm-Message-State: AOAM532psNiiWvnnQiaQC3ngVzX51KodsO7i2SP+TXMN4K/gPDsS1oqX
        4Sgdx8+5G1PAgC3cRPJcsqZVAiYK+d1T5SwpC2tnFrFrHx+KmA==
X-Google-Smtp-Source: ABdhPJz6Ac16eELMejGpA5pfteZH0S7xI3pqTk1GnO4kjTNW0lVeo7lq9J4RZJkz7zdoJDPT2VEy2pOJNu0QSN+3lS0=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr13819173otb.250.1603705746354;
 Mon, 26 Oct 2020 02:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201026081811.3934205-1-geert@linux-m68k.org>
In-Reply-To: <20201026081811.3934205-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Oct 2020 10:48:55 +0100
Message-ID: <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.10-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:46 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.10-rc1[1] compared to v5.9[2].
>
> Summarized:
>   - build errors: +3/-7
>   - build warnings: +26/-28
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3650b228f83adda7e5ee532e2b90429c03f7b9ec/ (all 192 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
>
>
> *** ERRORS ***
>
> 3 error regressions:
>   + /kisskb/src/arch/um/kernel/skas/clone.c: error: expected declaration specifiers or '...' before string constant:  => 24:16

um-all{mod,yes}config

>   + error: hotplug-memory.c: undefined reference to `of_drconf_to_nid_single':  => .text+0x5e0)

powerpc-gcc5/pseries_le_defconfig+NO_NUMA

>   + {standard input}: Error: inappropriate arguments for opcode 'adc':  => 170

arc-gcc10/axs101_defconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
