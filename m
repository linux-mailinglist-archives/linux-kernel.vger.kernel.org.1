Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E93279232
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgIYUf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:35:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56796 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIYUfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:35:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200925190831euoutp01f04ca6a478a3db37a3486058afcaadd1~4HGqJ9TYX2790127901euoutp013
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 19:08:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200925190831euoutp01f04ca6a478a3db37a3486058afcaadd1~4HGqJ9TYX2790127901euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601060911;
        bh=S6+3hCHR8LjgVN1kW1ZxtQl0x1kfYU7xsBVgczQxFKs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OpSZnr/XY1ZKi4kYrMt1Tyg6LgUNhnsdf/9VmYHqdZQ8ItUope4yHC0lNfERWF1zj
         4DljtZuvMYzKObWaqwSf8aAHcABxPC5InBtZnTAxUx+LbCn10o9YsCbDGA5zhjWHaU
         za88lTFpV3HQgISwBuja8kmb/IL1pXhyH1TQZhMw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200925190830eucas1p15c8ec026559b3665a9bf043d03793455~4HGo8ll5r0693906939eucas1p19;
        Fri, 25 Sep 2020 19:08:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.59.06456.E204E6F5; Fri, 25
        Sep 2020 20:08:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200925190829eucas1p2f35866317389cd5e842e99b465632902~4HGoD4XFt2304623046eucas1p27;
        Fri, 25 Sep 2020 19:08:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200925190829eusmtrp11077c53fa6410ae56d9961920e860d38~4HGoDEMJN2261422614eusmtrp16;
        Fri, 25 Sep 2020 19:08:29 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-6d-5f6e402e8fc4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.DA.06314.D204E6F5; Fri, 25
        Sep 2020 20:08:29 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200925190828eusmtip15ac30637c1d96ccdd6cd607486092aa3~4HGnWgd_40530605306eusmtip1L;
        Fri, 25 Sep 2020 19:08:28 +0000 (GMT)
Subject: Re: [PATCH printk v5 6/6] printk: reimplement log_cont using record
 extension
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
Date:   Fri, 25 Sep 2020 21:08:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914123354.832-7-john.ogness@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGeXfvdq+jxetSPNmXLRUbpkkFtyzJD+qGIP5RIELZ0otZbtqu
        mgalZZmKlhpqLsuyUBGnuHR+kZ+R2miUWvRlmVZopkF+gFqW28Xyv+c853fecx54aUL+QexI
        R2niOK1GFa2QSEnjkznzNo/9mrDt2WUSJvV+jYQxDpQgpsU0I2L6m4slTFfuPcT8fDBLMt3Z
        7SLmz8iMmGlNHxIxwzl5IkY/NUIxDw35BDN8bYLaL2ObdIMUe7n1LcU+rFCyhsoMCTtpNlNs
        z80Fkm27XbXkP0hma+pekuyUYWOwNFS6N4KLjkrgtJ4+x6UnP5qaqNgBu8TxhXxxCiqyzUQ2
        NOCdUN6xgDKRlJbjCgQfajMIoZhGYMjLpiyUHE8hKO1SLk/0fRmlBKgcwXjJqEgofiC4/qpt
        qUPTa3AIVFettQzY4UCoHH9kHSDwCwL0d1pEloYEe0HmRKbEwsuwDzT8crLYJHaBwXe9VsQe
        H4MnT4dJi5ZhW+gt+mzVNngfFP14LLFoAm+C1PpbhKAd4O3nEus9gC/S8OZTHWl5H3AAFNQG
        CAHWwLfuOkrQ68F0I4sU+FQEn8x6SiiyEPRfuokEyhvem+ethxJ4K9Q0ewq2L5T2F4qF91fD
        6wlb4YbVkGcsJARbBulpcoF2BV139b+1Hc/7iByk0K1IpluRRrcije7/3ruIrEQOXDyvjuR4
        Lw131oNXqfl4TaRHeIzagJZ+nWmx+2cjmuk70YkwjRSrZD3D6jC5WJXAJ6k7EdCEwk7m98x0
        TC6LUCWd47QxYdr4aI7vROtoUuEg21E6dlSOI1Vx3GmOi+W0y10RbeOYglyNV0L20GU7rs7t
        Yg5/7XD3GwvMPeSdnXh/dLC5Otwp6KDHFgWvX9w9G5RcUzAdZe92pMmmsT3n8IbN94J/o4ZC
        3j3NsbHrTE+9v4tfnrLAV0nb1c37u4wcj2jtSXX+rnGbiDs/ed31grFInvDCNrA5pPjUUKi3
        j3PwgWdVjteC3itI/qTKS0loedVfmY1uDXEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7q6DnnxBkemslk0L17PZrHtynxG
        i92nvzJZXN41h83i8MSFjBaflnxjsTjee4DJ4v/jr6wW+zoeMFk8mjCJyWLt58fsFps3TWW2
        eNT3lt2B12PnrLvsHi37brF7bF6h5bFpVSebx7tz59g9Tsz4zeKxf+4aoPiSeo/1W66yeHze
        JBfAFaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX
        cf/0TvaCKyIVr39PZW1gnCnYxcjJISFgInHp6Qv2LkYuDiGBpYwSr1dcZoJIyEicnNbACmEL
        S/y51sUGUfSWUeLdDBCHg0NYIEJi3RpJkBoRAW+JVa/3gg1iFrjMLPHqxVJ2kISQQL5E79rz
        YEPZBAwlut5C9PIK2Els/6MAEmYRUJW4e/skWImoQJzEmZ4XbCA2r4CgxMmZT1hAbE4BW4mZ
        74+AxZkFzCTmbX7IDGHLSzRvnQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW5
        6bnFhnrFibnFpXnpesn5uZsYgdG97djPzTsYL20MPsQowMGoxMN74lFuvBBrYllxZe4hRgkO
        ZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YePJK4g1NDc0tLA3Njc2NzSyU
        xHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCaSW6c6HG1NdX51KJnGQu53iVbscQXPf2gzMq+
        Y+9zmekzt4c313D4lMTs1T7fUhp7cznHJZPeewpx717GTRcM7XA+snLtEVn7R9bOqu632ZL2
        1ys2n/L26843XRS3cR330k8LihaeubalhkHL++ZZhQSVXGfRKJZfCm3R8T75xU3nH+qXZymx
        FGckGmoxFxUnAgCZaB2rBAMAAA==
