Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F32FEF55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbhAUPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733252AbhAUPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:43:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nezzSrfrCSeSFBX2KqRMJnf5Hayn4griPofBnbsDELI=; b=vHPPhHiDQETF4BFF5vSFEiqpPq
        4wd7SFUDGd7AG5rHqgVSUCqK9WLGDLEtiCPNGdRfyigdLAeofg77gvEOHZQDKhq5jVNkCT2A6rgWT
        jZ3dK4RxviO0Xhbjqi6Xx+GaVOwd2YFjx+EqkGJs2xEHEQ8mtmoOGdni8JH92hdq+6NOvC+oG8a3t
        Z0KO5FXEA3A5rIxc3qW/BSh48ltOpE25NRpx5Ie/m6ieJ6bgxmUJ8Rw9AV68HhIXHd2bOogezP2UJ
        cqR/iM/FFVraIy7TkAsSq8zFMZeH9rs9+GvyKJVqjgtJqBJ8XZBLFokqZxmHlkiHWpWxXHZQNxBL8
        qbKe1Ktg==;
Received: from 54-240-197-236.amazon.com ([54.240.197.236] helo=freeip.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2c6I-0000gL-TP; Thu, 21 Jan 2021 15:42:23 +0000
Message-ID: <22a9d92f51e0c6f8d4a3928b91f7f75e0297b93a.camel@infradead.org>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>,
        "Schander, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Date:   Thu, 21 Jan 2021 15:42:19 +0000
In-Reply-To: <877do65og8.fsf@nanos.tec.linutronix.de>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
         <8ac72d7b287ed1058b2dec3301578238aff0abdd.camel@infradead.org>
         <877do65og8.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-unmwRyp8fapjyUfijXcC"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-unmwRyp8fapjyUfijXcC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-01-21 at 15:55 +0100, Thomas Gleixner wrote:
> > Testing on real hardware has been more interesting and less useful so
> > far. We started with the CPUHP_BRINGUP_KICK_CPU state being
> > *immediately* before CPUHP_BRINGUP_CPU. On my 28-thread Haswell box,
> > that didn't come up at all even without actually *doing* anything in
> > the pre-bringup phase. Merely bringing all the AP threads up through
> > the various CPUHP_PREPARE_foo stages before actually bringing them
> > online, was enough to break it. I have no serial port on this box so we
> > haven't get worked out why; I've resorted to putting the
> > CPUHP_BRINGUP_KICK_CPU state before CPUHP_WORKQUEUE_PREP instead.
>=20
> Hrm.

Aha, I managed to reproduce in qemu. It's CPUHP_X2APIC_PREPARE, which
is only used in x2apic *cluster* mode not physical mode. So I actually
need to give the guest an IOMMU with IRQ remapping before I see it.


$ git diff
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bc56287a1ed1..f503e66b4718 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -92,6 +92,7 @@ enum cpuhp_state {
        CPUHP_MIPS_SOC_PREPARE,
        CPUHP_BP_PREPARE_DYN,
        CPUHP_BP_PREPARE_DYN_END                =3D CPUHP_BP_PREPARE_DYN + =
20,
+       CPUHP_BRINGUP_WAKE_CPU,
        CPUHP_BRINGUP_CPU,
        CPUHP_AP_IDLE_DEAD,
        CPUHP_AP_OFFLINE,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2b8d7a5db383..6c6f2986bfdb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1336,6 +1336,12 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpu=
s)
 {
        unsigned int cpu;
=20
+       for_each_present_cpu(cpu) {
+               if (num_online_cpus() >=3D setup_max_cpus)
+                       break;
+               if (!cpu_online(cpu))
+                       cpu_up(cpu, CPUHP_BRINGUP_WAKE_CPU);
+       }
        for_each_present_cpu(cpu) {
                if (num_online_cpus() >=3D setup_max_cpus)
                        break;
$ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "console=3DttyS0=
  trace_event=3Dcpuhp tp_printk" -display none -serial mon:stdio  -m 2G -M =
q35,accel=3Dkvm,kernel-irqchip=3Dsplit -device intel-iommu,intremap=3Don -s=
mp 40
...
[    0.349968] smp: Bringing up secondary CPUs ...
[    0.350281] cpuhp_enter: cpu: 0001 target:  42 step:   1 (smpboot_create=
_threads)
[    0.351421] cpuhp_exit:  cpu: 0001  state:   1 step:   1 ret: 0
[    0.352074] cpuhp_enter: cpu: 0001 target:  42 step:   2 (perf_event_ini=
t_cpu)
[    0.352276] cpuhp_exit:  cpu: 0001  state:   2 step:   2 ret: 0
[    0.353273] cpuhp_enter: cpu: 0001 target:  42 step:  37 (workqueue_prep=
are_cpu)
[    0.354377] cpuhp_exit:  cpu: 0001  state:  37 step:  37 ret: 0
[    0.355273] cpuhp_enter: cpu: 0001 target:  42 step:  39 (hrtimers_prepa=
re_cpu)
[    0.356271] cpuhp_exit:  cpu: 0001  state:  39 step:  39 ret: 0
[    0.356937] cpuhp_enter: cpu: 0001 target:  42 step:  41 (x2apic_prepare=
_cpu)
[    0.357277] cpuhp_exit:  cpu: 0001  state:  41 step:  41 ret: 0
[    0.358278] cpuhp_enter: cpu: 0002 target:  42 step:   1 (smpboot_create=
_threads)
...
[    0.614278] cpuhp_enter: cpu: 0032 target:  42 step:   1 (smpboot_create=
_threads)
[    0.615610] cpuhp_exit:  cpu: 0032  state:   1 step:   1 ret: 0
[    0.616274] cpuhp_enter: cpu: 0032 target:  42 step:   2 (perf_event_ini=
t_cpu)
[    0.617271] cpuhp_exit:  cpu: 0032  state:   2 step:   2 ret: 0
[    0.618272] cpuhp_enter: cpu: 0032 target:  42 step:  37 (workqueue_prep=
are_cpu)
[    0.619388] cpuhp_exit:  cpu: 0032  state:  37 step:  37 ret: 0
[    0.620273] cpuhp_enter: cpu: 0032 target:  42 step:  39 (hrtimers_prepa=
re_cpu)
[    0.621270] cpuhp_exit:  cpu: 0032  state:  39 step:  39 ret: 0
[    0.622009] cpuhp_enter: cpu: 0032 target:  42 step:  41 (x2apic_prepare=
_cpu)
[    0.622275] cpuhp_exit:  cpu: 0032  state:  41 step:  41 ret: 0
...
[    0.684272] cpuhp_enter: cpu: 0039 target:  42 step:  41 (x2apic_prepare=
_cpu)
[    0.685277] cpuhp_exit:  cpu: 0039  state:  41 step:  41 ret: 0
[    0.685979] cpuhp_enter: cpu: 0001 target: 217 step:  43 (smpcfd_prepare=
_cpu)
[    0.686283] cpuhp_exit:  cpu: 0001  state:  43 step:  43 ret: 0
[    0.687274] cpuhp_enter: cpu: 0001 target: 217 step:  44 (relay_prepare_=
cpu)
[    0.688274] cpuhp_exit:  cpu: 0001  state:  44 step:  44 ret: 0
[    0.689274] cpuhp_enter: cpu: 0001 target: 217 step:  47 (rcutree_prepar=
e_cpu)
[    0.690271] cpuhp_exit:  cpu: 0001  state:  47 step:  47 ret: 0
[    0.690982] cpuhp_multi_enter: cpu: 0001 target: 217 step:  59 (trace_rb=
_cpu_prepare)
[    0.691281] cpuhp_exit:  cpu: 0001  state:  59 step:  59 ret: 0
[    0.692272] cpuhp_multi_enter: cpu: 0001 target: 217 step:  59 (trace_rb=
_cpu_prepare)
[    0.694640] cpuhp_exit:  cpu: 0001  state:  59 step:  59 ret: 0
[    0.695272] cpuhp_multi_enter: cpu: 0001 target: 217 step:  59 (trace_rb=
_cpu_prepare)
[    0.696280] cpuhp_exit:  cpu: 0001  state:  59 step:  59 ret: 0
[    0.697279] cpuhp_enter: cpu: 0001 target: 217 step:  65 (timers_prepare=
_cpu)
[    0.698168] cpuhp_exit:  cpu: 0001  state:  65 step:  65 ret: 0
[    0.698272] cpuhp_enter: cpu: 0001 target: 217 step:  67 (kvmclock_setup=
_percpu)
[    0.699270] cpuhp_exit:  cpu: 0001  state:  67 step:  67 ret: 0
[    0.700272] cpuhp_enter: cpu: 0001 target: 217 step:  88 (bringup_cpu)
[    0.701312] x86: Booting SMP configuration:
[    0.702270] .... node  #0, CPUs:        #1
[    0.127218] kvm-clock: cpu 1, msr 59401041, secondary cpu clock
[    0.127218] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.709281] cpuhp_enter: cpu: 0001 target: 217 step: 147 (smpboot_unpark=
_threads)
[    0.712294] cpuhp_exit:  cpu: 0001  state: 147 step: 147 ret: 0
[    0.714283] cpuhp_enter: cpu: 0001 target: 217 step: 149 (irq_affinity_o=
nline_cpu)
[    0.717292] cpuhp_exit:  cpu: 0001  state: 149 step: 149 ret: 0
[    0.719283] cpuhp_enter: cpu: 0001 target: 217 step: 153 (perf_event_ini=
t_cpu)
[    0.721279] cpuhp_exit:  cpu: 0001  state: 153 step: 153 ret: 0
[    0.724285] cpuhp_enter: cpu: 0001 target: 217 step: 179 (lockup_detecto=
r_online_cpu)
[    0.727279] cpuhp_exit:  cpu: 0001  state: 179 step: 179 ret: 0
[    0.729279] cpuhp_enter: cpu: 0001 target: 217 step: 180 (workqueue_onli=
ne_cpu)
[    0.731309] cpuhp_exit:  cpu: 0001  state: 180 step: 180 ret: 0
[    0.733281] cpuhp_enter: cpu: 0001 target: 217 step: 181 (rcutree_online=
_cpu)
[    0.735276] cpuhp_exit:  cpu: 0001  state: 181 step: 181 ret: 0
[    0.737278] cpuhp_enter: cpu: 0001 target: 217 step: 183 (kvm_cpu_online=
)
[    0.739286] kvm-guest: stealtime: cpu 1, msr 7d46c080
[    0.740274] cpuhp_exit:  cpu: 0001  state: 183 step: 183 ret: 0
[    0.742278] cpuhp_enter: cpu: 0001 target: 217 step: 184 (page_writeback=
_cpu_online)
[    0.744275] cpuhp_exit:  cpu: 0001  state: 184 step: 184 ret: 0
[    0.745277] cpuhp_enter: cpu: 0001 target: 217 step: 185 (vmstat_cpu_onl=
ine)
[    0.747276] cpuhp_exit:  cpu: 0001  state: 185 step: 185 ret: 0
[    0.749280] cpuhp_enter: cpu: 0001 target: 217 step: 216 (sched_cpu_acti=
vate)
[    0.750275] cpuhp_exit:  cpu: 0001  state: 216 step: 216 ret: 0
[    0.752273] cpuhp_exit:  cpu: 0001  state: 217 step:  88 ret: 0
[    0.753030] cpuhp_enter: cpu: 0002 target: 217 step:  43 (smpcfd_prepare=
_cpu)
...
[    2.311273] cpuhp_exit:  cpu: 0031  state: 217 step:  88 ret: 0
[    2.312278] cpuhp_enter: cpu: 0032 target: 217 step:  43 (smpcfd_prepare=
_cpu)
[    2.313119] cpuhp_exit:  cpu: 0032  state:  43 step:  43 ret: 0
[    2.313277] cpuhp_enter: cpu: 0032 target: 217 step:  44 (relay_prepare_=
cpu)
[    2.314275] cpuhp_exit:  cpu: 0032  state:  44 step:  44 ret: 0
[    2.315274] cpuhp_enter: cpu: 0032 target: 217 step:  47 (rcutree_prepar=
e_cpu)
[    2.316104] cpuhp_exit:  cpu: 0032  state:  47 step:  47 ret: 0
[    2.316273] cpuhp_multi_enter: cpu: 0032 target: 217 step:  59 (trace_rb=
_cpu_prepare)
[    2.317292] cpuhp_exit:  cpu: 0032  state:  59 step:  59 ret: 0
[    2.318275] cpuhp_multi_enter: cpu: 0032 target: 217 step:  59 (trace_rb=
_cpu_prepare)
[    2.320401] cpuhp_exit:  cpu: 0032  state:  59 step:  59 ret: 0
[    2.321111] cpuhp_multi_enter: cpu: 0032 target: 217 step:  59 (trace_rb=
_cpu_prepare)
[    2.321286] cpuhp_exit:  cpu: 0032  state:  59 step:  59 ret: 0
[    2.322273] cpuhp_enter: cpu: 0032 target: 217 step:  65 (timers_prepare=
_cpu)
[    2.323271] cpuhp_exit:  cpu: 0032  state:  65 step:  65 ret: 0
[    2.324272] cpuhp_enter: cpu: 0032 target: 217 step:  67 (kvmclock_setup=
_percpu)
[    2.325133] cpuhp_exit:  cpu: 0032  state:  67 step:  67 ret: 0
[    2.325273] cpuhp_enter: cpu: 0032 target: 217 step:  88 (bringup_cpu)
[    2.326292]  #32
[    2.289283] kvm-clock: cpu 32, msr 59401801, secondary cpu clock
[    2.289283] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[    2.289283] #PF: supervisor write access in kernel mode
[    2.289283] #PF: error_code(0x0002) - not-present page
[    2.289283] PGD 0 P4D 0=20
[    2.289283] Oops: 0002 [#1] SMP PTI
[    2.289283] CPU: 32 PID: 0 Comm: swapper/32 Not tainted 5.10.0+ #745
[    2.289283] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
4.0-1.fc33 04/01/2014
[    2.289283] RIP: 0010:init_x2apic_ldr+0xa0/0xb0
[    2.289283] Code: 89 2d 9c 81 fb 72 65 8b 15 cd 12 fb 72 89 d2 f0 48 0f =
ab 50 08 5b 5d c3 48 8b 05 a3 7b 09 02 48 c7 05 98 7b 09 02 00 00 00 00 <89=
> 18 eb cd 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 89
[    2.289283] RSP: 0000:ffffb15e8016fec0 EFLAGS: 00010046
[    2.289283] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00040
[    2.289283] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 00000000000=
00028
[    2.289283] RBP: 0000000000018428 R08: 0000000000000000 R09: 00000000000=
00028
[    2.289283] R10: ffffb15e8016fd78 R11: ffff88ca7ff28368 R12: 00000000000=
00200
[    2.289283] R13: 0000000000000020 R14: 0000000000000000 R15: 00000000000=
00000
[    2.289283] FS:  0000000000000000(0000) GS:ffff88ca7dc00000(0000) knlGS:=
0000000000000000
[    2.289283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.289283] CR2: 0000000000000000 CR3: 0000000058610000 CR4: 00000000000=
006a0
[    2.289283] Call Trace:
[    2.289283]  setup_local_APIC+0x88/0x320
[    2.289283]  ? printk+0x48/0x4a
[    2.289283]  apic_ap_setup+0xa/0x20
[    2.289283]  start_secondary+0x2f/0x130
[    2.289283]  secondary_startup_64_no_verify+0xc2/0xcb
[    2.289283] Modules linked in:
[    2.289283] CR2: 0000000000000000
[    2.289283] ---[ end trace 676dcdbf63e55075 ]---
[    2.289283] RIP: 0010:init_x2apic_ldr+0xa0/0xb0
[    2.289283] Code: 89 2d 9c 81 fb 72 65 8b 15 cd 12 fb 72 89 d2 f0 48 0f =
ab 50 08 5b 5d c3 48 8b 05 a3 7b 09 02 48 c7 05 98 7b 09 02 00 00 00 00 <89=
> 18 eb cd 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 89
[    2.289283] RSP: 0000:ffffb15e8016fec0 EFLAGS: 00010046
[    2.289283] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00040
[    2.289283] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 00000000000=
00028
[    2.289283] RBP: 0000000000018428 R08: 0000000000000000 R09: 00000000000=
00028
[    2.289283] R10: ffffb15e8016fd78 R11: ffff88ca7ff28368 R12: 00000000000=
00200
[    2.289283] R13: 0000000000000020 R14: 0000000000000000 R15: 00000000000=
00000
[    2.289283] FS:  0000000000000000(0000) GS:ffff88ca7dc00000(0000) knlGS:=
0000000000000000
[    2.289283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.289283] CR2: 0000000000000000 CR3: 0000000058610000 CR4: 00000000000=
006a0
[    2.289283] Kernel panic - not syncing: Attempted to kill the idle task!
[    2.289283] ---[ end Kernel panic - not syncing: Attempted to kill the i=
dle task! ]---

--=-unmwRyp8fapjyUfijXcC
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEw
MTIxMTU0MjE5WjAvBgkqhkiG9w0BCQQxIgQgdS9dcA8yiHaJPlCSO1gmVQc0v80uO8K83Yx7AUyS
1L8wgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAAgnck5vJ7GMtNEFVAKEQGj59g76q1Kfw0aKYZAOKvKH4g6onWoA2Kx2EWMgxweM
muNl/60DGypofVGrLSpMIDlDBaDSg4w+RnYYQ8MIFXQTbCTvFCHfB7/glCj73OoqDdHZK/MZKZQ/
22i1395uPakge1FZWGnYCePPvCgB61FhNx39jWWTpVRwM/zORWoslgkXOAsAncVNVGkjDTMg8lWM
eKx+Ep5x7zJeWE7U4beg5B2gYo4f1YVaJU5uEaVIXtLv4M8J4uTAoOTjB6ai9jM0sDIe1QJctVVE
yZnKIRx3sI/SgLCgrWE19YBe5lMN82LCUBIvDw8jYIIc0V81kb4AAAAAAAA=


--=-unmwRyp8fapjyUfijXcC--

