Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B01268244
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgINBWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 21:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgINBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 21:22:18 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36EBC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:22:16 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id h8so3635559ooc.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=njOIoOL3ESk/QXF80lqlT2hTYa+Pci1pJW5x7OL9bho=;
        b=nNL8dtC/1wLK1+HTUSn+1mfTo09WIWYi/6BcsduFtNGqZmEAVf97wzQZFPkFyLCAKP
         HLeb/OByDSKghHrpY+MZAB8Qi6SxWgRqHIl573muGsiu584538tk7BeM6R7JQ5Mrqcy7
         5QS5fy8z/jDO+p4RRX9PkVcWWwbhvW7gEGlXvHADJLMeAe+TlIBq+soYypIVjuv/ijK/
         VQNi/dcncPFO/Ysp+LRNOkUc/s4QOsOCgK4Z6gjcePreTkyB0XixJ2b2kIQ4nt3sTEjO
         UMkqKMyY0c2sUcW5FzMeQHuwCivcNSctuC8lPjb2h2qVH2LEr1OmJMQqVK4vFH1revh1
         POvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=njOIoOL3ESk/QXF80lqlT2hTYa+Pci1pJW5x7OL9bho=;
        b=KveRIrxKIGKYBhI57yyAR6WmslxDu/oy3fVc4BYDSLTE2VvMP6g8ogv7R8wbd2AfpV
         UhVzWdvXAzBbKffvhv50dSEovBHwe5notrzTfJtN55bXcFCTU7v9OiqOGe2fk24FIBey
         PYWMV1pGFfO4Gy+Z2eUumHJADmWguWKAGGfh0LOntcbFWFnLYzyX0HGsGVX+a7XRlS7X
         zK48BlNcvM5vTMR6BvapNrowInRli0BUZ/zta5s3mbbYTrhKFZEccard9sl1KZR/Fozu
         0tjuc2K7pkBwHziktcZGUAYXwST70BCA5hG+8F1akV9uAvkUkoNbwhI7LzRbPhWIsr0I
         JjxA==
X-Gm-Message-State: AOAM533JWnmUcl4Y3P+kzpbo0fpXrVCK+yApVsZ15WQunwruKioxgQ9G
        31wOPauqN4U+qrldp2YxQBr4m0dcz/2rD2L9Ud4=
X-Google-Smtp-Source: ABdhPJzzSgb8tgYNd30rETkbjxHz4OlUK9R7Fy+G67Gwuy3nhn1u3QjZyE8hZpwUfyda3508n96Y94k/vgzhuizceF8=
X-Received: by 2002:a05:6820:384:: with SMTP id r4mr8631310ooj.62.1600046535572;
 Sun, 13 Sep 2020 18:22:15 -0700 (PDT)
MIME-Version: 1.0
From:   nirinA raseliarison <nirina.raseliarison@gmail.com>
Date:   Mon, 14 Sep 2020 04:22:00 +0300
Message-ID: <CANsGL8N5LgSY5oOkZQiWj9=Dy5AUrt9KcptJ9iggDzQEw7x2Jg@mail.gmail.com>
Subject: kernel BUG at mm/slub.c:3137!
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
i have some issues with the 5.8.9 kernel.

Linux version 5.8.9.20200912 (nirina@supernova.org) (gcc (GCC) 10.2.0,
GNU ld version 2.33.1-slack15) #1 SMP Sat Sep 12 16:07:04 EAT 2020

my system crashed with nothing to resolve it but a hard reset.
/var/log/syslog and /var/log/message recorded dozens of lines of
mojibake, so i've no idea what had caused that crash.

lately, i have a defunct program hanging around and the warnings and
bug below. i am also confused why this is marked as tainted

