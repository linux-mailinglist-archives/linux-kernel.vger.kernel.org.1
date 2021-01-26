Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912E0303A86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404121AbhAZKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbhAZCDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:03:32 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5EC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:22:42 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f2so12362599ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzP+mQr0Cb/8D8KEPDEqrJxNdNlq28R+Q5Q0SVRRzQk=;
        b=nArHdRc0ztw+g37RqkKvQRyU1WUXhJabqeq8z/jOkHeN+U9J5iZdwpuTzUsw8aI2oZ
         5w7opESA/cwvBZGpvLUThRy8Licw5lBB5rWYHAoRs9UCS2SvHCrY9O+To5Hu6G0MmY1T
         DAVDqyy2rV7G7KXeQVumOWfZQLiMWcjw9BZu0zAffuSOPLZI/Gt9k89524/XtioVszCR
         LlSAIij3paVS9pI0EQ44ut6x+aCCwLjHjTH88MPxG29/BkISVp0GW6j2aHoKRn4bI9Uh
         elLQaS2Jb6YfTGdarilgv527tSPPpX0aINOBrd5gzGrWV0W2uVzaYYcZVjUipeNJC/WD
         MfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzP+mQr0Cb/8D8KEPDEqrJxNdNlq28R+Q5Q0SVRRzQk=;
        b=rXvwCCHyRkwdLtTc00UrDikdtfUqwbjDFdM+jH1/DM18xJxwY+tDsclFrTUlQZmU2v
         LLu24D93LFJ92hD3g6eohTs2t4jykwV3WT5wCc2+j8EM/0QywlnM9AtW6UIZABtmLmmT
         DuDRpoeaEIjBBx6+IzmY6e5TDgc4Fw8mVZPhFscMGodDqYP8WnhZAuMyD9KPOkecRR8l
         6anmsjKHaJ+Yvobug26pttBDECKghmm4FBCuEJcVE3Qjg3xFG1beJQqu5hQu/lC2Pt2R
         CfX+4xfGMHi/HZc4YUZgn3fnlSIEoCgE0EXdlxm+gHwKZu57qyNPN4qv/tzzDzx3EkZa
         b0TA==
X-Gm-Message-State: AOAM530MwNbTlYI0/LjQYjLbIG9+k8k7K1zWIyzn9PWEqLi1wDHeHiaj
        za3PDlPB/QhUdBHo9JwoG2fxBRCJWfSUF38hzu6kisNDapfClQ==
X-Google-Smtp-Source: ABdhPJxp+Kxl2ljNST0OVZOxZ4MKFvOww3YK6lmH1s9MIhI4ZeVv4w+LKMj2K658dKogD+dj15y8P4T/UXa6TxHZBzw=
X-Received: by 2002:a05:651c:39c:: with SMTP id e28mr1441416ljp.81.1611620560792;
 Mon, 25 Jan 2021 16:22:40 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsMvRzY_JHH4cPtxQ3nsYrsEJFgD0Wh5Aimx+iGB8GnY3g@mail.gmail.com>
 <20210124111047.13404-1-hdanton@sina.com> <CABXGCsMY5eEefYLvnqtws8MRAqHOaDW9JwfsCPnLZydLDQqyuA@mail.gmail.com>
In-Reply-To: <CABXGCsMY5eEefYLvnqtws8MRAqHOaDW9JwfsCPnLZydLDQqyuA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 26 Jan 2021 05:22:29 +0500
Message-ID: <CABXGCsONEisAip4GHqJ=HR905CYd+=vd+NRWJgxTyg3rNqNoyQ@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jan 2021 at 23:23, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Thanks for looking at the issue.
> Why the proposed patch not intended for testing?
> It is not the final (optimal) variant?
>
>
> --
> Best Regards,
> Mike Gavrilov.

With disabled kasan I got slightly different trace (which flooded the
kernel logs):

