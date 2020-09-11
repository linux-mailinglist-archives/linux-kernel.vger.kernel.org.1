Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CC267628
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKWt2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Sep 2020 18:49:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40006 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKWtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:49:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kGrr4-0055zC-1y; Fri, 11 Sep 2020 16:49:18 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45648 helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kGrr2-0003sp-On; Fri, 11 Sep 2020 16:49:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
        <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
        <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
        <20200821110848.6c3183d1@oasis.local.home>
        <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
        <20200821170334.73b52fdd@oasis.local.home>
        <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
        <20200907114618.GR2674@hirez.programming.kicks-ass.net>
        <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
        <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
        <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
        <51f3b288-260b-a800-6a47-51d93f892c3d@jv-coder.de>
Date:   Fri, 11 Sep 2020 17:48:59 -0500
In-Reply-To: <51f3b288-260b-a800-6a47-51d93f892c3d@jv-coder.de> (Joerg
        Vehlow's message of "Wed, 9 Sep 2020 07:46:07 +0200")
Message-ID: <87sgbo3p5w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1kGrr2-0003sp-On;;;mid=<87sgbo3p5w.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192kHHHXBdulvVwN+LmBnC/lhvjZagpaUw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_Unicode,
        XM_Sft_Co_L33T autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Sft_Co_L33T No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Joerg Vehlow <lkml@jv-coder.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 884 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (1.5%), b_tie_ro: 12 (1.3%), parse: 1.60
        (0.2%), extract_message_metadata: 16 (1.9%), get_uri_detail_list: 4.2
        (0.5%), tests_pri_-1000: 4.5 (0.5%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 274 (31.0%), check_bayes:
        270 (30.6%), b_tokenize: 17 (1.9%), b_tok_get_all: 178 (20.2%),
        b_comp_prob: 4.5 (0.5%), b_tok_touch_all: 64 (7.2%), b_finish: 1.63
        (0.2%), tests_pri_0: 554 (62.7%), check_dkim_signature: 1.78 (0.2%),
        check_dkim_adsp: 4.0 (0.5%), poll_dns_idle: 1.81 (0.2%), tests_pri_10:
        3.8 (0.4%), tests_pri_500: 9 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt context
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
> here is the new version of the patch based on Peters suggestion
> It looks like it works fine. I added the BUG_ON to __crash_kexec, because it is
> a precondition, that panic_cpu is set correctly, otherwise the whole locking
> logic fails.
>
> The mutex_trylock can still be used, because it is only in syscall context and
> no interrupt context.

What is this patch supposed to be doing?

What bug is it fixing?

A BUG_ON that triggers inside of BUG_ONs seems not just suspect but
outright impossible to make use of.


I get the feeling skimming this that it is time to sort out and simplify
the locking here, rather than make it more complex, and more likely to
fail.

I get the feeling that over the years somehow the assumption that the
rest of the kernel is broken and that we need to get out of the broken
kernel as fast and as simply as possible has been lost.

Eric



> ---
>  kernel/kexec.c          |  8 ++--
>  kernel/kexec_core.c     | 86 +++++++++++++++++++++++++++--------------
>  kernel/kexec_file.c     |  4 +-
>  kernel/kexec_internal.h |  6 ++-
>  4 files changed, 69 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index f977786fe498..118a012aeac2 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -255,12 +255,12 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned
> long, nr_segments,
>       *
>       * KISS: always take the mutex.
>       */
> -    if (!mutex_trylock(&kexec_mutex))
> +    if (!kexec_trylock())
>          return -EBUSY;
>
>      result = do_kexec_load(entry, nr_segments, segments, flags);
>
> -    mutex_unlock(&kexec_mutex);
> +    kexec_unlock();
>
>      return result;
>  }
> @@ -309,12 +309,12 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
>       *
>       * KISS: always take the mutex.
>       */
> -    if (!mutex_trylock(&kexec_mutex))
> +    if (!kexec_trylock())
>          return -EBUSY;
>
>      result = do_kexec_load(entry, nr_segments, ksegments, flags);
>
> -    mutex_unlock(&kexec_mutex);
> +    kexec_unlock();
>
>      return result;
>  }
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c19c0dad1ebe..71682a33b1ba 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -45,7 +45,7 @@
>  #include <crypto/sha.h>
>  #include "kexec_internal.h"
>
> -DEFINE_MUTEX(kexec_mutex);
> +static DEFINE_MUTEX(kexec_mutex);
>
>  /* Per cpu memory for storing cpu states in case of system crash. */
>  note_buf_t __percpu *crash_notes;
> @@ -70,6 +70,43 @@ struct resource crashk_low_res = {
>      .desc  = IORES_DESC_CRASH_KERNEL
>  };
>
> +void kexec_lock(void)
> +{
> +    /*
> +     * LOCK kexec_mutex        cmpxchg(&panic_cpu, INVALID, cpu)
> +     *   MB                  MB
> +     * panic_cpu == INVALID        kexec_mutex == LOCKED
> +     *
> +     * Ensures either we observe the cmpxchg, or crash_kernel() observes
> +     * our lock acquisition.
> +     */
> +    mutex_lock(&kexec_mutex);
> +    smp_mb();
> +    atomic_cond_read_acquire(&panic_cpu, VAL == PANIC_CPU_INVALID);
> +}
> +
> +int kexec_trylock(void) {
> +    if (!mutex_trylock(&kexec_mutex)) {
> +        return 0;
> +    }
> +    smp_mb();
> +    if (atomic_read(&panic_cpu) != PANIC_CPU_INVALID) {
> +         mutex_unlock(&kexec_mutex);
> +         return 0;
> +    }
> +    return 1;
> +}
> +
> +void kexec_unlock(void)
> +{
> +    mutex_unlock(&kexec_mutex);
> +}
> +
> +int kexec_is_locked(void)
> +{
> +    return mutex_is_locked(&kexec_mutex);
> +}
> +
>  int kexec_should_crash(struct task_struct *p)
>  {
>      /*
> @@ -943,24 +980,15 @@ int kexec_load_disabled;
>   */
>  void __noclone __crash_kexec(struct pt_regs *regs)
>  {
> -    /* Take the kexec_mutex here to prevent sys_kexec_load
> -     * running on one cpu from replacing the crash kernel
> -     * we are using after a panic on a different cpu.
> -     *
> -     * If the crash kernel was not located in a fixed area
> -     * of memory the xchg(&kexec_crash_image) would be
> -     * sufficient.  But since I reuse the memory...
> -     */
> -    if (mutex_trylock(&kexec_mutex)) {
> -        if (kexec_crash_image) {
> -            struct pt_regs fixed_regs;
> -
> -            crash_setup_regs(&fixed_regs, regs);
> -            crash_save_vmcoreinfo();
> -            machine_crash_shutdown(&fixed_regs);
> -            machine_kexec(kexec_crash_image);
> -        }
> -        mutex_unlock(&kexec_mutex);
> +    BUG_ON(atomic_read(&panic_cpu) != raw_smp_processor_id());
> +
> +    if (!kexec_is_locked() && kexec_crash_image) {
> +        struct pt_regs fixed_regs;
> +
> +        crash_setup_regs(&fixed_regs, regs);
> +        crash_save_vmcoreinfo();
> +        machine_crash_shutdown(&fixed_regs);
> +        machine_kexec(kexec_crash_image);
>      }
>  }
>  STACK_FRAME_NON_STANDARD(__crash_kexec);
> @@ -977,9 +1005,11 @@ void crash_kexec(struct pt_regs *regs)
>      this_cpu = raw_smp_processor_id();
>      old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
>      if (old_cpu == PANIC_CPU_INVALID) {
> -        /* This is the 1st CPU which comes here, so go ahead. */
> -        printk_safe_flush_on_panic();
> -        __crash_kexec(regs);
> +        if (!kexec_is_locked()) {
> +            /* This is the 1st CPU which comes here, so go ahead. */
> +            printk_safe_flush_on_panic();
> +            __crash_kexec(regs);
> +        }
>
>          /*
>           * Reset panic_cpu to allow another panic()/crash_kexec()
> @@ -993,10 +1023,10 @@ size_t crash_get_memory_size(void)
>  {
>      size_t size = 0;
>
> -    mutex_lock(&kexec_mutex);
> +    kexec_lock();
>      if (crashk_res.end != crashk_res.start)
>          size = resource_size(&crashk_res);
> -    mutex_unlock(&kexec_mutex);
> +    kexec_unlock();
>      return size;
>  }
>
> @@ -1016,7 +1046,7 @@ int crash_shrink_memory(unsigned long new_size)
>      unsigned long old_size;
>      struct resource *ram_res;
>
> -    mutex_lock(&kexec_mutex);
> +    kexec_lock();
>
>      if (kexec_crash_image) {
>          ret = -ENOENT;
> @@ -1054,7 +1084,7 @@ int crash_shrink_memory(unsigned long new_size)
>      insert_resource(&iomem_resource, ram_res);
>
>  unlock:
> -    mutex_unlock(&kexec_mutex);
> +    kexec_unlock();
>      return ret;
>  }
>
> @@ -1126,7 +1156,7 @@ int kernel_kexec(void)
>  {
>      int error = 0;
>
> -    if (!mutex_trylock(&kexec_mutex))
> +    if (!kexec_trylock())
>          return -EBUSY;
>      if (!kexec_image) {
>          error = -EINVAL;
> @@ -1203,7 +1233,7 @@ int kernel_kexec(void)
>  #endif
>
>   Unlock:
> -    mutex_unlock(&kexec_mutex);
> +    kexec_unlock();
>      return error;
>  }
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index ca40bef75a61..d40b0aedc187 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -362,7 +362,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int,
> initrd_fd,
>
>      image = NULL;
>
> -    if (!mutex_trylock(&kexec_mutex))
> +    if (!kexec_trylock())
>          return -EBUSY;
>
>      dest_image = &kexec_image;
> @@ -434,7 +434,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int,
> initrd_fd,
>      if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
>          arch_kexec_protect_crashkres();
>
> -    mutex_unlock(&kexec_mutex);
> +    kexec_unlock();
>      kimage_free(image);
>      return ret;
>  }
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 39d30ccf8d87..2c1683cb1082 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -15,7 +15,11 @@ int kimage_is_destination_range(struct kimage *image,
>
>  int machine_kexec_post_load(struct kimage *image);
>
> -extern struct mutex kexec_mutex;
> +void kexec_lock(void);
> +int kexec_trylock(void);
> +void kexec_unlock(void);
> +int kexec_is_locked(void);
> +
>
>  #ifdef CONFIG_KEXEC_FILE
>  #include <linux/purgatory.h>
