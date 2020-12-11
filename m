Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9572D7D30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395451AbgLKRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:44:42 -0500
Received: from m12-16.163.com ([220.181.12.16]:52686 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392240AbgLKRog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=bgSuw
        3P0+vX+9j8f01r+M5Hb+8gLwQOtuD2VUzQ6Ca4=; b=MZvA2dRNDHzMm/r2AljEz
        DSNIg1QgRLFmZW71DpaM0UokKcAUM29t4ien9pyAeHeO8KmIlEW9XhPhw/3VPm6X
        S0HAviBaP01rWqJkixlUERiYCwPB5clcZLmEf2vjw9heC43tUw0hLeTw0DOinOmT
        uPpo9CJgFUY0nkm5Z5zVUc=
Received: from localhost (unknown [101.86.215.73])
        by smtp12 (Coremail) with SMTP id EMCowABHETnNq9Nf4E9pRA--.28184S2;
        Sat, 12 Dec 2020 01:26:37 +0800 (CST)
Date:   Sat, 12 Dec 2020 01:26:37 +0800
From:   Hui Su <sh_def@163.com>
To:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: [linux-next] kernel panic when poweroff (Tree for Dec 11)
Message-ID: <20201211172637.GA4771@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EMCowABHETnNq9Nf4E9pRA--.28184S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur17tFWxtFyUJryDXry3CFg_yoW7JFyrpr
        1YqryjkrWkJr1UJr1UAwn8Aw10yr48Aa17Xr17Ar1xAF1UW3W7Jr18Jr4UJr1DJr48Z347
        tw1DXa1rtr4jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3L05UUUUU=
X-Originating-IP: [101.86.215.73]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbipA33X1r7rzOmGQAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,all:

I compile the next tree today(Tree for Dec 11) with x86_64_defconfig,
then run the kernel with cmd:
sudo qemu-system-x86_64 \                                            
	-kernel /home/ubuntu/workspace/share/next/bzImage \                     
	-hda /home/ubuntu/myspace/qemu_build/ubuntu.img \                       
	-hdb /home/ubuntu/myspace/qemu_build/init.img   \                       
	-append "root=/dev/sda console=ttyS0 crashkernel=128M" \                
	-nographic \                                                            
	-m 1024 \                                                               
	-fsdev local,id=fs1,path=/home/ubuntu/workspace/share,security_model=none \
	-device virtio-9p-pci,fsdev=fs1,mount_tag=host_share' 

it goes well, but when it poweroff, the panic came like this:
[  OK  ] Reached target Power-Off.
[  273.685905] BUG: unable to handle page fault for address: ffffffffffffffe8
[  273.695330] #PF: supervisor read access in kernel mode
[  273.696944] #PF: error_code(0x0000) - not-present page
[  273.698303] PGD 1140f067 P4D 1140f067 PUD 11411067 PMD 0 
[  273.700358] Oops: 0000 [#1] SMP NOPTI
[  273.701682] CPU: 0 PID: 1 Comm: shutdown Not tainted 5.10.0-rc7-next-20201211 #2
[  273.704130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  273.706446] RIP: 0010:platform_shutdown+0x4/0x20
[  273.709430] Code: 84 00 00 00 00 00 48 81 fe 60 23 99 99 74 05 0f b7 46 08 c3 31 c0 83 bf 78 02 00 00 ff 75 f0 c3 66 0f 1f 44 00 00 48 8b 47 68 <48> 8b 40 e8f
[  273.712017] RSP: 0018:ffffaf9f00013dd8 EFLAGS: 00000246
[  273.714486] RAX: 0000000000000000 RBX: ffff9b16012f3c18 RCX: 0000000000000000
[  273.715641] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff9b16012f3c10
[  273.717263] RBP: ffffffff999923a0 R08: 0000000000000000 R09: 0000000000000000
[  273.719634] R10: ffff9b163fc29100 R11: 0000000000000400 R12: ffff9b16012f3c10
[  273.720744] R13: ffff9b16012f3c90 R14: 00000000fee1dead R15: 0000000000000000
[  273.727288] FS:  00007f8190b8b980(0000) GS:ffff9b163fc00000(0000) knlGS:0000000000000000
[  273.728787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  273.729710] CR2: ffffffffffffffe8 CR3: 0000000001fd4000 CR4: 00000000000006f0
[  273.730887] Call Trace:
[  273.732286]  device_shutdown+0x14a/0x1b0
[  273.734269]  kernel_power_off+0x2c/0x70
[  273.736045]  __do_sys_reboot+0x126/0x210
[  273.736663]  ? do_sigtimedwait.isra.0+0x1c9/0x1f0
[  273.737478]  ? __x64_sys_rt_sigtimedwait+0x69/0xd0
[  273.738024]  ? do_writev+0x66/0x110
[  273.742951]  ? exit_to_user_mode_prepare+0x2f/0x130
[  273.743753]  do_syscall_64+0x33/0x40
[  273.744333]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  273.745225] RIP: 0033:0x7f8191a39487
[  273.746531] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f08
[  273.749501] RSP: 002b:00007fff89b2aac8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
[  273.750640] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8191a39487
[  273.751767] RDX: 000000004321fedc RSI: 0000000028121969 RDI: 00000000fee1dead
[  273.755119] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fff89b29ed0
[  273.756097] R10: 00007f8190b8b900 R11: 0000000000000202 R12: 0000000000000000
[  273.757119] R13: 0000000000000000 R14: 0000001b00000004 R15: 0000000000000001
[  273.758191] Modules linked in:
[  273.759203] CR2: ffffffffffffffe8
[  273.821684] ---[ end trace 96d41b084dff3b81 ]---
[  273.830228] RIP: 0010:platform_shutdown+0x4/0x20
[  273.837431] Code: 84 00 00 00 00 00 48 81 fe 60 23 99 99 74 05 0f b7 46 08 c3 31 c0 83 bf 78 02 00 00 ff 75 f0 c3 66 0f 1f 44 00 00 48 8b 47 68 <48> 8b 40 e8f
[  273.849655] RSP: 0018:ffffaf9f00013dd8 EFLAGS: 00000246
[  273.852108] RAX: 0000000000000000 RBX: ffff9b16012f3c18 RCX: 0000000000000000
[  273.853109] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff9b16012f3c10
[  273.854291] RBP: ffffffff999923a0 R08: 0000000000000000 R09: 0000000000000000
[  273.855301] R10: ffff9b163fc29100 R11: 0000000000000400 R12: ffff9b16012f3c10
[  273.856067] R13: ffff9b16012f3c90 R14: 00000000fee1dead R15: 0000000000000000
[  273.856846] FS:  00007f8190b8b980(0000) GS:ffff9b163fc00000(0000) knlGS:0000000000000000
[  273.858692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  273.859415] CR2: ffffffffffffffe8 CR3: 0000000001fd4000 CR4: 00000000000006f0
[  273.860824] Kernel panic - not syncing: Attempted to kill init!  exitcode=0x00000009
[  273.868488] Kernel Offset: 0x17800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  273.871837] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
qemu-system-x86_64: terminating on signal 15 from pid 2836242 (pkill)

The next tree for Dec 10 does not contain this problem, and the tree for Dec 11
can reproduce this problem stably(always panic when poweroff).

Reported-by: Hui Su <sh_def@163.com>

