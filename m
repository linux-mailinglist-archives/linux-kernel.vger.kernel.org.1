Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82CB2F1F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbhAKTYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390994AbhAKTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:24:47 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:24:06 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id x23so138033lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0OmjkjcTOjF+NliUFttC/HX2uDGvuVHX6ED8ikhWhgI=;
        b=pffK/efwCG2f0Kw1G/KeekujmZFMaF5MU1iPZKAAT8GekMm9uOGLRukwGDxMy4O88W
         xqzMHblnn6pdfkAMRz6NZ01DikzXg2edyF+W7OO0X9gAIC9G0UC5KtO7lGU1SRS18nI3
         0Bysy8xcjwVtAI7+ZYmJpl2ztWng9OoL8hYug82dUDXFONi2hqxPSxHorwMVIDFjB2lq
         3sFzIeZ0OvFh3or9ULLjP/WGzNaE5MFX/OfBWSppi7nQTkClW64baW4CrJFAi3SUMeOw
         xce4pIt4dixIAreupCbNNuEqCexAgDadLmixAX86NqzO6XynO4J5/QqEy2IL7w8deKvr
         JbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0OmjkjcTOjF+NliUFttC/HX2uDGvuVHX6ED8ikhWhgI=;
        b=IvzOhMORAFoJHnjI4f4Zs6gBiCIuxmwaT8wgB4fzSVxjTbT/MgvJ5ezK2oaCsKmoKD
         I5vH82kIX6MB/c+x92d/T25gJAFYvvu4yvigEEYhtUEId24uo2FLcZ0XVC55WIYLSfUf
         VM4OZGvqYxApzXhFGLmaiBSeMm4uAyLgtCSGGrIznNC47qxW5MrqLtSIRCpblEfkDSjf
         oYEBkQkyICAJ3wTkXLARCpiC0f49SVWIFrbj3UbYz0CqE9sretIB0WOZudej4kyrxh3j
         o2tlHrmLnuTbqDzweW4LdG8oALUQTdE8iUJ2Htouh/GS6Qmyk1shVBLkiTGzWW8AQm+Q
         6QoA==
X-Gm-Message-State: AOAM531eGmHa2vCzWgZrRVLmBM9pp3ll5PwdaF+pfq7gzS+25i6wBZqj
        y4nb34RuNE/JnI3MH5Tl/g46gXHApp1l0bS21wjpH+O0ahBZ+mUjWVY=
X-Google-Smtp-Source: ABdhPJyXK94/uDF1GSVK6l2pgkPp6pl3e/LzPL6x0ZGBB6JpjnjXz5UJSr3WUFq+xGNsgAycdI1CrjXFtxZH2p+4TtQ=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr414633ljh.370.1610393044702;
 Mon, 11 Jan 2021 11:24:04 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com> <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
In-Reply-To: <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 12 Jan 2021 00:23:53 +0500
Message-ID: <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 at 19:01, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:

> Changing the page table attributes while releasing memory might sleep.
> So we can't use a spinlock here.
>
> Thanks for the report, a patch to fix this is on the mailing list now.

Can you look also the first trace?
Here a same error message "sleeping function called from invalid
context" and a lot of [amdgpu] code.

BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:196
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 501, name: systemd-u=
devd
1 lock held by systemd-udevd/501:
 #0: ffff978e0278d258 (&dev->mutex){....}-{3:3}, at:
device_driver_attach+0x3b/0xb0
CPU: 25 PID: 501 Comm: systemd-udevd Not tainted
5.11.0-0.rc2.20210108gitf5e6c330254a.120.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 2802 10/21/2020
Call Trace:
 dump_stack+0x8b/0xb0
 ___might_sleep.cold+0xb6/0xc6
 ? dcn30_clock_source_create+0x34/0xb0 [amdgpu]
 kmem_cache_alloc_trace+0x204/0x230
 dcn30_clock_source_create+0x34/0xb0 [amdgpu]
 dcn30_create_resource_pool+0x1d9/0x13a0 [amdgpu]
 ? rcu_read_lock_sched_held+0x3f/0x80
 ? trace_kmalloc+0xb2/0xe0
 ? __kmalloc+0x191/0x280
 ? dc_create_resource_pool+0x110/0x1d0 [amdgpu]
 dc_create_resource_pool+0x110/0x1d0 [amdgpu]
 dc_create+0x205/0x790 [amdgpu]
 ? trace_kmalloc+0xb2/0xe0
 ? kmem_cache_alloc_trace+0x174/0x230
 amdgpu_dm_init.isra.0+0x1b9/0x250 [amdgpu]
 ? dev_vprintk_emit+0x171/0x195
 ? dev_printk_emit+0x3e/0x40
 dm_hw_init+0xe/0x20 [amdgpu]
 amdgpu_device_init.cold+0x179f/0x1afd [amdgpu]
 ? pci_conf1_read+0xa4/0x100
 amdgpu_driver_load_kms+0x68/0x280 [amdgpu]
 amdgpu_pci_probe+0x129/0x1b0 [amdgpu]
 local_pci_probe+0x42/0x80
 pci_device_probe+0xd9/0x1a0
 really_probe+0x205/0x460
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa8/0xb0
 __driver_attach+0x8c/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x67/0x90
 bus_add_driver+0x12e/0x1f0
 driver_register+0x8f/0xe0
 ? 0xffffffffc0d9c000
 do_one_initcall+0x67/0x320
 ? rcu_read_lock_sched_held+0x3f/0x80
 ? trace_kmalloc+0xb2/0xe0
 ? kmem_cache_alloc_trace+0x174/0x230
 do_init_module+0x5c/0x270
 __do_sys_init_module+0x130/0x190
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f363661deee
Code: 48 8b 0d 85 1f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 52 1f 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffeb7191588 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
RAX: ffffffffffffffda RBX: 0000561b94563170 RCX: 00007f363661deee
RDX: 0000561b94579df0 RSI: 0000000000b8a356 RDI: 00007f3633b9e010
RBP: 00007f3633b9e010 R08: 0000561b94565240 R09: 00007ffeb718d786
R10: 0000561ef5ef1595 R11: 0000000000000246 R12: 0000561b94579df0
R13: 0000561b9457a3e0 R14: 0000000000000000 R15: 0000561b94576530
[drm] Display Core initialized with v3.2.116!
[drm] DMUB hardware initialized: version=3D0x02000001
usb 1-3.2: new high-speed USB device number 5 using xhci_hcd
[drm] REG_WAIT timeout 1us * 100000 tries - mpc2_assert_idle_mpcc line:480

