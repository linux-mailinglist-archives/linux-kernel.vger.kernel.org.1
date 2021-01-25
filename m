Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6B30258F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbhAYNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbhAYNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:34:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C40C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:32:54 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611581542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkfJYyLpqGTZ6t5e8ms5ekE3jqDy84Phvo4KKUJXLHc=;
        b=gLzZteCMJe6cD4lkE7i17bpR+laVMcwbKwLKBXz4LtRNR640W8oGzJ9Vm6weby0xTCAL+D
        F/TP5Zxn+TWHJ/vTYoAFy8iEM7GFC3yWFxxfiE4S9zV/gEpohckcpRLDfs0k8VsOftgQPW
        sqv5N/NV1AljIcPylhpMdcZXq+ejTODbjYiojG5PdTSs5e54F5eRwYh10xyIv2LY7ONmCK
        fsxiuTxsx2E6wFDNyBwR16lySGg7NFW1wxVi48p6FYxnpGt/NFE6yKUfVX5j2cGPUKMtkN
        mji/uMu2FxX17Q3oQ7sYxzRXX8OYJlF1I4xcml/pN5dQtwvsW9nqZLPycQmW/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611581542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkfJYyLpqGTZ6t5e8ms5ekE3jqDy84Phvo4KKUJXLHc=;
        b=yWieyC4dPs5a8PmcLNhJdAXEj9EbAywVkoxmlZdFPr6k7pPOMWkbr52EUj0S+xUtMVZevC
        8msPmQPGYS+RZqAA==
To:     "J. Avila" <elavila@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Issue in dmesg time with lockless ring buffer
In-Reply-To: <20210122235238.655049-1-elavila@google.com>
References: <20210122235238.655049-1-elavila@google.com>
Date:   Mon, 25 Jan 2021 14:38:20 +0106
Message-ID: <87im7l2lcr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22, "J. Avila" <elavila@google.com> wrote:
> When doing some internal testing on a 5.10.4 kernel, we found that the
> time taken for dmesg seemed to increase from the order of milliseconds
> to the order of seconds when the dmesg size approached the ~1.2MB
> limit. After doing some digging, we found that by reverting all of the
> patches in printk/ up to and including
> 896fbe20b4e2333fb55cc9b9b783ebcc49eee7c7 ("use the lockless
> ringbuffer"), we were able to once more see normal dmesg times.
>
> This kernel had no meaningful diffs in the printk/ dir when compared
> to Linus' tree. This behavior was consistently reproducible using the
> following steps:
>
> 1) In one shell, run "time dmesg > /dev/null"
> 2) In another, constantly write to /dev/kmsg
>
> Within ~5 minutes, we saw that dmesg times increased to 1 second, only
> increasing further from there. Is this a known issue?

The last couple days I have tried to reproduce this issue with no
success.

Is your dmesg using /dev/kmsg or syslog() to read the buffer?

Are there any syslog daemons or systemd running? Perhaps you can run
your test within an initrd to see if this effect is still visible?

John Ogness
