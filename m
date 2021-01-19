Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23372FC320
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbhASWNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbhASWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:12:07 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08199C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:11:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z21so13857407pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=swn/lFlreTHNa8exuubaqI6V2VjZdZSiepv5kEfW088=;
        b=Cfxcfy3o3dUhwNY9xxjHYDVCV2qv6d24hHv55DrhGuKyowNp/t1vfRMd0dGWa8xvzU
         BsR7VSv/IyPp+0G6Mv82dxmbqrtTIl9doekuc9VCBkZuemNiHjn+6bbM5afpzXa0wQRX
         zkBzlx0fQdK3ubMqlzPwz+y//xcU9TNbj3CXJn7xl84eIMsloRBtRVlBWnxDNVT+p5Bu
         NoBAIbm1gZkAW32qmZC/H7a5fQqMA9BSp8waoepvnhfmAwjTuU8IWvBd8xevEXCEYoos
         d+Kdm0K1bEWukkfro+4Jr1pxC5xFuSpPcMmDLgzkx71X6RGl1PGMkOuptO/hMyz9MSWS
         H1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swn/lFlreTHNa8exuubaqI6V2VjZdZSiepv5kEfW088=;
        b=pskx/Am4VgSFWQ4fZIo8uK0bNpJty1h9tHtxmsjXEPI4JeC9oyi+7q1bd7pEJZ5KbE
         A+BVBomlnLSaMoXf3DV9rv6+iNOLyb+37ttvGaOd1GDUcL2vmaeC/vMBsY2SVxPuhqXi
         v14h7KTWFbZqsGN9DBq7GOkqXtn158Kd5Cuinj+s6ebPR0VVbQdNiZSfMnCOkmH/+yF3
         ahjezLuaFlbHK+0kSRsMQey24sZQW7REkcbvgshsvIqq2hmwlmZACqZ/vqSP+7ZA6ZFT
         R9c2ekOJG1FHJW8PvdhIyKn4JzI1b8oAxn36dG49FhdmWIfJDCF8m375pk/U+sGnGeUq
         V9xw==
X-Gm-Message-State: AOAM5328VEjXxXZL3XEmJVjBaLi7ZM8n6xjzl0BediTrzIMRoY7MQxjJ
        uKSJm/onYOgICiOoY992i/RkE7B1cQkRlg==
X-Google-Smtp-Source: ABdhPJyK2GNfzbEuvg4RYa88eZeYn5iPKArW2XyJNdb76B+XXY8cEYsB8XK2OIF+2FxU6QQgx0tdPA==
X-Received: by 2002:a63:50a:: with SMTP id 10mr6263170pgf.273.1611094273530;
        Tue, 19 Jan 2021 14:11:13 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id b17sm3670pju.15.2021.01.19.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:11:12 -0800 (PST)
Date:   Wed, 20 Jan 2021 07:11:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
Message-ID: <20210119221110.GM2002709@lianli.shorne-pla.net>
References: <20210119080938.1832733-1-geert@linux-m68k.org>
 <20210119213444.GL2002709@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119213444.GL2002709@lianli.shorne-pla.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:34:44AM +0900, Stafford Horne wrote:
> On Tue, Jan 19, 2021 at 09:09:38AM +0100, Geert Uytterhoeven wrote:
> > Let the LiteX SoC Controller register a restart handler, which resets
> > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Thanks, this looks good to me, queued to my linux-next branch.
> 
> -Stafford
> 
> > @@ -66,8 +71,19 @@ static int litex_check_csr_access(void __iomem *reg_addr)
> >  
> >  struct litex_soc_ctrl_device {
> >  	void __iomem *base;
> > +	struct notifier_block reset_nb;
> >  };
> >  
> > +static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> > +			       void *cmd)
> > +{
> > +	struct litex_soc_ctrl_device *soc_ctrl_dev =
> > +		container_of(this, struct litex_soc_ctrl_device, reset_nb);
> 
> Nice.
> 
> > +	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
> > +	return NOTIFY_DONE;
> > +}
> > +

