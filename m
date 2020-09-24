Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541C277043
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgIXLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:49:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIXLtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:49:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600948193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8R1Sh15j2k0QJ0K4TKc4RHWcfFBi+0wiG7fmodTA+I=;
        b=swmykyZeRp309xSjYHL3QeINfDNUfWywdIA0YTHR4/JdWju9JhrrXMOFFFkl/k31GJL4++
        41/mz5aSYEXSjiOJlUlHPU+UMKxBIqmdM8Ss7PjyV3EG+0dsHgj6EM47mSJKncCfjvUghz
        SIj2C6kTN7hmKaqWfOhaOjRX6khvQFs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56E36B208;
        Thu, 24 Sep 2020 11:49:53 +0000 (UTC)
Date:   Thu, 24 Sep 2020 13:49:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Store all three timestamps
Message-ID: <20200924114952.GA29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-2-pmladek@suse.com>
 <87pn6cdtwa.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn6cdtwa.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 00:18:53, John Ogness wrote:
> On 2020-09-23, Petr Mladek <pmladek@suse.com> wrote:
> > printk() historically shows the timestamps from the monotonic clock.
> 
> printk() uses the local clock, not the monotonic clock.
> 
> > It is fast, available early during boot, in any context, and even
> > without using any lock.
> >
> > There are repeated requests [1][2][3] to show the timestamps from other
> > clocks. The main motivation is to make it easier to correlate the kernel
> > and userspace logs. Where userspace logs usually use the real time
> > clock.
> >
> > Unfortunately, it is not possible to simply replace the default clock.
> > Userspace tools, like journalctl, dmesg, expect to get the timestamps
> > from the mono via /dev/kmsg interface or syslog syscall [4].
> > Also administrators would be confused when logs from different
> > systems use different clocks depending on kernel version or
> > build option [5].
> >
> > As a result, the mono clock has to stay as the default clock
> > and has to be used in the current user interfaces.
> 
> Actually this series is changing the default clock from local to
> monotonic. I for one welcome this change (and wish ftrace would do it as
> well), but it is a change.

Good point! I expected that it is enough when boot timestamps are
monotonic.

IMHO, it is really important to use the same clock by printk() and
ftrace! Otherwise, it would be hard to match them.

Honestly, I do not know enough about the different clocks and their
users. My view is:

1. printk() needs a clock that is:

      + monotonic (always increasing)
      + lockless access
      + updated fast enough (precision)
      + available during early boot
      + match clock used by other kernel logs (ftrace)

2. ftrace needs a clock that is:

      + same requirements as for printk()
      + fast access to reduce performance problems

3. user space developers need:

   + real time clock to match userspace logs


Now, we have 4 clocks. IMHO, storing all 4 timestamps is not worth it.
We need at least two:

    + local, mono, or boot clock as legacy kernel timestamp
    + real clock to match timestamps from userspace tools


I am not able to say what clock is the best one for kernel timestamps.
The following questions come to my mind:

Is mono or boot clock fast enough for ftrace (performance wise)?
Is mono or boot clock available early enough during boot?
Is is boot clock acceptable as the default kernel clock?


IMHO, the boot clock is interesting because it has similar semantic
as the real time (running even during sleep). But I am not sure if
some developers do not rely on the mono clock or even local clock.

I guess that this need opinion from a wide audience or developers
experienced in many areas. I do not feel quialified to make
a decision.

Best Regards,
Petr
