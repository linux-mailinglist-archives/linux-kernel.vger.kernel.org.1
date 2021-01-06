Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC52EC1D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbhAFRLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbhAFRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:11:07 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F90C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 09:10:27 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q205so4117800oig.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 09:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rNDJjoQ5nkDBKaiffz2s/LKcKD149M0+6rxWrD4j2Mw=;
        b=hUlF3+afN13bfhyNKrrg3OJWH0n6Dr4csiL2WSPPJzWYFET5SCy9KlMQ83CV+DdSb5
         oYCeoRTl8XFs0rtapyEklo9aBabec8+JhC8YmwMkGaLV/y+cdnbsOhKMpHA3pIkFhV4Z
         VdBJu6FMzpNDa3/RBWtfM5GAFNKrrjpv9eIyhROqmmBAiXp3OsppvElj+/PH5wTRyTk/
         GgCLFm/Ya833g70RZrDN05vqb+VAzHCPHJ2EQadQh25ZBS2m86ZPGtWWjnvqJ9/2qkeh
         oUDwa9ORx1h8h+fOmCj455MyPemrBm2PYhqGgYeKEB1PziO6F8jMljYS4Edv5CTlb4Xo
         AKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNDJjoQ5nkDBKaiffz2s/LKcKD149M0+6rxWrD4j2Mw=;
        b=osxqzyjDah1zpUyj62U6MinypYL/6CbQyKCRN7buORDezlIgPF1HOZdT620me1sWt3
         w4AC6s2MduzsL7OulIkGLykNwhakBQ7jr882IueEqfugiAsgbVfztSmhZeGfYnpGNQUj
         ZT4Jg2SnHfhE7b/koqimDL/wv1/lCul+0VbLhRimfObl3t+SGaZJUDnknUTnBWdaKf7S
         9P/ZBQJbMlZVE1d0X1jKorf6dKvbKxHKOUplLyx48yST0Bn59pQwPxKTtMvqdLw4ngki
         +ykY8nioAXd6gyw5ye+9LOkIMgPAWDphxxagxy/lffyo0QPhCox5X3fqpKhtUM3M7Owy
         gcPg==
X-Gm-Message-State: AOAM532pvZFj//+G+hnFpe12Wd3SfU2tit7NfQoqSqlQWDShnIqZn4lv
        aahqcc9uJXfd8p2+M2Hc/W0teZMp9B10WqaSmOaKJ8hCbtY=
X-Google-Smtp-Source: ABdhPJyvchjp8iynPYOPmlZosMnCcp4Ir6oKhfbaicALgvMQ7N5TWosb5kTbwUe8BhjsBSa+yK3HL3UNUVmyWmQYi3g=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3805337oii.120.1609953026729;
 Wed, 06 Jan 2021 09:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20201231104020.GA4504@zn.tnic> <e3bfa0a4-5d0a-bd68-6cc8-73db1d29f22c@amd.com>
 <20210104105802.GD32151@zn.tnic> <20210105041213.GA544780@hr-amd>
 <20210105103138.GB28649@zn.tnic> <20210105110852.GA1052081@hr-amd>
 <20210105114351.GD28649@zn.tnic> <20210105122026.GA227519@hr-amd>
 <fa11e930-d8ee-a291-7d6a-6fdd6653ffa8@amd.com> <1b4a03ee5b5c0fc08063c5924ebbaef7a2fb7dce.camel@infradead.org>
