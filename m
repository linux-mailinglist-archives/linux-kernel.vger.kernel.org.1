Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874402DEB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgLRVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:30:40 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33483 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgLRVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:30:38 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kqNJr-000dfM-3d; Fri, 18 Dec 2020 22:29:47 +0100
Received: from p5b13a238.dip0.t-ipconnect.de ([91.19.162.56] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kqNJq-003t0R-Pt; Fri, 18 Dec 2020 22:29:47 +0100
Subject: Re: [PATCH v2 05/15] ia64: convert to legacy_timer_tick
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <59efce0e-a28d-9424-82ca-fb7f3a1b9c29@physik.fu-berlin.de>
Date:   Fri, 18 Dec 2020 22:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201030151758.1241164-6-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.56
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On 10/30/20 4:17 PM, Arnd Bergmann wrote:
> ia64 is the only architecture that calls xtime_update() in a loop,
> once for each jiffie that has passed since the last event.
> 
> Before commit 3171a0305d62 ("[PATCH] simplify update_times (avoid
> jiffies/jiffies_64 aliasing problem)") in 2006, it could not actually do
> this any differently, but now it seems simpler to just pass the number
> of jiffies that passed in the meantime.
> 
> While this loses the ability process interrupts in the middle of
> the timer tick by calling local_irq_enable(), doing so is fairly
> peculiar anyway and it seems better to just do what everyone
> else does here.

This broke the hpsa block device driver on my HP RX2600.

I'm seeing this backtrace now:

[  905.883273] usb 1-2: SerialNumber: A60020000001                                                                                                                         
[  905.918170]  sda: sda1 sda2 sda3                                                                                                                                        
[  905.920107] sd 0:1:0:0: [sda] Attached SCSI disk                                                                                                                        
[  905.944102] usb-storage 1-2:1.0: USB Mass Storage device detected                                                                                                       
[  905.944102] scsi host1: usb-storage 1-2:1.0                                                                                                                             
[  905.944102] usbcore: registered new interface driver usb-storage                                                                                                        
[  905.944117] usbcore: registered new interface driver uas                                                                                                                
[  905.948117] scsi 1:0:0:0: CD-ROM            TEAC     DV-W28EAW        H.0C PQ: 0 ANSI: 0                                                                                
[  905.952013] usb 2-1: new full-speed USB device number 2 using ohci-pci                                                                                                  
[  905.956102] sr 1:0:0:0: Power-on or device reset occurred                                                                                                               
[  905.968107] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray                                                                                  
[  905.968107] cdrom: Uniform CD-ROM driver Revision: 3.20                                                                                                                 
[  906.028013] ioc0: LSISAS1068 B0: Capabilities={Initiator}                                                                                                               
[  906.028110] tg3 0000:01:02.0 eth0: Tigon3 [partno(BCM95700A6) rev 2100] (PCIX:66MHz:64-bit) MAC address 00:17:a4:99:2d:09                                               
[  906.026167] usb 2-1: New USB device found, idVendor=03f0, idProduct=1126, bcdDevice= 0.01                                                                               
[  906.028110] tg3 0000:01:02.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])                                                             
[  906.028110] tg3 0000:01:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]                                                                                   
[  906.030214] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=63                                                                                          
[  906.032240] tg3 0000:01:02.0 eth0: dma_rwctrl[769f0000] dma_mask[64-bit]                                                                                                
[  906.036102] GSI 30 (level, low) -> CPU 2 (0x0200) vector 67                                                                                                             
[  906.034186] usb 2-1: Product: Virtual Management Device                                                                                                                 
[  906.038235] usb 2-1: Manufacturer: HP                                                                                                                                   
[  906.040017] usb 2-1: SerialNumber: 0017a499dd1c                                                                                                                         
[  906.056108] hid: raw HID events driver (C) Jiri Kosina                                                                                                                  
[  906.080013] usbcore: registered new interface driver usbhid                                                                                                             
[  906.080013] usbhid: USB HID core driver                                                                                                                                 
[  906.080107] input: HP Virtual Management Device as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1:1.0/0003:03F0:1126.0001/input/input2                                   
[  906.088110] hid-generic 0003:03F0:1126.0001: input,hidraw0: USB HID v1.11 Keyboard [HP Virtual Management Device] on usb-0000:00:02.0-1/input0                          
[  906.088110] input: HP Virtual Management Device as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1:1.1/0003:03F0:1126.0002/input/input3                                   
[  906.092110] hid-generic 0003:03F0:1126.0002: input,hidraw1: USB HID v1.01 Mouse [HP Virtual Management Device] on usb-0000:00:02.0-1/input1                             
[  906.104104] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.108288] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.108288] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  906.152107] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.170926] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.170926] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  906.218925] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.222925] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.222925] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  906.266926] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.272016] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.272016] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  906.272107] scsi host2: ioc0: LSISAS1068 B0, FwRev=010f0000h, Ports=1, MaxQ=511, IRQ=62                                                                                 
[  906.324110] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.330925] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.330925] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  906.378925] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.382926] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.382926] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  906.386926] tg3 0000:01:02.1 eth1: Tigon3 [partno(BCM95700A6) rev 2100] (PCIX:66MHz:64-bit) MAC address 00:17:a4:99:2d:08                                               
[  906.386926] tg3 0000:01:02.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])                                                             
[  906.388016] tg3 0000:01:02.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]                                                                                   
[  906.388016] tg3 0000:01:02.1 eth1: dma_rwctrl[769f0000] dma_mask[64-bit]                                                                                                
[  906.396108] tg3 0000:01:02.1 enp1s2f1: renamed from eth1                                                                                                                
[  906.408107] tg3 0000:01:02.0 enp1s2f0: renamed from eth0                                                                                                                
Begin: Loading essential drivers ... done.                                                                                                                                 
Begin: Running /scripts/init-premount ... done.                                                                                                                            
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.                                                                                           
Begin: Running /scripts/local-premount ... done.                                                                                                                           
Begin: Will now check root file system ... fsck from util-linux 2.36                                                                                                       
[/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2                                                                                                              
/dev/sda2: clean, 317994/2068416 files, 6480495/8257536 blocks                                                                                                             
[  906.666923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  906.670923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  906.670923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
done.                                                                                                                                                                      
[  906.722166] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:                                                                                                         
[  906.722166] rcu:     2-....: (3 ticks this GP) idle=fe6/1/0x4000000000000000 softirq=693/698 fqs=4                                                                      
[  906.722166]  (detected by 0, t=6115 jiffies, g=465, q=80)                                                                                                               
[  906.722166] Task dump for CPU 2:                                                                                                                                        
[  906.722166] task:modprobe        state:R  running task     stack:    0 pid:  162 ppid:   146 flags:0x00000002                                                           
[  906.722166]                                                                                                                                                             
[  906.722166] Call Trace:                                                                                                                                                 
[  906.722166]  [<0000000000000fd6>] 0xfd6                                                                                                                                 
[  906.722166]                                 sp=e000010046d27c70 bsp=e000010046d20e80                                                                                    
[  906.782168] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:                                                                                                         
[  906.782168] rcu:     2-....: (18 ticks this GP) idle=fe6/1/0x4000000000000000 softirq=693/698 fqs=18                                                                    
[  906.782168]  (detected by 0, t=22157 jiffies, g=465, q=80)                                                                                                              
[  906.782168] Task dump for CPU 2:                                                                                                                                        
[  906.782168] task:modprobe        state:R  running task     stack:    0 pid:  162 ppid:   146 flags:0x00000002                                                           
[  906.782168]                                                                                                                                                             
[  906.782168] Call Trace:                                                                                                                                                 
[  906.782168]  [<0000001d00000065>] 0x1d00000065                                                                                                                          
[  906.782168]                                 sp=e000010046d27c70 bsp=e000010046d20d48                                                                                    
[  906.844107] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)                                                                                     
done.                                                                                                                                                                      
Begin: Running /scripts/local-bottom ... done.                                                                                                                             
Begin: Running /scripts/init-bottom ... done.                                                                                                                              
[  906.978917] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.                                                                                
[  907.726923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  907.734923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  907.734923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  907.790923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  907.802923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  907.802923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  907.860014] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  907.886923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  907.886923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  907.930923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  907.942923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  907.942923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  907.976107] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  907.982923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  907.982923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  908.106923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  908.110923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  908.110923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  908.256014] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  908.258922] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  908.258922] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  908.428014] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  908.434923] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  908.434923] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  908.710922] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  908.714922] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  908.714922] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  908.754922] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1                           
[  908.758922] hpsa 0000:05:00.0: device is ready.                                                                                                                         
[  908.758922] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1        
[  908.788106] systemd[1]: Inserted module 'autofs4'                                                                                                                       
[  908.972107] systemd[1]: systemd 246.6-5 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD -SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)                                                                                         
[  908.976013] systemd[1]: Detected architecture ia64.                                                                                                                     

