Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10012EEA69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbhAHA2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:28:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48248 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbhAHA2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:28:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1080Epcx122096;
        Fri, 8 Jan 2021 00:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KUbxWwMt17+Tyvy8CsLbvt0zYSfh9QqFhIyfzyPysNU=;
 b=bvJVcbG69LPAO/zn3ix/GhB1t3R/qoPb6+qpp1lBpfZAd/fQUF/sJoWiSWViABSmJiKg
 w/z/frKRh0P4zoS78fQL4CO2tH5V9fRSjGnXVNeindGPY+D5QcwjqgsEiOlv9l1YTG+k
 i0yszUy/66ehVyNv58VSTipQ8XJ40/PdvA1B0R0W5z7E4l3mK7yPeHZ4d4xFRr/236bS
 DQcsyw5g51TCoIT6eS3wZxQvPlNrAazHtV9csOosqvn1PC0TV9IRowuZf+NWcLqHyPqd
 +Kuhr335zYZtNTVJ+MUER09tEnh68XY4LRfMhWFzkSlqEpNDxOTAnzACtx6VFB9Lw9xl wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35wcuxyctj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 00:26:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1080BfhI153759;
        Fri, 8 Jan 2021 00:26:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35w3g3hgj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 00:26:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1080Q9hV001477;
        Fri, 8 Jan 2021 00:26:09 GMT
Received: from [10.175.60.222] (/10.175.60.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 16:26:09 -0800
Subject: Re: [PATCH v1] panic: push panic() messages to the console even from
 the MCE nmi handler
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        William Roche <william.roche@oracle.com>
References: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
 <X/U9/yawcAoXQ7qG@jagdpanzerIV.localdomain>
From:   William Roche <william.roche@oracle.com>
Message-ID: <71663639-e66e-b938-4ded-8e2dc07830b5@oracle.com>
Date:   Fri, 8 Jan 2021 01:26:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/U9/yawcAoXQ7qG@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2021 05:35, Sergey Senozhatsky wrote:
 > On (21/01/04 16:15), “William Roche wrote:
 > [..]
 >> diff --git a/kernel/panic.c b/kernel/panic.c
 >> index 332736a..eb90cc0 100644
 >> --- a/kernel/panic.c
 >> +++ b/kernel/panic.c
 >> @@ -166,6 +166,15 @@ static void panic_print_sys_info(void)
 >>   		ftrace_dump(DUMP_ALL);
 >>   }
 >>
 >> +/*
 >> + * Force flush messages to the console.
 >> + */
 >> +static void panic_flush_to_console(void)
 >> +{
 >> +	printk_safe_flush_on_panic();
 >> +	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 >> +}
 >
 > You must debug_locks_off() as the very first step here. But see below.

