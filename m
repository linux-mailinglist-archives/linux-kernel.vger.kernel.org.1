Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09128B5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbgJLNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:15:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33167 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgJLNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id s21so843014oij.0;
        Mon, 12 Oct 2020 06:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=479sdd44MecSreb9si4jbrVvzN+pxNd9n3jIu5G3rEw=;
        b=YMtWBVhusDfnNMuco2wozTmT7Gv9B9IrVPJTjzbnFzyQRKn5Y+rcmymXeQk30UJW3o
         twk+CD5x9IqoXmqc8hWSQKbaVl24l26mMq0xXF7t9DSnBx2M3wN1yhJKD9nl5Xqg4koT
         WjXpqGjciFSX78JJdkbZek1GT/VW3F+T92GQOtTEXv7dUEI2iRdYuUT+Nb6uQt1EuS5z
         lV6rZcXXpjhQtQeuM35GAi+B/4GiZXe1Zj1XHCZB7Mx6pO9GegShxhm+tOPBSwDVFJFy
         xMnQMlfY4MlqSxnaHViv/YLWnDOz5d+vOf5le5xbfPqdVIbHCPBmGaaCXqoPf8E5G9Q4
         5NJQ==
X-Gm-Message-State: AOAM531+82OVXqYO0yB/tzsnoQ8MY4MASi99kO4FPUYdmqYcjkVKp4Im
        6KWkpITT8wChPK/DNtittdIBW4vCBYmy702ITQ2MC5Ie
X-Google-Smtp-Source: ABdhPJxW+cuVuSNpTqFXx/Oo7DUbd+3z4lLadyCXqpYmjYp69GvJFXK10DtV6alyiU95OoxbP6hkY5LDEnOMkJzJjYo=
X-Received: by 2002:aca:4441:: with SMTP id r62mr10153443oia.153.1602508517137;
 Mon, 12 Oct 2020 06:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-8-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-8-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:15:06 +0200
Message-ID: <CAMuHMdUgT38aG7YNqk9U2iD-y-Ms3JJO24jfVY9pGweuRFMcjA@mail.gmail.com>
Subject: Re: [PATCH 07/13] m68k: sun3/sun3c: use legacy_timer_tick
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
> These two are different from all other machines:
>
> * sun3 does not call timer_routine() but open-codes it
>   except for the profile_tick() call that appears to
>   be unintentionally missing.
>
> * sun3x has a commented-out timer irq handler but no
>   functional timer tick I could find.
>
> Change both to calling the new legacy_timer_tick here,
> which includes the call to profile_tick() but does not
> fix sun3x as that is still commented out.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
