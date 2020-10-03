Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1C28256D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJCRAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgJCRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 13:00:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265FC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 10:00:37 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p11so1945099vsg.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8cl6+UVJ6yhS670jYp/U5BJ0mT6d79lPBq5DKcewL0=;
        b=GKhCHiFuICA4QDBtmex6MU8h+z4tFWy27AyIQuGPJgqpb9NkQaqKppf3MpU/6CIn9m
         14UpE1tgN99qMtTiAgCbJ0DZo79bwcGCAMwtIT6VU2IeyEncrhsCXuUDMLn63c+Wq6OZ
         md6uhZIa9WFF5Dd+jS91EwWlcCmJdVkw4m8iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8cl6+UVJ6yhS670jYp/U5BJ0mT6d79lPBq5DKcewL0=;
        b=TrM7Qv49Qol30+jAVUNN3Hn4vYt6k1/+vAviiNKtuJcSUUF0vuOTVhSIFPQwFotaNW
         HY3onH1yvArv8Jnj0mKaDHX649DNXd3vw7OCOWllW4RbvjbBpkh3StZz2xIYiJ6nf8s2
         DcATyPgsv+CHPtnmwnihi1NOB2rIxEyD4ksD/RyBDaCLRW847Qc5W+01aKS/hEzneTkh
         wjWG/1oTPev9V8RvQi2705k18DeGOPrF7he4mFTb58i62x6HB477T0QpZrd/KgEZSH6K
         1vAU9CStQJqB7i4+qnImeWdwYifjBpa0ma8er4sP8+c7h4riS2Zb31DvOQgJ3W3S4bSJ
         F7ZA==
X-Gm-Message-State: AOAM530tAyMzParFzpbuW/RbvItzZS//C9+MwPLmclOvfBwbcNunyGjm
        M7QulDaQqOEHq0buXtP0xbYrLEgpxQTGbA==
X-Google-Smtp-Source: ABdhPJwSrZjIJ3Hu5A1r5ygfBeEKSxc3iP5DPAD6eEq8JQTn0R8DIhMd8dwq0hpkQaU0fhAW8efJ9Q==
X-Received: by 2002:a67:2f0a:: with SMTP id v10mr1490235vsv.7.1601744436476;
        Sat, 03 Oct 2020 10:00:36 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id t186sm713059vkg.7.2020.10.03.10.00.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 10:00:35 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id e23so2057171vsk.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 10:00:35 -0700 (PDT)
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr3999762vsn.4.1601744435389;
 Sat, 03 Oct 2020 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
 <20201003150633.23416-1-michael@walle.cc> <CAD=FV=VB-ML0=kmN-yAH7sD-sMiX9Cq1_9B9QwVL=Ed5ZrGnbg@mail.gmail.com>
 <b376b3f2e41662237d50d589e3696b06@walle.cc>
