Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7629A3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504168AbgJ0FIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:08:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38718 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441322AbgJ0FIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:08:09 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3FACD20B4905;
        Mon, 26 Oct 2020 22:08:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FACD20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603775287;
        bh=3sP2JzvT8Q4vd4lpgFSMh8xqUmWJN+8JmWmqwmeDMDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzh2OTaEecPDiB9itDkS2JwMXcn81e8B74OiKEb4IpYnHg6uKuG719yfTzozYpvZV
         cegCYyZJY31ioshtLnzqF8SuXoXqSMntr425Zt1NhCdmaCajplmVybGWeHIizh8YvT
         QE/x2XugdJUdhbTwHZKmP5rEMujlWbFhX9KnFGFQ=
Date:   Tue, 27 Oct 2020 00:08:00 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
Message-ID: <20201027050800.GA5039@sequoia>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com>
 <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <846fe4da67d05f57fba33e38c9a6e394e657adc3.camel@linux.ibm.com>
 <2d181eb8b62ae9a1821bb9093dccc3d6bcecbd23.camel@linux.ibm.com>
 <20201021054849.GA6856@sequoia>
 <2A43F8DD-7E07-4435-9666-63B8105ABF82@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2A43F8DD-7E07-4435-9666-63B8105ABF82@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 13:49:59, Kai-Heng Feng wrote:
