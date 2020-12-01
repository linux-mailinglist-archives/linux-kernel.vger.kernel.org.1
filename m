Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123022CA5EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbgLAOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:40:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389462AbgLAOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606833535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ld3EJGeffzGbwS28b30MuPmMHEkVkjE+LANi/PtEf7w=;
        b=R+msJP2xtHNpFn/o8rczq4VmIeOGAc4dDcwcWGvAEpI9s6YR5xHDEzxcZ6s2mxk/+1gWei
        pwZtCw3Igc83TOPkFPUF2MXqvAhr7QIzgph/LctmNzOJ/EzsRrxvSP/eJWpjI6xb3hESdB
        A0BqHSO0awRQHAHDPwzzThGhQWWJwww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-kdQZuW_kOi2c4cBB98Hy5Q-1; Tue, 01 Dec 2020 09:38:51 -0500
X-MC-Unique: kdQZuW_kOi2c4cBB98Hy5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E352CF984;
        Tue,  1 Dec 2020 14:38:38 +0000 (UTC)
Received: from holly.tpb.lab.eng.brq.redhat.com (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAC9C6EF57;
        Tue,  1 Dec 2020 14:38:36 +0000 (UTC)
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] rtc: adapt allowed RTC update error
Date:   Tue,  1 Dec 2020 15:38:35 +0100
Message-Id: <20201201143835.2054508-1-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Add a static variable to rtc_tv_nsec_ok() to count the checks. With each
failed check, relax the requirement by one jiffie, and reset the counter
when it finally succeeds. This should allow the RTC update to happen in
a minute at most.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
 include/linux/rtc.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 22d1575e4991..8d105f10ef6a 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -218,21 +218,30 @@ static inline bool rtc_tv_nsec_ok(s64 set_offset_nsec,
 				  struct timespec64 *to_set,
 				  const struct timespec64 *now)
 {
-	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
-	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
 	struct timespec64 delay = {.tv_sec = 0,
 				   .tv_nsec = set_offset_nsec};
+	unsigned long time_set_nsec_fuzz;
+	static unsigned int attempt;
 
 	*to_set = timespec64_add(*now, delay);
 
-	if (to_set->tv_nsec < TIME_SET_NSEC_FUZZ) {
+	/*
+	 * Determine allowed error in tv_nsec.  Start at 5 jiffies and add a
+	 * jiffie with each failed attempt to make sure the RTC will be set at
+	 * some point, even if the update cannot be scheduled very accurately.
+	 */
+	time_set_nsec_fuzz = (5 + attempt++) * TICK_NSEC;
+
+	if (to_set->tv_nsec < time_set_nsec_fuzz) {
 		to_set->tv_nsec = 0;
+		attempt = 0;
 		return true;
 	}
 
-	if (to_set->tv_nsec > NSEC_PER_SEC - TIME_SET_NSEC_FUZZ) {
+	if (to_set->tv_nsec > NSEC_PER_SEC - time_set_nsec_fuzz) {
 		to_set->tv_sec++;
 		to_set->tv_nsec = 0;
+		attempt = 0;
 		return true;
 	}
 	return false;
-- 
2.26.2