In-Reply-To: <1b4a03ee5b5c0fc08063c5924ebbaef7a2fb7dce.camel@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Jan 2021 12:10:15 -0500
Message-ID: <CADnq5_OLzTU5bv+t2wgWyfq89TTHTJCak=QngHwTDQuRXJJ-Nw@mail.gmail.com>
Subject: Re: 5.11-rc1 TTM list corruption
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@alien8.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 11:54 AM David Woodhouse <dwmw2@infradead.org> wrote=
:
>
> On Tue, 2021-01-05 at 16:40 +0100, Christian K=C3=B6nig wrote:
> > Am 05.01.21 um 13:20 schrieb Huang Rui:
> > > On Tue, Jan 05, 2021 at 07:43:51PM +0800, Borislav Petkov wrote:
> > > > On Tue, Jan 05, 2021 at 07:08:52PM +0800, Huang Rui wrote:
> > > > > Ah, this asic is a bit old and still use radeon driver. So we did=
n't
> > > > > reproduce it on amdgpu driver. I don't have such the old asic in =
my hand.
> > > > > May we know whether this issue can be duplicated after SI which i=
s used
> > > > > amdgpu module (not sure whether you have recent APU or GPU)?
> > > >
> > > > The latest I have (I think it is the latest) is:
> > > >
> > > > [    1.826102] [drm] initializing kernel modesetting (RENOIR 0x1002=
:0x1636 0x17AA:0x5099 0xD1).
> > > >
> > > > and so far that hasn't triggered it. Which makes sense because that
> > > > thing uses amdgpu:
> > > >
> > > > [    1.810260] [drm] amdgpu kernel modesetting enabled.
> > >
> > > Yes! Renoir is late enough for amdgpu kernel module. :-)
> > > Please let us know if you still encounter the issue.
> >
> > Thanks for the hints guys. You need a rather specific configuration, bu=
t
> > I can reproduce this now.
> >
> > Let's see what the problem is here.
>
> FWIW I'm seeing it here on my workstation too.

Should be fixed with this patch set I think:
https://patchwork.freedesktop.org/series/85515/

Alex

