Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307F52DEB70
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 23:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLRWOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:14:17 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:40867 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgLRWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:14:17 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kqO0A-000nUy-NP; Fri, 18 Dec 2020 23:13:30 +0100
Received: from p5b13a238.dip0.t-ipconnect.de ([91.19.162.56] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kqO0A-003yzK-Ex; Fri, 18 Dec 2020 23:13:30 +0100
Subject: Re: [PATCH v2 05/15] ia64: convert to legacy_timer_tick
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anatoly Pugachev <matorola@gmail.com>
References: <20201030151758.1241164-1-arnd@kernel.org>
 <20201030151758.1241164-6-arnd@kernel.org>
 <59efce0e-a28d-9424-82ca-fb7f3a1b9c29@physik.fu-berlin.de>
 <CAK8P3a0s5Wt=9sZXAV1JzebZFXVy4qn3KNvygEfPeH3eVMyO_w@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <ccc941a9-9b7f-2a37-664e-c01d60c200da@physik.fu-berlin.de>
Date:   Fri, 18 Dec 2020 23:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0s5Wt=9sZXAV1JzebZFXVy4qn3KNvygEfPeH3eVMyO_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.56
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On 12/18/20 11:07 PM, Arnd Bergmann wrote:
> Sorry for causing this bug, and thank you for bisecting it
> down to my patch.
> 
> Do you see any other strange behavior with that patch, or is
> this the only symptom you are aware of?

This seems to be the only issue I'm seeing so far. However, as I'm not
able to fully boot the system, I'm not able to be certain that there
might be other fallouts once the system is running.

>> I'm seeing this backtrace now:
>>
>> [  905.883273] usb 1-2: SerialNumber: A60020000001
>> [  905.918170]  sda: sda1 sda2 sda3
>> [  905.920107] sd 0:1:0:0: [sda] Attached SCSI disk
>> [  905.944102] usb-storage 1-2:1.0: USB Mass Storage device detected
>> [  905.944102] scsi host1: usb-storage 1-2:1.0
>> [  905.944102] usbcore: registered new interface driver usb-storage
>> [  905.944117] usbcore: registered new interface driver uas
> 
> The timestamps show that time is moving forward, which is at least
> something. Do you have a feeling for whether the timestamps are
> counting in (roughly) the correct speed, or is it going much faster
> or slower than it should?
> 
> To clarify: the [905.944117] numbers are seconds/microseconds
> since boot, so message would be 906 seconds after the kernel
> started.

No, that would be definitely off. I hadn't had the machine up and running
for 15 minutes. This issue showed right after boot.

>> Begin: Loading essential drivers ... done.                                                                                                                        > Begin: Running /scripts/init-premount ... done.                                                                                                                 > Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
> 
> Ok, so it gets into user space. Is this initramfs or the actual read-only root?

This is using an initramfs.

>> [  906.666923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
>> [  906.670923] hpsa 0000:05:00.0: device is ready.
>> [  906.670923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
>> done.
>> [  906.722166] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>> [  906.722166] rcu:     2-....: (3 ticks this GP) idle=fe6/1/0x4000000000000000 softirq=693/698 fqs=4
>> [  906.722166]  (detected by 0, t=6115 jiffies, g=465, q=80)
> This appears to be an 'rcu stall' warning, from print_cpu_stall_info(),
> indicating that timer ticks are missing.

OK.

>> [  909.360108] INFO: task systemd-sysv-ge:200 blocked for more than 127 seconds.
>> [  909.360108]       Not tainted 5.10.0+ #130
>> [  909.360108] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  909.360108] task:systemd-sysv-ge state:D stack:    0 pid:  200 ppid:   189 flags:0x00000000
>> [  909.364108]
>> [  909.364108] Call Trace:
>> [  909.364423]  [<a00000010109b210>] __schedule+0x890/0x21e0
>> [  909.364423]                                 sp=e0000100487d7b70 bsp=e0000100487d1748
>> [  909.368423]  [<a00000010109cc00>] schedule+0xa0/0x240
>> [  909.368423]                                 sp=e0000100487d7b90 bsp=e0000100487d16e0
>> [  909.368558]  [<a00000010109ce70>] io_schedule+0x70/0xa0
>> [  909.368558]                                 sp=e0000100487d7b90 bsp=e0000100487d16c0
>> [  909.372290]  [<a00000010109e1c0>] bit_wait_io+0x20/0xe0
>> [  909.372290]                                 sp=e0000100487d7b90 bsp=e0000100487d1698
>> [  909.374168] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>> [  909.376290]  [<a00000010109d860>] __wait_on_bit+0xc0/0x1c0
>> [  909.376290]                                 sp=e0000100487d7b90 bsp=e0000100487d1648
>> [  909.374168] rcu:     3-....: (2 ticks this GP) idle=19e/1/0x4000000000000002 softirq=1581/1581 fqs=2
>> [  909.374168]  (detected by 0, t=5661 jiffies, g=1089, q=3)
>> [  909.376290]  [<a00000010109da80>] out_of_line_wait_on_bit+0x120/0x140
>> [  909.376290]                                 sp=e0000100487d7b90 bsp=e0000100487d1610
>> [  909.374168] Task dump for CPU 3:
>> [  909.374168] task:khungtaskd      state:R  running task
> 
> and this seems to be another instance of the same. I would assume that this
> is completely unrelated to the block driver and just happened to trigger during
> the same time the driver was doing something.
> 
> Can you see in your full logs if the "Oops: timer tick before it's due" warning
> triggered at any point?

It's difficult, to be honest. The problem is that the above message spams the whole
kernel buffer to the point that the buffer of the built-in serial console is filled
up. So I'm not sure if I've seen this message.

> I've attached a patch for a partial revert of my original change, this
> should still work with the final cleanup on top, but restore the loop
> plus the local_irq_enable()/local_irq_disable() that I dropped from
> the original code. Does this make a difference?

I'll give it a try and report back.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

