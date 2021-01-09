Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7932EFF84
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 13:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAIMnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 07:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAIMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 07:43:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBEC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 04:42:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so29647206lfo.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 04:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ikIOv+7uh9vQ41ioXNZ3hAXp041WPdGPQZbdKGEX79A=;
        b=MmdNcn5qLYNajDkfmY5KQVO4zajlOUOZVxl+J2xwmfoRWzAzBonsddg5to1X9tKoh+
         ONF9Rqyq4BaEyquYr0ie5vyoQA2X4zPs+FoH/d932TkEnSemRauw+YR0n2v8vgl27mXE
         46zxKpH7ARu239f/m1pnKzYh4w/sfiEsdxAkq8hdjQlGfJHOVbE/brbBwFKK6fBUemi1
         cGvtjH+dkUijQKi7y7NzERA5JOAQq7hXjYNczvL5q2UI4m+EH+fnUKvxe6m2iAqTl0Q6
         klMdCofm0/odoTrxw0SWKbDZo0VCiBMffLW0V3p3qyDX4vcB+2J9zDIxQa4kzeDpCdAX
         0zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ikIOv+7uh9vQ41ioXNZ3hAXp041WPdGPQZbdKGEX79A=;
        b=hlvK2PRZxdOvQC5EDUF2pzi8xLlzswz9ejpvO2+xYTA492Tw8bowrgfpOir/aRq43N
         DPI8knK9bl6YU3qS76mecQD9zjyJdpkfpoMZeuWo2Jh5Z1EEQC27XyfZ1hcysUdjU0Qh
         laiVoX219GQJdS1PnaLcQ8W9GspFLk5jIGIpzInBEzlhKhMX7kGMZQS4JCgwBYzUGId6
         A2TVDDnclnO3mUJwDdIcsy/lKiwKUNJC6KGEbje+7BgdSOqjYOwpeW8xmJ+VCsBV7f2t
         Xkt+wjj/R3CgcCZVMDPJMJNVV6M24yiH+RgWzNE/bzV2PLklivlJFmHDzn3vQM/wmPKN
         Qb1A==
X-Gm-Message-State: AOAM531Ho/Sxfzjk4QduJYzK5Ei087ROV3W8MTHbyu3jtF7t9oZffcL0
        yq+J+KxVsyDgrP/2id9VRn77Lgc6LDQAV+mBesE=
X-Google-Smtp-Source: ABdhPJxaZJFRx+p07G6orAPhJvnDxsw/NtkHOVCUUXZCTL3zNYvIEtWcg+HnqUDbYmK9VcajNZKHYnmYyNuUk9wOVrY=
X-Received: by 2002:a19:f203:: with SMTP id q3mr3396509lfh.166.1610196160164;
 Sat, 09 Jan 2021 04:42:40 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 9 Jan 2021 17:42:29 +0500
Message-ID: <CABXGCsPZvfsUBiMr5fdQYRf26bMchN=UL8oXojgoVbWtwJhXjQ@mail.gmail.com>
Subject: BUG: key ffff8b521bda9148 has not been registered!
To:     bvanassche@acm.org, Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!
I started to see this message every boot after replacing Radeon VII to 6900XT.

$ journalctl | grep "BUG: key"
Dec 31 05:19:42 localhost.localdomain kernel: BUG: key
ffff98b59ab01148 has not been registered!
Dec 31 05:25:44 localhost.localdomain kernel: BUG: key
ffff8d425ba01148 has not been registered!
Jan 02 17:36:25 localhost.localdomain kernel: BUG: key
ffff935e5a959148 has not been registered!
Jan 03 03:29:08 localhost.localdomain kernel: BUG: key
ffff8d425b0b9148 has not been registered!
Jan 03 03:33:35 localhost.localdomain kernel: BUG: key
ffff8bc35aef9148 has not been registered!
Jan 03 16:47:44 localhost.localdomain kernel: BUG: key
ffff9a3cdb959148 has not been registered!
Jan 06 14:59:58 localhost.localdomain kernel: BUG: key
ffff97b6db9f9148 has not been registered!
Jan 07 14:51:49 localhost.localdomain kernel: BUG: key
ffff8f2dda569148 has not been registered!
Jan 07 15:08:23 localhost.localdomain kernel: BUG: key
ffffa0849bd31148 has not been registered!
Jan 08 18:07:28 localhost.localdomain kernel: BUG: key
ffff89721a0e9148 has not been registered!
Jan 08 18:12:51 localhost.localdomain kernel: BUG: key
ffff8b521bda9148 has not been registered!

