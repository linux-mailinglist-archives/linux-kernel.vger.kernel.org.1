Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14D02FB85E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbhASMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390671AbhASMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:15:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31255C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B7xTIIM1WG2QPyRE/OdE9wz+PmLE9Ow6SmuRp9tBvKk=; b=zEXM6A0s1cXcYwb8ZC79a+BnTf
        +0m4rDKs46uuSScDJK1Wajuy0Xf1QC8zLBCjPI7O+viUx5m6qSKcMqcSet2eKOBfOL+ejU4SaLvRL
        7xEtOTq8d7GTzovDy779IUMVN+mrUvjTf7ccPYDiKck2yEsGeam5leQIkPDxVkNRsu7goOI78VTfX
        LbDOJGl3s9sOEViDyz/1Y+d79AsVT4guqUXvASv+DiPvUF3ii9hy9+VctoDw2VAlvkk58lnEsGeIR
        sVoCgVf8EBIp1WDgzVH6J1JUw5rYvLX4QwaldQQ0SV0RpVr2BJ36kK6Hem/p6JtvhFssWRsXRflMg
        LozujZhg==;
Received: from dyn-234.woodhou.se ([90.155.92.234] helo=u3832b3a9db3152.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1puC-00006t-JD; Tue, 19 Jan 2021 12:14:40 +0000
Message-ID: <8ac72d7b287ed1058b2dec3301578238aff0abdd.camel@infradead.org>
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
Date:   Tue, 19 Jan 2021 12:12:01 +0000
In-Reply-To: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-BhGsjWsiYKV/h28auqhi"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BhGsjWsiYKV/h28auqhi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-15 at 22:20 +0100, Thomas Gleixner wrote:
> Since the rewrite of the CPU hotplug infrastructure to a state machine
> it's pretty obvious that the bringup of APs can changed from the fully
> serialized:
>=20
>      for_each_present_cpu(cpu) {
>         if (!cpu_online(cpu))
>            cpu_up(cpu, CPUHP_ONLINE);
>      }
>=20
> to
>=20
>      for_each_present_cpu(cpu) {
>         if (!cpu_online(cpu))
>            cpu_up(cpu, CPUHP_KICK_CPU);
>      }
>=20
>      for_each_present_cpu(cpu) {
>         if (!cpu_active(cpu))
>            cpu_up(cpu, CPUHP_ONLINE);
>      }
>=20
> The CPUHP_KICK_CPU state does not exist today, but it's just the logical
> consequence of the state machine. It's basically splitting __cpu_up()
> into:
>=20
> __cpu_kick()
> {
>     prepare();
>     arch_kick_remote_cpu();     -> Send IPI/NMI, Firmware call .....
> }
>    =20
> __cpu_wait_online()
> {
>     wait_until_cpu_online();
>     do_further_stuff();
> }
>=20
> There is some more to it than just blindly splitting it up at the
> architecture level.

We've been playing with this a little. There's a proof-of-concept hack
below; don't look too hard because it's only really for figuring out
the timing etc.

Basically we ripped out the 'wait' parts of the x86 do_boot_cpu() into
a separate function do_wait_cpu(). There are four phases to the wait.

 =E2=80=A2 Wait for the AP to turn up in cpu_initialized_mask, set its bit =
in
   cpu_callout_mask to allow it to run the AP thread.
 =E2=80=A2 Wait for it to finish init and show up in cpu_callin_mask.
 =E2=80=A2 check_tsc_sync_source()
 =E2=80=A2 Wait for cpu_online(cpu)

There's an EARLY_INIT macro which controls whether the early bringup
call actually *does* anything, or whether it's left until bringup_cpu()
as the current code does. It allows a simple comparison of the two.

First we tested under qemu (on a Skylake EC2 c5.metal instance). The
do_boot_cpu() actually sending the IPIs took ~300k cycles itself.
Without EARLY_INIT we see timing for the four wait phases along the
lines of:

[    0.285312] CPU#10 up in     192950,    952898,  60014786,        28 (  =
61160662)
[    0.288311] CPU#11 up in     181092,    962704,  60010432,        30 (  =
61154258)
[    0.291312] CPU#12 up in     386080,    970416,  60013956,        28 (  =
61370480)
[    0.294311] CPU#13 up in     372782,    964506,  60010564,        28 (  =
61347880)
[    0.297312] CPU#14 up in     389602,    976280,  60013046,        28 (  =
61378956)
[    0.300312] CPU#15 up in     213132,    968148,  60012138,        28 (  =
61193446)

