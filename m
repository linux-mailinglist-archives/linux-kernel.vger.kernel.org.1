Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A072C3C27
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKYJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:26:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44251 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgKYJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:26:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id y74so2079665oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 01:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0naYcgOV/DJ+KlBgbco2JRHU2RQrz3Hzd4fGpqCjFY=;
        b=FnyxavJbAQ62bXzyKWFHsmvYLYmhs7TqQp5Li5SRExnm/h3sytF5NGDBbXZjwy/Qio
         gNFK+1o3RTb1URbigiakx/PEAeZeqcg1mNdI5N5rFEzPnIiNx5sCsMrJ3cfIyTdfFbXg
         qbjvPN8kQKi+H1zqieBR2+05r8iAj5mpUQndDhv/8Ew24l9IrqyZcBEJs1t+vGv3BRnb
         /A3iUeSQ4sFUJZ852yslaNHO9sywKhdx8hN59B+iGEWaNCognS/LZPaM586lj1fRDcK9
         UrMKg28eZm5xjRgDkbDA6Gj0q59JUkRiZJGHHhTrA4P7tgMqaXDJpTEh/cGZWseQjrei
         uorg==
X-Gm-Message-State: AOAM532EfD5WQcNAOP9hG1x0O8rE3Gcz4nmf2KOcA5Vp6YkzCtPXSB9j
        chnUDxfnTn+3E3Hll1orrDOzM7dgifP7GZiaeAE=
X-Google-Smtp-Source: ABdhPJx18RYQTxCsRgCfIAFtw7e7+lJPxNNjSOT84XKGNRcQCOcw9TVuqcmzURk/G9pefApf8Ugv7JxzIsZsRQ6643Y=
X-Received: by 2002:aca:1c0f:: with SMTP id c15mr1683258oic.54.1606296373860;
 Wed, 25 Nov 2020 01:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20201124185738.3541314-1-geert@linux-m68k.org>
 <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdW9dySq3y_Uixv8_7e+Pe2VKw4iGV36mx-DbX6-yzk-Gw@mail.gmail.com> <CH2PR04MB652268FD0FB44AA5DF36ACFBE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
In-Reply-To: <CH2PR04MB652268FD0FB44AA5DF36ACFBE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Nov 2020 10:26:02 +0100
Message-ID: <CAMuHMdXEzo4EOw_=MgskNXPrbkP4Ui+dHKZ5iyJ04h453BUAhQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On Wed, Nov 25, 2020 at 10:02 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> On 2020/11/25 17:51, Geert Uytterhoeven wrote:
> > On Wed, Nov 25, 2020 at 7:14 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >> On 2020/11/25 3:57, Geert Uytterhoeven wrote:
> >>> There is no need to enable Virtual Terminal support in the Canaan
> >>> Kendryte K210 defconfigs, as no terminal devices are supported and
> >>> enabled.  Hence disable CONFIG_VT, and remove the no longer needed
> >>> override for CONFIG_VGA_CONSOLE.
> >>>
> >>> This reduces kernel size by ca. 65 KiB.
> >>
> >> Indeed, nice saving. Just tested, and all is good.
> >
> > I used my old script[1] to check the impact of disabling config options.

> > I haven't done enough riscv kernel development yet to assess if I need
> > CONFIG_FRAME_POINTER or not.
>
> Disabling it significantly reduced code size for me. Since the series is more
> stable now, it is not really needed, so I disabled it in the defconfig.
>
> I was just fiddling with CONFIG_UNIX98_PTYS. Disabling it is OK with the simple
> busybox userspace (no telnet/xterm like app running). But it saves only about
> 1KB with my toolchain (gcc 9.3). So I left that one enabled. I am surprised that
> you see 16K size impact... How big is your image ?
>
> For me, it is 1.768 MB right now for the sdcard defconfig, with CONFIG_VT
> disabled and ext2 enabled.

It might depend on how you measure.  "size" says 15 KiB impact for UNIX98
ptys, while bloat-o-meter reported less than 7 (my script uses "size").

I'm at 1.88 MiB, with ext4 and without frame pointers.
I also got rid of the EFI partition support, and a few I/O schedulers:

+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
