Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF052D1A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgLGUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:20:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33258 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLGUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:20:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so13775552ots.0;
        Mon, 07 Dec 2020 12:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8fj10nDje2x93+KcCvXW7CIv2lqtiTGkIsq3PGAkpQ=;
        b=QmWP6UUvEWOLWv8TLrh9DFiSAHMmF2KIfYfdt1772iEs32YcEfZquSi1tPhho5cUgu
         +P17fJGWsgGOF7LRUUBGakSETmkvkEmtn38UsfXZ4QLYGvnLOCLugminfokPrlPuCX2f
         Gj8PbY/URhtjhyMWkR8My+ROLvT7jesf/jSgi7MrgDeM2LHetq5a1Bc+dfEz7S13fdNf
         h4XCbL/nvv9EYXMzdUvMorHByNKVQw4Eymsw7CiWucxoGrBnZuoH8YBkpOTJsG+sIlsT
         ndj0NKMCafdxqirnxifWzf4ro4f6pgNLIwdR5vCCtYZ15wVrOdDeMeBgfwvOr7+GNtUZ
         g2wQ==
X-Gm-Message-State: AOAM532OQm2Waypd04pkUhUMTH/zvlin4Gqk8kHXq4mo7OHB/UVKLDu5
        2O3EAqO11cw9DJTsb4coyZVfwPebCsnqPOxx4iO3yklJ
X-Google-Smtp-Source: ABdhPJy2xXJ31q/f+prT+1t1V3CRJwLEpaT1rJWaISAdMh4ZqnS5NVqYeodB/wICppPMsAb4jFStHycuOjYZ7aK37g8=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr14394879oth.250.1607372403410;
 Mon, 07 Dec 2020 12:20:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
 <CAD=FV=Up-JW8RtMLQ_pAG3e0d8NnpT+rDiguxcz3DnVUz_7Jbw@mail.gmail.com>
 <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
 <CAPDyKFp9L+L9VeUD038G3mBTLBuPJsMtv7JhxCcSGb3iY=eq5A@mail.gmail.com> <CAK8P3a1Va_xJzk8qqJM1VBWfSKpomKbQh_NpPO20aoORoe0SWQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1Va_xJzk8qqJM1VBWfSKpomKbQh_NpPO20aoORoe0SWQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Dec 2020 21:19:52 +0100
Message-ID: <CAMuHMdUT83EkE-phUX2Z431AtGPfZvXeKwQriDKEHJKfr2R40A@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC devicetree

On Tue, Dec 1, 2020 at 3:06 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Tue, Dec 1, 2020 at 12:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > So, I think we have two options. If people are willing to move to
> > "disk labels" or to patch their DTBs with mmc aliases, things can stay
> > as is. Otherwise, we can revert the async probe parts of the mmc host
> > drivers, but that would still leave us in a fragile situation.
>
> Can you reliably detect whether the mmc aliases in the dt exist?
> If that's possible, maybe the async flag could be masked out to only have
> an effect when the device number is known.

IMHO DT aliases are not a proper solution for this.

Yes, you can detect reliably if an alias exists in the DT.
The problems start when having multiple devices, some with aliases,
some without.  And when devices can appear dynamically (without
aliases, as there is no support for dynamically updating the aliases
list).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
