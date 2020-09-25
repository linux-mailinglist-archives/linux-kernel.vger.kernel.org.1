Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1374C278469
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgIYJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:51:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgIYJvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:51:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601027483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAi/aR75Ote0HPMVROUAFbJ3AhLP6tIxclhH8TKF+t8=;
        b=KaDIc5PGxlmicuM1zqhGsIeenrkfE+yDDAWMRNWxO/+b8qWd/zia8qly0OkG+xSjIXara4
        mC7K5aNUxEsPOPMoMCyDhInpjy9C6Jb8jw7lQ24FyV7QOJxGZuG5lX89/4/yXxd0+Aw8sM
        gtz5dzMR2XvNrpqINizc0SFWncHlNfQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 298E8ACC2;
        Fri, 25 Sep 2020 09:51:23 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:51:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] printk: Store all three timestamps
Message-ID: <20200925095121.GN29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-2-pmladek@suse.com>
 <87pn6cdtwa.fsf@jogness.linutronix.de>
 <20200924114952.GA29288@alley>
 <CAJ-C09hqwOJhSXx1h40q96xhNZFXxP6dUVfjUQZpO4ZhOMZLbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-C09hqwOJhSXx1h40q96xhNZFXxP6dUVfjUQZpO4ZhOMZLbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 10:07:57, Mark Salyzyn wrote:
> I would hope for monotonic_raw, boottime and realtime as being the most
> useful for most situations.
> 
> [TL;DR]
> 
> Currently kernel logs actually uses monotonic_raw (no timing clock
> correction), not monotonic (timing correction).
> 
> Whereas boot (timing clock adjusted, still monotonic) and realtime (timing
> clock _and_ time adjusted, non monotonic), when we try to correlate to user
> space is workable, but we will have troubles correlating monotonic (w.r.t.
> monotonic_raw) clocks if used in user space.
> 
> In Android we have the option of monotonic and realtime only right now for
> the user space logger (which integrates logd, klogd and auditd, the later
> two come from the kernel). I have bugs open to consider boottime, but it is
> blocked on boottime availability from kernel space logging (this change). I
> have another bug to consider switching the logger to monotonic_raw instead
> of monotonic, to make it correlate better with existing kernel logs. But
> alas a lot of resistance for phones switching to monotonic(_raw), the only
> devices that chose monotonic(_raw) is everything else (google glass,
> watches, ...). As such, phones, and the associated developers, will
> continue to want realtime correlated in the kernel logs (yes, this change
> too).
> 
> realtime sucks for the first 10 seconds on Android, since phones generally
> do not get their time correction until then from network resources, and
> many of their rtc clocks are not adjustable, they store a correction factor
> that does not get picked up from user space until userdata is mounted
> (about 20 seconds in). But only kernel developers care about this first
> part of boot, everything after that (and associated correlated kernel
> interactions) are for user space folks.

Thanks a lot for this detailed feedback.

Just to be sure that I understand it correctly. You suggest to store
three timestamps: local_clock(), boot and real clock.

It makes sense to me. I just wonder if there might be any use case
when the adjusted mono clock is needed or preferred over local_clock().

Best Regards,
Petr