Actually, I tested this out on the latest (2-weeks ago) Litex and
openrisc/for-next and it didn't seem to work correctly.

I will look into it a bit closer, but if you see or can think of anything let
me know.  Note There are a few failures below related to network services as my
for-next kernel doesnt have a network driver (yet).

Using my buildroot rootfs: http://shorne.noip.me/downloads/or1k-glibc-rootfs.cpio.gz

    # shutdown -r now

    Broadcast message from root@buildroot (console) (Thu Jan  1 00:00:48 1970):
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
    Saving random seed: [   52.020000] random: dd: uninitialized urandom read (512 bytes read)
    OK
    Stopping klogd: OK
    Stopping syslogd: start-stop-daemon: warning: killing process 51: No such process
    FAIL
    umount: devtmpfs busy - remounted read-only
    umount: can't unmount /: Invalid argument
    [   53.710000] reboot: Restarting system
    [   54.710000] Reboot failed -- System halted
    [   76.040000] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [reboot:131]
    [   76.040000] CPU: 0 PID: 131 Comm: reboot Not tainted 5.11.0-rc1-00009-gff28dae0bc90 #418
    [   76.040000] CPU #: 0
    [   76.040000]    PC: c00050b8    SR: 0000827f    SP: c180fdb0
    [   76.040000] GPR00: 00000000 GPR01: c180fdb0 GPR02: c180fdc0 GPR03: 0000827f
    [   76.040000] GPR04: c0348944 GPR05: 00000000 GPR06: c180fc70 GPR07: 00000000
    [   76.040000] GPR08: c180fdb0 GPR09: c00050b8 GPR10: c180e000 GPR11: 0000001e
    [   76.040000] GPR12: 00000000 GPR13: 00000020 GPR14: 00000001 GPR15: 00000000
    [   76.040000] GPR16: 00000000 GPR17: c02e48d4 GPR18: 00418958 GPR19: c02e48d4
    [   76.040000] GPR20: 00000000 GPR21: 00000000 GPR22: c02e4018 GPR23: fffffffe
    [   76.040000] GPR24: ffffffff GPR25: 00000000 GPR26: 00000000 GPR27: 00000000
    [   76.040000] GPR28: 00000000 GPR29: ffffffff GPR30: 00000000 GPR31: ffffffff
    [   76.040000]   RES: 0000001e oGPR11: ffffffff
    [   76.040000] Process reboot (pid: 131, stackpage=c180a000)
    [   76.040000]
    [   76.040000] Stack:
    [   76.040000] Call trace:
    [   76.040000] [<(ptrval)>] machine_restart+0x44/0x5c
    [   76.040000] [<(ptrval)>] kernel_restart+0x78/0xa4
    [   76.040000] [<(ptrval)>] ? mutex_lock+0x24/0x50
    [   76.040000] [<(ptrval)>] __do_sys_reboot+0x1a8/0x21c
    [   76.040000] [<(ptrval)>] ? do_filp_open+0x40/0xa0
    [   76.040000] [<(ptrval)>] ? slab_free_freelist_hook+0x6c/0x14c
    [   76.040000] [<(ptrval)>] ? arch_local_irq_save+0x24/0x3c
    [   76.040000] [<(ptrval)>] ? kmem_cache_free+0x130/0x194
    [   76.040000] [<(ptrval)>] ? call_rcu+0x50/0x8c
    [   76.040000] [<(ptrval)>] ? __fput+0x2d0/0x2f4
    [   76.040000] [<(ptrval)>] ? do_sys_openat2+0xd8/0x134
    [   76.040000] [<(ptrval)>] ? task_work_run+0xbc/0xf4
    [   76.040000] [<(ptrval)>] ? do_work_pending+0x60/0x12c
    [   76.040000] [<(ptrval)>] sys_reboot+0x14/0x24
    [   76.040000] [<(ptrval)>] ? _syscall_return+0x0/0x4


-Stafford
