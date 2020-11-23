Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F782BFEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgKWD30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKWD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:29:25 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31404C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:29:24 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e81so13093710ybc.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+iJ9xZkdZqdb4FjFDSztGapfDkK/TqluWufvfmoV39s=;
        b=odGsUiwbUeXfqjRcXazttH2TKAk1v9EuprMxP2j3OQOlWPn8fOovw6syobCcpZ1517
         m71FbWAzblNyExAyUOyuh3gfEfGu939O0+gn7YZ33kE2UtZlil7pBwBsqPRFIjlyj3wP
         NvR2aApD/SpRn9aYioK3ctsIofkFCr7mB8mVDMIOwVo3rT6OMkE8nzUd5i8SrKBVDOKX
         Fs5UlzGY0XNR4/L9wSfhV0Y22rSw0sSCGidqDSbLYUMhTIuiFK9SmNrk6xjsuM6lEpI0
         Xhl9PU+e+pbYCf9HlJKvvj2c9LNwMtfjJ9bcLyRY8SDmlOMKHfMHy1tdTNKSF+zmVkAR
         p93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+iJ9xZkdZqdb4FjFDSztGapfDkK/TqluWufvfmoV39s=;
        b=K+0YVfWW60oQuQDE2C8alQh2uU2pMqMyTYtBK6aIUFZQDMN23gNFFXUDVxiNmqNh8X
         1g8hdm7UemmBilqa3m2fiQYsp/y45vl5qePx0FkUqdcqquqRCYzt3vS6sfB9IpRctOXQ
         lmwUZDSK4BBASftTACj5ASjK8PIyoxZrjy7DmOx2RHbhYyMgaxTq2lY2aqsbGZIvEEu5
         AtOuCRx/IMOr2ff43f7QcnFWXibRlFzB/1E0kM6kUWXZueGSs7Iz19qYLMhY531K996Z
         YweAnD9Im3xvmkrGD9sCLMeH5ui2dYgkMCw0pJvQxrXM6iC6fWg05OSwLGUPZUFAM96G
         NBPg==
X-Gm-Message-State: AOAM530GSieHoffhQTmb4Ur53xo4kXwRWFXyBicBoAEuszZ8OQ6sh+HB
        tRmPznqpOQc+mCRYpEJmj/f1wDV49Qx11V76mR0=
X-Google-Smtp-Source: ABdhPJz1cAWn9P09lB3kd7ly0yBvnyMq5IKueKHzbGQVCyD5N8Z6buKkHnXeo3ZuF3ZXRfvAQYGFe9aWMf0mIZHgp4M=
X-Received: by 2002:a25:2f4e:: with SMTP id v75mr40111361ybv.18.1606102163198;
 Sun, 22 Nov 2020 19:29:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Mon, 23 Nov 2020 11:28:57 +0800
Message-ID: <CAD-N9QXL6ZFBF+WtLuKD+ay-jTNep3mhR_n=Jxc3-MrpDwd3Ow@mail.gmail.com>
Subject: WARNING at drivers/gpu/drm/drm_gem_vram_helper.c:284 drm_gem_vram_offset
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When I leveraged syzkaller to fuzz this kernel image, the VMs is
always broken with the following WARNING report:

```
[   18.093341][    T1] ------------[ cut here ]------------
[   18.093419][    T1] WARNING: CPU: 1 PID: 1 at
drivers/gpu/drm/drm_gem_vram_helper.c:284
drm_gem_vram_offset+0x128/0x140
[   18.093431][    T1] Modules linked in:
[   18.093472][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1 #2
[   18.093489][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[   18.093532][    T1] RIP: 0010:drm_gem_vram_offset+0x128/0x140
[   18.093574][    T1] Code: 48 c7 c3 ed ff ff ff 31 c0 31 c9 eb b4 8b
7d d4 e8 bd 78 1e fc e9 56 ff ff ff 8b 3a e8 b1 78 1e fc 4d 85 ff 0f
85 6e ff ff ff <0f> 0b 31 c0 31 c9 31 db eb 8d 8b 7d d4 e8 96 78 1e fc
e9 67 ff ff
[   18.093594][    T1] RSP: 0000:ffff8880125a6718 EFLAGS: 00010246
[   18.093622][    T1] RAX: 0000000000000000 RBX: ffff8880155efd80
RCX: 00000000151efd80
[   18.093645][    T1] RDX: ffff8880151efd80 RSI: 0000000000000040
RDI: ffff8880155efd80
[   18.093669][    T1] RBP: ffff8880125a6748 R08: ffffea000000000f
R09: ffff8880bffd2000
[   18.093691][    T1] R10: 0000000000000004 R11: 00000000ffffffff
R12: ffff8880155efc00
[   18.093711][    T1] R13: 0000000000000000 R14: ffff8880125b0a10
R15: 0000000000000000
[   18.093736][    T1] FS:  0000000000000000(0000)
GS:ffff8880bfd00000(0000) knlGS:0000000000000000
[   18.093757][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.093777][    T1] CR2: 0000000000000000 CR3: 0000000010229001
CR4: 0000000000770ee0
[   18.093797][    T1] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   18.093816][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   18.093828][    T1] PKRU: 55555554
[   18.093839][    T1] Call Trace:
[   18.093886][    T1]  bochs_pipe_enable+0x16f/0x3f0
[   18.093935][    T1]  drm_simple_kms_crtc_enable+0x12e/0x1a0
[   18.093973][    T1]  ? bochs_connector_get_modes+0x1e0/0x1e0
[   18.094011][    T1]  ? drm_simple_kms_crtc_check+0x210/0x210
[   18.094049][    T1]  drm_atomic_helper_commit_modeset_enables+0x362/0x1000
[   18.094095][    T1]  drm_atomic_helper_commit_tail+0xd3/0x860
[   18.094135][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.094171][    T1]  commit_tail+0x61c/0x7d0
[   18.094205][    T1]  ? kmsan_internal_set_origin+0x85/0xc0
[   18.094246][    T1]  drm_atomic_helper_commit+0xbfe/0xcb0
[   18.094284][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.094322][    T1]  ? drm_atomic_helper_async_commit+0x780/0x780
[   18.094361][    T1]  drm_atomic_commit+0x192/0x210
[   18.094400][    T1]  drm_client_modeset_commit_atomic+0x700/0xbe0
[   18.094444][    T1]  drm_client_modeset_commit_locked+0x147/0x860
[   18.094481][    T1]  ? drm_master_internal_acquire+0x4a/0xd0
[   18.094513][    T1]  drm_client_modeset_commit+0x98/0x110
[   18.094551][    T1]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x1a7/0x2a0
[   18.094586][    T1]  drm_fb_helper_set_par+0x12a/0x220
[   18.094620][    T1]  ? drm_fb_helper_fill_pixel_fmt+0x780/0x780
[   18.094646][    T1]  fbcon_init+0x1959/0x2910
[   18.094685][    T1]  ? validate_slab+0x30/0x730
[   18.094714][    T1]  ? fbcon_startup+0x1590/0x1590
[   18.094746][    T1]  visual_init+0x3bb/0x7b0
[   18.094786][    T1]  do_bind_con_driver+0x136e/0x1c90
[   18.094834][    T1]  do_take_over_console+0xe0a/0xef0
[   18.094875][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
[   18.094907][    T1]  fbcon_fb_registered+0x51c/0xae0
[   18.094954][    T1]  register_framebuffer+0xb68/0xfc0
[   18.094999][    T1]  __drm_fb_helper_initial_config_and_unlock+0x17d2/0x2030
[   18.095047][    T1]  drm_fbdev_client_hotplug+0x7a3/0xe80
[   18.095085][    T1]  drm_fbdev_generic_setup+0x2b9/0x890
[   18.095124][    T1]  bochs_pci_probe+0x7de/0x800
[   18.095161][    T1]  ? qxl_gem_prime_mmap+0x30/0x30
[   18.095193][    T1]  pci_device_probe+0x95f/0xc70
[   18.095227][    T1]  ? pci_uevent+0x7b0/0x7b0
[   18.095259][    T1]  really_probe+0x9af/0x20d0
[   18.095298][    T1]  driver_probe_device+0x234/0x330
[   18.095334][    T1]  device_driver_attach+0x1e8/0x3c0
[   18.095370][    T1]  __driver_attach+0x30d/0x780
[   18.095399][    T1]  ? klist_devices_get+0x10/0x60
[   18.095431][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.095463][    T1]  bus_for_each_dev+0x252/0x360
[   18.095493][    T1]  ? driver_attach+0xa0/0xa0
[   18.095527][    T1]  driver_attach+0x84/0xa0
[   18.095558][    T1]  bus_add_driver+0x5d6/0xb00
[   18.095596][    T1]  driver_register+0x30c/0x830
[   18.095632][    T1]  __pci_register_driver+0x1fa/0x350
[   18.095669][    T1]  bochs_init+0xd6/0x115
[   18.095703][    T1]  do_one_initcall+0x246/0x7a0
[   18.095734][    T1]  ? qxl_init+0x165/0x165
[   18.095779][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.095815][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
[   18.095844][    T1]  ? qxl_init+0x165/0x165
[   18.095878][    T1]  do_initcall_level+0x2b4/0x34a
[   18.095913][    T1]  do_initcalls+0x123/0x1ba
[   18.095947][    T1]  ? cpu_init_udelay+0xcf/0xcf
[   18.095978][    T1]  do_basic_setup+0x2e/0x31
[   18.096011][    T1]  kernel_init_freeable+0x23f/0x35f
[   18.096049][    T1]  ? rest_init+0x1f0/0x1f0
[   18.096080][    T1]  kernel_init+0x1a/0x670
[   18.096111][    T1]  ? rest_init+0x1f0/0x1f0
[   18.096141][    T1]  ret_from_fork+0x1f/0x30
[   18.096166][    T1] Kernel panic - not syncing: panic_on_warn set ...
[   18.096192][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1 #2
[   18.096208][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[   18.096219][    T1] Call Trace:
[   18.096254][    T1]  dump_stack+0x189/0x218
[   18.096287][    T1]  panic+0x38e/0xae4
[   18.096335][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
[   18.096364][    T1]  __warn+0x433/0x5c0
[   18.096402][    T1]  ? drm_gem_vram_offset+0x128/0x140
[   18.096434][    T1]  report_bug+0x669/0x880
[   18.096474][    T1]  ? drm_gem_vram_offset+0x128/0x140
[   18.096506][    T1]  handle_bug+0x6f/0xd0
[   18.096537][    T1]  __exc_invalid_op+0x34/0x80
[   18.096566][    T1]  exc_invalid_op+0x30/0x40
[   18.096603][    T1]  asm_exc_invalid_op+0x12/0x20
[   18.096640][    T1] RIP: 0010:drm_gem_vram_offset+0x128/0x140
[   18.096674][    T1] Code: 48 c7 c3 ed ff ff ff 31 c0 31 c9 eb b4 8b
7d d4 e8 bd 78 1e fc e9 56 ff ff ff 8b 3a e8 b1 78 1e fc 4d 85 ff 0f
85 6e ff ff ff <0f> 0b 31 c0 31 c9 31 db eb 8d 8b 7d d4 e8 96 78 1e fc
e9 67 ff ff
[   18.096693][    T1] RSP: 0000:ffff8880125a6718 EFLAGS: 00010246
[   18.096721][    T1] RAX: 0000000000000000 RBX: ffff8880155efd80
RCX: 00000000151efd80
[   18.096743][    T1] RDX: ffff8880151efd80 RSI: 0000000000000040
RDI: ffff8880155efd80
[   18.096767][    T1] RBP: ffff8880125a6748 R08: ffffea000000000f
R09: ffff8880bffd2000
[   18.096787][    T1] R10: 0000000000000004 R11: 00000000ffffffff
R12: ffff8880155efc00
[   18.096807][    T1] R13: 0000000000000000 R14: ffff8880125b0a10
R15: 0000000000000000
[   18.096849][    T1]  ? drm_gem_vram_offset+0x79/0x140
[   18.096884][    T1]  bochs_pipe_enable+0x16f/0x3f0
[   18.096927][    T1]  drm_simple_kms_crtc_enable+0x12e/0x1a0
[   18.096964][    T1]  ? bochs_connector_get_modes+0x1e0/0x1e0
[   18.097001][    T1]  ? drm_simple_kms_crtc_check+0x210/0x210
[   18.097039][    T1]  drm_atomic_helper_commit_modeset_enables+0x362/0x1000
[   18.097083][    T1]  drm_atomic_helper_commit_tail+0xd3/0x860
[   18.097120][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.097156][    T1]  commit_tail+0x61c/0x7d0
[   18.097190][    T1]  ? kmsan_internal_set_origin+0x85/0xc0
[   18.097230][    T1]  drm_atomic_helper_commit+0xbfe/0xcb0
[   18.097267][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.097305][    T1]  ? drm_atomic_helper_async_commit+0x780/0x780
[   18.097341][    T1]  drm_atomic_commit+0x192/0x210
[   18.097378][    T1]  drm_client_modeset_commit_atomic+0x700/0xbe0
[   18.097422][    T1]  drm_client_modeset_commit_locked+0x147/0x860
[   18.097459][    T1]  ? drm_master_internal_acquire+0x4a/0xd0
[   18.097491][    T1]  drm_client_modeset_commit+0x98/0x110
[   18.097528][    T1]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x1a7/0x2a0
[   18.097562][    T1]  drm_fb_helper_set_par+0x12a/0x220
[   18.097596][    T1]  ? drm_fb_helper_fill_pixel_fmt+0x780/0x780
[   18.097621][    T1]  fbcon_init+0x1959/0x2910
[   18.097660][    T1]  ? validate_slab+0x30/0x730
[   18.097688][    T1]  ? fbcon_startup+0x1590/0x1590
[   18.097719][    T1]  visual_init+0x3bb/0x7b0
[   18.097758][    T1]  do_bind_con_driver+0x136e/0x1c90
[   18.097807][    T1]  do_take_over_console+0xe0a/0xef0
[   18.097848][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
[   18.097879][    T1]  fbcon_fb_registered+0x51c/0xae0
[   18.097917][    T1]  register_framebuffer+0xb68/0xfc0
[   18.097961][    T1]  __drm_fb_helper_initial_config_and_unlock+0x17d2/0x2030
[   18.098009][    T1]  drm_fbdev_client_hotplug+0x7a3/0xe80
[   18.098047][    T1]  drm_fbdev_generic_setup+0x2b9/0x890
[   18.098085][    T1]  bochs_pci_probe+0x7de/0x800
[   18.098123][    T1]  ? qxl_gem_prime_mmap+0x30/0x30
[   18.098152][    T1]  pci_device_probe+0x95f/0xc70
[   18.098187][    T1]  ? pci_uevent+0x7b0/0x7b0
[   18.098217][    T1]  really_probe+0x9af/0x20d0
[   18.098255][    T1]  driver_probe_device+0x234/0x330
[   18.098291][    T1]  device_driver_attach+0x1e8/0x3c0
[   18.098326][    T1]  __driver_attach+0x30d/0x780
[   18.098355][    T1]  ? klist_devices_get+0x10/0x60
[   18.098388][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.098419][    T1]  bus_for_each_dev+0x252/0x360
[   18.098448][    T1]  ? driver_attach+0xa0/0xa0
[   18.098482][    T1]  driver_attach+0x84/0xa0
[   18.098512][    T1]  bus_add_driver+0x5d6/0xb00
[   18.098550][    T1]  driver_register+0x30c/0x830
[   18.098585][    T1]  __pci_register_driver+0x1fa/0x350
[   18.098620][    T1]  bochs_init+0xd6/0x115
[   18.098651][    T1]  do_one_initcall+0x246/0x7a0
[   18.098680][    T1]  ? qxl_init+0x165/0x165
[   18.098727][    T1]  ? kmsan_get_metadata+0x116/0x180
[   18.098763][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
[   18.098791][    T1]  ? qxl_init+0x165/0x165
[   18.098824][    T1]  do_initcall_level+0x2b4/0x34a
[   18.098859][    T1]  do_initcalls+0x123/0x1ba
[   18.098890][    T1]  ? cpu_init_udelay+0xcf/0xcf
[   18.098921][    T1]  do_basic_setup+0x2e/0x31
[   18.098958][    T1]  kernel_init_freeable+0x23f/0x35f
[   18.098993][    T1]  ? rest_init+0x1f0/0x1f0
[   18.099024][    T1]  kernel_init+0x1a/0x670
[   18.099054][    T1]  ? rest_init+0x1f0/0x1f0
[   18.099085][    T1]  ret_from_fork+0x1f/0x30
[   18.099240][    T1] Dumping ftrace buffer:
[   18.099250][    T1]    (ftrace buffer empty)
[   18.099250][    T1] Kernel Offset: disabled
[   18.099250][    T1] Rebooting in 1 seconds..

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
