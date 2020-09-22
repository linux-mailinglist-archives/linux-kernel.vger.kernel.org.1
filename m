Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26927436F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIVNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:44:21 -0400
Received: from services.gouders.net ([141.101.32.176]:42383 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVNoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:44:21 -0400
X-Greylist: delayed 1005 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 09:44:20 EDT
Received: from localhost (ltea-047-066-036-058.pools.arcor-ip.net [47.66.36.58])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 08MDNAXH029898
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 15:23:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1600780991; bh=coiTodviEcrcWxbwMzd9GUCHHrnCtn2z1Ed7xLk9mlY=;
        h=From:To:Cc:Subject:Date;
        b=ewkZtHTKNy2m8ROiLmQcBRUetAem+7GCruAm0U94ouRSFagvie7nET4flARo7Hh3s
         sWW7Kafg6QUMIMhecesh9ipdJX1zS2LRB+W7SCF3ltGTmEfi3WkZtn3LQ8FnCxiKPI
         93zGIQ5pd8eWwpxbmYBYXhOfZxxR9GSPKY7qk5gY=
From:   Dirk Gouders <dirk@gouders.net>
To:     Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: amdgpu: call trace introduced in 5.9-rc1 for Lenovo L14 Renoir
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 22 Sep 2020 15:23:10 +0200
Message-ID: <ghh7rqvtc1.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a call trace (attached) when starting my machine (ThinkPad
L14).  This machine is new and I am still working on it's
configuration but visually noticeable is that scrolling in xterms with
SHIFT-PgUp/PgDn is broken.  Using the mouse wheel works.

It seems the call trace has been introduced between 5.8 and 5.9-rc1 and
I tried to bisect this but always end in situations where I dont't find
a bootable commit around the current bisect position.  Mainly the
machine then hangs when udevd is started.

Please let me know if I can help with further information.

Dirk

= lspci -vk ============================================================

06:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Renoir (rev c3) (prog-if 00 [VGA controller])
        Subsystem: Lenovo Renoir
        Flags: bus master, fast devsel, latency 0, IRQ 64
        Memory at 460000000 (64-bit, prefetchable) [size=256M]
        Memory at 470000000 (64-bit, prefetchable) [size=2M]
        I/O ports at 1000 [size=256]
        Memory at fd300000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [64] Express Legacy Endpoint, MSI 00
        Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
        Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [270] Secondary PCI Express
        Capabilities: [2b0] Address Translation Service (ATS)
        Capabilities: [2c0] Page Request Interface (PRI)
        Capabilities: [2d0] Process Address Space ID (PASID)
        Capabilities: [400] Data Link Feature <?>
        Capabilities: [410] Physical Layer 16.0 GT/s <?>
        Capabilities: [440] Lane Margining at the Receiver <?>
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu

= call trace ===========================================================

[    5.181468] amdgpu 0000:06:00.0: amdgpu: SMU is initialized successfully!
[    5.182857] [drm] kiq ring mec 2 pipe 1 q 0
[    5.183374] ------------[ cut here ]------------
[    5.183448] WARNING: CPU: 1 PID: 684 at drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c:716 rn_clk_mgr_construct+0x242/0x389 [amdgpu]
[    5.183449] Modules linked in: btusb btrtl btbcm btintel bluetooth ecdh_generic ecc iwlmvm mac80211 libarc4 wmi_bmof crct10dif_pclmul snd_hda_codec_realtek 
crc32c_intel iwlwifi snd_hda_codec_generic amdgpu(+) tpm_crb snd_hda_codec_hdmi gpu_sched i2c_algo_bit ttm sdhci_pci aesni_intel drm_kms_helper cqhci sdhci ccp
 syscopyarea snd_hda_intel sysfillrect tpm_tis snd_intel_dspcfg sysimgblt xhci_pci tpm_tis_core fb_sys_fops r8169 snd_hda_codec mmc_core snd_hda_core xhci_hcd 
thinkpad_acpi cfg80211 realtek drm snd_pcm rng_core mdio_devres sha1_generic snd_timer nvram libphy i2c_piix4 snd k10temp soundcore ledtrig_audio rfkill tpm hw
mon wmi battery ac video backlight pinctrl_amd acpi_cpufreq button efivarfs
[    5.183470] CPU: 1 PID: 684 Comm: udevd Not tainted 5.9.0-rc6-x86_64+ #170
[    5.183471] Hardware name: LENOVO 20U50008GE/20U50008GE, BIOS R19ET26W (1.10 ) 06/22/2020
[    5.183531] RIP: 0010:rn_clk_mgr_construct+0x242/0x389 [amdgpu]
[    5.183533] Code: 30 4d 85 c9 74 26 ba 03 00 00 00 83 bc d4 a8 00 00 00 00 89 d6 74 0a 83 bc d4 ac 00 00 00 00 75 40 48 ff ca 48 83 fa ff 75 e1 <0f> 0b 83 7
b 20 01 0f 84 13 01 00 00 81 bd e8 00 00 00 ff 14 37 00
[    5.183533] RSP: 0018:ffffc9000111f798 EFLAGS: 00010246
[    5.183534] RAX: ffff8883fc1d8e00 RBX: ffff8883f925c9c0 RCX: 0000000000000000
[    5.183535] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff8883f8da70c8
[    5.183535] RBP: ffff8883fe8da000 R08: 0000000000000000 R09: ffff8883f724fc00
[    5.183535] R10: 7fc9117fffffffff R11: ffff8883f925c9c0 R12: ffff8883f925c900
[    5.183536] R13: ffff8883f5980000 R14: 0000000000000000 R15: 0000000000000001
[    5.183537] FS:  00007f9e31a83d80(0000) GS:ffff88840ec40000(0000) knlGS:0000000000000000
[    5.183537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.183538] CR2: 000055fdf9ec5568 CR3: 00000003fb2b6000 CR4: 0000000000350ee0
[    5.183538] Call Trace:
[    5.183595]  dc_clk_mgr_create+0x135/0x18b [amdgpu]
[    5.183651]  dc_create+0x238/0x5e3 [amdgpu]
[    5.183708]  amdgpu_dm_init+0x167/0x1101 [amdgpu]
[    5.183762]  dm_hw_init+0xa/0x17 [amdgpu]
[    5.183805]  amdgpu_device_init+0x1566/0x1853 [amdgpu]
[    5.183811]  ? __kmalloc+0xad/0xbf
[    5.183852]  ? amdgpu_driver_load_kms+0x1c/0x17f [amdgpu]
[    5.183892]  amdgpu_driver_load_kms+0x41/0x17f [amdgpu]
[    5.183959]  amdgpu_pci_probe+0x139/0x1c0 [amdgpu]
[    5.183967]  pci_device_probe+0xc6/0x135
[    5.183971]  really_probe+0x157/0x32a
[    5.183974]  driver_probe_device+0x63/0x97
[    5.183976]  device_driver_attach+0x37/0x50
[    5.183978]  __driver_attach+0x92/0x9a
[    5.183980]  ? device_driver_attach+0x50/0x50
[    5.183983]  bus_for_each_dev+0x70/0xa6
[    5.183986]  bus_add_driver+0x103/0x1b4
[    5.183988]  driver_register+0x99/0xd2
[    5.183990]  ? 0xffffffffa0b2f000
[    5.183993]  do_one_initcall+0x8a/0x195
[    5.183997]  ? kmem_cache_alloc_trace+0x80/0x8f
[    5.184002]  do_init_module+0x56/0x1e8
[    5.184005]  load_module+0x1c2c/0x2139
[    5.184010]  ? __do_sys_finit_module+0x8f/0xb6
[    5.184012]  __do_sys_finit_module+0x8f/0xb6
[    5.184017]  do_syscall_64+0x5d/0x6a
[    5.184021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.184023] RIP: 0033:0x7f9e31b93919
[    5.184026] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 05 0c 00 f7 d8 64 89 01 48
[    5.184028] RSP: 002b:00007fff315a0fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    5.184030] RAX: ffffffffffffffda RBX: 000055fdf9eebde0 RCX: 00007f9e31b93919
[    5.184031] RDX: 0000000000000000 RSI: 00007f9e31c6a91d RDI: 0000000000000013
[    5.184032] RBP: 0000000000020000 R08: 0000000000000000 R09: 00007fff315a1110
[    5.184033] R10: 0000000000000013 R11: 0000000000000246 R12: 00007f9e31c6a91d
[    5.184034] R13: 0000000000000000 R14: 000055fdf9ed8060 R15: 000055fdf9eebde0
[    5.184037] ---[ end trace a782862b8da91b8d ]---
