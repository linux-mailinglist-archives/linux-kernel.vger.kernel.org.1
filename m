Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE32CBEA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgLBNpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLBNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:45:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DFDC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 05:44:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606916693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzMMjQyaeZrm/HNSN+mhSwIbxiRBf393Vs7HWKgVtkM=;
        b=Tv7J6qcDVORtOlnAa3OupOe9P62Z1WqaqUKdZwWeYihesNHRzgdo6ux7t2RowyyiqnLxVO
        O8D4VKJBnwD+lfiNk4PNX+74PozbasFan5wRhvpQs3NvuxMECm6HRKP0jXBsG9XoNZ2QjI
        uNR4mQPVIMtJfHjMM8WIdGaHxpgUYOVer4+4mhhvy+WqoItvYOJd0Ag/Xdr234I5caxTYM
        3n73yqpEUTcR1SBeYXowSw4hXJpIzX9zs5U4Mx7CwsXnasxObV6clNcLwAJ4rwWuTJQTNZ
        BKHMcAKrTiKrjoZm6qs/nXBjvxsEKU5OhIGkACS6lLieuN6fMzdSWjTEKJ9l6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606916693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzMMjQyaeZrm/HNSN+mhSwIbxiRBf393Vs7HWKgVtkM=;
        b=pURFW9GwyfU2vlD+ndRgCpQ0KiG3qLkdyiteOmFvTrNtyiPn7WAsHJ/BAr+KI6JHm3uxVg
        oysp9u0srwxrkeDw==
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Miroslav Lichvar <mlichvar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
In-Reply-To: <20201201173540.GH5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com> <20201201161224.GF5487@ziepe.ca> <20201201171420.GN1900232@localhost> <20201201173540.GH5487@ziepe.ca>
Date:   Wed, 02 Dec 2020 14:44:53 +0100
Message-ID: <87mtywe2zu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 13:35, Jason Gunthorpe wrote:
> On Tue, Dec 01, 2020 at 06:14:20PM +0100, Miroslav Lichvar wrote:
>> I found no good explanation. It seems to depend on what system is
>> doing, if it's idle, etc. I suspect it's a property of the workqueues
>> that they cannot generally guarantee the jobs to run exactly on time.
>> I tried switching to the non-power-efficient and high priority
>> workqueues and it didn't seem to make a big difference.
>
> When I wrote it originally the workqueues got increasingly inaccurate
> the longer the duration, so it does a very short sleep to get back on
> track.
>
> If you are missing that time target it must be constantly scheduling
> new delayed work and none of it hits the target for long, long time
> periods? 

delayed work is based on the timer wheel which is inaccurate by
design. Looking at the whole machinery:

sync_rtc_clock()
    ktime_get_real_ts64(&now);

    rtc_set_ntp_time(now, &target_nsec)

      set_normalized_timespec64(&to_set, 0, -rtc->set_offset_nsec);
      // rtc->set_offset_nsec = NSEC_PER_SEC / 2
      *target_nsec = to_set.tv_nsec;

    sched_sync_hw_clock(now, target_nsec, rc) <- now is unused here

       ktime_get_real_ts64(&next);
       if (!fail)
          next.tv_sec = 659;
       else
          next.tv_sec = 0;
       
       next.tv_nsec = target_nsec - next.tv_nsec;
       ...
       queue_delayed_work(system_power_efficient_wq, &sync_work,
                          timespec64_to_jiffies(&next));

Let's look at the 659 seconds case first. Depending on the HZ value the
granularity of the timer wheel bucket in which that timer ends up is:

HZ          Granularity
1000        32s
 250        16s
 100        40s

That's been true for the old timer wheel implementation as well, just
the granularity values were slighty different.

The probability to run at the expected time is pretty low. The target
time would need to be exactly aligned with the wheel level period.

Now for the 0 second X nanoseconds case.

That's affected by the bucket granularities as well depending on the
resulting nanoseconds value:

 * HZ 1000
 * Level Offset  Granularity            Range
 *  0      0         1 ms                0 ms -         63 ms
 *  1     64         8 ms               64 ms -        511 ms
 *  2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
 *
 * HZ  250
 * Level Offset  Granularity            Range
 *  0	   0         4 ms                0 ms -        255 ms
 *  1	  64        32 ms              256 ms -       2047 ms (256ms - ~2s)
 *
 * HZ  100
 * Level Offset  Granularity            Range
 *  0	   0         10 ms               0 ms -        630 ms
 *  1	  64         80 ms             640 ms -       5110 ms (640ms - ~5s)

