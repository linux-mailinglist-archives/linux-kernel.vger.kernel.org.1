Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284341CB960
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgEHVAA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 May 2020 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:00:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:00:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXA6A-0003Pr-8E; Fri, 08 May 2020 22:59:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A2C5B101175; Fri,  8 May 2020 22:59:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
In-Reply-To: <20200508201859.vlffp4fomw2fr4qc@pali>
References: <20200508201859.vlffp4fomw2fr4qc@pali>
Date:   Fri, 08 May 2020 22:59:57 +0200
Message-ID: <878si2jg6q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali,

Pali Rohár <pali@kernel.org> writes:

> I'm looking at clocks which are provided by kernel for userspace
> applications via clock_gettime() syscall and I think that there is
> missing clock variant CLOCK_BOOTTIME_RAW.
>
> If userspace application wants to measure time difference between two
> events then I think all of available clocks CLOCK_REALTIME,
> CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW and CLOCK_BOOTTIME have some issues
> for such task.
...
> CLOCK_BOOTTIME is affected by NTP jumps but provides correct time
> difference when system was suspended during measurement.

What do you mean with NTP jumps?

Neither CLOCK_BOOTTIME nor CLOCK_MONOTONIC jump. They are frequency
corrected when NTP, PTP or PPS are in use. The frequency correction is
incremental an smothed. They really don't jump and they give you proper
time in nanoseconds which is as close to the real nanoseconds as it
gets.

CLOCK_MONOTONIC_RAW converts some assumed clock frequency into something
which looks like time. But it's raw and subject to drift. The only
reason why it's exposed is because NTP/PTP need it to calculate the
frequency difference between the hardware counter and the master clock.

> So for me it looks like that there is missing CLOCK_BOOTTIME_RAW clock
> which would not be affected by NTP jumps (like CLOCK_MONOTONIC_RAW) and
> also would not be affected by system suspend (like CLOCK_BOOTTIME).
>
> Please correct me if I'm wrong in some of my above assumptions. It is
> how I understood documentation for clock_gettime() function from Linux
> manpage.

I don't know how you read jumps into this:

  CLOCK_MONOTONIC

   Clock that cannot be set and represents monotonic time since some
   unspecified starting point.  This clock is not affected by
   discontinuous jumps in the system time (e.g., if the system
   administrator manually changes the clock), but is affected by the
   incremental adjustments performed by adjtime(3) and NTP.

And CLOCK_BOOTTIME is the same except that it accounts time in suspend
while MONOTONIC stops in suspend.

> Is there any reason why kernel does not provide such CLOCK_BOOTTIME_RAW
> clock for userspace applications which would be interested in measuring
> time difference which occurred between two events?

Nobody needs it and there is even no guarantee that it can be
reconstructed on resume.

If you want accurate time deltas then use either CLOCK_MONOTONIC or
CLOCK_BOOTTIME depending on your interest in suspend time.

Thanks,

        tglx
