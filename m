Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169B62E8EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 00:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbhACXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 18:04:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:45351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhACXEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 18:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609714966;
        bh=ySnJQNOm+Vjhor1VPMBVFpYxvKhMVi/0yci7iOSalk8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=OdMLNae30JC6NxH6ggWGEkTQJ1nYIENWUM6tYW3RCRG5Ve1x3QzqnTs4o/WLmqVN7
         GURsh2RufW47xMRv92Aa/avvm9JuWkj6dwNFuaHNf485FxNQuDc8JRyCgqq2//nsDZ
         /O+W0+frykBn3llUt92iBDRlIr/daFqe7movdndU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.36] ([85.127.169.10]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1k925Y42Wb-00ubn0; Mon, 04
 Jan 2021 00:02:46 +0100
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
From:   Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Subject: PROBLEM: CPU hotplug leads to NULL pointer dereference with RAPL
 enabled on AMD 2990WX
Message-ID: <151f54e9-5b45-5624-681c-754224b6c263@gmx.at>
Date:   Mon, 4 Jan 2021 00:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UqOTvpBClXHG2QvWDKjMnAl9dZaxoTzksqICMRUdsI5yI/wrWd6
 cywA7gP/8LQmBn+Ro9t8vA4cK8YexodfIT/EiugdNyMu61hTQbliWSQypSAuGsGZuB1kUEw
 p3QrSpREF+37XvnpGjKrVIK8lgWlVj27b60i9LeDRuUVf+z7e1CnkK+jEMovZGMiUrQGMom
 Ax3zJB62ZmoVRxI2Sg/bA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+0bNqvuFTh4=:PGepRwY9AVwV39u/LvNwuQ
 bJ3utgkSYYzsclYnVnMwLMpcHLHYpMsWEeU+dWR00L7Br0t6ynX7DKn8yX4CVRsWtttL/VEmX
 QT51xCYbbddTocRafNZ5Oere24UdORhCqT45WhaX5TWh67MdFyJLfljU6YBYjGgMZ1TjpVlws
 7rGqtMNHl7oWPsozgW0Q+gPk2+k2TNZEzSOnSK3jwWd7Jrqz/ww8BD3mW290fWiT8vtOvWCfx
 Pmfhqdj3XYBPN59bh/q+8sVTO+FCJN9lsQIA1CVWALLkXTP0X9tBJQXrmC7BBZYx7yNe17id8
 Nk6wohdIhgOYOBsnc4hYhFJB4sSgYRBMa9Bf56NURlDAU5V7tcYO62AZDkmh+7RSm0Zr52CUi
 MTTVsv6yzv396EWCm6lp1mSVTlEra54sk15+vE2fnBx3Ss9CI4Hs4oDQY4WbqCpUsM710MVPT
 quTB6UX2hjbkPtoHyDzo76E8sHT90LGwT/hKdoa2TZG15e4totSSyaH5OZrCgL2arK0GX3w/E
 1nRCb5d7fc8n9xUQE03JCUL3UPdO5vV95Kqn3ucG71LgXubJcTNwRBHRYBZvJm9RR0kxSEwXo
 ajiIsiSSdtONkTeeBH4oXYyf5QjbLARfLEvJPgbA0TYc2EOGkRx6gBVcHpTtOEfVOwtX3x+LD
 W09Rt9A9z+lOFwE559wizDQ70zFx2XKmbcDpMMaz+YbTWN5CC75PsNjl+cAj3Llq+A2p1CDCR
 z+kOw7/kvCYwzjfajd44Y+USFpJvOPeb30J7DIbLW55LuqxCqHZspY8q64WjblqWfSLyFE1l5
 mm2eSX8zQMAkI0kqDZFtGx1YWsDLXq/kURuUwg0gcD7B+qqEfyC27ubh2Q9uW/b1BayXDZiGV
 wwkUuQ7ztd73Rw5yn9YdAOcHvHAIsliL0we08UMX4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU hotplug leads to NULL pointer dereference with RAPL enabled on AMD 2990WX


When hot-plugging CPUs (e.g. manually or on suspend) I get a NULL
pointer dereference in rapl_cpu_offline() for CPUs 16 and 24.
It *seems* to me that this has to do with commit
700d098acec5271161606f3c0086b71695ea2ef8
("x86/CPU/AMD: Save AMD NodeId as cpu_die_id").
When reverting said commit hotplug works again.


I have been able to reproduce this on 5.10.4 and 5.11-rc1; 5.4.86 appears
to be not affected because RAPL does not seem to get enabled for the CPU
in use.
(CPUs 16 and 24 are not siblings according to
/sys/devices/system/cpu/cpu16/topology/thread_siblings_list in case that is
relevant.)


Steps to reproduce (on my system (ubuntu 18.04), as root):
	echo 0 > /sys/devices/system/cpu/cpu16/hotplug/target
(When turning off RAPL by unsetting "PERF_EVENTS_INTEL_RAPL" I seem to be able
to hot-plug the mentioned CPUs without reverting 700d098acec5.)

(In order to be able to test this with 5.11-rc1 on my system I had to revert
commit f36a74b9345aebaf5d325380df87a54720229d18.)


Relevant part of dmesg when trying to turn off CPU16:

[   46.828426] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   46.828467] #PF: supervisor write access in kernel mode
[   46.828493] #PF: error_code(0x0002) - not-present page
[   46.828518] PGD 0 P4D 0
[   46.828534] Oops: 0002 [#1] SMP NOPTI
[   46.828554] CPU: 16 PID: 107 Comm: cpuhp/16 Not tainted 5.11.0-rc1-bisect #1
[   46.828589] Hardware name: System manufacturer System Product Name/ROG ZENITH
EXTREME, BIOS 1701 01/09/2019
[   46.828632] RIP: 0010:rapl_cpu_offline+0x51/0xb0 [rapl]
[   46.828663] Code: 0d 84 2c 00 00 45 31 e4 3b 91 28 01 00 00 73 08 4c 8b a4 d1
30 01 00 00 f0 48 0f b3 05 68 28 00 00 72 07 5b 31 c0 41 5c 5d c3 <41> c7 44 24
08 ff ff ff ff 48 8b 04 c5 00 89 28 9d 89 fb 48 c7 c2
[   46.828746] RSP: 0018:ffffaaba8397be48 EFLAGS: 00010247
[   46.828773] RAX: 0000000000000010 RBX: ffff9963ee018760 RCX: ffff9960108cbc00
[   46.828807] RDX: 0000000000000002 RSI: 000000000000009e RDI: 0000000000000010
[   46.828839] RBP: ffffaaba8397be58 R08: ffff9963ee018788 R09: 0000000000000000
[   46.828872] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   46.828905] R13: 0000000000000010 R14: ffff9963ee018788 R15: ffff9960020ec8c0
[   46.828938] FS:  0000000000000000(0000) GS:ffff9963ee000000(0000)
knlGS:0000000000000000
[   46.828975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.829003] CR2: 0000000000000008 CR3: 000000076b810000 CR4: 00000000003506e0
[   46.829036] Call Trace:
[   46.829052]  ? rapl_hrtimer_handle+0xa0/0xa0 [rapl]
[   46.829078]  cpuhp_invoke_callback+0x85/0x410
[   46.829105]  ? sort_range+0x30/0x30
[   46.829125]  cpuhp_thread_fun+0xb8/0x120
[   46.829145]  smpboot_thread_fn+0xfc/0x170
[   46.829166]  kthread+0x126/0x140
[   46.829185]  ? kthread_park+0x90/0x90
[   46.829206]  ret_from_fork+0x22/0x30
[   46.829229] Modules linked in: xt_CHECKSUM iptable_mangle xt_MASQUERADE
bridge stp llc iptable_filter xt_nat xt_tcpudp iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 bpfilter binfmt_misc snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg nls_iso8859_1 soundwire_intel soundwire_generic_allocation
soundwire_cadence joydev input_leds snd_hda_codec snd_hda_core snd_hwdep
intel_rapl_msr soundwire_bus intel_rapl_common snd_soc_core snd_compress
amd64_edac_mod ac97_bus snd_pcm_dmaengine edac_mce_amd snd_pcm kvm_amd
snd_seq_midi kvm snd_seq_midi_event rapl snd_rawmidi eeepc_wmi asus_wmi
sparse_keymap snd_seq video wmi_bmof snd_seq_device snd_timer snd efi_pstore
soundcore k10temp ccp mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
async_raid6_recov async_memcpy async_pq
[   46.829309]  async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath
linear hid_cherry hid_generic usbhid hid mxm_wmi crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper nvme igb
nvme_core dca ahci i2c_piix4 xhci_pci i2c_algo_bit libahci xhci_pci_renesas
gpio_amdpt wmi gpio_generic
[   46.829830] CR2: 0000000000000008
[   46.829848] ---[ end trace 5c9c68d47cf771f6 ]---
[   46.881781] RIP: 0010:rapl_cpu_offline+0x51/0xb0 [rapl]
[   46.881808] Code: 0d 84 2c 00 00 45 31 e4 3b 91 28 01 00 00 73 08 4c 8b a4 d1
30 01 00 00 f0 48 0f b3 05 68 28 00 00 72 07 5b 31 c0 41 5c 5d c3 <41> c7 44 24
08 ff ff ff ff 48 8b 04 c5 00 89 28 9d 89 fb 48 c7 c2
[   46.881885] RSP: 0018:ffffaaba8397be48 EFLAGS: 00010247
[   46.882413] RAX: 0000000000000010 RBX: ffff9963ee018760 RCX: ffff9960108cbc00
[   46.886575] RDX: 0000000000000002 RSI: 000000000000009e RDI: 0000000000000010
[   46.891210] RBP: ffffaaba8397be58 R08: ffff9963ee018788 R09: 0000000000000000
[   46.895849] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   46.900579] R13: 0000000000000010 R14: ffff9963ee018788 R15: ffff9960020ec8c0
[   46.904623] FS:  0000000000000000(0000) GS:ffff9963ee000000(0000)
knlGS:0000000000000000
[   46.909198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.913625] CR2: 0000000000000008 CR3: 00000004adf54000 CR4: 00000000003506e0




Kind regards
John


