Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8A2689D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgINLPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:15:55 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:46670 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgINLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:14:17 -0400
Subject: Re: gcc crashes with general protection faults in 5.9.0-rc5
From:   Meelis Roos <mroos@linux.ee>
To:     LKML <linux-kernel@vger.kernel.org>
References: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
Message-ID: <3b2a4c1d-5eab-e0e6-21c3-85abb51eb78b@linux.ee>
Date:   Mon, 14 Sep 2020 14:14:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> This is 5.9.0-rc3-00091-ge28f0104343d on Lenovo t460s that has ran fine up to 5.8.0.
> 
> Today I tried reproducing my linking problem with git kernel on my laptop and got segmentation faults in gcc. This is probably the corresponding dmesg part:
And it still happens with 5.9-rc5 on a HP desktop PC where I tried rc5:

[ 1502.992914] general protection fault, probably for non-canonical address 0xdead000000000400: 0000 [#1] SMP PTI
[ 1502.992919] CPU: 5 PID: 35115 Comm: cc1 Not tainted 5.9.0-rc5 #324
[ 1502.992920] Hardware name: Hewlett-Packard HP Compaq 8100 Elite SFF PC/304Ah, BIOS 786H1 v01.13 07/14/2011
[ 1502.992927] RIP: 0010:ext4_readpage+0xa/0x50
[ 1502.992929] Code: ff a9 00 00 00 10 74 0b 66 83 bf e2 02 00 00 00 74 01 c3 31 d2 e9 46 ea 01 00 66 0f 1f 44 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd e2 02
[ 1502.992932] RSP: 0000:ffff96b18b09fd88 EFLAGS: 00010286
[ 1502.992934] RAX: dead000000000400 RBX: ffff96b18b09fe60 RCX: 0000000000000000
[ 1502.992935] RDX: 0000000000000001 RSI: ffffc54a413fdf80 RDI: ffff8d8f41c3c800
[ 1502.992936] RBP: ffffc54a413fdf80 R08: 0000000000000005 R09: ffff8d8f9bd61e50
[ 1502.992938] R10: 0000000000000000 R11: ffff8d8f41c3c800 R12: ffffc54a413fdf80
[ 1502.992939] R13: 0000000000000b7e R14: ffff8d8efa04bb18 R15: ffff8d8efa04bc90
[ 1502.992941] FS:  00007f26d5649f00(0000) GS:ffff8d8f9bd40000(0000) knlGS:0000000000000000
[ 1502.992942] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1502.992944] CR2: 0000000001029bc0 CR3: 00000000731fe000 CR4: 00000000000006e0
[ 1502.992945] Call Trace:
[ 1502.992952]  filemap_fault+0x193/0x7c0
[ 1502.992954]  ext4_filemap_fault+0x28/0x3a
[ 1502.992957]  __do_fault+0x31/0xf0
[ 1502.992959]  handle_mm_fault+0xf0e/0x14c0
[ 1502.992962]  exc_page_fault+0x1a2/0x3b0
[ 1502.992965]  ? asm_exc_page_fault+0x8/0x30
[ 1502.992967]  asm_exc_page_fault+0x1e/0x30
[ 1502.992968] RIP: 0033:0xf7e720
[ 1502.992971] Code: Bad RIP value.
[ 1502.992972] RSP: 002b:00007ffebfbcb028 EFLAGS: 00010293
[ 1502.992973] RAX: 0000000000000019 RBX: 00007f26d25959d8 RCX: 0000000000000048
[ 1502.992974] RDX: 00007ffebfbcb080 RSI: 00007f26d4ee5000 RDI: 000000007ff84590
[ 1502.992975] RBP: 00007f26d4ee5000 R08: 00007f26d257ca00 R09: 00007f26d258bbd0
[ 1502.992976] R10: 00007f26d25959d8 R11: 0000000000000000 R12: 000000007ff84590
[ 1502.992977] R13: 00007f26d25959d8 R14: 00007ffebfbcb080 R15: 00007f26d5062300
[ 1502.992979] Modules linked in: dm_mod md_mod cpufreq_conservative cpufreq_userspace cpufreq_powersave pktcdvd joydev snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi coretemp radeon snd_hda_intel snd_intel_dspcfg intel_powerclamp snd_hda_codec hwmon snd_hwdep kvm_intel ttm snd_hda_core kvm irqbypass iTCO_wdt snd_pcm_oss tpm_infineon iTCO_vendor_support crc32c_intel snd_mixer_oss mei_wdt psmouse evdev pcspkr tpm_tis snd_pcm tpm_tis_core snd_timer e1000e snd lpc_ich tpm mfd_core rng_core soundcore acpi_cpufreq loop i2c_dev parport_pc lp parport ip_tables x_tables autofs4
[ 1502.993024] ---[ end trace 5ccb97e370c341f5 ]---
[ 1502.993030] RIP: 0010:ext4_readpage+0xa/0x50
[ 1502.993033] Code: ff a9 00 00 00 10 74 0b 66 83 bf e2 02 00 00 00 74 01 c3 31 d2 e9 46 ea 01 00 66 0f 1f 44 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd e2 02
[ 1502.993035] RSP: 0000:ffff96b18b09fd88 EFLAGS: 00010286
[ 1502.993038] RAX: dead000000000400 RBX: ffff96b18b09fe60 RCX: 0000000000000000
[ 1502.993039] RDX: 0000000000000001 RSI: ffffc54a413fdf80 RDI: ffff8d8f41c3c800
[ 1502.993040] RBP: ffffc54a413fdf80 R08: 0000000000000005 R09: ffff8d8f9bd61e50
[ 1502.993041] R10: 0000000000000000 R11: ffff8d8f41c3c800 R12: ffffc54a413fdf80
[ 1502.993042] R13: 0000000000000b7e R14: ffff8d8efa04bb18 R15: ffff8d8efa04bc90
[ 1502.993044] FS:  00007f26d5649f00(0000) GS:ffff8d8f9bd40000(0000) knlGS:0000000000000000
[ 1502.993045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1502.993046] CR2: 0000000000f7e6f6 CR3: 00000000731fe000 CR4: 00000000000006e0
[ 1503.001633] general protection fault, probably for non-canonical address 0xdead000000000400: 0000 [#2] SMP PTI
[ 1503.001638] CPU: 0 PID: 34924 Comm: cc1 Tainted: G      D           5.9.0-rc5 #324
[ 1503.001640] Hardware name: Hewlett-Packard HP Compaq 8100 Elite SFF PC/304Ah, BIOS 786H1 v01.13 07/14/2011
[ 1503.001645] RIP: 0010:ext4_readpage+0xa/0x50
[ 1503.001648] Code: ff a9 00 00 00 10 74 0b 66 83 bf e2 02 00 00 00 74 01 c3 31 d2 e9 46 ea 01 00 66 0f 1f 44 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd e2 02
[ 1503.001649] RSP: 0000:ffff96b18af57d88 EFLAGS: 00010286
[ 1503.001651] RAX: dead000000000400 RBX: ffff96b18af57e60 RCX: 0000000000000000
[ 1503.001652] RDX: 0000000000000001 RSI: ffffc54a413f8a40 RDI: ffff8d8f94593a00
[ 1503.001654] RBP: ffffc54a413f8a40 R08: 0000000000000000 R09: ffff8d8f9bc21e50
[ 1503.001655] R10: 0000000000000003 R11: ffff8d8f94593a00 R12: ffffc54a413f8a40
[ 1503.001656] R13: 0000000000000c29 R14: ffff8d8efa04bb18 R15: ffff8d8efa04bc90
[ 1503.001658] FS:  00007f3087b05f00(0000) GS:ffff8d8f9bc00000(0000) knlGS:0000000000000000
[ 1503.001660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1503.001661] CR2: 00000000012a5700 CR3: 0000000073114000 CR4: 00000000000006f0
[ 1503.001662] Call Trace:
[ 1503.001669]  filemap_fault+0x193/0x7c0
[ 1503.001672]  ext4_filemap_fault+0x28/0x3a
[ 1503.001675]  __do_fault+0x31/0xf0
[ 1503.001677]  handle_mm_fault+0xf0e/0x14c0
[ 1503.001680]  ? tick_sched_do_timer+0x60/0x60
[ 1503.001683]  exc_page_fault+0x1a2/0x3b0
[ 1503.001687]  ? asm_exc_page_fault+0x8/0x30
[ 1503.001689]  asm_exc_page_fault+0x1e/0x30
[ 1503.001692] RIP: 0033:0x1029bc0
[ 1503.001695] Code: Bad RIP value.
[ 1503.001696] RSP: 002b:00007ffd6e6babc8 EFLAGS: 00010246
[ 1503.001697] RAX: 0000000001ab8900 RBX: 0000000000000099 RCX: 0000000000000040
[ 1503.001699] RDX: 00007f3081563d40 RSI: 00007f308157c330 RDI: 00007f308157c2d0
[ 1503.001700] RBP: 00007f308157c2d0 R08: 0000000000010000 R09: 0000000000000000
[ 1503.001701] R10: 0000000000000000 R11: 0000000000000000 R12: 00007f308157c330
[ 1503.001703] R13: 00007f30825ef360 R14: 00007f308157cd68 R15: 0000000000000078
[ 1503.001704] Modules linked in: dm_mod md_mod cpufreq_conservative cpufreq_userspace cpufreq_powersave pktcdvd joydev snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi coretemp radeon snd_hda_intel snd_intel_dspcfg intel_powerclamp snd_hda_codec hwmon snd_hwdep kvm_intel ttm snd_hda_core kvm irqbypass iTCO_wdt snd_pcm_oss tpm_infineon iTCO_vendor_support crc32c_intel snd_mixer_oss mei_wdt psmouse evdev pcspkr tpm_tis snd_pcm tpm_tis_core snd_timer e1000e snd lpc_ich tpm mfd_core rng_core soundcore acpi_cpufreq loop i2c_dev parport_pc lp parport ip_tables x_tables autofs4
[ 1503.001727] ---[ end trace 5ccb97e370c341f6 ]---
[ 1503.001729] RIP: 0010:ext4_readpage+0xa/0x50
[ 1503.001731] Code: ff a9 00 00 00 10 74 0b 66 83 bf e2 02 00 00 00 74 01 c3 31 d2 e9 46 ea 01 00 66 0f 1f 44 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd e2 02
[ 1503.001733] RSP: 0000:ffff96b18b09fd88 EFLAGS: 00010286
[ 1503.001734] RAX: dead000000000400 RBX: ffff96b18b09fe60 RCX: 0000000000000000
[ 1503.001736] RDX: 0000000000000001 RSI: ffffc54a413fdf80 RDI: ffff8d8f41c3c800
[ 1503.001738] RBP: ffffc54a413fdf80 R08: 0000000000000005 R09: ffff8d8f9bd61e50
[ 1503.001739] R10: 0000000000000000 R11: ffff8d8f41c3c800 R12: ffffc54a413fdf80
[ 1503.001741] R13: 0000000000000b7e R14: ffff8d8efa04bb18 R15: ffff8d8efa04bc90
[ 1503.001742] FS:  00007f3087b05f00(0000) GS:ffff8d8f9bc00000(0000) knlGS:0000000000000000
[ 1503.001745] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1503.001746] CR2: 0000000001029b96 CR3: 0000000073114000 CR4: 00000000000006f0
[ 1513.208946] general protection fault, probably for non-canonical address 0xdead000000000400: 0000 [#3] SMP PTI
[ 1513.208952] CPU: 0 PID: 35952 Comm: cc1 Tainted: G      D           5.9.0-rc5 #324
[ 1513.208953] Hardware name: Hewlett-Packard HP Compaq 8100 Elite SFF PC/304Ah, BIOS 786H1 v01.13 07/14/2011
[ 1513.208960] RIP: 0010:ext4_readpage+0xa/0x50
[ 1513.208962] Code: ff a9 00 00 00 10 74 0b 66 83 bf e2 02 00 00 00 74 01 c3 31 d2 e9 46 ea 01 00 66 0f 1f 44 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd e2 02
[ 1513.208964] RSP: 0000:ffff96b18b64fd88 EFLAGS: 00010286
[ 1513.208966] RAX: dead000000000400 RBX: ffff96b18b64fe60 RCX: 0000000000000000
[ 1513.208967] RDX: 0000000000000001 RSI: ffffc54a4130cb00 RDI: ffff8d8f3b993e00
[ 1513.208968] RBP: ffffc54a4130cb00 R08: 0000000000000000 R09: ffff8d8f9bc21e50
[ 1513.208970] R10: 0000000000000000 R11: ffff8d8f3b993e00 R12: ffffc54a4130cb00
[ 1513.208971] R13: 0000000000000d2c R14: ffff8d8efa04bb18 R15: ffff8d8efa04bc90
[ 1513.208973] FS:  00007f60e012bf00(0000) GS:ffff8d8f9bc00000(0000) knlGS:0000000000000000
[ 1513.208975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1513.208977] CR2: 000000000125bf10 CR3: 00000000bb72e000 CR4: 00000000000006f0
[ 1513.208978] Call Trace:
[ 1513.208984]  filemap_fault+0x193/0x7c0
[ 1513.208988]  ext4_filemap_fault+0x28/0x3a
[ 1513.208991]  __do_fault+0x31/0xf0
[ 1513.208994]  handle_mm_fault+0xf0e/0x14c0
[ 1513.208998]  exc_page_fault+0x1a2/0x3b0
[ 1513.209003]  ? asm_exc_page_fault+0x8/0x30
[ 1513.209005]  asm_exc_page_fault+0x1e/0x30
[ 1513.209007] RIP: 0033:0x112ccc0
[ 1513.209011] Code: Bad RIP value.
[ 1513.209012] RSP: 002b:00007ffe555f0c48 EFLAGS: 00010202
[ 1513.209014] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00007f60df9b20c0
[ 1513.209016] RDX: 0000000000000002 RSI: 0000000000000006 RDI: 00007f60da91b1f8
[ 1513.209017] RBP: 00007f60da91b1f8 R08: 0000000000000011 R09: 0000000000000001
[ 1513.209019] R10: 00007f60da91c3a8 R11: 00007f60e029f3c0 R12: 0000000001ab53e0
[ 1513.209020] R13: 0000000000000003 R14: 00000000ffffffff R15: 00007f60da91b1f8
[ 1513.209023] Modules linked in: dm_mod md_mod cpufreq_conservative cpufreq_userspace cpufreq_powersave pktcdvd joydev snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi coretemp radeon snd_hda_intel snd_intel_dspcfg intel_powerclamp snd_hda_codec hwmon snd_hwdep kvm_intel ttm snd_hda_core kvm irqbypass iTCO_wdt snd_pcm_oss tpm_infineon iTCO_vendor_support crc32c_intel snd_mixer_oss mei_wdt psmouse evdev pcspkr tpm_tis snd_pcm tpm_tis_core snd_timer e1000e snd lpc_ich tpm mfd_core rng_core soundcore acpi_cpufreq loop i2c_dev parport_pc lp parport ip_tables x_tables autofs4
[ 1513.209048] ---[ end trace 5ccb97e370c341f7 ]---
[ 1513.209051] RIP: 0010:ext4_readpage+0xa/0x50
[ 1513.209053] Code: ff a9 00 00 00 10 74 0b 66 83 bf e2 02 00 00 00 74 01 c3 31 d2 e9 46 ea 01 00 66 0f 1f 44 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd e2 02
[ 1513.209055] RSP: 0000:ffff96b18b09fd88 EFLAGS: 00010286
[ 1513.209057] RAX: dead000000000400 RBX: ffff96b18b09fe60 RCX: 0000000000000000
[ 1513.209058] RDX: 0000000000000001 RSI: ffffc54a413fdf80 RDI: ffff8d8f41c3c800
[ 1513.209059] RBP: ffffc54a413fdf80 R08: 0000000000000005 R09: ffff8d8f9bd61e50
[ 1513.209061] R10: 0000000000000000 R11: ffff8d8f41c3c800 R12: ffffc54a413fdf80
[ 1513.209062] R13: 0000000000000b7e R14: ffff8d8efa04bb18 R15: ffff8d8efa04bc90
[ 1513.209065] FS:  00007f60e012bf00(0000) GS:ffff8d8f9bc00000(0000) knlGS:0000000000000000
[ 1513.209067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1513.209068] CR2: 000000000112cc96 CR3: 00000000bb72e000 CR4: 00000000000006f0

-- 
Meelis Roos <mroos@linux.ee>
