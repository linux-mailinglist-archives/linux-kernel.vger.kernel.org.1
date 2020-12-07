Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59262D0B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLGHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:36:35 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34331 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLGHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:36:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id s75so11371465oih.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81A1/EI2V5mNEQhjEQLpvlKbCZRpRrCc/XWWtaeN53s=;
        b=kKRvZJayZCNEEJxNbqY/f1JqWGQPyo3mKGN+0FZZQPP1U+TRdSIi8lSvYW+h/WO1+2
         DmrloVsaupcf1jCloO+TV4RgiC3NMMStiI+336hoJgLmQlyMA1fBvfJ7GpgbCIVOuIc4
         BSIS4Cvw6kbaCB2jpQ63nwkguLikUV7L85lJecAtTc922JBs9DwrnosBYHQ78dM+28Gx
         qRALjdrc9aFrfg2mTd9uqdazilIpSCvyWwkGAvSL3e24ZivTaWgh9iolKAFdUmTgHxog
         6m7Na8u6l7SMgqynbQb7bUmvyTlLRGmd1XuJ/Pe1Ay+CDCE7CAVAG2LiRX09BL+wcu5z
         RyqQ==
X-Gm-Message-State: AOAM532zTFY0TfdC10vfOQY3MeR9BmVOU3QWIvGG4RX4FGmCC58j0FVq
        BojFLyWr8JmCChq73TZL2sSPa996Q1zZZ+AUxYkljz1Z
X-Google-Smtp-Source: ABdhPJy/JEX754OpU/TA3+t9ubAjETJ+JgblXzUnQ4UMH8YPy4PUYm8OthzBU9+DM64zMQkgJyrBU5FFU4KbRsoCaak=
X-Received: by 2002:aca:5c08:: with SMTP id q8mr9941990oib.54.1607326553857;
 Sun, 06 Dec 2020 23:35:53 -0800 (PST)
MIME-Version: 1.0
References: <fbac2cd8632bb719f48cd1368910abd310548a0e.1607139987.git.fthain@telegraphics.com.au>
In-Reply-To: <fbac2cd8632bb719f48cd1368910abd310548a0e.1607139987.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Dec 2020 08:35:42 +0100
Message-ID: <CAMuHMdWVS1nQM1vP5kyz9Dz3TmzYSDeZxCPXGpG-pGN93Zdxcw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update 68k Mac entry
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sat, Dec 5, 2020 at 4:49 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Two files under drivers/macintosh are actually m68k-only. I think that
> patches for these files should be reviewed in the appropriate forum and
> merged via the appropriate tree, rather than falling to the powerpc
> maintainers to deal with. Update the "M68K ON APPLE MACINTOSH" section
> accordingly.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