>
> [    3.952102] [drm] radeon kernel modesetting enabled.
> [    3.952885] checking generic (90000000 300000) vs hw (90000000 1000000=
0)
> [    3.952898] fb0: switching to radeondrmfb from EFI VGA
> [    3.953665] Console: switching to colour dummy device 80x25
> [    3.953696] radeon 0000:03:00.0: vgaarb: deactivate vga console
> [    3.953898] [drm] initializing kernel modesetting (CYPRESS 0x1002:0x68=
98 0x1462:0x8032 0x00).
> [    3.953940] resource sanity check: requesting [mem 0x000c0000-0x000dff=
ff], which spans more than PCI Bus 0000:00 [mem 0x000c4000-0x000cbfff windo=
w]
> [    3.953945] caller pci_map_rom+0x6c/0x1b0 mapping multiple BARs
> [    3.953972] ATOM BIOS: 113
> [    3.954028] radeon 0000:03:00.0: VRAM: 1024M 0x0000000000000000 - 0x00=
0000003FFFFFFF (1024M used)
> [    3.954032] radeon 0000:03:00.0: GTT: 1024M 0x0000000040000000 - 0x000=
000007FFFFFFF
> [    3.954037] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
> [    3.954039] [drm] RAM width 256bits DDR
> [    3.954087] [TTM] Zone  kernel: Available graphics memory: 16389788 Ki=
B
> [    3.954090] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    3.954105] [drm] radeon: 1024M of VRAM memory ready
> [    3.954107] [drm] radeon: 1024M of GTT memory ready.
> [    3.954114] [drm] Loading CYPRESS Microcode
> [    3.954168] [drm] Internal thermal controller with fan control
> [    3.954531] usb 3-1.1.1: New USB device found, idVendor=3D10d5, idProd=
uct=3D1234, bcdDevice=3D 9.02
> [    3.954539] usb 3-1.1.1: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
> [    3.958098] hub 3-1.1.1:1.0: USB hub found
> [    3.959704] hub 3-1.1.1:1.0: 4 ports detected
> [    3.975098] [drm] radeon: dpm initialized
> [    3.975159] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    3.976074] [drm] enabling PCIE gen 2 link speeds, disable with radeon=
.pcie_gen2=3D0
> [    3.979669] igb 0000:01:00.0 eno0: renamed from eth0
> [    3.993789] [drm] PCIE GART of 1024M enabled (table at 0x000000000014C=
000).
> [    3.993912] radeon 0000:03:00.0: WB enabled
> [    3.993915] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0=
x0000000040000c00
> [    3.993918] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0=
x0000000040000c0c
> [    3.994359] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0=
x000000000005c418
> [    3.994531] radeon 0000:03:00.0: radeon: MSI limited to 32-bit
> [    3.994563] radeon 0000:03:00.0: radeon: using MSI.
> [    3.994581] [drm] radeon: irq initialized.
> [    4.011086] [drm] ring test on 0 succeeded in 1 usecs
> [    4.011094] [drm] ring test on 3 succeeded in 2 usecs
> [    4.030666] EXT4-fs (md127): mounted filesystem with ordered data mode=
. Opts: (null)
> [    4.188159] [drm] ring test on 5 succeeded in 1 usecs
> [    4.188165] [drm] UVD initialized successfully.
> [    4.188326] [drm] ib test on ring 0 succeeded in 0 usecs
> [    4.188371] [drm] ib test on ring 3 succeeded in 0 usecs
> ...
> [    4.839982] [drm] ib test on ring 5 succeeded
> [    4.841079] [drm] Radeon Display Connectors
> [    4.841087] [drm] Connector 0:
> [    4.841090] [drm]   DP-1
> [    4.841094] [drm]   HPD4
> [    4.841097] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x6=
43c 0x643c
> [    4.841104] [drm]   Encoders:
> [    4.841107] [drm]     DFP1: INTERNAL_UNIPHY2
> [    4.841111] [drm] Connector 1:
> [    4.841114] [drm]   HDMI-A-1
> [    4.841118] [drm]   HPD5
> [    4.841120] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x6=
46c 0x646c
> [    4.841127] [drm]   Encoders:
> [    4.841130] [drm]     DFP2: INTERNAL_UNIPHY2
> [    4.841133] [drm] Connector 2:
> [    4.841136] [drm]   DVI-I-1
> [    4.841139] [drm]   HPD1
> [    4.841142] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x6=
45c 0x645c
> [    4.841149] [drm]   Encoders:
> [    4.841151] [drm]     DFP3: INTERNAL_UNIPHY1
> [    4.841155] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
> [    4.841159] [drm] Connector 3:
> [    4.841162] [drm]   DVI-I-2
> [    4.841165] [drm]   HPD6
> [    4.841168] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x6=
47c 0x647c
> [    4.841174] [drm]   Encoders:
> [    4.841177] [drm]     DFP4: INTERNAL_UNIPHY
> [    4.841180] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    4.921539] [drm] fb mappable at 0x9034D000
> [    4.921547] [drm] vram apper at 0x90000000
> [    4.921549] [drm] size 9216000
> [    4.921552] [drm] fb depth is 24
> [    4.921555] [drm]    pitch is 7680
> [    4.921680] fbcon: radeondrmfb (fb0) is primary device
> [    4.943121] Console: switching to colour frame buffer device 240x75
> [    4.950509] radeon 0000:03:00.0: [drm] fb0: radeondrmfb frame buffer d=
evice
> [    4.959011] [drm] Initialized radeon 2.50.0 20080528 for 0000:03:00.0 =
on minor 0
>
>
> ...
>
> [27221.673320] list_del corruption. next->prev should be ffffffffc02e4e40=
, but was ffff98de96e40ed0
> [27221.673355] ------------[ cut here ]------------
> [27221.673357] kernel BUG at lib/list_debug.c:54!
> [27221.673365] invalid opcode: 0000 [#1] SMP PTI
> [27221.673370] CPU: 9 PID: 263 Comm: kswapd0 Tainted: G S        I       =
5.10.0+ #701
> [27221.673373] Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5=
C610.86B.01.01.0008.021120151325 02/11/2015
> [27221.673376] RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
> [27221.673386] Code: c7 c7 08 b7 40 9d e8 77 3f fe ff 0f 0b 48 89 fe 48 c=
7 c7 98 b7 40 9d e8 66 3f fe ff 0f 0b 48 c7 c7 48 b8 40 9d e8 58 3f fe ff <=
0f> 0b 48 89 f2 48 89 fe 48 c7 c7 08 b8 40 9d e8 44 3f fe ff 0f 0b
> [27221.673389] RSP: 0000:ffffac17007f3c20 EFLAGS: 00010286
> [27221.673394] RAX: 0000000000000054 RBX: ffffffffc02e4e40 RCX: 000000000=
0000000
> [27221.673396] RDX: ffff98e5df866ba0 RSI: ffff98e5df858ac0 RDI: ffff98e5d=
f858ac0
> [27221.673398] RBP: 0000000000000080 R08: 0000000000000000 R09: ffffac170=
07f3a58
> [27221.673401] R10: ffffac17007f3a50 R11: ffffffff9d744ca8 R12: 000000000=
0000000
> [27221.673403] R13: 0000000000000000 R14: 0000000000000084 R15: ffffffffc=
02e4ba0
> [27221.673405] FS:  0000000000000000(0000) GS:ffff98e5df840000(0000) knlG=
S:0000000000000000
> [27221.673408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27221.673411] CR2: 00000000004fea86 CR3: 000000079a9e4001 CR4: 000000000=
01726e0
> [27221.673414] Call Trace:
> [27221.673420]  ttm_pool_shrink+0x53/0xb0 [ttm]
> [27221.673433]  ttm_pool_shrinker_scan+0xa/0x20 [ttm]
> [27221.673440]  do_shrink_slab+0x145/0x240
> [27221.673447]  shrink_slab+0x9c/0x280
> [27221.673451]  shrink_node+0x2c2/0x6f0
> [27221.673456]  balance_pgdat+0x2ff/0x620
> [27221.673461]  kswapd+0x1e6/0x360
> [27221.673464]  ? finish_wait+0x80/0x80
> [27221.673471]  ? balance_pgdat+0x620/0x620
> [27221.673474]  kthread+0x11b/0x140
> [27221.673479]  ? __kthread_bind_mask+0x60/0x60
> [27221.673483]  ret_from_fork+0x22/0x30
> [27221.673491] Modules linked in: vhost_net vhost vhost_iotlb tap xt_MASQ=
UERADE xt_conntrack xt_CHECKSUM ip6t_REJECT ipt_REJECT nf_nat_tftp nft_objr=
ef nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_rej=
ect_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_t=
ables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw =
ip6table_security tun bridge iptable_nat nf_nat nf_conntrack stp llc nf_def=
rag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security rfkill =
ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable=
_filter vfat fat intel_rapl_msr intel_rapl_common sb_edac snd_hda_codec_rea=
ltek x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp ledtrig_au=
dio snd_hda_codec_hdmi coretemp kvm_intel snd_hda_intel joydev snd_intel_ds=
pcfg apple_mfi_fastcharge snd_hda_codec kvm snd_hda_core iTCO_wdt irqbypass=
 intel_pmc_bxt snd_hwdep iTCO_vendor_support snd_seq ipmi_si rapl snd_seq_d=
evice ipmi_devintf intel_cstate
> [27221.673569]  snd_pcm mei_me intel_uncore i2c_i801 ipmi_msghandler pcsp=
kr snd_timer i2c_smbus mei snd lpc_ich ioatdma soundcore acpi_power_meter a=
cpi_pad auth_rpcgss binfmt_misc sunrpc ip_tables radeon uas usb_storage drm=
_ttm_helper ttm drm_kms_helper igb cec crct10dif_pclmul crc32_pclmul crc32c=
_intel dca drm raid0 ghash_clmulni_intel wmi i2c_algo_bit fuse ecryptfs
> [27221.673609] ---[ end trace 98f04a1b0e5570b4 ]---
> [27221.726254] RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
> [27221.726277] Code: c7 c7 08 b7 40 9d e8 77 3f fe ff 0f 0b 48 89 fe 48 c=
7 c7 98 b7 40 9d e8 66 3f fe ff 0f 0b 48 c7 c7 48 b8 40 9d e8 58 3f fe ff <=
0f> 0b 48 89 f2 48 89 fe 48 c7 c7 08 b8 40 9d e8 44 3f fe ff 0f 0b
> [27221.726281] RSP: 0000:ffffac17007f3c20 EFLAGS: 00010286
> [27221.726284] RAX: 0000000000000054 RBX: ffffffffc02e4e40 RCX: 000000000=
0000000
> [27221.726286] RDX: ffff98e5df866ba0 RSI: ffff98e5df858ac0 RDI: ffff98e5d=
f858ac0
> [27221.726288] RBP: 0000000000000080 R08: 0000000000000000 R09: ffffac170=
07f3a58
> [27221.726290] R10: ffffac17007f3a50 R11: ffffffff9d744ca8 R12: 000000000=
0000000
> [27221.726292] R13: 0000000000000000 R14: 0000000000000084 R15: ffffffffc=
02e4ba0
> [27221.726294] FS:  0000000000000000(0000) GS:ffff98e5df840000(0000) knlG=
S:0000000000000000
> [27221.726296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27221.726298] CR2: 00000000004fea86 CR3: 000000079a9e4001 CR4: 000000000=
01726e0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
