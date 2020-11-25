Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2792C3B61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgKYIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:51:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39996 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgKYIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:51:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id 79so1545470otc.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kl1ooVwC5sorQ85yYzVr3KYM5DDAoiMuzVAwUEh9o3w=;
        b=s0NFf/nDkaqL+VfgvliyPNrSsm3rHXeR3ddB2jmXnLBY8u79VvCwYuQ8jf8SBnu8k7
         hOx2MeevalkpWovMhy10YEzWSxb6LyfRv4sRrtjYDg+6qu86KWrZ3WCdzHyqOMY+/X5t
         wPz1NAwHXGGPD8uUhgn3hGuYT5qYEGan837MzVwZfofSDsPrBm5xvOPl/9cSf2GXEEg+
         pZxbxxZzmU3ejLGXKS+OafZ+coItSImNbf7U66kow1OAUXu4nelLHWhwPW2eHzX/sNL4
         kq08xj4u32w8VIXnXsJpo14Y+pOP3ISJ3hh7h99zd++uC+vDpA8Gjxzg8gF2vN07/efS
         HqYw==
X-Gm-Message-State: AOAM531R+umlZs8UPwdazDHjGWDf8gRfOMNaNfo1F/ItBejphKISqx9k
        081p/K5VPCfTLAELou0T92mFtBxOfS8TtZmvyPQ=
X-Google-Smtp-Source: ABdhPJzngLqzabrksUi7zxt1gakeAI2FVfVbqE6msa5OQLUvUdCUroniLCADSSSuVQ6ru5wj9GYRhi8SwYoVuEwK6gQ=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr2109851oth.250.1606294290430;
 Wed, 25 Nov 2020 00:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20201124185738.3541314-1-geert@linux-m68k.org> <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
In-Reply-To: <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Nov 2020 09:51:19 +0100
Message-ID: <CAMuHMdW9dySq3y_Uixv8_7e+Pe2VKw4iGV36mx-DbX6-yzk-Gw@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 7:14 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> On 2020/11/25 3:57, Geert Uytterhoeven wrote:
> > There is no need to enable Virtual Terminal support in the Canaan
> > Kendryte K210 defconfigs, as no terminal devices are supported and
> > enabled.  Hence disable CONFIG_VT, and remove the no longer needed
> > override for CONFIG_VGA_CONSOLE.
> >
> > This reduces kernel size by ca. 65 KiB.
>
> Indeed, nice saving. Just tested, and all is good.

I used my old script[1] to check the impact of disabling config options.

I don't see any other low-hanging fruits:

Disabling CONFIG_BLOCK saves 492890 bytes
Disabling CONFIG_EXT4_FS saves 322528 bytes
Disabling CONFIG_PRINTK saves 214612 bytes
Disabling CONFIG_SMP saves 214486 bytes
Disabling CONFIG_FRAME_POINTER saves 166368 bytes
Disabling CONFIG_TTY saves 156618 bytes
Disabling CONFIG_PROC_FS saves 110274 bytes
Disabling CONFIG_MMC saves 87656 bytes
Disabling CONFIG_VT saves 70350 bytes
Disabling CONFIG_SYSFS saves 62298 bytes
Disabling CONFIG_BUG saves 50882 bytes
Disabling CONFIG_SPI saves 34420 bytes
Disabling CONFIG_SOC_CANAAN saves 34286 bytes
Disabling CONFIG_I2C saves 34086 bytes
Disabling CONFIG_PROC_SYSCTL saves 23890 bytes
Disabling CONFIG_POSIX_TIMERS saves 18388 bytes
Disabling CONFIG_I2C_DESIGNWARE_PLATFORM saves 17530 bytes
Disabling CONFIG_MMC_BLOCK saves 17200 bytes
Disabling CONFIG_UNIX98_PTYS saves 16360 bytes
Disabling CONFIG_MULTIUSER saves 16148 bytes
Disabling CONFIG_NEW_LEDS saves 15964 bytes
Disabling CONFIG_SPI_DESIGNWARE saves 15434 bytes
Disabling CONFIG_GPIO_CDEV saves 15352 bytes
Disabling CONFIG_MMC_SPI saves 14754 bytes
Disabling CONFIG_SOC_CANAAN_K210_DTB_BUILTIN saves 13864 bytes

(Yes, I have ext4 enabled ;-)

I haven't done enough riscv kernel development yet to assess if I need
CONFIG_FRAME_POINTER or not.

[1] https://github.com/geertu/linux-scripts/blob/master/linux-analyze-marginal-sizes

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
