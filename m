Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AE2F2634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbhALCUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:20:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42810 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbhALCUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:20:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C29TBi179921;
        Tue, 12 Jan 2021 02:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bU/DsLI84ax+3OB5FgDi6iSmWlC197hauSHV9MifOcU=;
 b=r9CJvbDBfWXQ3Yl8FhgNwGjswqvqJlvx74bFOyrdnaXQdc+HVt/f4SpqSTYA0M9oY6ow
 O1DNfGvtLMYXqj3a747NJYauuxNzjC3yeA805o3IBtc4yghn5c5Etzh8kr99nX5o1QUg
 kheLEjfTPnXDcS7sFrV0dF/Ynlh5l9DIXAhFKiQeWRa4sgpvF6zAIwUpUfUSFjRNXNgA
 ZBr99vC5CmTc8sN/e89ddQz2UAJ51Yl468Ho9jHRq5OUTx17FojR2Fov3HODtJr/MixC
 a9WU37CEOSW1SZwgur40wjrYYWuJsBd791j7FvReBO2rZKnkpbfhWN2StZehpIGihI2p 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1m4kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 02:19:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C29vw4186540;
        Tue, 12 Jan 2021 02:17:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kex5rdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 02:17:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10C2H1RO002836;
        Tue, 12 Jan 2021 02:17:02 GMT
Received: from [10.175.63.91] (/10.175.63.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 18:17:01 -0800
Subject: Re: [PATCH v1] panic: push panic() messages to the console even from
 the MCE nmi handler
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        William Roche <william.roche@oracle.com>
References: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
 <X/U9/yawcAoXQ7qG@jagdpanzerIV.localdomain>
 <71663639-e66e-b938-4ded-8e2dc07830b5@oracle.com> <X/hXNnXClzeIKeb1@alley>
From:   William Roche <william.roche@oracle.com>
Message-ID: <5577527e-3da2-d352-e21b-3632c276f341@oracle.com>
Date:   Tue, 12 Jan 2021 03:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/hXNnXClzeIKeb1@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your clarification, and let me explain what I was
talking about before providing my last code version.

 >>>>   	kmsg_dump(KMSG_DUMP_PANIC);
 >>>> +	panic_flush_to_console();
 >
 > This is wrong. kmsg_dump() flushes the messages into the registered
 > dumpers, e.g. pstore. It handles only messages in the main
 > log buffer.
 >
 > printk_safe_flush_on_panic() must be called before. It moves any
 > pending messages from the temporary per-CPU buffers into the main
 > log buffer so that they are visible for the dumpers.

Ok, this is very clear.

 >>> Why?
 >>
 >> Here, we are supposed to push the pending messages, as I could verify
 >> that they don't reach the console until the console_unblank(). So I
 >> wanted to push them with panic_flush_to_console() before the possible
 >> upcoming __crash_kexec() call.
 >
 > I do not see how the ordering of printk_safe_flush_on_panic()
 > and kmsg_dump() would change anything for the upcoming
 > __crash_kexec() call.

I was wrong to remove the call to printk_safe_flush_on_panic() before
kmsg_dump() as it was in panic_flush_to_console().

The call panic_flush_to_console() idea here was to push any messages
that could have been submitted (even by any dumper) to the console
before the possible upcoming __crash_kexec() call. Otherwise they could
be discarded (if the crash messages can't be retrieved).

And that's the reason why I've changed this code in my previous version
to force a call to panic_flush_to_console() before the __crash_kexec().
Which seems to be too insecure as far as I understand it now.


In your previous email you also indicate:

 >>     . With the use of "crashkernel", a Fatal MCE injection shows 
only the
 >>     injection message
 >>
 >>     [   80.811708] mce: Machine check injector initialized
 >>     [   92.298755] mce: Triggering MCE exception on CPU 0
 >>     [   92.299362] Disabling lock debugging due to kernel taint
 >>
 >>     	No other messages is displayed and the system reboots immediately.
 >
 > But you could find the messages in the crashdump. Aren't you?

Yes, but _only_ with the latest kexec-tools-2.0.21.git version !
[My installed kexec-tools.x86_64 2.0.20-34.0.4.el8_3 doesn't seem to
work, and I guess there is a separate problem that I will investigate
later.]


 >
 > It works this way by "design". The idea is the following:
 >

That's a rather disarming statement :)

I'm sure we can agree that getting the information directly (and of
course safely) from the running kernel console would be a better option,
instead of having a 2 steps process to get the crash reason (even when
it works) as it adds a risk not to get this crash reason at all. And I
know for a fact that Cloud people do want to know why a platform goes
away ;)


 > Taking any locks from NMI context might lead to a deadlock.
 > Re-initializing the locks might lead to deadlock as well
 > because of possible double unlock. Ignoring the locks might
 > lead to problems either.
 >
 > A compromise is needed:
 >
 > 1. crashdump disabled
 >
 >    console_flush_on_panic() is called. It tries hard to get the
 >    messages on the console because it is the only chance.
 >
 >    It does console_trylock(). It is called after
 >    bust_spinlocks(1) so that even the console-specific locks
 >    are taken only with trylock, see oops_in_progress.
 >
 >    BTW: There are people that do not like this because there
 > 	is still a risk of a deadlock. Some code paths
 > 	take locks without checking oops_in_progress.
 > 	For these people, more reliable reboot is more
 > 	important because they want to have the system
 > 	back ASAP (cloud people).
 >
 >
 > 2. crashdump enabled:
 >
 >   Only printk_safe_flush_on_panic() is called. It does the best effort
 >   to flush messages from the per-CPU buffers into the main log buffer
 >   so that they can be found easily in the core.
 >
 >   It is pretty reliable. It should not be needed at all once the new
 >   lockless ringbuffer gets fully integrated,
 >
 >   It does not try to flush the messages to the console. Getting
 >   the crash dump is more important than risking a deadlock with
 >   consoles.

