Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199262E876B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbhABNKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 08:10:52 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35898 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbhABNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 08:10:51 -0500
Received: by mail-oi1-f171.google.com with SMTP id 9so26806548oiq.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 05:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOBlA4nmgbYcLbjWcHo5UvnezZZmpodZaYFnX7DjUAo=;
        b=apQ4uLOiSFg3vKSXhB+7kL6AVzsTECvD3iyhqBxy59Md9TVo6xX5T9cW8HU55uoN0/
         8KwolkikdFrv64URYVSJRW6V2HGdHtrX3ihFjSKXsImZRYWtZ+x4bdX4v/R64GKmhBIi
         fo8M/wy4yrFZsDffMOtAM4YFoeSeUTU2+czTa+NQiymSe98qwdlNBgNfTyiBMS0DJbDg
         jQuziVDx87AyFTRIhYehDVQIRzKoY4smlL0+8QyA5RF2/VQvn+ry1H1IU6e/X1MYugWP
         4xEqt3xeNI1FEer8ltSwfVLCGdcmcR5LQYv5Ael2tlMQD2ZqPCfrusVhU/LP3QPgcNnT
         MM7g==
X-Gm-Message-State: AOAM532eDvwBa5UFQXyE5SJsk8vV+LhKOaDnpwqKP7eHqOkI29T6pzAJ
        y5yasB1MvwgIOsnW5lYEMECQUuw88HNhQu2/sUG4sSBB
X-Google-Smtp-Source: ABdhPJzIQy2IpjbeAmLMMeFfB2dnfzRU7PxLTkW66Rjpyl+AhXr6UNO9Ef4yyU2CPgP/t0ZqPa4Ug349X0LTJTi4zz8=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr13074888oih.153.1609593010883;
 Sat, 02 Jan 2021 05:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20201227091446.118437-1-joel@jms.id.au> <20210101061135.GA3106870@lianli.shorne-pla.net>
In-Reply-To: <20210101061135.GA3106870@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 2 Jan 2021 14:10:00 +0100
Message-ID: <CAMuHMdU0HKLnmRdBqpfpZpse=SUFCSOS8TnZRgRSmqV0zEMBzQ@mail.gmail.com>
Subject: Re: [PATCH] openrisc: restart: Call common handlers before hanging
To:     Stafford Horne <shorne@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Fri, Jan 1, 2021 at 7:11 AM Stafford Horne <shorne@gmail.com> wrote:
> On Sun, Dec 27, 2020 at 07:44:46PM +1030, Joel Stanley wrote:
> > Currently openrisc will print a message and then hang in an infinite
> > loop when rebooting.
> >
> > This patch adopts some code from ARM, which calls the common restart
> > infrastructure and hangs after a small delay if the restart infra
> > doesn't do anything.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > Geert has a patch[1] for the litex soc code that adds a restart hander.
> > Openrisc doesn't hit that code path, this patch fixes that.
> >
> > [1] https://github.com/geertu/linux/commit/7d09dc0797a8208a11eb7c0c2156c1a4c120180f

> > +     do_kernel_restart(cmd);
> As you mentioned this depends on Geert's patch.  Does he plan to submit it soon?

Will do, once I have managed to escape from Xmas-and-NY mode ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
