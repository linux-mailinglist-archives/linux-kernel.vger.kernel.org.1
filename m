Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3572B2C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 09:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgKNITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 03:19:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39510 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKNITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:19:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id z16so11134372otq.6;
        Sat, 14 Nov 2020 00:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsO4YusmCWtmh3PFk8rpkaoH2Xb+m3Y7qEI/Mhtk4iY=;
        b=htA6okI/laLi8wf0vOlAhx/4jKuXWVDzC78uRJny0FzAc9fbiosDnX63jB7YUaF2nB
         wP1KJzouoGHIdsi9h/3OD0VQoEb9DM39108W5CKf8c22LXHSHrrkCN64P3KcMqEV+lGn
         61Lt/PUv4U/8BARb5g3wd9s0dobt+87Cg8pgE08BSnALjZTONTPw1Ed3yIOx+tKGDZfH
         fFqAati9QGvOM74UMKtWgB7bw6D8VdCCQ2DpSyzCZl17gaDk1uiI3TvVsUP8wus7TFFG
         m4RX48d5uFiqCkBK85D2sV57ffNj3O0lMSd0wizYu0+XL7XMUVeOQKqUSo1mO45LcyWB
         b5uA==
X-Gm-Message-State: AOAM531dXUcsBS+xWELmFCt6sC6yG3sCHJFrVICTo31A0RBWObwn0Npa
        APKdDy8QzfDGU4lXRYw4yn6qD5O0XARfw2Z5Qk4=
X-Google-Smtp-Source: ABdhPJx401sGw+XL8h5gJ4sgYQkRZ1cEOu04jprL9naZjocGh6jJL3ERtDEGeRUDF2fkGNoiSYta76yuvwv1zPea+Ac=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr3947226oti.107.1605341988652;
 Sat, 14 Nov 2020 00:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20201110144033.3278499-1-geert+renesas@glider.be> <20201113150421.2614cd8d@lwn.net>
In-Reply-To: <20201113150421.2614cd8d@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 14 Nov 2020 09:19:17 +0100
Message-ID: <CAMuHMdV+1kSb0qYU_CY0H2FV9AwhCQ0m8DQi3Ao+AOM1KH6owg@mail.gmail.com>
Subject: Re: [PATCH] docs: ABI: Drop trailing whitespace
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Justin P . Mattock" <justinmattock@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Fri, Nov 13, 2020 at 11:04 PM Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 10 Nov 2020 15:40:33 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > Remove all trailing whitespace from the ABI documentation.
> > Most of it was introduced during recent updates.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Fixes: 0ea6e61122196509 ("Documentation: update broken web addresses.")
> > Fixes: 54a19b4d3fe0fa0a ("docs: ABI: cleanup several ABI documents")
> > Fixes: 3197ebdb130473a9 ("ext4: Add sysfs support")
> > ---
> >  Documentation/ABI/testing/configfs-usb-gadget-ecm     | 2 +-
> >  Documentation/ABI/testing/sysfs-devices-memory        | 2 +-
> >  Documentation/ABI/testing/sysfs-fs-ext4               | 2 +-
> >  Documentation/ABI/testing/sysfs-module                | 2 +-
> >  Documentation/ABI/testing/sysfs-platform-renesas_usb3 | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
>
> Applied, thanks.  Not really sure we need Fixes tags for a whitespace fix,

Thanks!

> though...

That's why I put them below the 3 dashes.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
