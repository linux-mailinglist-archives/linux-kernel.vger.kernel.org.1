Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805D11D2D04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgENKjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:39:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:39:52 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZBHI-0001Uc-87; Thu, 14 May 2020 10:39:48 +0000
Date:   Thu, 14 May 2020 12:39:47 +0200
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
Message-ID: <20200514103947.w4segr3rvwy4mjnh@wittgenstein>
References: <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
 <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
 <20200514100459.pt7dxq2faghdds2c@wittgenstein>
 <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
 <20200514101540.25hvle74w63t66fs@wittgenstein>
 <20200514101914.fu7xhgaxtb5fy2ky@wittgenstein>
 <4aad9ad5-b0e9-12b0-0ad2-ac23fceae87b@physik.fu-berlin.de>
 <20200514103259.tdfjc5ds4igpmoxj@wittgenstein>
 <666503de-d8f9-b19c-6924-ab80d36cd446@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <666503de-d8f9-b19c-6924-ab80d36cd446@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:35:49PM +0200, John Paul Adrian Glaubitz wrote:
> On 5/14/20 12:32 PM, Christian Brauner wrote:
> > Do you have a very minimalistic ia64 userspace preferably without systemd where
> > you could simply test. That should give us an idea whether things work:
> > 
> > #define _GNU_SOURCE
> > #include <sys/wait.h>
> > #include <sys/utsname.h>
> > #include <sched.h>
> > #include <string.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <sys/mman.h>
> > 
> > #define STACK_SIZE (8 * 1024 * 1024) /* standard stack size for threads in glibc */
> > 
> > int main(int argc, char *argv[])
> > {
> > 	char *stack;
> >         pid_t pid;
> > 
> > 	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
> > 		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
> > 	if (stack == MAP_FAILED)
> > 		exit(EXIT_FAILURE);
> > 
> >         /* 
> > 	 * Note that legacy clone() has different argument ordering on
> >          * different architectures so this won't work everywhere.
> >          */
> >         pid = syscall(189 /* __NR_clone2 */, SIGCHLD, stack, STACK_SIZE, NULL, NULL);
> >         if (pid < 0)
> >                 exit(EXIT_FAILURE);
> >         if (pid == 0)
> >                 exit(EXIT_SUCCESS);
> >         if (wait(NULL) != pid)
> >                 exit(EXIT_FAILURE);
> > 
> >         exit(EXIT_SUCCESS);
> > }
> 
> root@titanium:~# gcc systemd_test.c -o systemd_test
> root@titanium:~# ./systemd_test
> root@titanium:~# echo $?
> 1
> root@titanium:~#
> 
> I can also give you access to this machine.

Yes please! :)
My ssh key should be on
https://launchpad.net/~cbrauner

Christian
