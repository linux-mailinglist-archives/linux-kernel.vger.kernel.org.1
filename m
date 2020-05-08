Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E761CB9D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 23:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEHVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 17:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgEHVbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:31:25 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8209621582;
        Fri,  8 May 2020 21:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588973484;
        bh=1RunAbg9yPDYcIM2xk1zX+QnL3l50+9M4joa5kazxcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9Vj0PpLCl4w8rRHSw6AblX5YPetgOMvn5t6JQ5/rEm7JUBJrmpi1CyYoP5xoRqba
         3Q4zQfJRZSRhDwhiY9MiZ5bpO2u/uhKq8OpBRiXIyFowLSlXFdmtiUUTg5OVqC0tmq
         aORagheluEp71miwtnayZtAR6zHS/gEUfFz6rSZc=
Received: by pali.im (Postfix)
        id 73C0A7F5; Fri,  8 May 2020 23:31:22 +0200 (CEST)
Date:   Fri, 8 May 2020 23:31:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
Message-ID: <20200508213122.f7srcd2gnduamtvs@pali>
References: <20200508201859.vlffp4fomw2fr4qc@pali>
 <878si2jg6q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878si2jg6q.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 May 2020 22:59:57 Thomas Gleixner wrote:
> Pali,
> 
> Pali Rohár <pali@kernel.org> writes:
> 
> > I'm looking at clocks which are provided by kernel for userspace
> > applications via clock_gettime() syscall and I think that there is
> > missing clock variant CLOCK_BOOTTIME_RAW.
> >
> > If userspace application wants to measure time difference between two
> > events then I think all of available clocks CLOCK_REALTIME,
> > CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW and CLOCK_BOOTTIME have some issues
> > for such task.
> ...
> > CLOCK_BOOTTIME is affected by NTP jumps but provides correct time
> > difference when system was suspended during measurement.
> 
> What do you mean with NTP jumps?
> 
> Neither CLOCK_BOOTTIME nor CLOCK_MONOTONIC jump. They are frequency
> corrected when NTP, PTP or PPS are in use. The frequency correction is
> incremental an smothed. They really don't jump and they give you proper
> time in nanoseconds which is as close to the real nanoseconds as it
> gets.

Hello! I should have been more precise about it. CLOCK_BOOTTIME and
CLOCK_MONOTONIC do not jump but I understood that they are affected by
adjtime(). So these clocks may tick faster or slower than real time. NTP
daemon when see that CLOCK_REALTIME is incorrect, it may speed up or
slow down its ticking. And this is affected also by CLOCK_BOOTTIME and
CLOCK_MONOTONIC, right?

> CLOCK_MONOTONIC_RAW converts some assumed clock frequency into something
> which looks like time. But it's raw and subject to drift. The only
> reason why it's exposed is because NTP/PTP need it to calculate the
> frequency difference between the hardware counter and the master clock.

  CLOCK_MONOTONIC_RAW
      Similar to CLOCK_MONOTONIC, but provides access to a raw
      hardware-based time that is not subject to NTP adjustments or the
      incremental adjustments performed by adjtime(3).

I understood it that it is like CLOCK_MONOTONIC but is not affected by
adjtime() which is used by NTP daemon to slow down or speed up system
clock to synchronize it (when system clock is incorrect).

So I thought that this clock is better for time differences as measured
time would not be affected when NTP daemon speeded up system clock via
adjtime().

You wrote that this clock is subject to drifts. What exactly may happen
with CLOCK_MONOTONIC_RAW?

> > So for me it looks like that there is missing CLOCK_BOOTTIME_RAW clock
> > which would not be affected by NTP jumps (like CLOCK_MONOTONIC_RAW) and
> > also would not be affected by system suspend (like CLOCK_BOOTTIME).
> >
> > Please correct me if I'm wrong in some of my above assumptions. It is
> > how I understood documentation for clock_gettime() function from Linux
> > manpage.
> 
> I don't know how you read jumps into this:
> 
>   CLOCK_MONOTONIC
> 
>    Clock that cannot be set and represents monotonic time since some
>    unspecified starting point.  This clock is not affected by
>    discontinuous jumps in the system time (e.g., if the system
>    administrator manually changes the clock), but is affected by the
>    incremental adjustments performed by adjtime(3) and NTP.

Sorry, by jump I mean that clock may be adjusted (even smoothed
adjustment).

> And CLOCK_BOOTTIME is the same except that it accounts time in suspend
> while MONOTONIC stops in suspend.
> 
> > Is there any reason why kernel does not provide such CLOCK_BOOTTIME_RAW
> > clock for userspace applications which would be interested in measuring
> > time difference which occurred between two events?
> 
> Nobody needs it and there is even no guarantee that it can be
> reconstructed on resume.
> 
> If you want accurate time deltas then use either CLOCK_MONOTONIC or
> CLOCK_BOOTTIME depending on your interest in suspend time.
> 
> Thanks,
> 
>         tglx