If we define EARLY_INIT then that first phase of waiting for the CPU
add itself is fairly much instantaneous, which is precisely what we
were hoping for. We also seem to save about 300k cycles on the AP
bringup too. It's just that it *all* pales into insignificance with
whatever it's doing to synchronise the TSC for 60M cycles.

[    0.338829] CPU#10 up in        600,    689054,  60025522,        28 (  =
60715204)
[    0.341829] CPU#11 up in        610,    635346,  60019390,        28 (  =
60655374)
[    0.343829] CPU#12 up in        632,    619352,  60020728,        28 (  =
60640740)
[    0.346829] CPU#13 up in        602,    514234,  60025402,        26 (  =
60540264)
[    0.348830] CPU#14 up in        608,    621058,  60025952,        26 (  =
60647644)
[    0.351829] CPU#15 up in        600,    624690,  60021526,       410 (  =
60647226)

Testing on real hardware has been more interesting and less useful so
far. We started with the CPUHP_BRINGUP_KICK_CPU state being
*immediately* before CPUHP_BRINGUP_CPU. On my 28-thread Haswell box,
that didn't come up at all even without actually *doing* anything in
the pre-bringup phase. Merely bringing all the AP threads up through
the various CPUHP_PREPARE_foo stages before actually bringing them
online, was enough to break it. I have no serial port on this box so we
haven't get worked out why; I've resorted to putting the
CPUHP_BRINGUP_KICK_CPU state before CPUHP_WORKQUEUE_PREP instead.

That lets it boot without the EARLY_INIT at least (so it's basically a
no-op), and I get these timings. Looks like there's 3-4M cycles to be
had by the parallel SIPI/INIT, but the *first* thread of each core is
also taking another 8M cycles and it might be worth doing *those* in
parallel too. And Thomas I think that waiting for the AP to bring
itself up is the part you meant was pointlessly differently
reimplemented across architectures? So the way forward there might be
to offer a generic CPUHP state for that, for architectures to plug into
and ditch their own tracking.

[    0.311581] CPU#1 up in    4057008,   8820492,      1828,       808 (  1=
2880136)
[    0.316802] CPU#2 up in    3885080,   8738092,      1792,       904 (  1=
2625868)
[    0.321674] CPU#3 up in    3468276,   8244880,      1724,       860 (  1=
1715740)
[    0.326609] CPU#4 up in    3565216,   8357876,      1808,       984 (  1=
1925884)
[    0.331565] CPU#5 up in    3566916,   8367340,      1836,       708 (  1=
1936800)
[    0.336446] CPU#6 up in    3465324,   8249512,      1756,       796 (  1=
1717388)
[    0.341337] CPU#7 up in    3518268,   8313476,      1572,      1072 (  1=
1834388)
[    0.346196] CPU#8 up in    3479444,   8260244,      1648,       608 (  1=
1741944)
[    0.351068] CPU#9 up in    3475692,   8269092,      1568,       908 (  1=
1747260)
[    0.355968] CPU#10 up in    3534648,   8336648,      1488,       864 (  =
11873648)
[    0.361306] CPU#11 up in    4028288,   8932216,      1632,       692 (  =
12962828)
[    0.366657] CPU#12 up in    4046256,   8941736,      1624,      1164 (  =
12990780)
[    0.371985] CPU#13 up in    4012912,   8922192,      1700,       964 (  =
12937768)
[    0.373813] CPU#14 up in    3794196,    300948,      1520,      1300 (  =
 4097964)
[    0.374936] CPU#15 up in    3853616,    265080,      1428,       784 (  =
 4120908)
[    0.376843] CPU#16 up in    3841572,    261448,      1428,       528 (  =
 4104976)
[    0.378597] CPU#17 up in    3420856,    258888,      1272,       872 (  =
 3681888)
[    0.380403] CPU#18 up in    3516220,    259840,      2152,       648 (  =
 3778860)
[    0.382210] CPU#19 up in    3503316,    262876,      1720,       500 (  =
 3768412)
[    0.383975] CPU#20 up in    3421752,    263248,      1472,       764 (  =
 3687236)
[    0.385747] CPU#21 up in    3434744,    272240,      1352,       716 (  =
 3709052)
[    0.387516] CPU#22 up in    3427700,    273900,      1260,       820 (  =
 3703680)
[    0.389300] CPU#23 up in    3457724,    269708,      1328,       816 (  =
 3729576)
