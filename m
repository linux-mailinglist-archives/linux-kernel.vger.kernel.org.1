Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D335D2FCCAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbhATI0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:26:17 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40930 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbhATIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:21:32 -0500
Received: by mail-ot1-f44.google.com with SMTP id i20so14816537otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54NUOyClmna+6jwSaRTzrk1a0mWX77xAMqQqC9zDA3k=;
        b=nqlP9g9AtEOjyEEdxib0Z4gpQxlJySRFC+/0WgGja+m4b8dnUHV+X07cSb84qqQw9Z
         kYsYJ2a7K0XX4creQiaX33QSadaNYKygTxs5kR2LS5ckp8qgzMwNxgkv1EqrbIFzKMmb
         YXAQ+0SMNPtXejl0j2SPsK8ZHvgbS69NPvs5daImZrLk5k6iSefydqIXos0g5O6MV5eG
         fzcmuPKLhm6s8xj2vcwHZGZDZEwSoGjbsn1SFNMEp0j4MLIyGox/GIVbYFb44mTRsMMS
         zJ5n72ahFaJx8Eebgg/T1+DF11pgzNulBEHL2LpNezizjRe43u0riocN0yt+edziOEl9
         qw3g==
X-Gm-Message-State: AOAM532TWMRwaZletkxHcgAlvpWLOCBKMdfA6vo4++Wxck4e7CY0k1UH
        gztcRqHog+8rQBQb0sh2f4QJWSE9msCbXeqI1kg=
X-Google-Smtp-Source: ABdhPJzfxMTsAvZ+SILTVY24yY9okpaVeh49Zuxh+4hAVdm2JWBVT+vMz8fsNOfjP6a3VqlGpJ4mOqfERVCUhhoahvE=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr6286950oth.250.1611130850929;
 Wed, 20 Jan 2021 00:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20210119080938.1832733-1-geert@linux-m68k.org>
 <20210119213444.GL2002709@lianli.shorne-pla.net> <20210119221110.GM2002709@lianli.shorne-pla.net>
In-Reply-To: <20210119221110.GM2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jan 2021 09:20:39 +0100
Message-ID: <CAMuHMdVpogc=oEgCCq8N__RJkujJX47OaZZcyaRgjSJV2+SZ-Q@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
To:     Stafford Horne <shorne@gmail.com>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Tue, Jan 19, 2021 at 11:11 PM Stafford Horne <shorne@gmail.com> wrote:
> On Wed, Jan 20, 2021 at 06:34:44AM +0900, Stafford Horne wrote:
> > On Tue, Jan 19, 2021 at 09:09:38AM +0100, Geert Uytterhoeven wrote:
> > > Let the LiteX SoC Controller register a restart handler, which resets
> > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Thanks, this looks good to me, queued to my linux-next branch.
> >
> > -Stafford
> >
> > > @@ -66,8 +71,19 @@ static int litex_check_csr_access(void __iomem *reg_addr)
> > >
> > >  struct litex_soc_ctrl_device {
> > >     void __iomem *base;
> > > +   struct notifier_block reset_nb;
> > >  };
> > >
> > > +static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> > > +                          void *cmd)
> > > +{
> > > +   struct litex_soc_ctrl_device *soc_ctrl_dev =
> > > +           container_of(this, struct litex_soc_ctrl_device, reset_nb);
> >
> > Nice.
> >
> > > +   litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
> > > +   return NOTIFY_DONE;
> > > +}
> > > +
>
> Actually, I tested this out on the latest (2-weeks ago) Litex and
> openrisc/for-next and it didn't seem to work correctly.
>
> I will look into it a bit closer, but if you see or can think of anything let
> me know.  Note There are a few failures below related to network services as my
> for-next kernel doesnt have a network driver (yet).

