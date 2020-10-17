Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA562914F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439735AbgJQWda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 18:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439624AbgJQWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 18:33:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D5C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 15:33:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j7so3246125wrt.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nZues3DMc1aMY/wWQF+0jyot6qhBYNPn0Q7yZqoFcHo=;
        b=BaOFC0mQ0cRJFlnmX60NN40BRVKpV/DZ7pHs+ILEsHCetSe3dGZsHRTIasYd1IPtDQ
         KMN37IUTBnDxITgiv/jDCLfV4mlQBDN0nxanItBKYI3SNaGa1n0PeQva9l9QYg5yIs7Z
         Ad8j7XfRDqB8i5fzoyJ+rYce3/LgoYB3xD7BKfKOCZ2jXVIDVxnQSIlUDujUbd//Max5
         YzTzWVm83QVolddnSg5EF9lwDu+0mulGBFgMaTbzgCpRUleN2vTPFc8fJFOqx72fB0QY
         IrNw/KWF+ysDviWdcL1jNiJo8ZxRvZYTzpCTigGzevMnHtyp92092uim+yeIsKJFU7Mw
         Cl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nZues3DMc1aMY/wWQF+0jyot6qhBYNPn0Q7yZqoFcHo=;
        b=PxfcLecmjwRyXYapyw6Fd0j4R2TM2wJwNXqWngBXB2APrUCtdAXvtO2Vub1lMOL9w1
         AUMPt15SDniLAvlmtCtZUdAu3U+tvva9I3sfPIYb4Tp7Cetds8m7+zChkpMnjBCH6kIW
         rzeL65bE6PKwmmfFXFlsW2EzZugiSbGSL8HntEnyNPZRwKl49Ws9gVjsvZFS7sYIfZoL
         M7znMH4tliVhpCMZvz/ovoRekMb/Zg5QQP2JSE5hFO8XoKx1ni8ZsJDsZegDYdcmGa12
         88ruDyXrfw12PQh/f4Du7MCUW95gMmA8GRvl9z6MqjYVvcPrGkQa215d93D9naLq1Cdu
         LN0w==
X-Gm-Message-State: AOAM530raHTtjhJHL1wPAd8VXEy+EfUOgpX5umos2qkfkPHFcMzLRhCG
        wMvSzGEeJvirZL81GMNi7FwpnlAKN2OIhGsZisU=
X-Google-Smtp-Source: ABdhPJyqjpmS/3QlnFx0pCyKlO7vU2oN5GBIQ6D8k551PTpflMhLvzN47plxEmclEBMGzgc0gd2GYmclr0UKTqjbnvQ=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr11387315wrq.270.1602974008085;
 Sat, 17 Oct 2020 15:33:28 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 18 Oct 2020 03:33:17 +0500
Message-ID: <CABXGCsOimdNZqQ+uwyYpF_YU3e1=Sr8v=-B+NteEukxc5EabVw@mail.gmail.com>
Subject: [bugreport] [5.10] DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock != ww)
 We 'forgot' to unlock everything else first?
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.
I observed this issue since 5.3 and it still happens with 5.10 git.
This warning has reproductivity 100% reliable when I launch
"Wolfenstein: Youngblood" version of Mesa doesn't matter.

