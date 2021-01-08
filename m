Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8C2EF2A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhAHMsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:48:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:39102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHMsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:48:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610110077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DckcCzsJ+u0tQc15f+xtfESHNbQlsx8GV/bkEuYJ8P0=;
        b=ocsWBWYbP5iRk6KKSnQ9NGsRsaPJ7jDiStJvkOEF/UwhljYpqmwHz/RAV9R1ttciVhBegM
        6Sdx4CUO3Ixo3XIHxcaolSJ1UnrWpn7bfr82TL1C+jHap/1kfV/qnJYum4P5sFVhuwNplf
        YI+Q37oA9/Bm7YuMgnWYt0rfeKjh/L4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3941AD62;
        Fri,  8 Jan 2021 12:47:56 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:47:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] panic: push panic() messages to the console even from
 the MCE nmi handler
Message-ID: <X/hUfBaYBCPqek5T@alley>
References: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-01-04 16:15:55, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Force push panic messages to the console as panic() can be called from NMI
> interrupt handler functions where printed messages can't always reach the
> console without an explicit push provided by printk_safe_flush_on_panic()
> and console_flush_on_panic().
> This is the case with the MCE handler that can lead to a system panic
> giving information on the fatal MCE root cause that must reach the console.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
> 
> Notes:
>     	While testing MCE injection and kernel reaction, we discovered a bug
>     in the way the kernel provides the panic reason information: When dealing
>     with fatal MCE, the machine (physical or virtual) can reboot without
>     leaving any message on the console.
>     
>     	This behavior can be reproduced on Intel with the mce-inject tool
>     with a simple:
>     	# modprobe mce-inject
>     	# mce-inject test/uncorrected
>     
>     	The investigations showed that the MCE panic can be totally message-less
>     or can give a small set of messages. This behavior depends on the use of the
>     crash_kexec mechanism (using the "crashkernel" parameter). Not using this
>     parameter, we get a partial [Hardware Error] information on panic, but some
>     important notifications can be missing. And when using it, a fatal MCE can
>     panic the system without leaving any information.
>     
>     . Without "crashkernel", a Fatal MCE injection shows:
>     
>     [  212.153928] mce: Machine check injector initialized
>     [  236.730682] mce: Triggering MCE exception on CPU 0
>     [  236.731304] Disabling lock debugging due to kernel taint
>     [  236.731947] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 1: b000000000000000
>     [  236.731948] mce: [Hardware Error]: TSC 78418fb4a83f
>     [  236.731949] mce: [Hardware Error]: PROCESSOR 0:406f1 TIME 1605312952 SOCKET 0 APIC 0 microcode 1
>     [  236.731949] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>     [  236.731950] mce: [Hardware Error]: Machine check: MCIP not set in MCA handler
>     [  236.731950] Kernel panic - not syncing: Fatal machine check
>     [  236.732047] Kernel Offset: disabled
>     
>     	The system hangs 30 seconds without any additional message, and finally
>     reboots.
>     
>     . With the use of "crashkernel", a Fatal MCE injection shows only the
>     injection message
>     
>     [   80.811708] mce: Machine check injector initialized
>     [   92.298755] mce: Triggering MCE exception on CPU 0
>     [   92.299362] Disabling lock debugging due to kernel taint
>     
>     	No other messages is displayed and the system reboots immediately.

But you could find the messages in the crashdump. Aren't you?

It works this way by "design". The idea is the following:

Taking any locks from NMI context might lead to a deadlock.
Re-initializing the locks might lead to deadlock as well
because of possible double unlock. Ignoring the locks might
lead to problems either.

A compromise is needed:

1. crashdump disabled

   console_flush_on_panic() is called. It tries hard to get the
   messages on the console because it is the only chance.

   It does console_trylock(). It is called after
   bust_spinlocks(1) so that even the console-specific locks
   are taken only with trylock, see oops_in_progress.

   BTW: There are people that do not like this because there
	is still a risk of a deadlock. Some code paths
	take locks without checking oops_in_progress.
	For these people, more reliable reboot is more
	important because they want to have the system
	back ASAP (cloud people).


2. crashdump enabled:

  Only printk_safe_flush_on_panic() is called. It does the best effort
  to flush messages from the per-CPU buffers into the main log buffer
  so that they can be found easily in the core.

  It it pretty reliable. It should not be needed at all once the new
  lockless ringbuffer gets fully integrated,

  It does not try to flush the messages to the console. Getting
  the crash dump is more important than risking a deadlock with
  consoles.


Best Regards,
Petr
