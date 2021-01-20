Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E072FD271
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbhATONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbhATNHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:07:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F7C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:07:03 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so7303937pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZOvZA96ZqHhYYsl3TXxpU61JXBoyw6gS3vQQtm7WhqA=;
        b=XGLsFqBfw29Axuri0oRGB/SxGWwPC7x9iXNKeWx1fOQd8pNcWe580ocWmP+vByX8p2
         2djvXDWYV6b/0PPSyWBfS0TzmYUHM7drEbSJlaGFF7+93p0iv8HKen6LU3BtbwX4fnDz
         YTqBI0q3y8GI37coPtA8sJsqBfyNv/H8hikQ9tWeA44biBh7fvY0O3hf5k1qRacdCrVj
         9k6DSywqBx/oolXcfCqKs1CWp/IgmBQVKla7D5PKMGqpAv8Fm+4Xq8LIjrmHevXwluBE
         3s0dLTxUFPLrIkdJp+L0nzWbu7PclY62v0aZyEaYwDNeDusMNXf1jwIXalp2k46eUmjo
         OHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZOvZA96ZqHhYYsl3TXxpU61JXBoyw6gS3vQQtm7WhqA=;
        b=bgeGunh/pN9Bc6NM8OAswzqBBOuLCTEaQfSTmZxupd8FwlSF7P08CgW0n8fsDaIGVT
         fzq78MC7Qx+xuaqadj9j40mR0kPTrSr6EiVBh8XHdAcG4ovMjEPmQCQTJ7HRt7VE7oso
         4XjV/NB6wdWcTvLUB5MYoXTWyXZLPN7mfPpfQO3DCX5UbMxfY+yFO1K+JMCDjUYX6AAh
         o5PX9jaF7zYDiJqYVrGsE7plVJ8rmE18mNXIwIaPiG1vd15qpoWHY4TY+8PhfJScBhGT
         CY++Y+NEU9fb+g67K2qi8dSfh1LWqKstRsbUm2/3DsRM4FiNjoD528n3DBgwMqhJfUUH
         +XpA==
X-Gm-Message-State: AOAM5332KwtTz5ukHFi3PPNSqJcLWt3rGdtvtLFWtWB+0L7Y7x/Yw5Oy
        w3j5/FJB9StSyeZgG6HKSEc=
X-Google-Smtp-Source: ABdhPJyWYxsCNaud4l5HTIU2X7R5T/Xz6UT6kJEieFA13jRSuANZg+q8KXJ17UrLhYygL3ubwyjH3Q==
X-Received: by 2002:aa7:8eda:0:b029:19e:c8c3:ed74 with SMTP id b26-20020aa78eda0000b029019ec8c3ed74mr9014247pfr.66.1611148022806;
        Wed, 20 Jan 2021 05:07:02 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id r30sm2593787pjg.43.2021.01.20.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:07:01 -0800 (PST)
Date:   Wed, 20 Jan 2021 22:06:59 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
Message-ID: <20210120130659.GN2002709@lianli.shorne-pla.net>
References: <20210119080938.1832733-1-geert@linux-m68k.org>
 <20210119213444.GL2002709@lianli.shorne-pla.net>
 <20210119221110.GM2002709@lianli.shorne-pla.net>
 <CAMuHMdVpogc=oEgCCq8N__RJkujJX47OaZZcyaRgjSJV2+SZ-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVpogc=oEgCCq8N__RJkujJX47OaZZcyaRgjSJV2+SZ-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:20:39AM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, Jan 19, 2021 at 11:11 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Wed, Jan 20, 2021 at 06:34:44AM +0900, Stafford Horne wrote:
> > > On Tue, Jan 19, 2021 at 09:09:38AM +0100, Geert Uytterhoeven wrote:
> > > > Let the LiteX SoC Controller register a restart handler, which resets
> > > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >
> > > Thanks, this looks good to me, queued to my linux-next branch.
> > >
> > > -Stafford
> > >
> > > > @@ -66,8 +71,19 @@ static int litex_check_csr_access(void __iomem *reg_addr)
> > > >
> > > >  struct litex_soc_ctrl_device {
> > > >     void __iomem *base;
> > > > +   struct notifier_block reset_nb;
> > > >  };
> > > >
> > > > +static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> > > > +                          void *cmd)
> > > > +{
> > > > +   struct litex_soc_ctrl_device *soc_ctrl_dev =
> > > > +           container_of(this, struct litex_soc_ctrl_device, reset_nb);
> > >
> > > Nice.
> > >
> > > > +   litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
> > > > +   return NOTIFY_DONE;
> > > > +}
> > > > +
> >
> > Actually, I tested this out on the latest (2-weeks ago) Litex and
> > openrisc/for-next and it didn't seem to work correctly.
> >
> > I will look into it a bit closer, but if you see or can think of anything let
> > me know.  Note There are a few failures below related to network services as my
> > for-next kernel doesnt have a network driver (yet).
> 
> Hmmm, openrisc/for-next does have commit 131172a4a8ce3fcc ("openrisc:
> restart: Call common handlers before hanging").
> 
> It's been a few years I used an OpenRISC setup.
> Do you have a link to Linux on mor1kx/LiteX setup instructions?

Actually, I rebuilt everything again and it works fine.  FYI, my instructions
for setup are here:

 - https://github.com/stffrdhrn/or1k-utils/tree/master/litex

I use an arty dev board, you can see the reset working below. There are some
things I need to fix in my dev rootfs shutdown scripts but it does reset.


    # shutdown -r now

    Broadcast message from root@buildroot (console) (Thu Jan  1 00:01:07 1970):
    The system is going down for reboot NOW!
    INIT: Switching to runlevel: 6
    # mounting home work nfs ...
    mount: mounting 10.0.0.27:/home/shorne/work on /home/shorne/work failed: No such device
    enabling login for shorne ...
    setting coredumps ...
    Stopping dropbear sshd: FAIL
    Stopping ntpd: FAIL
    Nothing to do, sntp is not a daemon.
    Stopping network: ifdown: interface lo not configured
    ifdown: interface eth0 not configured
    OK
    Saving random seed: [   70.960000] random: dd: uninitialized urandom read (512 bytes read)
    OK
    Stopping klogd: OK
    Stopping syslogd: start-stop-daemon: warning: killing process 51: No such
    process
    FAIL
    umount: devtmpfs busy - remounted read-only
    umount: can't unmount /: Invalid argument
    [   72.650000] reboot: Res
	    __   _ __      _  __
	   / /  (_) /____ | |/_/
	  / /__/ / __/ -_)>  <
	 /____/_/\__/\__/_/|_|
       Build your hardware, easily!

     (c) Copyright 2012-2020 Enjoy-Digital
     (c) Copyright 2007-2015 M-Labs

     BIOS built on Jan 20 2021 21:18:10
     BIOS CRC passed (b12f1de3)

     Migen git sha1: 40b1092
     LiteX git sha1: 57289dd4

    --=============== SoC ==================--
    CPU:            MOR1KX @ 100MHz
    BUS:            WISHBONE 32-bit @ 4GiB

-Stafford