z3fold: No free chunks in unbuddied
------------[ cut here ]------------
WARNING: CPU: 16 PID: 270 at mm/z3fold.c:1120 z3fold_zpool_malloc+0xe4/0x780
Modules linked in: tun snd_seq_dummy snd_hrtimer uinput rfcomm
nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
iptable_filter cmac bnep zstd sunrpc vfat fat uas usb_storage
hid_logitech_hidpp hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb
mt76_usb mt76x02_lib mt76 gspca_zc3xx gspca_main snd_hda_codec_realtek
snd_hda_codec_generic intel_rapl_msr snd_hda_codec_hdmi ledtrig_audio
intel_rapl_common snd_hda_intel snd_intel_dspcfg iwlmvm
soundwire_intel soundwire_generic_allocation snd_soc_core mac80211
snd_compress snd_pcm_dmaengine soundwire_cadence snd_hda_codec joydev
edac_mce_amd uvcvideo snd_hda_core kvm_amd btusb
 videobuf2_vmalloc btrtl videobuf2_memops ac97_bus videobuf2_v4l2
btbcm snd_usb_audio libarc4 btintel videobuf2_common snd_usbmidi_lib
kvm bluetooth snd_hwdep iwlwifi videodev snd_seq snd_rawmidi eeepc_wmi
asus_wmi snd_seq_device irqbypass mc sparse_keymap xpad ecdh_generic
snd_pcm rapl ff_memless wmi_bmof video ecc cfg80211 pcspkr snd_timer
k10temp snd sp5100_tco i2c_piix4 soundcore rfkill acpi_cpufreq
binfmt_misc ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec igb nvme
drm ghash_clmulni_intel ccp xhci_pci dca nvme_core xhci_pci_renesas
i2c_algo_bit wmi pinctrl_amd fuse
CPU: 16 PID: 270 Comm: kswapd0 Tainted: G        W        ---------
---  5.11.0-0.rc4.20210120git45dfb8a5659a.133.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 3402 01/13/2021
RIP: 0010:z3fold_zpool_malloc+0xe4/0x780
Code: 0f c1 43 58 83 f8 01 0f 84 7c 06 00 00 85 c0 0f 8e 93 06 00 00
48 8d 7b 10 e8 a8 8c 9a 00 48 c7 c7 c8 b5 5f b2 e8 46 ce 93 00 <0f> 0b
eb 81 c7 04 24 00 00 00 00 8b 7c 24 18 85 ff 0f 84 a6 00 00
RSP: 0018:ffffb39dc086b910 EFLAGS: 00010282
RAX: 0000000000000023 RBX: ffff9c12bfc3f000 RCX: 0000000000000000
RDX: ffff9c1888be9f60 RSI: ffff9c1888bdb2a0 RDI: ffff9c1888bdb2a0
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb39dc086b750
R10: ffffb39dc086b748 R11: 0000000000000000 R12: ffff9c11b25cd400
R13: 0000000000012800 R14: 00000000000001a0 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff9c1888a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00001a925bb89fe8 CR3: 00000003862c4000 CR4: 0000000000350ee0
Call Trace:
 ? _raw_spin_unlock+0x1f/0x30
 zswap_frontswap_store+0x43e/0x890
 __frontswap_store+0xc8/0x170
 swap_writepage+0x39/0x70
 pageout+0x125/0x540
 shrink_page_list+0x1329/0x1bc0
 shrink_inactive_list+0x12a/0x440
 shrink_lruvec+0x4a9/0x6d0
 ? super_cache_count+0x79/0xf0
 shrink_node+0x2d1/0x700
 balance_pgdat+0x2f5/0x650
 kswapd+0x21d/0x4d0
 ? do_wait_intr_irq+0xd0/0xd0
 ? balance_pgdat+0x650/0x650
 kthread+0x13a/0x150
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
irq event stamp: 46
hardirqs last  enabled at (45): [<ffffffffb1d3fea1>]
_raw_spin_unlock_irqrestore+0x41/0x50
hardirqs last disabled at (46): [<ffffffffb1d39aaf>] __schedule+0x6ef/0xb20
softirqs last  enabled at (0): [<ffffffffb10ddbbb>] copy_process+0x8fb/0x1de0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace d045ca861a4f792f ]---
z3fold: No free chunks in unbuddied

Full kernel log is here: https://pastebin.com/BTJ0Fz6d

-- 
Best Regards,
Mike Gavrilov.
