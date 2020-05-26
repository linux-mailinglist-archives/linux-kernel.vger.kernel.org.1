Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494431D2C50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgENKPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:15:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgENKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:15:47 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZAtx-0007l8-T6; Thu, 14 May 2020 10:15:42 +0000
Date:   Thu, 14 May 2020 12:15:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Message-ID: <20200514101540.25hvle74w63t66fs@wittgenstein>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
 <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
 <20200514100459.pt7dxq2faghdds2c@wittgenstein>
 <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:08:27PM +0200, John Paul Adrian Glaubitz wrote:
> On 5/14/20 12:04 PM, Christian Brauner wrote:
> > So that's interesting because systemd doesn't support itanium correctly afaict.
> > They have a raw_clone() function that they use which is not tailored to
> > ia64. __NR_clone should be defined as so to hit clone2() but they don't
> > pass a stack size argument down which is invalid on ia64:
> Ah, I wasn't aware of this limitation. I'm surprised the systemd testsuite passes
> then on ia64.
> 
> On sparc64, Michael Karcher provided the hand-written assembly you quoted to
> fix the raw_clone() on this architecture.
> 
> I assume we could do the same on ia64?

I think the following should be correct:

(Probably worth checking that __NR_clone and __NR_clone2 are the same
for ia64. Also note, that __NR_clone was _never_ supported by glibc on
ia64. They even have this comment:

/* clone is not supported under Linux/ia64, use clone2. */
)

static inline pid_t raw_clone(unsigned long flags) {
        pid_t ret;

        assert((flags & (CLONE_VM|CLONE_PARENT_SETTID|CLONE_CHILD_SETTID|
                         CLONE_CHILD_CLEARTID|CLONE_SETTLS)) == 0);
#if defined(__s390x__) || defined(__s390__) || defined(__CRIS__)
        /* On s390/s390x and cris the order of the first and second arguments
         * of the raw clone() system call is reversed. */
        ret = (pid_t) syscall(__NR_clone, NULL, flags);
#elif defined(__sparc__)
        {
                /**
                 * sparc always returns the other process id in %o0, and
                 * a boolean flag whether this is the child or the parent in
                 * %o1. Inline assembly is needed to get the flag returned
                 * in %o1.
                 */
                int in_child, child_pid, error;

                asm volatile("mov %3, %%g1\n\t"
                             "mov %4, %%o0\n\t"
                             "mov 0 , %%o1\n\t"
#if defined(__arch64__)
                             "t 0x6d\n\t"
#else
                             "t 0x10\n\t"
#endif
                             "addx %%g0, 0, %2\n\t"
                             "mov %%o1, %0\n\t"
                             "mov %%o0, %1" :
                             "=r"(in_child), "=r"(child_pid), "=r"(error) :
                             "i"(__NR_clone), "r"(flags) :
                             "%o1", "%o0", "%g1", "cc" );

                if (error) {
                        errno = child_pid;
                        ret = -1;
                } else
                        ret = in_child ? 0 : child_pid;
        }
+#elif defined(__ia64__)
+	/* On ia64 the stack and stack size are passed as separate arguments. */
+	return (pid_t)syscall(__NR_clone, flags, NULL, 0);
+#else
+	return (pid_t)syscall(__NR_clone, flags, NULL);
+#endif

        if (ret == 0)
                reset_cached_pid();

        return ret;
}