In-Reply-To: <b376b3f2e41662237d50d589e3696b06@walle.cc>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 3 Oct 2020 10:00:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VddVg=QLS32Jr-Mxh6nyiB2=1MybxGiYuuaKd+fQ4+Lw@mail.gmail.com>
Message-ID: <CAD=FV=VddVg=QLS32Jr-Mxh6nyiB2=1MybxGiYuuaKd+fQ4+Lw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Prefer asynchronous probe
To:     Michael Walle <michael@walle.cc>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Sat, Oct 3, 2020 at 9:54 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Douglas,
>
> Am 2020-10-03 18:27, schrieb Doug Anderson:
> > Hi,
> >
> > On Sat, Oct 3, 2020 at 8:22 AM Michael Walle <michael@walle.cc> wrote:
> >>
> >> Hi Douglas,
> >>
> >> > On my system the spi_nor_probe() took ~6 ms at bootup.  That's not a
> >> > lot, but every little bit adds up to a slow bootup.  While we can get
> >> > this out of the boot path by making it a module, there are times where
> >> > it is convenient (or even required) for this to be builtin the kernel.
> >> > Let's set that we prefer async probe so that we don't block other
> >> > drivers from probing while we are probing.
> >> >
> >> > This is a tiny little change that is almost guaranteed to be safe for
> >> > anything that is able to run as a module, which SPI_NOR is.
> >> > Specifically modules are already probed asynchronously.  Also: since
> >> > other things in the system may have enabled asynchronous probe the
> >> > system may already be doing other things during our probe.
> >> >
> >> > There is a small possibility that some other driver that was a client
> >> > of SPI_NOR didn't handle -EPROBE_DEFER and was relying on probe
> >> > ordering and only worked when the SPI_NOR and the SPI bus were
> >> > builtin.  In that case the other driver has a bug that's waiting to
> >> > hit and the other driver should be fixed.
> >>
> >> linux-next now triggers the following warning in kernel/kmod.c:136 on
> >> my
> >> board. I've bisected this to this patch.
> >>
> >> kmod.c:
> >>         /*
> >>          * We don't allow synchronous module loading from async.
> >> Module
> >>          * init may invoke async_synchronize_full() which will end up
> >>          * waiting for this task which already is waiting for the
> >> module
> >>          * loading to complete, leading to a deadlock.
> >>          */
> >>         WARN_ON_ONCE(wait && current_is_async());
> >>
> >> [    1.849801] ------------[ cut here ]------------
> >> [    1.854271] mscc_felix 0000:00:00.5: device is disabled, skipping
> >> [    1.858753] WARNING: CPU: 1 PID: 7 at kernel/kmod.c:136
> >> __request_module+0x3a4/0x568
> >> [    1.858755] Modules linked in:
> >> [    1.865028] fsl_enetc 0000:00:00.0: Adding to iommu group 1
> >> [    1.872640] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted
> >> 5.9.0-rc6-00001-g03edda0e1eda #113
> >> [    1.872642] Hardware name: Kontron SMARC-sAL28 (Single PHY) on
> >> SMARC Eval 2.0 carrier (DT)
> >> [    1.872647] Workqueue: events_unbound async_run_entry_fn
> >> [    1.876013] spi-nor spi0.0: w25q32dw (4096 Kbytes)
> >> [    1.881294] pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
> >> [    1.881297] pc : __request_module+0x3a4/0x568
> >> [    1.881299] lr : __request_module+0x39c/0x568
> >> [    1.881302] sp : ffff8000113a3920
> >> [    1.925739] x29: ffff8000113a3920 x28: ffff800010c7b000
> >> [    1.931068] x27: ffff00207ae05648 x26: ffff800010a41a88
> >> [    1.936397] x25: 0000000000000000 x24: 0000000000000000
> >> [    1.941727] x23: ffff800010c35140 x22: 0000000000000001
> >> [    1.947055] x21: ffff800011149948 x20: ffff800010615bdc
> >> [    1.952383] x19: 00000000ffffffff x18: 0000000000000000
> >> [    1.957447] fsl_enetc 0000:00:00.0: enabling device (0400 -> 0402)
> >> [    1.957711] x17: ffff800010a3e618 x16: ffff800010a3e5f8
> >> [    1.964175] libphy: Freescale ENETC MDIO Bus: probed
> >> [    1.969238] x15: ffffffffffffffff x14: ffff800011149948
> >> [    1.969241] x13: ffff8000113a3918 x12: 0000000000000018
> >> [    1.969245] x11: 0000000000000005 x10: 0101010101010101
> >> [    1.975241] 10 fixed-partitions partitions found on MTD device
> >> 20c0000.spi
> >> [    1.979550] x9 : ffff80001005f6a4 x8 : 0000000000000000
> >> [    1.979553] x7 : 606f2c6364776865 x6 : 05041c090d431511
> >> [    1.979556] x5 : 1115430d091c0405 x4 : 0000000000000000
> >> [    1.979558] x3 : 6dac8d8d2dccae00 x2 : ffff800010c956e8
> >> [    1.979561] x1 : ffff80001005fa58 x0 : 0000000000000001
> >> [    1.979564] Call trace:
> >> [    1.979571]  __request_module+0x3a4/0x568
> >> [    1.984914] Creating 10 MTD partitions on "20c0000.spi":
> >> [    1.990227]  parse_mtd_partitions+0x2ec/0x3c0
> >> [    1.990232]  mtd_device_parse_register+0xdc/0x1c8
> >> [    1.997133] 0x000000000000-0x000000010000 : "rcw"
> >> [    2.002454]  spi_nor_probe+0x29c/0x2f0
> >> [    2.002458]  spi_mem_probe+0x74/0xb0
> >> [    2.017759] 0x000000010000-0x000000100000 : "failsafe bootloader"
> >> [    2.018433]  spi_drv_probe+0x88/0xe8
> >> [    2.018439]  really_probe+0xec/0x3c0
> >> [    2.033744] 0x000000100000-0x000000140000 : "failsafe DP firmware"
> >> [    2.035555]  driver_probe_device+0x60/0xc0
> >> [    2.035559]  __device_attach_driver+0x8c/0xd0
> >> [    2.040455] 0x000000140000-0x0000001e0000 : "failsafe trusted
> >> firmware"
> >> [    2.044642]  bus_for_each_drv+0x84/0xd8
> >> [    2.044645]  __device_attach_async_helper+0xc4/0xe8
> >> [    2.044648]  async_run_entry_fn+0x4c/0x150
> >> [    2.044653]  process_one_work+0x1f4/0x4b8
> >> [    2.057751] 0x0000001e0000-0x000000200000 : "reserved"
> >> [    2.062814]  worker_thread+0x50/0x480
> >> [    2.062817]  kthread+0x160/0x168
> >> [    2.062821]  ret_from_fork+0x10/0x34
> >> [    2.073748] 0x000000200000-0x000000210000 : "configuration store"
> >> [    2.076185] ---[ end trace 44224cc02e4e53d2 ]---
> >>
> >> -michael
> >
> > Thanks for your report!  My vote would be to revert my patch and then
> > this would need to be resolved before it could be added back in.
> > Without doing tons of research, maybe the right answer here is that
> > mtd_device_parse_register() should be moved into a separate task so
> > it's not blocking probe?  I probably won't try to tackle this
> > immediately, but the eventual goal is that async is default, so I
> > think this would need to be resolved before then.
>
> Ok. Vignesh, will you take care of that?
>
> While debugging another issue I also noticed that sometimes my
> /dev/mtdN devices were reordered. Note that I have two SPI flashes.
> Might this also be connected to the async probe?

It's likely.  My guess is that you shouldn't really be depending on
the numbering.  If you need to depend on the numbering, there should
be something that guarantees it like a device tree alias.  We have
struggled with similar things on MMC for years and I guess Ulf finally
decided that we weren't going to get a better solution than the device
tree aliases.  See:

https://lore.kernel.org/r/CAPDyKFoNFEa4ssv3TXbj4KM0UGjJgcp3dtypwicxJ-bExBL28A@mail.gmail.com

...for some details.

-Doug