Here is trace:
[    6.333672] [drm] REG_WAIT timeout 1us * 100000 tries -
mpc2_assert_idle_mpcc line:480
[    6.335258] BUG: key ffff8b521bda9148 has not been registered!
[    6.335271] ------------[ cut here ]------------
[    6.335273] DEBUG_LOCKS_WARN_ON(1)
[    6.335279] WARNING: CPU: 18 PID: 525 at
kernel/locking/lockdep.c:4618 lockdep_init_map_waits+0x18b/0x210
[    6.335284] Modules linked in: fjes(-) amdgpu(+) iommu_v2 gpu_sched
ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel ccp igb nvme nvme_core dca i2c_algo_bit wmi
pinctrl_amd fuse
[    6.335298] CPU: 18 PID: 525 Comm: systemd-udevd Not tainted
5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64 #1
[    6.335302] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 2802 10/21/2020
[    6.335306] RIP: 0010:lockdep_init_map_waits+0x18b/0x210
[    6.335309] Code: 00 85 c0 0f 84 75 ff ff ff 8b 3d 18 c4 f1 01 85
ff 0f 85 67 ff ff ff 48 c7 c6 68 43 60 97 48 c7 c7 1d 90 5a 97 e8 70
1f b6 00 <0f> 0b e9 4d ff ff ff e8 19 59 bc 00 85 c0 74 21 44 8b 1d e6
c3 f1
[    6.335315] RSP: 0018:ffff9e5a013d3910 EFLAGS: 00010282
[    6.335317] RAX: 0000000000000016 RBX: ffffffff97247d80 RCX: ffff8b5908fdb238
[    6.335320] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8b5908fdb230
[    6.335322] RBP: ffff8b520e2a7978 R08: 0000000000000000 R09: 0000000000000000
[    6.335325] R10: ffff9e5a013d3740 R11: ffff8b592e2fffe8 R12: ffff8b521bda9148
[    6.335327] R13: 0000000000000000 R14: ffff8b521bc30330 R15: ffff8b521bc30330
[    6.335330] FS:  00007fe019eb9140(0000) GS:ffff8b5908e00000(0000)
knlGS:0000000000000000
[    6.335333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.335336] CR2: 00007fe018f5e000 CR3: 00000001142ee000 CR4: 0000000000350ee0
[    6.335338] Call Trace:
[    6.335342]  __kernfs_create_file+0x7b/0x100
[    6.335344]  sysfs_add_file_mode_ns+0xa3/0x190
[    6.335347]  sysfs_create_bin_file+0x50/0x70
[    6.335428]  hdcp_create_workqueue+0x3bd/0x410 [amdgpu]
[    6.335499]  amdgpu_dm_init.isra.0.cold+0x136/0x126d [amdgpu]
[    6.335570]  ? psp_set_srm+0xb0/0xb0 [amdgpu]
[    6.335637]  ? hdcp_update_display+0x1f0/0x1f0 [amdgpu]
[    6.335641]  ? dev_printk_emit+0x3e/0x40
[    6.335709]  dm_hw_init+0xe/0x20 [amdgpu]
[    6.335776]  amdgpu_device_init.cold+0x18c3/0x1bbc [amdgpu]
[    6.335781]  ? pci_bus_read_config_word+0x39/0x50
[    6.335831]  amdgpu_driver_load_kms+0x2b/0x1f0 [amdgpu]
[    6.335879]  amdgpu_pci_probe+0x129/0x1b0 [amdgpu]
[    6.335889]  local_pci_probe+0x42/0x80
[    6.335891]  pci_device_probe+0xd9/0x1a0
[    6.335896]  really_probe+0x205/0x460
[    6.335898]  driver_probe_device+0xe1/0x150
[    6.335901]  device_driver_attach+0xa8/0xb0
[    6.335904]  __driver_attach+0x8c/0x150
[    6.335907]  ? device_driver_attach+0xb0/0xb0
[    6.335909]  ? device_driver_attach+0xb0/0xb0
[    6.335911]  bus_for_each_dev+0x67/0x90
[    6.335914]  bus_add_driver+0x12e/0x1f0
[    6.335917]  driver_register+0x8b/0xe0
[    6.335919]  ? 0xffffffffc0e4c000
[    6.335922]  do_one_initcall+0x67/0x320
[    6.335925]  ? rcu_read_lock_sched_held+0x3f/0x80
[    6.335928]  ? trace_kmalloc+0xb2/0xe0
[    6.335930]  ? kmem_cache_alloc_trace+0x157/0x270
[    6.335934]  do_init_module+0x5c/0x260
[    6.335936]  __do_sys_init_module+0x13d/0x1a0
[    6.335940]  do_syscall_64+0x33/0x40
[    6.335943]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    6.335945] RIP: 0033:0x7fe01aab2efe
[    6.335948] Code: 48 8b 0d 7d 1f 0c 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4a 1f 0c 00 f7 d8 64 89
01 48
[    6.335953] RSP: 002b:00007ffdf4879928 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[    6.335957] RAX: ffffffffffffffda RBX: 00005636774ad820 RCX: 00007fe01aab2efe
[    6.335959] RDX: 00005636774856e0 RSI: 0000000000b4f95e RDI: 00007fe01840f010
[    6.335962] RBP: 00007fe01840f010 R08: 000056367748bd30 R09: 0000000000b4f970
[    6.335964] R10: 00005633142fc82b R11: 0000000000000246 R12: 00005636774856e0
[    6.335967] R13: 00005636774d22d0 R14: 0000000000000000 R15: 00005636774a1d80
[    6.335971] irq event stamp: 343839
[    6.335973] hardirqs last  enabled at (343839):
[<ffffffff96162861>] console_unlock+0x511/0x640
[    6.335977] hardirqs last disabled at (343838):
[<ffffffff961627c8>] console_unlock+0x478/0x640
[    6.335981] softirqs last  enabled at (343730):
[<ffffffff96e01112>] asm_call_irq_on_stack+0x12/0x20
[    6.335984] softirqs last disabled at (343657):
[<ffffffff96e01112>] asm_call_irq_on_stack+0x12/0x20
[    6.335987] ---[ end trace a4445e953bea9224 ]---

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux lockdep_init_map_waits+0x18b
lockdep_init_map_waits+0x18b/0x210:
lockdep_init_map_waits at kernel/locking/lockdep.c:4618 (discriminator 7)