[73690.883948] ------------[ cut here ]------------
[73690.883953] DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock !=3D ww)
[73690.883963] WARNING: CPU: 30 PID: 194867 at
kernel/locking/mutex.c:327 __ww_mutex_lock.constprop.0+0xe96/0xef0
[73690.883966] Modules linked in: tun snd_seq_dummy snd_hrtimer uinput
rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
nf_conntrack_tftp bridge stp llc nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set
nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter cmac
bnep sunrpc vfat fat snd_hda_codec_realtek mt76x2u mt76x2_common
snd_hda_codec_generic mt76x02_usb ledtrig_audio snd_hda_codec_hdmi
mt76_usb mt76x02_lib snd_hda_intel uvcvideo iwlmvm snd_intel_dspcfg
mt76 gspca_zc3xx snd_hda_codec gspca_main joydev videobuf2_vmalloc
snd_usb_audio btusb edac_mce_amd videobuf2_memops snd_hda_core
videobuf2_v4l2 snd_usbmidi_lib kvm_amd btrtl videobuf2_common btbcm
snd_hwdep
[73690.884036]  snd_rawmidi mac80211 btintel snd_seq videodev
snd_seq_device eeepc_wmi libarc4 bluetooth kvm xpad ff_memless snd_pcm
mc iwlwifi asus_wmi irqbypass sparse_keymap ecdh_generic rapl ecc
sp5100_tco video wmi_bmof snd_timer pcspkr snd k10temp i2c_piix4
soundcore cfg80211 rfkill acpi_cpufreq binfmt_misc zram ip_tables
hid_logitech_hidpp hid_logitech_dj amdgpu iommu_v2 gpu_sched ttm
drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel ccp igb nvme dca i2c_algo_bit nvme_core wmi
pinctrl_amd fuse
[73690.884094] CPU: 30 PID: 194867 Comm: Youngblood_x64v Not tainted
5.10.0-0.rc0.20201014gitb5fc7a89e58b.42.fc34.x86_64 #1
[73690.884097] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 2606 08/13/2020
[73690.884100] RIP: 0010:__ww_mutex_lock.constprop.0+0xe96/0xef0
[73690.884103] Code: f2 89 5b 9e 48 c7 c7 1d bb 59 9e e8 ef f6 f8 ff
0f 0b e9 2a fc ff ff 48 c7 c6 d4 89 5b 9e 48 c7 c7 1d bb 59 9e e8 d5
f6 f8 ff <0f> 0b e9 e9 fe ff ff 83 3d 44 3d 81 02 00 75 07 48 83 7d 28
00 75
[73690.884106] RSP: 0018:ffffa1c5d079f8f0 EFLAGS: 00010286
[73690.884108] RAX: 0000000000000032 RBX: 0000000000000001 RCX: ffff8c650a7=
db178
[73690.884111] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8c650a7=
db170
[73690.884112] RBP: ffffa1c5d079fc38 R08: 0000000000000000 R09: 00000000000=
00000
[73690.884114] R10: ffffa1c5d079f720 R11: ffff8c652e2fffe8 R12: ffff8c600cd=
42990
[73690.884116] R13: ffff8c5f055f0000 R14: ffff8c600cd42a00 R15: 00000000000=
00000
[73690.884119] FS:  00000000060e3640(0000) GS:ffff8c650a600000(0000)
knlGS:000000013ffc0000
[73690.884121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[73690.884122] CR2: 00007fe25431d010 CR3: 000000011916e000 CR4: 00000000003=
50ee0
[73690.884124] Call Trace:
[73690.884136]  ? ttm_mem_evict_first+0x212/0x4f0 [ttm]
[73690.884139]  ? __schedule+0x345/0xa80
[73690.884144]  ww_mutex_lock_interruptible+0x43/0xb0
[73690.884149]  ttm_mem_evict_first+0x212/0x4f0 [ttm]
[73690.884157]  ttm_bo_mem_space+0x30f/0x340 [ttm]
[73690.884164]  ttm_bo_validate+0x12b/0x1d0 [ttm]
[73690.884169]  ? sched_clock+0x5/0x10
[73690.884261]  amdgpu_cs_bo_validate+0x8b/0x190 [amdgpu]
[73690.884350]  amdgpu_cs_list_validate+0x10e/0x150 [amdgpu]
[73690.884435]  amdgpu_cs_ioctl+0x7f4/0x1ed0 [amdgpu]
[73690.884531]  ? amdgpu_cs_find_mapping+0xf0/0xf0 [amdgpu]
[73690.884550]  drm_ioctl_kernel+0x8c/0xe0 [drm]
[73690.884563]  drm_ioctl+0x20f/0x3a0 [drm]
[73690.884623]  ? amdgpu_cs_find_mapping+0xf0/0xf0 [amdgpu]
[73690.884625]  ? sched_clock+0x5/0x10
[73690.884628]  ? sched_clock_cpu+0xc/0xb0
[73690.884631]  ? lockdep_hardirqs_on_prepare+0xff/0x180
[73690.884632]  ? _raw_spin_unlock_irqrestore+0x41/0x50
[73690.884684]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[73690.884688]  __x64_sys_ioctl+0x83/0xb0
[73690.884691]  do_syscall_64+0x33/0x40
[73690.884693]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[73690.884695] RIP: 0033:0x7fe3209e64cb
[73690.884697] Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c
ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7d b9 0c 00 f7 d8 64 89
01 48
[73690.884699] RSP: 002b:00000000060db248 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[73690.884701] RAX: ffffffffffffffda RBX: 00000000060db2d0 RCX: 00007fe3209=
e64cb
[73690.884702] RDX: 00000000060db2d0 RSI: 00000000c0186444 RDI: 00000000000=
000d4
[73690.884703] RBP: 00000000c0186444 R08: 00007fe1bd653780 R09: 00000000060=
db290
[73690.884705] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe17d8=
2a120
[73690.884706] R13: 00000000000000d4 R14: 00007fe3083ff6f0 R15: 00007fe1bd6=
53720
[73690.884710] irq event stamp: 2315027
[73690.884712] hardirqs last  enabled at (2315027):
[<ffffffff9dd01ac4>] _raw_spin_unlock_irq+0x24/0x40
[73690.884714] hardirqs last disabled at (2315026):
[<ffffffff9dcfb815>] __schedule+0x685/0xa80
[73690.884715] softirqs last  enabled at (2309462):
[<ffffffff9de010d2>] asm_call_irq_on_stack+0x12/0x20
[73690.884717] softirqs last disabled at (2309387):
[<ffffffff9de010d2>] asm_call_irq_on_stack+0x12/0x20
[73690.884718] ---[ end trace 29c797a32d5422cf ]---

$ git blame -L 322,332 kernel/locking/mutex.c
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 322)   if
(ww_ctx->contending_lock) {
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 323)           /*
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 324)
  * After -EDEADLK you tried to
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 325)
  * acquire a different ww_mutex? Bad!
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 326)            */
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 327)
 DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock !=3D ww);
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 328)
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 329)           /*
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 330)
  * You called ww_mutex_lock after receiving -EDEADLK,
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 331)
  * but 'forgot' to unlock everything else first?
76916515d9d84 (Davidlohr Bueso 2014-07-30 13:41:53 -0700 332)            */