[    0.391089] CPU#24 up in    3466012,    269136,      1296,       824 (  =
 3737268)
[    0.393067] CPU#25 up in    3970568,    279256,      1432,       892 (  =
 4252148)
[    0.395042] CPU#26 up in    3977228,    283956,      1656,       772 (  =
 4263612)
[    0.397020] CPU#27 up in    3946448,    288852,      1600,       648 (  =
 4237548)

When I enabled EARLY_INIT it didn't boot; I need to hook up some box
with a serial port to make more meaningful progress there, but figured
it was worth sharing the findings so far.

Here's the hack we're testing with, for reference. It's kind of ugly
but you can see where it's going. Note that the CMOS mangling for the
warm reset vector is going to need to be lifted out of the per-cpu
loop, and done *once* at startup and torn down once in smp_cpus_done.
Except that it also needs to be done before/after a hotplug cpu up;
we'll have to come back to that but we've just shifted it to
native_smp_cpus_done() for testing for now.


diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7f57ede3cb8e..99d1fa254921 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -308,7 +308,7 @@ static void kvm_register_steal_time(void)
 		return;
=20
 	wrmsrl(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
-	pr_info("stealtime: cpu %d, msr %llx\n", cpu,
+	if (0)	pr_info("stealtime: cpu %d, msr %llx\n", cpu,
 		(unsigned long long) slow_virt_to_phys(st));
 }
=20
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index aa593743acf6..79a5c26c376e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -108,7 +108,7 @@ static inline void kvm_sched_clock_init(bool stable)
 	kvm_sched_clock_offset =3D kvm_clock_read();
 	pv_ops.time.sched_clock =3D kvm_sched_clock_read;
=20
-	pr_info("kvm-clock: using sched offset of %llu cycles",
+	if (0) pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
=20
 	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
@@ -184,7 +184,7 @@ static void kvm_register_clock(char *txt)
=20
 	pa =3D slow_virt_to_phys(&src->pvti) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
-	pr_info("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
+	if (0)	pr_info("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa,=
 txt);
 }
=20
 static void kvm_save_sched_clock_state(void)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2e6046..42f479979b52 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -360,7 +360,7 @@ int topology_update_die_map(unsigned int die, unsigned =
int cpu)
 		goto found;
=20
 	new =3D logical_die++;
-	if (new !=3D die) {
+	if (0 && new !=3D die) {
 		pr_info("CPU %u Converting physical %u to logical die %u\n",
 			cpu, die, new);
 	}
@@ -1028,9 +1028,7 @@ static int do_boot_cpu(int apicid, int cpu, struct ta=
sk_struct *idle,
 {
 	/* start_ip had better be page-aligned! */
 	unsigned long start_ip =3D real_mode_header->trampoline_start;
-
 	unsigned long boot_error =3D 0;
-	unsigned long timeout;
=20
 	idle->thread.sp =3D (unsigned long)task_pt_regs(idle);
 	early_gdt_descr.address =3D (unsigned long)get_cpu_gdt_rw(cpu);
@@ -1083,55 +1081,71 @@ static int do_boot_cpu(int apicid, int cpu, struct =
task_struct *idle,
 		boot_error =3D wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
 						     cpu0_nmi_registered);
=20
-	if (!boot_error) {
-		/*
-		 * Wait 10s total for first sign of life from AP
-		 */
-		boot_error =3D -1;
-		timeout =3D jiffies + 10*HZ;
-		while (time_before(jiffies, timeout)) {
-			if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
-				/*
-				 * Tell AP to proceed with initialization
-				 */
-				cpumask_set_cpu(cpu, cpu_callout_mask);
-				boot_error =3D 0;
-				break;
-			}
-			schedule();
-		}
-	}
+	return boot_error;
+}
=20
-	if (!boot_error) {
-		/*
-		 * Wait till AP completes initial initialization
-		 */
-		while (!cpumask_test_cpu(cpu, cpu_callin_mask)) {
+int do_wait_cpu(unsigned int cpu)
+{
+	unsigned long flags;
+	unsigned long timeout;
+	cycles_t t1 =3D get_cycles(), t2, t3, t4, t5;
+	/*
+	 * Wait 10s total for first sign of life from AP
+	 */
+	int err =3D -1;
+	timeout =3D jiffies + 10*HZ;
+	while (time_before(jiffies, timeout)) {
+		if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
 			/*
-			 * Allow other tasks to run while we wait for the
-			 * AP to come online. This also gives a chance
-			 * for the MTRR work(triggered by the AP coming online)
-			 * to be completed in the stop machine context.
+			 * Tell AP to proceed with initialization
 			 */
-			schedule();
+			cpumask_set_cpu(cpu, cpu_callout_mask);
+			err =3D 0;
+			break;
 		}
+		schedule();
 	}
=20
-	if (x86_platform.legacy.warm_reset) {
+	if (err)
+		return err;
+	t2 =3D get_cycles();
+	/*
+	 * Wait till AP completes initial initialization
+	 */
+	while (!cpumask_test_cpu(cpu, cpu_callin_mask)) {
 		/*
-		 * Cleanup possible dangling ends...
+		 * Allow other tasks to run while we wait for the
+		 * AP to come online. This also gives a chance
+		 * for the MTRR work(triggered by the AP coming online)
+		 * to be completed in the stop machine context.
 		 */
-		smpboot_restore_warm_reset_vector();
+		schedule();
 	}
=20
-	return boot_error;
+	/*
+	 * Check TSC synchronization with the AP (keep irqs disabled
+	 * while doing so):
+	 */
+	t3 =3D get_cycles();
+	local_irq_save(flags);
+	check_tsc_sync_source(cpu);
+	local_irq_restore(flags);
+	t4 =3D get_cycles();
+	while (!cpu_online(cpu)) {
+		cpu_relax();
+		touch_nmi_watchdog();
+	}
+	t5 =3D get_cycles();
+
+	printk("CPU#%d up in %10lld,%10lld,%10lld,%10lld (%10lld)\n", cpu,
+	       t2-t1, t3-t2, t4-t3, t5-t4, t5-t1);
+	return 0;
 }
=20
-int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+int do_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int apicid =3D apic->cpu_present_to_apicid(cpu);
 	int cpu0_nmi_registered =3D 0;
-	unsigned long flags;
 	int err, ret =3D 0;
=20
 	lockdep_assert_irqs_enabled();
@@ -1178,19 +1192,6 @@ int native_cpu_up(unsigned int cpu, struct task_stru=
ct *tidle)
 		goto unreg_nmi;
 	}
=20
-	/*
-	 * Check TSC synchronization with the AP (keep irqs disabled
-	 * while doing so):
-	 */
-	local_irq_save(flags);
-	check_tsc_sync_source(cpu);
-	local_irq_restore(flags);
-
-	while (!cpu_online(cpu)) {
-		cpu_relax();
-		touch_nmi_watchdog();
-	}
-
 unreg_nmi:
 	/*
 	 * Clean up the nmi handler. Do this after the callin and callout sync
@@ -1202,6 +1203,31 @@ int native_cpu_up(unsigned int cpu, struct task_stru=
ct *tidle)
 	return ret;
 }
=20
+#define EARLY_INIT
+
+int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	int ret;
+
+#ifndef EARLY_INIT
+	ret =3D do_cpu_up(cpu, tidle);
+	if (ret)
+		return ret;
+#endif
+	ret =3D do_wait_cpu(cpu);
+	return ret;
+}
+
+int __cpu_init(unsigned int cpu, struct task_struct *tidle)
+{
+	int ret =3D 0;
+
+#ifdef EARLY_INIT
+	ret =3D do_cpu_up(cpu, tidle);
+#endif
+	return ret;
+}
+
 /**
  * arch_disable_smp_support() - disables SMP support for x86 at runtime
  */
@@ -1415,6 +1441,13 @@ void __init native_smp_cpus_done(unsigned int max_cp=
us)
 {
 	pr_debug("Boot done\n");
=20
+	if (x86_platform.legacy.warm_reset) {
+		/*
+		 * Cleanup possible dangling ends...
+		 */
+		smpboot_restore_warm_reset_vector();
+	}
+
 	calculate_max_logical_packages();
=20
 	if (x86_has_numa_in_package)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bc56287a1ed1..cdea060b1009 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -61,6 +61,7 @@ enum cpuhp_state {
 	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
+	CPUHP_BRINGUP_KICK_CPU,		/* Asynchronously kick/wake/INIT CPU */
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -92,7 +93,7 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
-	CPUHP_BRINGUP_CPU,
+	CPUHP_BRINGUP_CPU,		/* Wait for CPU to actually respond */
 	CPUHP_AP_IDLE_DEAD,
 	CPUHP_AP_OFFLINE,
 	CPUHP_AP_SCHED_STARTING,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2b8d7a5db383..17881f836de6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -545,11 +545,36 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	return cpuhp_kick_ap(st, st->target);
 }
=20
-static int bringup_cpu(unsigned int cpu)
+extern int __cpu_init(unsigned int cpu, struct task_struct *tidle);
+static int bringup_kick_cpu(unsigned int cpu)
 {
 	struct task_struct *idle =3D idle_thread_get(cpu);
 	int ret;
+	cycles_t t =3D get_cycles();
+	/*
+	 * Some architectures have to walk the irq descriptors to
+	 * setup the vector space for the cpu which comes online.
+	 * Prevent irq alloc/free across the bringup.
+	 */
+	irq_lock_sparse();
+
+	/* Arch-specific enabling code. */
+	ret =3D __cpu_init(cpu, idle);
+	irq_unlock_sparse();
+
+	t =3D get_cycles() - t;
+	printk("bringup_kick_cpu %d in %ld cycles\n", cpu, t);
+	if (ret)
+		return ret;
+	return 0;
+}
=20
+static int bringup_cpu(unsigned int cpu)
+{
+	struct task_struct *idle =3D idle_thread_get(cpu);
+	int ret;
+	cycles_t t2, t =3D get_cycles();
+=09
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
@@ -562,7 +587,12 @@ static int bringup_cpu(unsigned int cpu)
 	irq_unlock_sparse();
 	if (ret)
 		return ret;
-	return bringup_wait_for_ap(cpu);
+	t2 =3D get_cycles() - t;
+	ret =3D bringup_wait_for_ap(cpu);
+	t =3D get_cycles() - t;
+	printk("bringup_cpu %d in %ld,%ld cycles\n", cpu, t2, t -t2);
+
+	return ret;
 }
=20
 static int finish_cpu(unsigned int cpu)
@@ -1336,6 +1366,13 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpu=
s)
 {
 	unsigned int cpu;
=20
+	for_each_present_cpu(cpu) {
+		if (num_online_cpus() >=3D setup_max_cpus)
+			break;
+		if (!cpu_online(cpu))
+			cpu_up(cpu, CPUHP_BRINGUP_KICK_CPU);
+	}
+
 	for_each_present_cpu(cpu) {
 		if (num_online_cpus() >=3D setup_max_cpus)
 			break;
@@ -1565,7 +1602,13 @@ static struct cpuhp_step cpuhp_hp_states[] =3D {
 		.startup.single		=3D timers_prepare_cpu,
 		.teardown.single	=3D timers_dead_cpu,
 	},
-	/* Kicks the plugged cpu into life */
+	/* Asynchronously kicks the plugged cpu into life */
+	[CPUHP_BRINGUP_KICK_CPU] =3D {
+		.name			=3D "cpu:kick",
+		.startup.single		=3D bringup_kick_cpu,
+		.cant_stop		=3D true,
+	},
+	/* Wait for woken CPU to be responding */
 	[CPUHP_BRINGUP_CPU] =3D {
 		.name			=3D "cpu:bringup",
 		.startup.single		=3D bringup_cpu,
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d17501433be..2d07d1c42789 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -807,6 +807,8 @@ void __init smp_init(void)
=20
 	pr_info("Bringing up secondary CPUs ...\n");
=20
+	//	smp_cpus_start(setup_max_cpus);
+
 	bringup_nonboot_cpus(setup_max_cpus);
=20
 	num_nodes =3D num_online_nodes();


--=-BhGsjWsiYKV/h28auqhi
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
MTE5MTIxMjAxWjAvBgkqhkiG9w0BCQQxIgQgrKIy4IKhekyOZPLjS6G/nOYfP4gfm8xfOuik2J9q
gS4wgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAGWN0WqS88C3GKPTQHqRTF73/j0vNLQKZRo8aZDo3kxBJYhxNrXb5XhslgSLiWWM
KA2Eo5PuB7OWSxHli8p6O0cHp9JZtIGeAS427fu55bSjTSaYMVl1tNMRn6KFYscRc9jDpIs1KC5V
H3/2C+cbck1x0PWjkO8zFrvW75hcCFkigsHas2laxPOtMRAzrNsRkK7Q6z8uPYpkxLoeflyd+NJl
ahxuZYuYiEU6emCqRyhp2mv0RPtcseUnkTieMRJreNDCPSqq/qLLD+21Wpo3jk0gfrAKOafHX9FH
t55X4BZXyc+O2TPysmSWorh9yRS8v06DXnFQNvIHJdtJrsbyNJMAAAAAAAA=


--=-BhGsjWsiYKV/h28auqhi--

