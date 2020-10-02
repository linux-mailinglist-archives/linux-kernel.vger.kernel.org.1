Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95078281B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgJBSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:46:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58909 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:46:36 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1kOQ4f-0006GP-U1
        for linux-kernel@vger.kernel.org; Fri, 02 Oct 2020 18:46:33 +0000
Received: by mail-wr1-f69.google.com with SMTP id j7so869543wro.14
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Jf3n0rPRFEpE5/OYrnQZaCFvLpESoMlzuwuIBP6WRrE=;
        b=LxG6LjTQU2NMH45p4oNahBQLU2E5UyseG1dK5ThtoSUNdYlRVXM5j3pYSpBvesCeeN
         DMlK4kxupezrxa6SP5wVGMTxdmjlHOaPERMgPWaHog5YoOB/YWuY96j9ZGX/LvCNl2Ax
         DMyhajrFhYVr67WE9GAS3YCK9eNgaN4Gon+Dy1JSq9zRI5fMFDNNgeaC1MfxGjd5hLvv
         8lG9GKXDx5WBmRnEIR+CephNHRKZjARP0G4q6XFP+FWOReF6dz6z2vR3yxy5TpAlempJ
         V0qzKkd7QqKQW/iXiQJIDqF58NRd0XMP7NmuA3idGcu6DP6n3ezlRdQqzwDh2Fm82zI3
         Wy3A==
X-Gm-Message-State: AOAM532ZoERks1aRlENUu0x9DwffiDtG3Ua10ZAqD3Y2TiORNmQm9He9
        5VpMXm3P0S8gm17F9Mv+jSDG9yQO5HbwC66h1GKYuqv+vP8664w9RvwD5WgHOW1aT6IautzhpD6
        sVi/R803D6Q8X4bNCxfLOqoXRXY3Ny3VhWJJ3RSJraBW8+Ub+SEdbo9AQfQ==
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr4284962wrm.147.1601664393337;
        Fri, 02 Oct 2020 11:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4OwAgfjdglWIPEZpDVm8zed3uvcZDxqpRrJIeWF6USRobt9OTJN7EULVK4GFWvR7O0gUgknWyoeDkVl1Mzos=
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr4284938wrm.147.1601664392995;
 Fri, 02 Oct 2020 11:46:32 -0700 (PDT)
MIME-Version: 1.0
From:   dann frazier <dann.frazier@canonical.com>
Date:   Fri, 2 Oct 2020 12:46:22 -0600
Message-ID: <CALdTtntb20W92Z=HS1K8Upj7+9Yu4f2MP=F0GcFXhX-3_N4bdg@mail.gmail.com>
Subject: 5.9-rc7 oops in nvkm_udevice_info() w/ GA100
To:     nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hey,
  I'm seeing an Oops when nouveau loads (see below). I've verified
that this is because both device->chip and device->name are NULL prior
to the strncpy()s at the end of nvkm_udevice_info(). Bisect shows that
this started happening after:

commit 24d5ff40a732633dceab68c6559ba723784f4a68
Author: Karol Herbst <kherbst@redhat.com>
Date: Tue Apr 28 18:54:02 2020 +0200

    drm/nouveau/device: rework mmio mapping code to get rid of second map

    Fixes warnings on GPUs with smaller a smaller mmio region like vGPUs.

    Signed-off-by: Karol Herbst <kherbst@redhat.com>
    Signed-off-by: Ben Skeggs <bskeggs@redhat.com>