> > -12 is just -ENOMEM. Looks like a memory leak to me, maybe caused by
> > the problem above, maybe something completely unrelated.
> >
> > I will take a look.
>
> The looks like a completely unrelated memory leak to me.
>
> Probably best if you open up a bug report for this.

Yes, the monitor still turns off after applying patch "make the pool
shrinker lock a mutex".
Anyway patch fixed the issue with flood of message "BUG: sleeping
function called from invalid context at mm/vmalloc.c:1756" so kernel
log became cleaner.
Now the issue with turns off monitor looks in logs so:

DMA-API: cacheline tracking ENOMEM, dma-debug disabled
amdgpu 0000:0b:00.0: amdgpu: 000000006b791523 pin failed
[drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
framebuffer with error -12
BUG: kernel NULL pointer dereference, address: 0000000000000060
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 20 PID: 3780 Comm: brave:cs0 Tainted: G        W        ---------
---  5.11.0-0.rc2.20210108gitf5e6c330254a.120.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 2802 10/21/2020
RIP: 0010:ttm_tt_swapin+0x34/0x1b0 [ttm]
Code: 55 41 54 55 53 48 83 ec 10 48 8b 47 20 48 89 44 24 08 48 85 c0
0f 84 86 01 00 00 48 8b 44 24 08 49 89 fc 4c 8b a8 e0 01 00 00 <41> 8b
45 60 89 44 24 04 8b 47 0c 85 c0 0f 84 df 00 00 00 31 db 65
RSP: 0018:ffffa7400532b9c0 EFLAGS: 00010286
RAX: ffff978e2ae25800 RBX: ffff97910ec12058 RCX: ffff978e12caac70
RDX: 0000000080000010 RSI: 0000000000000000 RDI: ffff97912c3d99c0
RBP: ffff97912c3d99c0 R08: 0000000000000000 R09: 0000000070b3a000
R10: 0000000000000002 R11: 0000000000000000 R12: ffff97912c3d99c0
R13: 0000000000000000 R14: ffffa7400532ba90 R15: ffff978e182c6350
FS:  00007f070bb1b640(0000) GS:ffff979509200000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000060 CR3: 00000001f0cd2000 CR4: 0000000000350ee0
Call Trace:
 ttm_tt_populate+0xa9/0xe0 [ttm]
 ttm_bo_handle_move_mem+0x142/0x180 [ttm]
 ttm_bo_validate+0x12e/0x1c0 [ttm]
 amdgpu_cs_bo_validate+0x82/0x190 [amdgpu]
 amdgpu_cs_list_validate+0x105/0x150 [amdgpu]
 amdgpu_cs_ioctl+0x80a/0x1f10 [amdgpu]
 ? trace_hardirqs_off_caller+0x21/0xd0
 ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
 drm_ioctl_kernel+0x8c/0xe0 [drm]
 drm_ioctl+0x20f/0x3c0 [drm]
 ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
 ? selinux_file_ioctl+0x147/0x200
 ? lock_acquired+0x1fa/0x380
 ? lock_release+0x1e9/0x400
 ? trace_hardirqs_on+0x1b/0xe0
 amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
 __x64_sys_ioctl+0x82/0xb0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f0725633f8b
Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c
c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d b5 be 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f070bb19ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f070bb19f40 RCX: 00007f0725633f8b
RDX: 00007f070bb19f40 RSI: 00000000c0186444 RDI: 000000000000001b
RBP: 00000000c0186444 R08: 00007f070bb1a540 R09: 00007f070bb19f20
R10: 0000000000000000 R11: 0000000000000246 R12: 00002b89a7bdb088
R13: 000000000000001b R14: 0000000000000000 R15: 00000000fffffffd
Modules linked in: snd_seq_dummy snd_hrtimer uinput rfcomm nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
iptable_filter cmac bnep zstd sunrpc vfat fat uas usb_storage
hid_logitech_hidpp hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb
mt76_usb mt76x02_lib gspca_zc3xx mt76 gspca_main snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg intel_rapl_msr soundwire_intel joydev
intel_rapl_common soundwire_generic_allocation iwlmvm snd_soc_core
uvcvideo edac_mce_amd videobuf2_vmalloc videobuf2_memops snd_compress
snd_usb_audio kvm_amd videobuf2_v4l2 snd_pcm_dmaengine
 snd_usbmidi_lib soundwire_cadence videobuf2_common btusb mac80211
snd_rawmidi snd_hda_codec videodev kvm snd_hda_core ac97_bus snd_hwdep
btrtl libarc4 snd_seq btbcm btintel snd_seq_device irqbypass xpad
bluetooth mc snd_pcm iwlwifi rapl ff_memless eeepc_wmi asus_wmi
snd_timer sparse_keymap ecdh_generic video wmi_bmof ecc pcspkr snd
sp5100_tco cfg80211 k10temp soundcore i2c_piix4 rfkill acpi_cpufreq
binfmt_misc ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel ccp igb nvme dca i2c_algo_bit xhci_pci nvme_core
xhci_pci_renesas wmi pinctrl_amd fuse
CR2: 0000000000000060
---[ end trace b0dd767146d85401 ]---
RIP: 0010:ttm_tt_swapin+0x34/0x1b0 [ttm]
Code: 55 41 54 55 53 48 83 ec 10 48 8b 47 20 48 89 44 24 08 48 85 c0
0f 84 86 01 00 00 48 8b 44 24 08 49 89 fc 4c 8b a8 e0 01 00 00 <41> 8b
45 60 89 44 24 04 8b 47 0c 85 c0 0f 84 df 00 00 00 31 db 65
RSP: 0018:ffffa7400532b9c0 EFLAGS: 00010286
RAX: ffff978e2ae25800 RBX: ffff97910ec12058 RCX: ffff978e12caac70
RDX: 0000000080000010 RSI: 0000000000000000 RDI: ffff97912c3d99c0
RBP: ffff97912c3d99c0 R08: 0000000000000000 R09: 0000000070b3a000
R10: 0000000000000002 R11: 0000000000000000 R12: ffff97912c3d99c0
R13: 0000000000000000 R14: ffffa7400532ba90 R15: ffff978e182c6350
FS:  00007f070bb1b640(0000) GS:ffff979509200000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000060 CR3: 00000001f0cd2000 CR4: 0000000000350ee0
BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:49
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 3780, name: brave:cs=
0
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff8c0d9abb>] copy_process+0x8fb/0x1d=
e0
softirqs last  enabled at (0): [<ffffffff8c0d9abb>] copy_process+0x8fb/0x1d=
e0
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 20 PID: 3780 Comm: brave:cs0 Tainted: G      D W        ---------
---  5.11.0-0.rc2.20210108gitf5e6c330254a.120.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 2802 10/21/2020
Call Trace:
 dump_stack+0x8b/0xb0
 ___might_sleep.cold+0xb6/0xc6
 exit_signals+0x1c/0x2d0
 do_exit+0xcd/0xc20
 ? __x64_sys_ioctl+0x82/0xb0
 rewind_stack_do_exit+0x17/0x20
