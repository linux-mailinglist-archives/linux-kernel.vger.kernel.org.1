Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6E2C407B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKYMra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:47:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39768 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKYMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:47:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id f11so2684312oij.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPUOnTI/GXJjBWfcQKn1UW1GCzqLDHOJc8mxlHuRZhA=;
        b=QhfxRdwtGk7Zg4ijmZ8/rQGawDxnUYhINtI2RISexUmEZedk/tJzTltdXBMeSs028K
         MT06qdQkJIWMUygl4f2HhGiR8EbxIGjij0OkvyHDs1mNo8kG+VsJOb950C0eeVd/yTjW
         wHkgsImJDGYOJlkit4D1tIsQLanrqjzMpWALT5D+sEDBWSsSqFJlSMbtVaX+L19iI9Rk
         7lE8ELVc/EXZ++6BD9G6myBWe2KsrpsPgZSzI9fUc1AIDPcR1ALQcYZDOa3Od6zikK5i
         ndBB1UIQHWjw3GNd2kIRxjQdhs85YXTR+97nqUs0MjEB1xUfXmKw2HicDvAH5gqb71OH
         oZvg==
X-Gm-Message-State: AOAM533DArkbV8MH+ybdkGj9zKAcGMPrCQig5PmlPmjOsn5ximfs+Wp0
        ffi1ZYL1GDwBWI0asspvN6nCjrftxtENslu9tFU=
X-Google-Smtp-Source: ABdhPJwikQNqVaFir6QHfyhm6IF2bhFKder5YyspCgClKVn0JsSsIW5TiEWBwEjHR4D8jSSsj5zffkSg2G78j4kq9IU=
X-Received: by 2002:aca:1c0f:: with SMTP id c15mr2142536oic.54.1606308448683;
 Wed, 25 Nov 2020 04:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20201124185738.3541314-1-geert@linux-m68k.org>
 <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdW9dySq3y_Uixv8_7e+Pe2VKw4iGV36mx-DbX6-yzk-Gw@mail.gmail.com>
 <CH2PR04MB652268FD0FB44AA5DF36ACFBE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdXEzo4EOw_=MgskNXPrbkP4Ui+dHKZ5iyJ04h453BUAhQ@mail.gmail.com> <CH2PR04MB6522E6443C6E12CD28FD1A30E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
In-Reply-To: <CH2PR04MB6522E6443C6E12CD28FD1A30E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Nov 2020 13:47:17 +0100
Message-ID: <CAMuHMdW4YC4mNcX28s6HDSc-tuks2H7i-vojsOLbmaCBr2o2Ow@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 12:00 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> On 2020/11/25 18:26, Geert Uytterhoeven wrote:
> > On Wed, Nov 25, 2020 at 10:02 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >> On 2020/11/25 17:51, Geert Uytterhoeven wrote:
> >> I was just fiddling with CONFIG_UNIX98_PTYS. Disabling it is OK with the simple
> >> busybox userspace (no telnet/xterm like app running). But it saves only about
> >> 1KB with my toolchain (gcc 9.3). So I left that one enabled. I am surprised that
> >> you see 16K size impact... How big is your image ?
> >>
> >> For me, it is 1.768 MB right now for the sdcard defconfig, with CONFIG_VT
> >> disabled and ext2 enabled.
> >
> > It might depend on how you measure.  "size" says 15 KiB impact for UNIX98
> > ptys, while bloat-o-meter reported less than 7 (my script uses "size").
>
> I look at the size of the arch/riscv/boot/loader.bin file since that is what
> gets loaded in RAM and booted. It is significantly smaller than vmlinux file
> size. E.g. for the sd card defconfig, I have:
>
> vmlinux: 2369920 B
> loader.bin: 1751250 B

Doesn't loader.bin lack bss?
Bss does consume RAM, so you do want to take that into account, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