$ git blame -L 4613,4623 kernel/locking/lockdep.c
Blaming lines:   0% (11/6357), done.
108c14858b9ea kernel/locking/lockdep.c (Bart Van Assche 2019-02-14
15:00:53 -0800 4613)          * statically or must have been
registered as a dynamic key.
fbb9ce9530fd9 kernel/lockdep.c         (Ingo Molnar     2006-07-03
00:24:50 -0700 4614)          */
108c14858b9ea kernel/locking/lockdep.c (Bart Van Assche 2019-02-14
15:00:53 -0800 4615)         if (!static_obj(key) &&
!is_dynamic_key(key)) {
108c14858b9ea kernel/locking/lockdep.c (Bart Van Assche 2019-02-14
15:00:53 -0800 4616)                 if (debug_locks)
108c14858b9ea kernel/locking/lockdep.c (Bart Van Assche 2019-02-14
15:00:53 -0800 4617)                         printk(KERN_ERR "BUG: key
%px has not been registered!\n", key);
fbb9ce9530fd9 kernel/lockdep.c         (Ingo Molnar     2006-07-03
00:24:50 -0700 4618)                 DEBUG_LOCKS_WARN_ON(1);
fbb9ce9530fd9 kernel/lockdep.c         (Ingo Molnar     2006-07-03
00:24:50 -0700 4619)                 return;
fbb9ce9530fd9 kernel/lockdep.c         (Ingo Molnar     2006-07-03
00:24:50 -0700 4620)         }
fbb9ce9530fd9 kernel/lockdep.c         (Ingo Molnar     2006-07-03
00:24:50 -0700 4621)         lock->key = key;
c8a2500586564 kernel/lockdep.c         (Peter Zijlstra  2009-04-17
09:40:49 +0200 4622)
c8a2500586564 kernel/lockdep.c         (Peter Zijlstra  2009-04-17
09:40:49 +0200 4623)         if (unlikely(!debug_locks))

Looks this issue also triggering the next issue, see backtrace:
WARNING: CPU: 29 PID: 1186 at net/netfilter/nf_tables_api.c:622
nft_chain_parse_hook+0x26d/0x310 [nf_tables]

Who can help fix this?

Full kernel logs is here: https://pastebin.com/d2Nq01SX

--
Best Regards,
Mike Gavrilov.