Hmmm, openrisc/for-next does have commit 131172a4a8ce3fcc ("openrisc:
restart: Call common handlers before hanging").

It's been a few years I used an OpenRISC setup.
Do you have a link to Linux on mor1kx/LiteX setup instructions?

>
> Using my buildroot rootfs: http://shorne.noip.me/downloads/or1k-glibc-rootfs.cpio.gz
>
>     # shutdown -r now
>
>     Broadcast message from root@buildroot (console) (Thu Jan  1 00:00:48 1970):
>     The system is going down for reboot NOW!
>     INIT: Switching to runlevel: 6
>     # mounting home work nfs ...
>     mount: mounting 10.0.0.27:/home/shorne/work on /home/shorne/work failed: No such device
>     enabling login for shorne ...
>     setting coredumps ...
>     Stopping dropbear sshd: FAIL
>     Stopping ntpd: FAIL
>     Nothing to do, sntp is not a daemon.
>     Stopping network: ifdown: interface lo not configured
>     ifdown: interface eth0 not configured
>     OK
>     Saving random seed: [   52.020000] random: dd: uninitialized urandom read (512 bytes read)
>     OK
>     Stopping klogd: OK
>     Stopping syslogd: start-stop-daemon: warning: killing process 51: No such process
>     FAIL
>     umount: devtmpfs busy - remounted read-only
>     umount: can't unmount /: Invalid argument
>     [   53.710000] reboot: Restarting system
>     [   54.710000] Reboot failed -- System halted
>     [   76.040000] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [reboot:131]
>     [   76.040000] CPU: 0 PID: 131 Comm: reboot Not tainted 5.11.0-rc1-00009-gff28dae0bc90 #418
>     [   76.040000] CPU #: 0
>     [   76.040000]    PC: c00050b8    SR: 0000827f    SP: c180fdb0
>     [   76.040000] GPR00: 00000000 GPR01: c180fdb0 GPR02: c180fdc0 GPR03: 0000827f
>     [   76.040000] GPR04: c0348944 GPR05: 00000000 GPR06: c180fc70 GPR07: 00000000
>     [   76.040000] GPR08: c180fdb0 GPR09: c00050b8 GPR10: c180e000 GPR11: 0000001e
>     [   76.040000] GPR12: 00000000 GPR13: 00000020 GPR14: 00000001 GPR15: 00000000
>     [   76.040000] GPR16: 00000000 GPR17: c02e48d4 GPR18: 00418958 GPR19: c02e48d4
>     [   76.040000] GPR20: 00000000 GPR21: 00000000 GPR22: c02e4018 GPR23: fffffffe
>     [   76.040000] GPR24: ffffffff GPR25: 00000000 GPR26: 00000000 GPR27: 00000000
>     [   76.040000] GPR28: 00000000 GPR29: ffffffff GPR30: 00000000 GPR31: ffffffff
>     [   76.040000]   RES: 0000001e oGPR11: ffffffff
>     [   76.040000] Process reboot (pid: 131, stackpage=c180a000)
>     [   76.040000]
>     [   76.040000] Stack:
>     [   76.040000] Call trace:
>     [   76.040000] [<(ptrval)>] machine_restart+0x44/0x5c
>     [   76.040000] [<(ptrval)>] kernel_restart+0x78/0xa4
>     [   76.040000] [<(ptrval)>] ? mutex_lock+0x24/0x50
>     [   76.040000] [<(ptrval)>] __do_sys_reboot+0x1a8/0x21c
>     [   76.040000] [<(ptrval)>] ? do_filp_open+0x40/0xa0
>     [   76.040000] [<(ptrval)>] ? slab_free_freelist_hook+0x6c/0x14c
>     [   76.040000] [<(ptrval)>] ? arch_local_irq_save+0x24/0x3c
>     [   76.040000] [<(ptrval)>] ? kmem_cache_free+0x130/0x194
>     [   76.040000] [<(ptrval)>] ? call_rcu+0x50/0x8c
>     [   76.040000] [<(ptrval)>] ? __fput+0x2d0/0x2f4
>     [   76.040000] [<(ptrval)>] ? do_sys_openat2+0xd8/0x134
>     [   76.040000] [<(ptrval)>] ? task_work_run+0xbc/0xf4
>     [   76.040000] [<(ptrval)>] ? do_work_pending+0x60/0x12c
>     [   76.040000] [<(ptrval)>] sys_reboot+0x14/0x24
>     [   76.040000] [<(ptrval)>] ? _syscall_return+0x0/0x4
>
>
> -Stafford



-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