RIP: 0033:0x7f0725633f8b
Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c
c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d b5 be 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f070bb19ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f070bb19f40 RCX: 00007f0725633f8b
RDX: 00007f070bb19f40 RSI: 00000000c0186444 RDI: 000000000000001b
RBP: 00000000c0186444 R08: 00007f070bb1a540 R09: 00007f070bb19f20
R10: 0000000000000000 R11: 0000000000000246 R12: 00002b89a7bdb088
R13: 000000000000001b R14: 0000000000000000 R15: 00000000fffffffd
GpuWatchdog[3635]: segfault at 0 ip 000055a8db6e3429 sp
00007fc593e4d420 error 6 in gitkraken[55a8d7d97000+5cb7000]
Code: 00 79 09 48 8b 7d c0 e8 85 f6 bd fe c7 45 c0 aa aa aa aa 0f ae
f0 41 8b 84 24 e0 00 00 00 89 45 c0 48 8d 7d c0 e8 e7 96 6b fc <c7> 04
25 00 00 00 00 37 13 00 00 48 83 c4 38 5b 41 5c 41 5d 41 5e

You said that I need open up a bug report you means site
https://bugzilla.kernel.org ?
I thought mailing lists is better because bug report on
bugzilla.kernel.org usually leave opened for several years without
attention.

Full kernel logs is here:
[1] https://pastebin.com/w64H4b8w

--
Best Regards,
Mike Gavrilov.
