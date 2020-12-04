Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C02CEB1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgLDJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:40:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45299 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:40:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id t205so5462340oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKYautqiHQEpkDB1c+3Dy3+VdTIBoWQmd6MxwQREzb4=;
        b=qPB5DtqtRkX6aDrRIuCHzZMhxgNOdv5YwDN9whs4bgqZCa+b5TAPb5igHVvR81bTIU
         QXPNkpTR2EtF4pbkkdQPML7iIpO03SOO2UAxFGnRgm3YPJQZDqJMai1/bOyi7CKW6aoy
         u0qrXjhknsnN/ibd8b5eMaWU4q4NSHoiYlcXHzqBvsqqKKFtggO52LV6WD6PxThywgw8
         VDm7+w+9t286PMweLeBDcyE/6mwxJ4JejlexninMjWyBtDIRJG77d+H6QDvYLA7CMcwm
         x5/ghSF79MPZ6NRonreyxpgehGlp/E5b7pSMlWYvuJesTn66tHL4f05oFmGUFM4pgd7b
         PCMw==
X-Gm-Message-State: AOAM533+/8gJC94VVjvg4GeCmt2tcdV1PdvyK3TGJ56XmsouNtyLkvv2
        Pr3IK4TvI45oaJ8btfa0l+ukr53u3JZA3W9x5lzmx1eG
X-Google-Smtp-Source: ABdhPJygxWDI0dik2fcz4VjKkQs2fqv4QrqQyCylbk9IR9N1BND3VFsECpHuiZZeicA/CAJZGBhaMtKemAcn4UHW5uw=
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr2568905oia.148.1607074783084;
 Fri, 04 Dec 2020 01:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118191314.4019887-1-geert+renesas@glider.be> <CACRpkdY5iTsW371gB334dXqr1H7iycd248y5k62ZUx9ceC7HPw@mail.gmail.com>
In-Reply-To: <CACRpkdY5iTsW371gB334dXqr1H7iycd248y5k62ZUx9ceC7HPw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Dec 2020 10:39:31 +0100
Message-ID: <CAMuHMdXhevvKLd_+P8U-J1k=0=bUB+hEGy2S6T+Hr2Bp-mnGCw@mail.gmail.com>
Subject: Re: [PATCH] ARM: uncompress: Fix dbgadtb size parameter name
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Dec 4, 2020 at 9:08 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 18, 2020 at 8:13 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The dbgadtb macro is passed the size of the appended DTB, not the end
> > address.
> >
> > Fixes: c03e41470e901123 ("ARM: 9010/1: uncompress: Print the location of appended DTB")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please put this in Russell's patch tracker.

Thanks, done.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
