Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDA2CBA0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgLBKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387427AbgLBKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606903285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfNSj/g+nonq0OZosWf2zSc7yUS9oiX/UR3lecdLm1w=;
        b=cz39VW6lnzPFjXE4OwXRuhFVv23ZuzOG6mZDHTWSY7a0jz73oxKTrEq7akcksoQCFshbfL
        cI1yOV9/XHRS2pj/GvtKxBPdV7Ew+LibizkyxjWtD5JsoAhyL6f1ENj1lqEVSY++gTgizg
        nwYyrg8iW3jMPfp/wfcs+dmbwuALlXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-42t4AdnTMXiyxnuzQXADHA-1; Wed, 02 Dec 2020 05:01:21 -0500
X-MC-Unique: 42t4AdnTMXiyxnuzQXADHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74466185E48B;
        Wed,  2 Dec 2020 10:01:20 +0000 (UTC)
Received: from holly.tpb.lab.eng.brq.redhat.com (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 177095C1BD;
        Wed,  2 Dec 2020 10:01:18 +0000 (UTC)
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCHv2] rtc: adapt allowed RTC update error
Date:   Wed,  2 Dec 2020 11:01:18 +0100
Message-Id: <20201202100118.2093139-1-mlichvar@redhat.com>
In-Reply-To: <20201201173540.GH5487@ziepe.ca>
References: <20201201173540.GH5487@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system clock is marked as synchronized via adjtimex(), the
kernel is expected to copy the system time to the RTC every 11 minutes.

There are reports that it doesn't always work reliably. It seems the
current requirement for the RTC update to happen within 5 ticks of the
target time in some cases can consistently fail for hours or even days.

It is better to set the RTC with a larger error than let it drift for
too long.

Instead of increasing the constant again, use a static variable to count
the checks and with each failed check increase the allowed error by one
jiffie. Reset the counter when the check finally succeeds. This will
allow the RTC update to keep good accuracy if it can happen in the first
few attempts and it will not take more than a minute if the timing is
consistently bad for any reason.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---

Notes:
    v2:
    - moved the static variable to callers in ntp.c

 drivers/rtc/systohc.c |  6 ++++--
 include/linux/rtc.h   | 14 +++++++++-----
 kernel/time/ntp.c     |  9 +++++++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index 8b70f0520e13..0777f590cdae 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -5,6 +5,7 @@
 /**
  * rtc_set_ntp_time - Save NTP synchronized time to the RTC
  * @now: Current time of day
+ * @attempt: Number of previous failures used to adjust allowed error
  * @target_nsec: pointer for desired now->tv_nsec value
  *
  * Replacement for the NTP platform function update_persistent_clock64
@@ -18,7 +19,8 @@
  *
  * If temporary failure is indicated the caller should try again 'soon'
  */
-int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
+int rtc_set_ntp_time(struct timespec64 now, unsigned int attempt,
+		     unsigned long *target_nsec)
 {
 	struct rtc_device *rtc;
 	struct rtc_time tm;
@@ -44,7 +46,7 @@ int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
 	 * it does not we update target_nsec and return EPROTO to make the ntp
 	 * code try again later.
 	 */
-	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, &to_set, &now);
+	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, attempt, &to_set, &now);
 	if (!ok) {
 		err = -EPROTO;
 		goto out_close;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 22d1575e4991..9f3326b43620 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -165,7 +165,8 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc);
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec);
+extern int rtc_set_ntp_time(struct timespec64 now, unsigned int attempt,
+				unsigned long *target_nsec);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
 			struct rtc_wkalrm *alrm);
@@ -213,24 +214,27 @@ static inline bool is_leap_year(unsigned int year)
  * a zero in tv_nsecs, such that:
  *    to_set - set_delay_nsec == now +/- FUZZ
  *
+ * The allowed error starts at 5 jiffies on the first attempt and is increased
+ * with each failed attempt to make sure the RTC will be set at some point,
+ * even if the timing is consistently inaccurate.
  */
 static inline bool rtc_tv_nsec_ok(s64 set_offset_nsec,
+				  unsigned int attempt,
 				  struct timespec64 *to_set,
 				  const struct timespec64 *now)
 {
-	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
-	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
+	unsigned long time_set_nsec_fuzz = (5 + attempt) * TICK_NSEC;
 	struct timespec64 delay = {.tv_sec = 0,
 				   .tv_nsec = set_offset_nsec};
 
 	*to_set = timespec64_add(*now, delay);
 
-	if (to_set->tv_nsec < TIME_SET_NSEC_FUZZ) {
+	if (to_set->tv_nsec < time_set_nsec_fuzz) {
 		to_set->tv_nsec = 0;
 		return true;
 	}
 
-	if (to_set->tv_nsec > NSEC_PER_SEC - TIME_SET_NSEC_FUZZ) {
+	if (to_set->tv_nsec > NSEC_PER_SEC - time_set_nsec_fuzz) {
 		to_set->tv_sec++;
 		to_set->tv_nsec = 0;
 		return true;
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 069ca78fb0bf..893bc7ed7845 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -531,6 +531,7 @@ static void sched_sync_hw_clock(struct timespec64 now,
 
 static void sync_rtc_clock(void)
 {
+	static unsigned int attempt;
 	unsigned long target_nsec;
 	struct timespec64 adjust, now;
 	int rc;
@@ -548,9 +549,11 @@ static void sync_rtc_clock(void)
 	 * The current RTC in use will provide the target_nsec it wants to be
 	 * called at, and does rtc_tv_nsec_ok internally.
 	 */
-	rc = rtc_set_ntp_time(adjust, &target_nsec);
+	rc = rtc_set_ntp_time(adjust, attempt++, &target_nsec);
 	if (rc == -ENODEV)
 		return;
+	if (rc != -EPROTO)
+		attempt = 0;
 
 	sched_sync_hw_clock(now, target_nsec, rc);
 }
@@ -564,6 +567,7 @@ int __weak update_persistent_clock64(struct timespec64 now64)
 
 static bool sync_cmos_clock(void)
 {
+	static unsigned int attempt;
 	static bool no_cmos;
 	struct timespec64 now;
 	struct timespec64 adjust;
@@ -585,7 +589,8 @@ static bool sync_cmos_clock(void)
 	 * implement this legacy API.
 	 */
 	ktime_get_real_ts64(&now);
-	if (rtc_tv_nsec_ok(-1 * target_nsec, &adjust, &now)) {
+	if (rtc_tv_nsec_ok(-1 * target_nsec, attempt++, &adjust, &now)) {
+		attempt = 0;
 		if (persistent_clock_is_local)
 			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
 		rc = update_persistent_clock64(adjust);
-- 
2.26.2