>=20
>=20
> > On Oct 21, 2020, at 13:48, Tyler Hicks <tyhicks@linux.microsoft.com> wr=
ote:
> >=20
> > On 2020-10-20 17:07:50, Mimi Zohar wrote:
> >> On Tue, 2020-09-29 at 13:52 -0400, Mimi Zohar wrote:
> >>> On Mon, 2020-09-28 at 22:16 +0800, Kai-Heng Feng wrote:
> >>>> Hi Jarkko,
> >>>>=20
> >>>>> On Sep 28, 2020, at 22:06, Jarkko Sakkinen <jarkko.sakkinen@linux.i=
ntel.com> wrote:
> >>>>>=20
> >>>>> On Mon, Sep 28, 2020 at 08:31:04PM +0800, Kai-Heng Feng wrote:
> >>>>>> Commit 7f3d176f5f7e "tpm: Require that all digests are present in
> >>>>>> TCG_PCR_EVENT2 structures" causes a null pointer dereference on all
> >>>>>> laptops I have:
> >>>>>=20
> >>>>> ...
> >>>>>=20
> >>>>>> [   17.868849] BUG: kernel NULL pointer dereference, address: 0000=
00000000002c
> >>>>>> [   17.868852] #PF: supervisor read access in kernel mode
> >>>>>> [   17.868854] #PF: error_code(0x0000) - not-present page
> >>>>>> [   17.868855] PGD 0 P4D 0=20
> >>>>>> [   17.868858] Oops: 0000 [#1] SMP PTI
> >>>>>> [   17.868860] CPU: 0 PID: 1873 Comm: fwupd Not tainted 5.8.0-rc6+=
 #25
> >>>>>> [   17.868861] Hardware name: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N=
27ET38W (1.24 ) 11/28/2019
> >>>>>> [   17.868866] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> >>>>>> [   17.868868] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 =
25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 =
00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> >>>>>> [   17.868869] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> >>>>>> [   17.868871] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 00=
00000000000010
> >>>>>> [   17.868872] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ff=
ff917c99b19438
> >>>>>> [   17.868873] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ff=
ff917cbfeae4c0
> >>>>>> [   17.868874] R10: 0000000000000000 R11: 0000000000000002 R12: 00=
00000000000010
> >>>>>> [   17.868875] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ff=
ff917c99b19470
> >>>>>> [   17.868876] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(000=
0) knlGS:0000000000000000
> >>>>>> [   17.868877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> [   17.868878] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00=
000000003606f0
> >>>>>> [   17.868879] Call Trace:
> >>>>>> [   17.868884]  seq_read+0x95/0x470
> >>>>>> [   17.868887]  ? security_file_permission+0x150/0x160
> >>>>>> [   17.868889]  vfs_read+0xaa/0x190
> >>>>>> [   17.868891]  ksys_read+0x67/0xe0
> >>>>>> [   17.868893]  __x64_sys_read+0x1a/0x20
> >>>>>> [   17.868896]  do_syscall_64+0x52/0xc0
> >>>>>> [   17.868898]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>>>>> [   17.868900] RIP: 0033:0x7f9d83be91dc
> >>>>>> [   17.868901] Code: Bad RIP value.
> >>>>>> [   17.868902] RSP: 002b:00007fff7f5e0250 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000000
> >>>>>> [   17.868903] RAX: ffffffffffffffda RBX: 00005651d262f420 RCX: 00=
007f9d83be91dc
> >>>>>> [   17.868904] RDX: 0000000000001000 RSI: 00007fff7f5e0350 RDI: 00=
00000000000010
> >>>>>> [   17.868905] RBP: 00007f9d83cc54a0 R08: 0000000000000000 R09: 00=
005651d26c1830
> >>>>>> [   17.868906] R10: 00005651d2582010 R11: 0000000000000246 R12: 00=
00000000001000
> >>>>>> [   17.868907] R13: 00007fff7f5e0350 R14: 0000000000000d68 R15: 00=
007f9d83cc48a0
> >>>>>> [   17.868909] Modules linked in: rfcomm ccm cmac algif_hash algif=
_skcipher af_alg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_gen=
eric bnep joydev mei_hdcp wmi_bmof intel_rapl_msr intel_wmi_thunderbolt x86=
_pkg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm crc=
t10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper cryp=
to_simd cryptd rapl input_leds intel_cstate snd_hda_intel snd_intel_dspcfg =
rmi_smbus iwlmvm snd_hda_codec serio_raw snd_hwdep mac80211 rmi_core snd_hd=
a_core libarc4 uvcvideo snd_pcm videobuf2_vmalloc btusb videobuf2_memops iw=
lwifi videobuf2_v4l2 btrtl btbcm videobuf2_common btintel thunderbolt i915 =
bluetooth mei_me videodev thinkpad_acpi nvram cfg80211 ledtrig_audio mei mc=
 ecdh_generic ecc i2c_algo_bit processor_thermal_device snd_seq_midi drm_km=
s_helper snd_seq_midi_event intel_soc_dts_iosf syscopyarea sysfillrect snd_=
rawmidi intel_pch_thermal sysimgblt intel_rapl_common intel_xhci_usb_role_s=
witch fb_sys_fops
> >>  u
> >>> cs
> >>>> i_acpi r
> >>>> o
> >>>>> les cec
> >>>>>> [   17.868935]  typec_ucsi typec nxp_nci_i2c snd_seq nxp_nci wmi n=
ci nfc snd_timer snd_seq_device snd int3403_thermal soundcore int340x_therm=
al_zone video mac_hid int3400_thermal acpi_pad acpi_thermal_rel sch_fq_code=
l parport_pc ppdev lp parport drm ip_tables x_tables autofs4 btrfs blake2b_=
generic libcrc32c xor zstd_compress raid6_pq uas usb_storage psmouse e1000e=
 nvme i2c_i801 i2c_smbus nvme_core intel_lpss_pci intel_lpss idma64 virt_dm=
a pinctrl_sunrisepoint pinctrl_intel
> >>>>>> [   17.868951] CR2: 000000000000002c
> >>>>>> [   17.868953] ---[ end trace ee7716fff5dec2fb ]---
> >>>>>> [   17.868955] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> >>>>>> [   17.868957] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 =
25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 =
00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> >>>>>> [   17.868958] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> >>>>>> [   17.868959] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 00=
00000000000010
> >>>>>> [   17.868960] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ff=
ff917c99b19438
> >>>>>> [   17.868961] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ff=
ff917cbfeae4c0
> >>>>>> [   17.868962] R10: 0000000000000000 R11: 0000000000000002 R12: 00=
00000000000010
> >>>>>> [   17.868963] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ff=
ff917c99b19470
> >>>>>> [   17.868964] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(000=
0) knlGS:0000000000000000
> >>>>>> [   17.868965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> [   17.868966] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00=
000000003606f0
> >>>>>=20
> >>>>> It is possible but initially feels a bit weird:
> >>>>>=20
> >>>>> -                  sizeof(TCG_SPECID_SIG)) || count > efispecid->nu=
m_algs) {
> >>>>> +                  sizeof(TCG_SPECID_SIG)) ||
> >>>>> +           !efispecid->num_algs || count !=3D efispecid->num_algs)=
 {
> >>>>>=20
> >>>>> Assuming that check does not pass because of a more strict constrai=
nt,
> >>>>> __calc_tpm2_event_size() returns 0.
> >>>>>=20
> >>>>> It is wrapped like this in drivers/char/tpm/eventlog/tpm2.c:
> >>>>>=20
> >>>>> static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *even=
t,
> >>>>> 				   struct tcg_pcr_event *event_header)
> >>>>> {
> >>>>> 	return __calc_tpm2_event_size(event, event_header, false);
> >>>>> }
> >>>>>=20
> >>>>> I.e. TPM_MEMUNMAP will not get executed because "do_mapping =3D=3D =
false".
> >>>>> tpm2_bios_measurements_start() checks for "size =3D=3D 0" and retur=
ns NULL
> >>>>> whenever this happens.
> >>>>>=20
> >>>>> Are you 100% sure that it is exactly this commit that triggers the =
bug?
> >>>>=20
> >>>> Yes I am 100% sure. The issue happens all the time, and never happens
> >>>> if I checkout the previous commit.
> >>>=20
> >>> I'm seeing this too on my test Ubuntu laptop.  Reverting the patch
> >>> fixes it, but there's no data.
> >>=20
> >> For a while I wasn't able to boot the test system with secure boot
> >> enabled.  The NULL pointer dereference problem occurred during the
> >> period of time that secure boot was disabled.   Once the secure boot
> >> issue was resolved, the NULL pointer dereference problem was resolved
> >> as well, when booting with/without secure boot enabled.
> >=20
> > I noticed that Kai had disabled secure boot, as well. I found a Thinkpad
> > with the same BIOS revision as Kai's Thinkpad (N27ET38W - 1.24) and
> > tested an unpatched v5.9 kernel running on an up-to-date Ubuntu 20.04.1
> > userspace. The main difference is that he has a Thinkpad T580 and I was
> > using a Thinkpad P52s. I was unable to reproduce the crash either by
> > running fwupdtpmevlog or cat'ing /sys/kernel/security/tpm0/binary_bios_=
measurements.
> >=20
> > I noticed that Kai had cleared his secure boot allowed signature
> > database (db) so I also tried that but was still unsuccessful in
> > reproducing the crash.
> >=20
> > Of course, I also tested with secure boot enabled and also after
> > toggling every secure boot and TPM related option in the BIOS. Still no
> > luck.
> >=20
> > Kenneth mentioned elsewhere[1] that he experienced the crash with
> > Ubuntu's 5.8.0-18 kernel so I also tried that but still no luck.
> >=20
> > Everyone that has reported this crash[1][2][3][4] seems to have been
> > running with an Ubuntu userspace. I do see that Ubuntu recently fixed a
> > shim bug[5] on Sept 24. Ubuntu auto-installs security updates by default
> > but this was not a security update so perhaps folks that were initially
> > affected by this crash hadn't yet applied the update. It looks unrelated
> > to me but it might explain why I can't reproduce this crash now, how the
> > crash no longer affects Mimi, and why nobody else is complaining about
> > the crash in recent weeks.
> >=20
> > Kai, could you please try once more with v5.9 and ensuring that your
> > Ubuntu system is fully updated?
>=20
> Yes it's fully updated.
>=20
> > If you're able to reproduce it with
> > v5.9, please send me your kernel config and your raw
>=20
> Ok, please refer to attachment.
>=20
> > /sys/kernel/security/tpm0/binary_bios_measurements file contents after
> > rebooting into a working kernel. I really appreciate it!
>=20
> Hmm, it's empty.

Thanks, this was the key detail I was missing. I'm now able to reproduce
this crash locally by forcing an empty events log in the EFI stub.

I've got a patch that fixes this crash but I'm still reading TCG specs
to understand exactly why my change started triggering this and if
there's a second fix needed. I hope to have the patch(es) out tomorrow.

Tyler

>=20
> Kai-Heng
>=20



>=20
> >=20
> > Tyler
> >=20
> > [1] https://lore.kernel.org/linux-integrity/alpine.DEB.2.23.453.2009121=
522400.7398@xps-7390/
> > [2] https://lore.kernel.org/lkml/E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@c=
anonical.com/
> > [3] https://lore.kernel.org/lkml/846fe4da67d05f57fba33e38c9a6e394e657ad=
c3.camel@linux.ibm.com/
> > [4] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1898998
> > [5] https://bugs.launchpad.net/ubuntu/+source/shim/+bug/1864223
> >=20
> >>=20
> >> Mimi
>=20