Thanks I've missed this point, I will call debug_locks_off() before
the first call to console_flush_on_panic(CONSOLE_FLUSH_PENDING);

 >
 >>   /**
 >>    *	panic - halt the system
 >>    *	@fmt: The text string to print
 >> @@ -247,7 +256,7 @@ void panic(const char *fmt, ...)
 >>   	 * Bypass the panic_cpu check and call __crash_kexec directly.
 >>   	 */
 >>   	if (!_crash_kexec_post_notifiers) {
 >> -		printk_safe_flush_on_panic();
 >> +		panic_flush_to_console();
 >>   		__crash_kexec(NULL);
 >
 > It's dangerous to call console_flush_on_panic() before we stop secondary
 > CPUs. console_flush_on_panic() ignores the state console_sem, so if any
 > of the secondary is currently printing something on the consoles you'll
 > get corrupted messages - we use `static char buffer` for messages we
 > push to consoles.

I understand that there is a risk here, and the __crash_exec() call is
not supposed to return when crashexec is ready. This is our last chance
here to push to the console the pending messages.

 > Another issue is that with this panic_flush_to_console() call console_sem
 > can end up being locked once (by secondary CPU) and unlocked twice (by
 > second and panic CPUs) [*]

I agree, this is a risk. But what we see is that even the message
previously submitted by the pr_emerg() call of the panic thread is
currently discarded when __crash_kexec(NULL) is called.
In the case described here, no other message is printed out by a
secondary CPU, but I understand that it could happen, and we
could avoid calling panic_flush_to_console() when kexec_crash isn't
loaded so that we can wait for the SMP stop and leave the current
steps to run untouched until the last printed messages.

 >
 >>   		/*
 >> @@ -271,9 +280,8 @@ void panic(const char *fmt, ...)
 >>   	 */
 >>   	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 >>
 >> -	/* Call flush even twice. It tries harder with a single online CPU */
 >> -	printk_safe_flush_on_panic();
 >>   	kmsg_dump(KMSG_DUMP_PANIC);
 >> +	panic_flush_to_console();
 >
 > Why?

Here, we are supposed to push the pending messages, as I could verify
that they don't reach the console until the console_unblank(). So I
wanted to push them with panic_flush_to_console() before the possible
upcoming __crash_kexec() call.

Are you suggesting that I should leave the printk_safe_flush_on_panic()
call before the kmsg_dump(KMSG_DUMP_PANIC) call ?
But let's leave that untouched too.

 >
 >>   	/*
 >>   	 * If you doubt kdump always works fine in any situation,
 >> @@ -298,7 +306,7 @@ void panic(const char *fmt, ...)
 >>   	 * buffer.  Try to acquire the lock then release it regardless of the
 >>   	 * result.  The release will also print the buffers out.  Locks debug
 >>   	 * should be disabled to avoid reporting bad unlock balance when
 >> -	 * panic() is not being callled from OOPS.
 >> +	 * panic() is not being called from OOPS.
 >>   	 */
 >>   	debug_locks_off();
 >>   	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 >> @@ -314,6 +322,7 @@ void panic(const char *fmt, ...)
 >>   		 * We can't use the "normal" timers since we just panicked.
 >>   		 */
 >>   		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
 >> +		panic_flush_to_console();
 >
 > [*] So this
 >
 >>   		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
 >>   			touch_nmi_watchdog();
 >> @@ -347,6 +356,7 @@ void panic(const char *fmt, ...)
 >>   	disabled_wait();
 >>   #endif
 >>   	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 >> +	panic_flush_to_console();
 >
 > [*] and this are both very interesting points.
 >
 > Those extra console_flush_on_panic() calls indicate that normal printk()
 > cannot succeed in locking the console_sem so it doesn't try to
 > console_unlock(): either because we killed the secondary CPU while it
 > was holding the lock, or because we locked it once and unlocked it twice.
 >
 > I think it would make sense to just re-init console_sem, so that normal
 > printk()-s will have chance to grab the console_sem lock and then we 
don't
 > need any extra panic_flush_to_console() calls. Maybe we can do something
 > like this
 >
 > ---
 >
 > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
 > index ffdd0dc7ec6d..4bd2e29c8cc0 100644
 > --- a/kernel/printk/printk.c
 > +++ b/kernel/printk/printk.c
 > @@ -2638,6 +2638,7 @@ void console_flush_on_panic(enum con_flush_mode 
mode)
 >   	 * context and we don't want to get preempted while flushing,
 >   	 * ensure may_schedule is cleared.
 >   	 */
 > +	sema_init(&console_sem, 1);
 >   	console_trylock();
 >   	console_may_schedule = 0;
 >
 >

I've tried your suggestion, and even with this sema_init() call, the
  pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
message is not printed to the console without a subsequent call to
panic_flush_to_console().

See below a code modification that would illustrate a possible change
including the above comments. Would something like that be more
appropriate ?

This is the end of this running kernel, and panic is called from the NMI
context where printk() messages have to be pushed. The mechanism I use
seems to work in this case, but there could be another way to achieve
this goal (?)

Thanks again for your help,
William.


--- kernel/panic.c	2021-01-07 18:20:01.992582942 -0500
***************
*** 166,171 ****
--- 166,180 ----
   		ftrace_dump(DUMP_ALL);
   }

+ /*
+  * Force flush messages to the console.
+  */
+ static void panic_flush_to_console(void)
+ {
+ 	printk_safe_flush_on_panic();
+ 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+ }
+
   /**
    *	panic - halt the system
    *	@fmt: The text string to print
***************
*** 247,253 ****
   	 * Bypass the panic_cpu check and call __crash_kexec directly.
   	 */
   	if (!_crash_kexec_post_notifiers) {
! 		printk_safe_flush_on_panic();
   		__crash_kexec(NULL);

   		/*
--- 256,265 ----
   	 * Bypass the panic_cpu check and call __crash_kexec directly.
   	 */
   	if (!_crash_kexec_post_notifiers) {
! 		if (kexec_crash_loaded()) {
! 			debug_locks_off();
! 			panic_flush_to_console();
! 		}
   		__crash_kexec(NULL);

   		/*
***************
*** 284,291 ****
   	 *
   	 * Bypass the panic_cpu check and call __crash_kexec directly.
   	 */
! 	if (_crash_kexec_post_notifiers)
   		__crash_kexec(NULL);

   #ifdef CONFIG_VT
   	unblank_screen();
--- 296,308 ----
   	 *
   	 * Bypass the panic_cpu check and call __crash_kexec directly.
   	 */
! 	if (_crash_kexec_post_notifiers) {
! 		if (kexec_crash_loaded()) {
! 			debug_locks_off();
! 			panic_flush_to_console();
! 		}
   		__crash_kexec(NULL);
+ 	}

   #ifdef CONFIG_VT
   	unblank_screen();
***************
*** 298,304 ****
   	 * buffer.  Try to acquire the lock then release it regardless of the
   	 * result.  The release will also print the buffers out.  Locks debug
   	 * should be disabled to avoid reporting bad unlock balance when
! 	 * panic() is not being callled from OOPS.
   	 */
   	debug_locks_off();
   	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
--- 315,321 ----
   	 * buffer.  Try to acquire the lock then release it regardless of the
   	 * result.  The release will also print the buffers out.  Locks debug
   	 * should be disabled to avoid reporting bad unlock balance when
! 	 * panic() is not being called from OOPS.
   	 */
   	debug_locks_off();
   	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
***************
*** 314,319 ****
--- 331,337 ----
   		 * We can't use the "normal" timers since we just panicked.
   		 */
   		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+ 		panic_flush_to_console();

   		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
   			touch_nmi_watchdog();
***************
*** 347,352 ****
--- 365,371 ----
   	disabled_wait();
   #endif
   	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+ 	panic_flush_to_console();

   	/* Do not scroll important messages printed above */
   	suppress_printk = 1;

