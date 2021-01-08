Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9642EF5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbhAHQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:27:32 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:32886 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbhAHQ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:27:31 -0500
Received: by mail-oi1-f182.google.com with SMTP id d203so11968827oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 08:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azXInPSYO1Sxr7q4l4v0RAEEyoV6Ow0CghP+JPok7j4=;
        b=TbluwBQa9/+DY4M1SClgmDX/OuYaweAezVyJKUkGbfzP+trpuUChweZ2uToPgEue8e
         lkwJCgR7aWdXZLSWOBmuoVDCdXZlRpg+yNCuG5DV7n0dqOHk4u46wRy5wKXw/OotLPg4
         p9Ge8exprQ4bDi+8SoVfdr1h1S9lDJ8am8QDs5KROvXY+0rJeWc8Jr0PZDLlHIOQXJG2
         17igcnapmeb4kOtf4y2nnlnEOgILMH0xG13HQag/cqfqiRS21cUQ1CPqxxQ9Q0ywhX5B
         na4kxlTrWOQ1ha3KBaigPqjiH23ymE0N/WIb3DeuUDbdlaSsdAoX5Ernpy7zjpKlbD+W
         EsdQ==
X-Gm-Message-State: AOAM533I7HeP/dxGGg1G6/ix71btg6qMEARn6br2x147GwmbCYQNLsVw
        zehMZVgwOou7AuftmAE1kMH6pgy3Id0b9F1h7Z2iWQvyt9w=
X-Google-Smtp-Source: ABdhPJyPQ491YV55uOoMwNsIOAdkuPZquMI0Rs4CGfdDsvkg7QdkXk6frf8BGdsvk49jfEBjMSkoODf4qlj8pM19MjY=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr2868502oia.54.1610123210752;
 Fri, 08 Jan 2021 08:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-4-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-4-atish.patra@wdc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jan 2021 17:26:39 +0100
Message-ID: <CAMuHMdUYeBoFppRZzQm7GgqTvFW-sXKRG4RnTB+q0MrYMQOWfA@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 10:28 AM Atish Patra <atish.patra@wdc.com> wrote:
> SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> allocation if it is requested to be aligned with SMP_CACHE_BYTES.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
(on vexriscv)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