[ 213.131657] nouveau 0000:07:00.0: unknown chipset (170000a1)
[ 213.138547] nouveau 0000:07:00.0: unknown chipset (170000a1)
[ 213.144938] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 213.152704] #PF: supervisor read access in kernel mode
[ 213.158433] #PF: error_code(0x0000) - not-present page
[ 213.164162] PGD 0 P4D 0
[ 213.166985] Oops: 0000 [#1] SMP NOPTI
[ 213.171068] CPU: 32 PID: 206 Comm: kworker/32:0 Not tainted 5.9.0-rc7+ #1
[ 213.178639] Hardware name: NVIDIA DGXA100
920-23687-2530-000/DGXA100, BIOS 0.25 06/30/2020
[ 213.187866] Workqueue: events work_for_cpu_fn
[ 213.192761] RIP: 0010:nvkm_udevice_mthd+0x1ed/0x7d0 [nouveau]
[ 213.199170] Code: 10 49 89 47 08 4d 85 c9 74 10 48 85 c0 74 0b 41 8b
51 70 48 29 d0 49 89 47 10 49 8b 86 c0 00 00 00 49 8d 7f 18 ba 10 00
00 00 <48> 8b 30 e8 6b 91 89 c0 49 8b 76 28 49 8d 7f 28 ba 40 00 00 00
e8
[ 213.220121] RSP: 0018:ffffae0619d47b48 EFLAGS: 00010246
[ 213.225948] RAX: 0000000000000000 RBX: ffff9cefab819580 RCX: 00000000000000c6
[ 213.233907] RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffff9cef988f0578
[ 213.241864] RBP: ffffae0619d47b80 R08: 0000000000000000 R09: 0000000000000000
[ 213.249813] R10: 0000000000000088 R11: 0000000001320122 R12: 0000000000000000
[ 213.257762] R13: 0000000000000068 R14: ffff9cef6107c400 R15: ffff9cef988f0560
[ 213.265721] FS: 0000000000000000(0000) GS:ffff9cefce000000(0000)
knlGS:0000000000000000
[ 213.274747] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 213.281153] CR2: 0000000000000000 CR3: 0000007f3019c000 CR4: 0000000000350ee0
[ 213.289104] Call Trace:
[ 213.291854] ? nvkm_object_insert+0x6f/0x80 [nouveau]
[ 213.297509] nvkm_object_mthd+0x1a/0x30 [nouveau]
[ 213.302773] nvkm_ioctl_mthd+0x65/0x70 [nouveau]
[ 213.307940] nvkm_ioctl+0xf0/0x190 [nouveau]
[ 213.312735] nvkm_client_ioctl+0x12/0x20 [nouveau]
[ 213.318097] nvif_object_ioctl+0x4f/0x60 [nouveau]
[ 213.323460] nvif_object_mthd+0x9f/0x150 [nouveau]
[ 213.328822] ? nvif_object_ctor+0x14b/0x1d0 [nouveau]
[ 213.334473] nvif_device_ctor+0x61/0x70 [nouveau]
[ 213.339749] nouveau_cli_init+0x1a3/0x460 [nouveau]
[ 213.345215] ? nouveau_drm_device_init+0x3e/0x780 [nouveau]
[ 213.351454] nouveau_drm_device_init+0x77/0x780 [nouveau]
[ 213.357479] ? pci_read_config_word+0x27/0x40
[ 213.362337] ? pci_enable_device_flags+0x14f/0x170
[ 213.367705] nouveau_drm_probe+0x132/0x1f0 [nouveau]
[ 213.373241] local_pci_probe+0x48/0x80
[ 213.377419] work_for_cpu_fn+0x1a/0x30
[ 213.381598] process_one_work+0x1e8/0x3b0
[ 213.386068] worker_thread+0x53/0x420
[ 213.390149] kthread+0x12f/0x150
[ 213.393745] ? process_one_work+0x3b0/0x3b0
[ 213.398406] ? __kthread_bind_mask+0x70/0x70
[ 213.403169] ret_from_fork+0x22/0x30
[ 213.407153] Modules linked in: nouveau(+) mxm_wmi wmi video
nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
amd64_edac_mod edac_mce_amd amd_energy kvm_amd kvm rapl efi_pstore
ipmi_ssif input_leds cdc_ether usbnet mii ccp k10temp acpi_ipmi
ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel ip_tables
x_tables autofs4 btrfs blake2b_generic raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib ses enclosure
hid_generic usbhid uas hid usb_storage ib_uverbs ib_core
crct10dif_pclmul crc32_pclmul ast ghash_clmulni_intel drm_vram_helper
aesni_intel drm_ttm_helper crypto_simd ttm cryptd drm_kms_helper
glue_helper syscopyarea sysfillrect sysimgblt mlx5_core fb_sys_fops
pci_hyperv_intf igb cec mpt3sas dca rc_core raid_class nvme tls
i2c_algo_bit scsi_transport_sas drm mlxfw xhci_pci nvme_core
xhci_pci_renesas i2c_piix4
[ 213.497060] CR2: 0000000000000000
[ 213.500755] ---[ end trace eed3a19f1f25ca74 ]---