Thanks again for the good clarification. I did not realize that calling
console_flush_on_panic(CONSOLE_FLUSH_PENDING) from panic() before our
__crash_kexec() was not safe enough.

So here is a new version of a (minimal) fix trying to follow your
suggestions:
(And you'll probably remove the added calls to
printk_safe_flush_on_panic() when integrating the new lockless
ringbuffer)

What do you think of this simplified possibility ?:
[If this fix is correct, I'll submit it as a v2 fix, with an updated 
comment and Notes]

--- kernel/panic.c	2021-01-11 20:33:25.268047057 -0500
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
*** 284,291 ****
   	 *
   	 * Bypass the panic_cpu check and call __crash_kexec directly.
   	 */
! 	if (_crash_kexec_post_notifiers)
   		__crash_kexec(NULL);

   #ifdef CONFIG_VT
   	unblank_screen();
--- 293,302 ----
   	 *
   	 * Bypass the panic_cpu check and call __crash_kexec directly.
   	 */
! 	if (_crash_kexec_post_notifiers) {
! 		printk_safe_flush_on_panic();
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
--- 309,315 ----
   	 * buffer.  Try to acquire the lock then release it regardless of the
   	 * result.  The release will also print the buffers out.  Locks debug
   	 * should be disabled to avoid reporting bad unlock balance when
! 	 * panic() is not being called from OOPS.
   	 */
   	debug_locks_off();
   	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
***************
*** 314,319 ****
--- 325,331 ----
   		 * We can't use the "normal" timers since we just panicked.
   		 */
   		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+ 		panic_flush_to_console();

   		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
   			touch_nmi_watchdog();
***************
*** 347,352 ****
--- 359,365 ----
   	disabled_wait();
   #endif
   	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+ 	panic_flush_to_console();

   	/* Do not scroll important messages printed above */
   	suppress_printk = 1;

