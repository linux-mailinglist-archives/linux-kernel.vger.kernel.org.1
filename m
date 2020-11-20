Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607212BA356
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKTHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:34:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34091 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgKTHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:34:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id s18so8311645oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G2QXy2DyQdps+7JOhcILOmABxjD2Cyllu51GS8eEUA=;
        b=WlnCKx7JWEUoHMi6yzwxCDlr38vhQvLvQ7OUpszwnpw5DED/A8TNvVUdXEMFDdW1om
         2cmvQpqa0k4RvabkUpc/XinBHZ37/Je5M7unLLhxeEK9ADYhRUu4hktCfyQUrL1aoBuK
         N0mn2P/FaDhkdirbmitw+YMdBnaszwUcvVnflOgn8KzgHE5W0XUFFSAQXqrqBAoCMTJm
         ZFPLIG5v1ZTrTIWpcbQBTZ2Q4limpQkF2h1AUO19CpBDKq0+dfim0s34adzpzftaS/A/
         LOFEU79rz6QXiuMHjPhpS2xARUr3vf++ev54jp9C278wCIlVAwG1g7G8HWl7cmQh9O6Q
         rw+g==
X-Gm-Message-State: AOAM5322fTJSpcZd9XTU+vh1eQM4/q/XcaooMxuh16mTke24wgbWS6Ce
        0QslsArqa4QsNb/A+fyfsKyeJIhTE29fI24N/TQ=
X-Google-Smtp-Source: ABdhPJxTEV6JWrhe7RuqSWIYrFMwZ2x36SFeDhxHuau6uqBqN0qfbPzx+GihHxwrJaUYRpdUGeebVvqkDI/uavZJOoM=
X-Received: by 2002:aca:52c9:: with SMTP id g192mr5790892oib.54.1605857661074;
 Thu, 19 Nov 2020 23:34:21 -0800 (PST)
MIME-Version: 1.0
References: <bb327f05f8fb61eeb332cc2ba4e8335570976474.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <bb327f05f8fb61eeb332cc2ba4e8335570976474.1605847196.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Nov 2020 08:34:10 +0100
Message-ID: <CAMuHMdUQ5mJzJH7nsKTaxMTjS4yXoBM2_2R4=meg4KyxCfimgg@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Update Kconfig help
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 5:51 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> There is still some missing hardware support that affects all models,
> such as sound chip and localtalk support. However, many models are well
> supported, including the Quadra 800 emulated by QEMU. Missing hardware
> support is mostly documented at the web site, so add the URL.
>
> Cc: Joshua Thompson <funaho@jurai.org>
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