Welcome to Debian GNU/Linux bullseye/sid!

[  909.020014] systemd[1]: Set hostname to <glendronach>.
[  909.178923] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[  909.182922] hpsa 0000:05:00.0: device is ready.
[  909.182922] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[  909.242922] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[  909.254922] hpsa 0000:05:00.0: device is ready.
[  909.254922] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[  909.322922] hpsa 0000:05:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[  909.334922] hpsa 0000:05:00.0: device is ready.
[  909.334922] hpsa 0000:05:00.0: scsi 0:1:0:0: reset logical  completed successfully Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[  909.360108] INFO: task systemd-sysv-ge:200 blocked for more than 127 seconds.
[  909.360108]       Not tainted 5.10.0+ #130
[  909.360108] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  909.360108] task:systemd-sysv-ge state:D stack:    0 pid:  200 ppid:   189 flags:0x00000000
[  909.364108] 
[  909.364108] Call Trace:
[  909.364423]  [<a00000010109b210>] __schedule+0x890/0x21e0
[  909.364423]                                 sp=e0000100487d7b70 bsp=e0000100487d1748
[  909.368423]  [<a00000010109cc00>] schedule+0xa0/0x240
[  909.368423]                                 sp=e0000100487d7b90 bsp=e0000100487d16e0
[  909.368558]  [<a00000010109ce70>] io_schedule+0x70/0xa0
[  909.368558]                                 sp=e0000100487d7b90 bsp=e0000100487d16c0
[  909.372290]  [<a00000010109e1c0>] bit_wait_io+0x20/0xe0
[  909.372290]                                 sp=e0000100487d7b90 bsp=e0000100487d1698
[  909.374168] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  909.376290]  [<a00000010109d860>] __wait_on_bit+0xc0/0x1c0
[  909.376290]                                 sp=e0000100487d7b90 bsp=e0000100487d1648
[  909.374168] rcu:     3-....: (2 ticks this GP) idle=19e/1/0x4000000000000002 softirq=1581/1581 fqs=2 
[  909.374168]  (detected by 0, t=5661 jiffies, g=1089, q=3)
[  909.376290]  [<a00000010109da80>] out_of_line_wait_on_bit+0x120/0x140
[  909.376290]                                 sp=e0000100487d7b90 bsp=e0000100487d1610
[  909.374168] Task dump for CPU 3:
[  909.374168] task:khungtaskd      state:R  running task

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

