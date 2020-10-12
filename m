Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6E28B5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbgJLNPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:15:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45926 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbgJLNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id j7so1101790oie.12;
        Mon, 12 Oct 2020 06:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpOWl2K8xGZe8ObyWcT/Rs8C0sopZbqbVvo88pQRdW8=;
        b=rfCEB1dRndNdvCiNRKyfAIolIc3X8BOvfdTslUV0aaj8cASuzaoQIVN042SjOuc6gK
         ZmCRoJCvwixwBJv9vNoSbhxZMtAocDiLnwzPJxarpbNWgKwNbKZeLRaoifMP5Uk1y1cx
         hOyglQG2837dFTotqFRIUsFwfyQJbCEwpgUVBBKz9RIAs+9oa2t8+pHhin3UU/1Qtzye
         3R3dXJbjdMFRG/wcpZPzkG/sOrZ32jAWKl0HF1D/1cqKudlq7AGjmXyYLOw138KPRbNF
         sGidQYz/1wEkth3OZ9u56mwlttKlyYDPiddAGFP22PGFWFxl9CK8eTFK1AOBFa29oNrG
         x4/w==
X-Gm-Message-State: AOAM530n0OEHIU+cThJxD7U68Qn2Wbpgn501AGlwlW/Mzw0paaqVddhQ
        omXKhf9krmIvNqL90ZZ5jbe2PJEZtcTNNNgT+RY=
X-Google-Smtp-Source: ABdhPJx4N97WaNtxkBiGWavGJamYpC2k/3nsjt/ifSHOvJJxlsVXZ3k/2Mj9uJqTjcLeGamsrfAVV4ILuEa2QQZHLEA=
X-Received: by 2002:aca:c490:: with SMTP id u138mr10798781oif.54.1602508510780;
 Mon, 12 Oct 2020 06:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-7-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-7-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:14:59 +0200
Message-ID: <CAMuHMdWPcw39MZotZtBP-b_CiiaX0iyys5SyuK6TYQQZ0+k_PQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] m68k: split heartbeat out of timer function
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The heartbeat functionality is mostly separate from the
> actual timer interrupt handling, and it is only used on
> five platforms.
>
> Split it out into a separate function and call that directly
> from the timer irq on those platforms.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

And finally (for Amiga):
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