So if this ends up in level #1 then again the chance is pretty low that
the expiry time is aligned to the the level period. If this works then
it only works by chance.

> This seems like a more fundamental problem someplace else in the
> kernel.

I don't think so. :)

Something like the completely untested below should make this reliable
and only needs to retry when the work is running late (busy machine),
but the wakeup will be on time or at max 1 jiffie off when high
resolution timers are not available or disabled.

Thanks,

        tglx
---
 kernel/time/ntp.c |   65 +++++++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -495,64 +495,53 @@ int second_overflow(time64_t secs)
 }
 
 static void sync_hw_clock(struct work_struct *work);
-static DECLARE_DELAYED_WORK(sync_work, sync_hw_clock);
-
-static void sched_sync_hw_clock(struct timespec64 now,
-				unsigned long target_nsec, bool fail)
+static DECLARE_WORK(sync_work, sync_hw_clock);
+static struct hrtimer sync_hrtimer;
+#define SYNC_PERIOD_NS (11UL * 60 * NSEC_PER_SEC)
 
+static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
 {
-	struct timespec64 next;
+	queue_work(system_power_efficient_wq, &sync_work);
 
-	ktime_get_real_ts64(&next);
-	if (!fail)
-		next.tv_sec = 659;
-	else {
-		/*
-		 * Try again as soon as possible. Delaying long periods
-		 * decreases the accuracy of the work queue timer. Due to this
-		 * the algorithm is very likely to require a short-sleep retry
-		 * after the above long sleep to synchronize ts_nsec.
-		 */
-		next.tv_sec = 0;
-	}
+	return HRTIMER_NORESTART;
+}
 
-	/* Compute the needed delay that will get to tv_nsec == target_nsec */
-	next.tv_nsec = target_nsec - next.tv_nsec;
-	if (next.tv_nsec <= 0)
-		next.tv_nsec += NSEC_PER_SEC;
-	if (next.tv_nsec >= NSEC_PER_SEC) {
-		next.tv_sec++;
-		next.tv_nsec -= NSEC_PER_SEC;
-	}
+static void sched_sync_hw_clock(unsigned long offset_nsec, bool retry)
+{
+	ktime_t exp = ktime_set(ktime_get_real_seconds(), 0);
+
+	if (retry)
+		exp = ktime_add_ns(exp, 2 * NSEC_PER_SEC - offset_nsec);
+	else
+		exp = ktime_add_ns(exp, SYNC_PERIOD_NS - offset_nsec);
 
-	queue_delayed_work(system_power_efficient_wq, &sync_work,
-			   timespec64_to_jiffies(&next));
+	hrtimer_start(&sync_hrtimer, exp, HRTIMER_MODE_ABS);
 }
 
 static void sync_rtc_clock(void)
 {
-	unsigned long target_nsec;
-	struct timespec64 adjust, now;
+	unsigned long offset_nsec;
+	struct timespec64 adjust;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
 		return;
 
-	ktime_get_real_ts64(&now);
+	ktime_get_real_ts64(&adjust);
 
-	adjust = now;
 	if (persistent_clock_is_local)
 		adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
 
 	/*
-	 * The current RTC in use will provide the target_nsec it wants to be
-	 * called at, and does rtc_tv_nsec_ok internally.
+	 * The current RTC in use will provide the nanoseconds offset prior
+	 * to a full second it wants to be called at, and invokes
+	 * rtc_tv_nsec_ok() internally.
 	 */
-	rc = rtc_set_ntp_time(adjust, &target_nsec);
+	rc = rtc_set_ntp_time(adjust, &offset_nsec);
 	if (rc == -ENODEV)
 		return;
 
-	sched_sync_hw_clock(now, target_nsec, rc);
+	sched_sync_hw_clock(offset_nsec, rc != 0);
 }
 
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
@@ -599,7 +588,7 @@ static bool sync_cmos_clock(void)
 		}
 	}
 
-	sched_sync_hw_clock(now, target_nsec, rc);
+	sched_sync_hw_clock(target_nsec, rc != 0);
 	return true;
 }
 
@@ -629,7 +618,7 @@ void ntp_notify_cmos_timer(void)
 
 	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
 	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
-		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
+		queue_work(system_power_efficient_wq, &sync_work);
 }
 
 /*
@@ -1044,4 +1033,6 @@ static int __init ntp_tick_adj_setup(cha
 void __init ntp_init(void)
 {
 	ntp_clear();
+	hrtimer_init(&sync_hrtimer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	sync_hrtimer.function = sync_timer_callback;
 }