[33448.031012] ------------[ cut here ]------------
[33448.031023] WLinux version 5.8.9.20200912 (nirina@supernova.org)
(gcc (GCC) 10.2.0, GNU ld version 2.33.1-slack15) #1 SMP Sat Sep 12
16:07:04 EAT 2020
Linux version 5.8.9.20200912 (nirina@supernova.org) (gcc (GCC) 10.2.0,
GNU ld version 2.33.1-slack15) #1 SMP Sat Sep 12 16:07:04 EAT 2020
ARNING: CPU: 0 PID: 14222 at mm/shmem.c:1118 shmem_evict_inode+0x1fe/0x240
[33448.031024] Modules linked in: nct6775 hwmon_vid cpufreq_ondemand
rfkill ipv6 snd_pcm_oss snd_mixer_oss sg hid_generic usbhid hid at24
snd_hda_codec_hdmi regmap_i2c snd_hda_codec_realtek mei_hdcp i2c_dev
snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal
intel_powerclamp i915 kvm_intel kvm i2c_algo_bit r8169 irqbypass
drm_kms_helper snd_hda_intel crc32_pclmul syscopyarea realtek evdev
sysfillrect serio_raw sysimgblt fb_sys_fops snd_intel_dspcfg libphy
drm snd_hda_codec thermal fan snd_hwdep snd_hda_core snd_pcm
drm_panel_orientation_quirks 8250 8250_base intel_gtt snd_timer
serial_core snd agpgart mei_me ehci_pci i2c_i801 lpc_ich soundcore mei
ehci_hcd i2c_smbus video mfd_core button loop
[33448.031052] CPU: 0 PID: 14222 Comm: kworker/0:0 Not tainted 5.8.9.20200912 #1
[33448.031053] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5 01/07/2013
[33448.031058] Workqueue: events delayed_fput
[33448.031060] RIP: 0010:shmem_evict_inode+0x1fe/0x240
[33448.031062] Code: 74 24 18 ba 02 00 00 00 4c 89 e7 e8 ac fd f1 ff
41 8b 45 f8 85 c0 75 e1 48 8d 74 24 18 4c 89 e7 e8 37 fb f1 ff e9 64
ff ff ff <0f> 0b e9 6e fe ff ff 48 8b 47 50 48 c7 c7 40 05 84 82 8b 15
fa 9d
[33448.031063] RSP: 0000:ffffc90001acfd80 EFLAGS: 00010286
[33448.031064] RAX: ffff88808c5d8030 RBX: ffff88808c5d8040 RCX: 000000005f5ead47
[33448.031065] RDX: 0000000001208458 RSI: 0000000000000000 RDI: ffffc90001acfd48
[33448.031065] RBP: ffffc90001acfde8 R08: 0000000000000000 R09: ffffffffffffffff
[33448.031066] R10: 00000000001fd10f R11: 0000000000000000 R12: ffff88808c5d8040
[33448.031067] R13: ffff88808c5d8060 R14: ffff88808c5d8040 R15: ffff8881ee9f9180
[33448.031068] FS:  0000000000000000(0000) GS:ffff888217600000(0000)
knlGS:0000000000000000
[33448.031069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[33448.031069] CR2: 00007f0ff076c014 CR3: 0000000200118002 CR4: 00000000001606f0
[33448.031070] Call Trace:
[33448.031076]  ? var_wake_function+0x20/0x20
[33448.031080]  evict+0xbf/0x180
[33448.031082]  __dentry_kill+0xd4/0x160
[33448.031084]  __fput+0x129/0x240
[33448.031086]  delayed_fput+0x1f/0x30
[33448.031088]  process_one_work+0x1d1/0x3a0
[33448.031090]  worker_thread+0x4d/0x3d0
[33448.031092]  ? rescuer_thread+0x3e0/0x3e0
[33448.031093]  kthread+0x11b/0x140
[33448.031095]  ? kthread_create_worker_on_cpu+0x70/0x70
[33448.031096]  ret_from_fork+0x22/0x30
[33448.031098] ---[ end trace 4522bce7d2eb1606 ]---
[33460.042058] ------------[ cut here ]------------
[33460.042081] WARNING: CPU: 0 PID: 14222 at mm/shmem.c:1118
shmem_evict_inode+0x1fe/0x240
[33460.042083] Modules linked in: nct6775 hwmon_vid cpufreq_ondemand
rfkill ipv6 snd_pcm_oss snd_mixer_oss sg hid_generic usbhid hid at24
snd_hda_codec_hdmi regmap_i2c snd_hda_codec_realtek mei_hdcp i2c_dev
snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal
intel_powerclamp i915 kvm_intel kvm i2c_algo_bit r8169 irqbypass
drm_kms_helper snd_hda_intel crc32_pclmul syscopyarea realtek evdev
sysfillrect serio_raw sysimgblt fb_sys_fops snd_intel_dspcfg libphy
drm snd_hda_codec thermal fan snd_hwdep snd_hda_core snd_pcm
drm_panel_orientation_quirks 8250 8250_base intel_gtt snd_timer
serial_core snd agpgart mei_me ehci_pci i2c_i801 lpc_ich soundcore mei
ehci_hcd i2c_smbus video mfd_core button loop
[33460.042122] CPU: 0 PID: 14222 Comm: kworker/0:0 Tainted: G        W
        5.8.9.20200912 #1
[33460.042123] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5 01/07/2013
[33460.042128] Workqueue: events delayed_fput
[33460.042130] RIP: 0010:shmem_evict_inode+0x1fe/0x240
[33460.042132] Code: 74 24 18 ba 02 00 00 00 4c 89 e7 e8 ac fd f1 ff
41 8b 45 f8 85 c0 75 e1 48 8d 74 24 18 4c 89 e7 e8 37 fb f1 ff e9 64
ff ff ff <0f> 0b e9 6e fe ff ff 48 8b 47 50 48 c7 c7 40 05 84 82 8b 15
fa 9d
[33460.042133] RSP: 0000:ffffc90001acfd80 EFLAGS: 00210286
[33460.042134] RAX: ffff88808c5d8030 RBX: ffff88808c5d8040 RCX: 000000005f5ead53
[33460.042135] RDX: 0000000001c83d87 RSI: 0000000000000000 RDI: ffffc90001acfd48
[33460.042135] RBP: ffffc90001acfde8 R08: 0000000000000000 R09: ffffffffffffffff
[33460.042136] R10: 00000000001fd10f R11: 0000000000000000 R12: ffff88808c5d8040
[33460.042136] R13: ffff88808c5d8060 R14: ffff88808c5d8040 R15: ffff888200f836c0
[33460.042138] FS:  0000000000000000(0000) GS:ffff888217600000(0000)
knlGS:0000000000000000
[33460.042138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[33460.042139] CR2: 00007f0ff0908014 CR3: 000000014b936005 CR4: 00000000001606f0
[33460.042140] Call Trace:
[33460.042146]  ? var_wake_function+0x20/0x20
[33460.042149]  evict+0xbf/0x180
[33460.042151]  __dentry_kill+0xd4/0x160
[33460.042153]  __fput+0x129/0x240
[33460.042155]  delayed_fput+0x1f/0junky x30
[33460.042157]  process_one_work+0x1d1/0x3a0
[33460.042159]  worker_thread+0x4d/0x3d0
[33460.042161]  ? rescuer_thread+0x3e0/0x3e0
[33460.042162]  kthread+0x11b/0x140
[33460.042164]  ? kthread_create_worker_on_cpu+0x70/0x70
[33460.042166]  ret_from_fork+0x22/0x30
[33460.042167] ---[ end trace 4522bce7d2eb1607 ]---
[33489.612957] ------------[ cut here ]------------
[33489.612960] kernel BUG at mm/slub.c:3137!
[33489.612966] invalid opcode: 0000junky  [#1] SMP PTI
[33489.612971] CPU: 0 PID: 14222 Comm: kworker/0:0 Tainted: G        W
        5.8.9.20200912 #1
[33489.612973] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5 01/07/2013
[33489.612979] Workqueue: events kfree_rcu_work
[33489.612985] RIP: 0010:kmem_cache_free_bulk+0x3e9/0x440
[33489.612987] Code: 00 00 01 00 74 04 0f b6 71 51 48 8b 3c 24 48 63
eb e8 5b 07 fe ff 49 c7 06 00 00 00 00 e9 51 fe ff ff 48 8b 41 08 a8
01 75 cc <0f> 0b 45 31 e4 80 3d 1d 42 11 01 00 0f 85 d5 fc ff ff 48 c7
c6 60
[33489.612988] RSP: 0000:ffffc90001acfdf8 EFLAGS: 00010246
[33489.612990] RAX: ffffea0001311248 RBX: 0000000000000001 RCX: ffffea0001311280
[33489.612991] RDX: 0000000000000000 RSI: 000000000000000c RDI: 000000000000000e
[33489.612992] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000002
[33489.612993] R10: ffff8880c645f100 R11: 0000000000000000 R12: ffffea0001311247
[33489.612994] R13: ffff8880c645fa00 R14: ffff88808c59c010 R15: ffff88804c44aa00
[33489.612995] FS:  0000000000000000(0000) GS:ffff888217600000(0000)
knlGS:0000000000000000
[33489.612996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[33489.612998] CR2: 00007f0ff4639014 CR3: 000000014b936006 CR4: 00000000001606f0
[33489.612999] Call Trace:
[33489.613004]  ? kfree_rcu_work+0x69/0xc0
[33489.613006]  kfree_rcu_work+0x69/0xc0
[33489.613009]  process_one_work+0x1d1/0x3a0
[33489.613011]  worker_thread+0x4d/0x3d0
[33489.613013]  ? rescuer_thread+0x3e0/0x3e0
[33489.613015]  kthread+0x11b/0x140
[33489.613017]  ? kthread_create_worker_on_cpu+0x70/0x70
[33489.613019]  ret_from_fork+0x22/0x30
[33489.613021] Modules linked in: nct6775 hwmon_vid cpufreq_ondemand
rfkill ipv6 snd_pcm_oss snd_mixer_oss sg hid_generic usbhid hid at24
snd_hda_codec_hdmi regmap_i2c snd_hda_codec_realtek mei_hdcp i2c_dev
snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal
intel_powerclamp i915 kvm_intel kvm i2c_algo_bit r8169 irqbypass
drm_kms_helper snd_hda_intel crc32_pclmul syscopyarea realtek evdev
sysfillrect serio_raw sysimgblt fb_sys_fops snd_intel_dspcfg libphy
drm snd_hda_codec thermal fan snd_hwdep snd_hda_core snd_pcm
drm_panel_orientation_quirks 8250 8250_base intel_gtt snd_timer
serial_core snd agpgart mei_me ehci_pci i2c_i801 lpc_ich soundcore mei
ehci_hcd i2c_smbus video mfd_core button loop
[33489.613045] ---[ end trace 4522bce7d2eb1608 ]---

thanks,
--
nirinA
