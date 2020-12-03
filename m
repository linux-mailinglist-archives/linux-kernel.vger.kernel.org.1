Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C692CCE1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgLCE5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:57:06 -0500
Received: from cmta19.telus.net ([209.171.16.92]:46256 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgLCE5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:57:05 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 23:57:04 EST
Received: from [192.168.20.38] ([209.89.189.71])
        by cmsmtp with SMTP
        id kgZ7kvCzkc2CmkgZ9kPpGb; Wed, 02 Dec 2020 21:50:03 -0700
X-Telus-Authed: Z2lsbGI0
X-Authority-Analysis: v=2.4 cv=NMEQR22g c=1 sm=1 tr=0 ts=5fc86e7b
 a=lXP6RixAJDH2mbiCOq84ew==:117 a=lXP6RixAJDH2mbiCOq84ew==:17
 a=IkcTkHD0fZMA:10 a=8qRUqkmczX7pih-us7MA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
To:     linux-kernel@vger.kernel.org
From:   bob <gillb4@telusplanet.net>
Subject: Nouveau video --- [ cut here ] ----- crash dump 5.10.0-rc6
Message-ID: <5d3e93cb-1a95-589c-71ed-2413932884d5@telusplanet.net>
Date:   Wed, 2 Dec 2020 21:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4xfK8Rb6RWUGYWpDWVVPUPgC7QtfDjmBVC4JNV570MipBwtZ5AiFF3rPxSFYDYlY2LfWLJZHcgFHgxbXk/RZf7LF8i89ad407xpYQGxHVDnj2BEH5iZBgV
 dzN07d8jnEZvaqTDYXokNn3OKM4XxBo4CiEhCATTghd3xBS5QKN/OYvumgB31n+w+k302Q2bWXnvrOPTZKC7H3Q03vufSb+/XPw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I have a crash dump for:

$ uname -a
Linux freedom 5.10.0-rc6 #1 SMP Sun Nov 29 17:26:13 MST 2020 x86_64 
x86_64 x86_64 GNU/Linux

Occasionally when this dumps it likes to lock up the computer, but I 
caught it this time.

Also video likes to flicker a lot.   Nouveau has been iffy since kernel 
5.8.0.

This isn't the only dump, it dumped probably 50 times.  If you are 
really desperate for all of it,

reply to me directly as I'm not on the mailing list.  Here is one of them.

[39019.426580] ------------[ cut here ]------------
[39019.426589] WARNING: CPU: 6 PID: 14136 at 
drivers/gpu/drm/nouveau/dispnv50/disp.c:211 nv50_dmac_wait+0x1e1/0x230
[39019.426590] Modules linked in: mt2131 s5h1409 fuse tda8290 tuner 
cx25840 rt2800usb rt2x00usb rt2800lib snd_hda_codec_analog 
snd_hda_codec_generic ledtrig_audio rt2x00lib binfmt_misc 
intel_powerclamp coretemp cx23885 mac80211 tda18271 altera_stapl 
videobuf2_dvb m88ds3103 tveeprom cx2341x dvb_core rc_core i2c_mux 
snd_hda_codec_hdmi videobuf2_dma_sg videobuf2_memops videobuf2_v4l2 
snd_hda_intel videobuf2_common snd_intel_dspcfg kvm_intel snd_hda_codec 
videodev snd_hda_core kvm mc snd_hwdep snd_pcm_oss snd_mixer_oss 
irqbypass snd_pcm cfg80211 snd_seq_dummy snd_seq_midi snd_seq_oss 
snd_seq_midi_event snd_rawmidi snd_seq intel_cstate snd_seq_device 
serio_raw snd_timer input_leds nfsd libarc4 snd asus_atk0110 i7core_edac 
soundcore i5500_temp auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc 
parport_pc ppdev lp parport ip_tables x_tables btrfs blake2b_generic 
libcrc32c xor zstd_compress raid6_pq dm_mirror dm_region_hash dm_log 
pata_acpi pata_marvell hid_generic usbhid hid psmouse firewire_ohci
[39019.426650]  firewire_core crc_itu_t i2c_i801 ahci sky2 libahci 
i2c_smbus lpc_ich
[39019.426658] CPU: 6 PID: 14136 Comm: kworker/u16:0 Tainted: G        W 
I       5.10.0-rc6 #1
[39019.426659] Hardware name: System manufacturer System Product 
Name/P6T DELUXE, BIOS 2209    09/21/2010
[39019.426662] Workqueue: events_unbound nv50_disp_atomic_commit_work
[39019.426665] RIP: 0010:nv50_dmac_wait+0x1e1/0x230
[39019.426667] Code: 8d 48 04 48 89 4a 68 c7 00 00 00 00 20 49 8b 46 38 
41 c7 86 20 01 00 00 00 00 00 00 49 89 46 68 e8 e4 fc ff ff e9 76 fe ff 
ff <0f> 0b b8 92 ff ff ff e9 ed fe ff ff 49 8b be 80 00 00 00 e8 c7 fc
[39019.426668] RSP: 0018:ffffb79d028ebd48 EFLAGS: 00010282
[39019.426670] RAX: ffffffffffffff92 RBX: 000000000000000d RCX: 
0000000000000000
[39019.426671] RDX: ffffffffffffff92 RSI: ffffb79d028ebc88 RDI: 
ffffb79d028ebd28
[39019.426671] RBP: ffffb79d028ebd48 R08: 0000000000000000 R09: 
ffffb79d028ebc58
[39019.426672] R10: 0000000000000030 R11: 00000000000011c4 R12: 
00000000fffffffb
[39019.426673] R13: ffffa05fc1ebd368 R14: ffffa05fc1ebd3a8 R15: 
ffffa05fc2425000
[39019.426675] FS:  0000000000000000(0000) GS:ffffa061f3d80000(0000) 
knlGS:0000000000000000
[39019.426676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[39019.426677] CR2: 00007fb2d58e0000 CR3: 000000026280a000 CR4: 
00000000000006e0
[39019.426678] Call Trace:
[39019.426685]  base827c_image_set+0x2f/0x1d0
[39019.426687]  nv50_wndw_flush_set+0x89/0x1c0
[39019.426688]  nv50_disp_atomic_commit_tail+0x4e7/0x7e0
[39019.426693]  process_one_work+0x1d4/0x370
[39019.426695]  worker_thread+0x4a/0x3b0
[39019.426697]  ? process_one_work+0x370/0x370
[39019.426699]  kthread+0xfe/0x140
[39019.426701]  ? kthread_park+0x90/0x90
[39019.426704]  ret_from_fork+0x22/0x30
[39019.426706] ---[ end trace d512d675211c738c ]---
[39021.426751] ------------[ cut here ]------------


Thanks in advance,

Bob

