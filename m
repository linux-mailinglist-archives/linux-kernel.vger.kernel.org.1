Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12732EF2C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbhAHNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:00:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:54868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAHNAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:00:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610110775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Yldxc0OHRlCNDcj3L0XTRzCQ6O7egbVLgrLXwd0ce8=;
        b=IpaH2U2C4KytjMFsk4Z09JJ8CY0zNleghWfR79SrQ20XVO7EtBqXqZAnIZR0tv55232OfP
        JUxYMJmLinRpet54BceSZtXp3GsjSf2337LGj24IB56R00kYBbxLDWzYyd9k6ManmVmWcP
        azJcIE/PvRm5mKJk7wQadKtBrz9jrjE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 525F1AD62;
        Fri,  8 Jan 2021 12:59:35 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:59:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     William Roche <william.roche@oracle.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] panic: push panic() messages to the console even from
 the MCE nmi handler
Message-ID: <X/hXNnXClzeIKeb1@alley>
References: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
 <X/U9/yawcAoXQ7qG@jagdpanzerIV.localdomain>
 <71663639-e66e-b938-4ded-8e2dc07830b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71663639-e66e-b938-4ded-8e2dc07830b5@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-01-08 01:26:06, William Roche wrote:
> On 06/01/2021 05:35, Sergey Senozhatsky wrote:
> > On (21/01/04 16:15), “William Roche wrote:
> >> @@ -271,9 +280,8 @@ void panic(const char *fmt, ...)
> >>   	 */
> >>   	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >>
> >> -	/* Call flush even twice. It tries harder with a single online CPU */
> >> -	printk_safe_flush_on_panic();
> >>   	kmsg_dump(KMSG_DUMP_PANIC);
> >> +	panic_flush_to_console();

This is wrong. kmsg_dump() flushes the messages into the registered
dumpers, e.g. pstore. It handles only messages in the main
log buffer.

printk_safe_flush_on_panic() must be called before. It moves any
pending messages from the temporary per-CPU buffers into the main
log buffer so that they are visible for the dumpers.

> > Why?
> 
> Here, we are supposed to push the pending messages, as I could verify
> that they don't reach the console until the console_unblank(). So I
> wanted to push them with panic_flush_to_console() before the possible
> upcoming __crash_kexec() call.

I do not see how the ordering of printk_safe_flush_on_panic()
and kmsg_dump() would change anything for the upcoming
__crash_kexec() call.

Best Regards,
Petr