X-CMS-MailID: 20200925190829eucas1p2f35866317389cd5e842e99b465632902
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200925190829eucas1p2f35866317389cd5e842e99b465632902
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200925190829eucas1p2f35866317389cd5e842e99b465632902
References: <20200914123354.832-1-john.ogness@linutronix.de>
        <20200914123354.832-7-john.ogness@linutronix.de>
        <CGME20200925190829eucas1p2f35866317389cd5e842e99b465632902@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 14.09.2020 14:33, John Ogness wrote:
> Use the record extending feature of the ringbuffer to implement
> continuous messages. This preserves the existing continuous message
> behavior.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

This patch landed recently in linux-next as commit f5f022e53b87 
("printk: reimplement log_cont using record extension"). I've noticed 
that it causes a regression on my test system (ARM 32bit Samsung Exynos 
4412-based Trats2 board). The messages are printed correctly on the 
serial console during boot, but then when I run 'dmesg' command, the log 
is truncated.

Here is are the last lines of the dmesg log after this patch:

[    6.649018] Waiting 2 sec before mounting root device...
[    6.766423] dwc2 12480000.hsotg: new device is high-speed
[    6.845290] dwc2 12480000.hsotg: new device is high-speed
[    6.914217] dwc2 12480000.hsotg: new address 51
[    8.710351] RAMDISK: squashfs filesystem found at block 0

The corresponding dmesg lines before applying this patch:

[    8.864320] RAMDISK: squashfs filesystem found at block 0
[    8.868410] RAMDISK: Loading 37692KiB [1 disk] into ram disk... /
[    9.071670] /
[    9.262498] /
[    9.540711] /
[    9.818031] done.
[   10.660074] VFS: Mounted root (squashfs filesystem) readonly on 
device 1:0.
[   10.739525] EXT4-fs (mmcblk0p1): INFO: recovery required on readonly 
filesystem
[   10.745347] EXT4-fs (mmcblk0p1): write access will be enabled during 
recovery
[   10.861129] EXT4-fs (mmcblk0p1): recovery complete
[   10.878150] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data 
mode. Opts: (null)
[   10.881811] VFS: Mounted root (ext4 filesystem) readonly on device 
179:49.
[   10.889858] Trying to move old root to /initrd ...
[   10.895192] okay
[   10.914411] devtmpfs: mounted
[   10.925087] Freeing unused kernel memory: 1024K
[   10.933222] Run /sbin/init as init process
[   10.941723]   with arguments:
[   10.949890]     /sbin/init
[   10.949900]   with environment:
[   10.949909]     HOME=/
[   10.949917]     TERM=linux
[   12.415991] random: systemd-udevd: uninitialized urandom read (16 
bytes read)
[   12.425361] random: systemd-udevd: uninitialized urandom read (16 
bytes read)
[   12.438578] random: systemd-udevd: uninitialized urandom read (16 
bytes read)

...

I can provide a complete logs if that helps.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