So I think it really not good if we 'forgot' to unlock everything else firs=
t.

So looking next...

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname
-r`/kernel/drivers/gpu/drm/ttm/ttm.ko.debug ttm_mem_evict_first+0x212
ttm_mem_evict_first+0x212/0x4f0:
dma_resv_lock_interruptible at
/usr/src/debug/kernel-20201014gitb5fc7a89e58b/linux-5.10.0-0.rc0.20201014gi=
tb5fc7a89e58b.42.fc34.x86_64/./include/linux/dma-resv.h:134
(inlined by) ttm_mem_evict_wait_busy at
/usr/src/debug/kernel-20201014gitb5fc7a89e58b/linux-5.10.0-0.rc0.20201014gi=
tb5fc7a89e58b.42.fc34.x86_64/drivers/gpu/drm/ttm/ttm_bo.c:756
(inlined by) ttm_mem_evict_first at
/usr/src/debug/kernel-20201014gitb5fc7a89e58b/linux-5.10.0-0.rc0.20201014gi=
tb5fc7a89e58b.42.fc34.x86_64/drivers/gpu/drm/ttm/ttm_bo.c:822

$ git blame -L 125,140 include/linux/dma-resv.h
Blaming lines:   5% (16/293), done.
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 125)  *
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 126)  * As the reservation object may be locked by
multiple parties in an
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 127)  * undefined order, a #ww_acquire_ctx is passed to
unwind if a cycle
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 128)  * is detected. See ww_mutex_lock() and
ww_acquire_init(). A reservation
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 129)  * object may be locked by itself by passing NULL
as @ctx.
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 130)  */
52791eeec1d9f include/linux/dma-resv.h    (Christian K=C3=B6nig 2019-08-11
10:06:32 +0200 131) static inline int
dma_resv_lock_interruptible(struct dma_resv *obj,
52791eeec1d9f include/linux/dma-resv.h    (Christian K=C3=B6nig 2019-08-11
10:06:32 +0200 132)                                             struct
ww_acquire_ctx *ctx)
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 133) {
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 134)       return
ww_mutex_lock_interruptible(&obj->lock, ctx);
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 135) }
5d276a1acaa80 include/linux/reservation.h (Christian K=C3=B6nig 2017-11-09
09:59:05 +0100 136)
0dbd555a011c2 include/linux/reservation.h (Christian K=C3=B6nig 2019-07-31
09:41:50 +0200 137) /**
52791eeec1d9f include/linux/dma-resv.h    (Christian K=C3=B6nig 2019-08-11
10:06:32 +0200 138)  * dma_resv_lock_slow - slowpath lock the
reservation object
0dbd555a011c2 include/linux/reservation.h (Christian K=C3=B6nig 2019-07-31
09:41:50 +0200 139)  * @obj: the reservation object
0dbd555a011c2 include/linux/reservation.h (Christian K=C3=B6nig 2019-07-31
09:41:50 +0200 140)  * @ctx: the locking context


$ git blame -L 750,760 drivers/gpu/drm/ttm/ttm_bo.c
Blaming lines:   0% (11/1869), done.
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 750)   int r;
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 751)
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 752)   if
(!busy_bo || !ticket)
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 753)
 return -EBUSY;
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 754)
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 755)   if
(ctx->interruptible)
52791eeec1d9f (Christian K=C3=B6nig 2019-08-11 10:06:32 +0200 756)
 r =3D dma_resv_lock_interruptible(busy_bo->base.resv,
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 757)
                                           ticket);
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 758)   else
52791eeec1d9f (Christian K=C3=B6nig 2019-08-11 10:06:32 +0200 759)
 r =3D dma_resv_lock(busy_bo->base.resv, ticket);
d367bd2a5e2b1 (Christian K=C3=B6nig 2019-05-22 09:51:47 +0200 760)

Christian, you are the author of their lines of code.
Alex, Michel you were made a review and tested this code.
I invited you here, because you, like no one in this world, know what
is happening here, can you clarify the situation.

Full dmesg here: https://pastebin.com/ZK9F4SbR

--
Best Regards,
Mike Gavrilov.
