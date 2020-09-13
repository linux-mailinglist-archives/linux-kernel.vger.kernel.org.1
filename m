Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF02680FF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 21:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgIMTkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 15:40:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57786 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 15:40:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600026014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v6QwRxkHU/1Ri5sU6gikMQ3SI6ZgMItVTudlFdglRzw=;
        b=3Qshcww+jybXNX3VsyoZoa/jKeGTbT1ZopEpRFOGytKi4BY94oawA6ePN40VECOEepkO10
        0tOwgxHW490JhuL34kUV+mzEUxX6q79epARnEI1+VHFNgvrmmaBC3zAVTo9X3PJPnXRFR7
        XJq/J267SxClBKB+CZbpMNBUJNJdIpHNAg75ivyRRCKjiLKNgLI8/HRe4pb2+l8Oo43wAQ
        lZiI+abpZU0XkY2095kxtx91TdzUg1Syw5lx3SudvGDWf+q28Y9OLGmg4loBf7dnINwW6P
        5XKxEQpOppkiOKJnE+8JyUd59JTqYbqEJeB/c3wvOOzXH8CrmX5Q9xJXBEwvnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600026014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v6QwRxkHU/1Ri5sU6gikMQ3SI6ZgMItVTudlFdglRzw=;
        b=NPSKP6l8f5IkAtJuHDJRrhRRntgFU04gJKABgZnRSrHGX5ewVoD6piUmUxDNFaRPmbUK+c
        zFFMZPdCMnkA8tDQ==
To:     syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in syscall_exit_to_user_mode
In-Reply-To: <00000000000018a47605af074c7d@google.com>
References: <00000000000018a47605af074c7d@google.com>
Date:   Sun, 13 Sep 2020 21:40:14 +0200
Message-ID: <87y2ldpish.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11 2020 at 03:39, syzbot wrote:
>
> ------------[ cut here ]------------
> syscall 56 left IRQs disabled

Ouch. syscall 56 == sys_clone

> WARNING: CPU: 1 PID: 31467 at kernel/entry/common.c:245 syscall_exit_to_user_mode_prepare kernel/entry/common.c:245 [inline]

<snip>

>  ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:287

But this does not make any sense for regular fork because
ret_from_fork() invokes schedule_tail() which drops the runqueue lock
and enables interrupts.

But for kernel threads that's more interesting because after
schedule_tail() the kernel thread function is invoked and this can call
kernel_execve() and return to ret_from_fork() and then run through
syscall_exit_to_user_mode().

Let me get that reproducer...
