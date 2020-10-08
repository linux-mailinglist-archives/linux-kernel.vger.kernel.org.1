Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB7286E36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgJHFkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:40:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgJHFke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:40:34 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N63NQ-1kSWHo0Lm4-016OoD; Thu, 08 Oct 2020 07:40:24 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
Date:   Thu,  8 Oct 2020 07:39:42 +0200
Message-Id: <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Cf9gHLAJMHLfOMZzoSVqao8dyO5jv9z/kPbG8b2aGn+ViU2I24S
 6ZY7gqEHoKKLbaJgXAZVuo3cKDkkAIpjZVuDZVe9fF/hIiPiB0kqx4MQBcHbjauoPZzzHc2
 RQBrDbUtfiPlLr8A1YkONJz+K/Dpa4vg7LQ9o44/aFG3FYaKWknBgeLPxM/VR9tOqk1V54D
 rTbqn0yzwPLI0PLReuRMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FLygPdmyepM=:lGUMuV5pwFqJDV2J+gfcG9
 HW/jFpo2wYDtKVKb989bgaw0fpWC9xHYcEN2fOD2aQwM2pYncUx4yjiRf0ztZ8JJHAaN6MX+Z
 cA6gUFBEAOtL+vE08GmM2K/b3aUnOXtqLMG7Tthp5B8HuMNKZmFtOnRNcOx+M3Lq7NWcYdJoU
 ODf2wxlRIFFn0IL6gpUewCnCn6Oq0VKYZv7qXeoMLj1/1EZUiUMotjpxyZ1/xIxaVeERhsEBZ
 bkTiO2ILtQGiPWt2bzn9qNIGYSvD0KAsf7g5Kt9hkjf9BJggWLNQw1xGWPZo9s/uWdPxE5rou
 O5dDIAD2+2OhrgT3pXIH88sRvs66EfANp2ngw1b44WkAMeAXGDark5WKz5aGaefUeF5O8jDeV
 dQ/gMi8SzdnCvjugMRQdEEG/Cy7wSzpa7zsBBysCC0hUdHrkdsM470zMNOoKbZtWVV133VfSY
 CXGHnaMKhPiiTAi+82X22jYJfM31Kaa10WsjBLeudsTX2RPWnxG3DH9SOpc8qfxLE+JWmfZGc
 ckOD3rISqPlndF9Z9szS8uGV5L6AYpbjLTEk9kJFpQ7O1qTfDMQ3hm2cER91xpoo/O1oTsuxS
 ovr/nkxG614yGqLE84hN8+EQqjOqJDpapSC18w6eTF053UOPvjbrQt93lM5lID8P33rjJgB7y
 6GiwaJWGImZvCrUl2+m1hAaNJ2M7ilZPULiDBNDVNvrruYhzrlj9IIqzJf9Zo1I7l+NhCNIuf
 DQGFR0HZ52VpYBxevBfUqS1s29ez4yS0+tvHOE8TtmknsBSQPPh9waFUWyltpPKLPZZL0tESJ
 qiXzc9Q8WQ8YazXqxFQ4tdKbTAgUnmZNOtXbsfG3F9BKZP7O02aokZ6MfAFdNbUTQI6SWpthl
 T8TL/RrJjvV6SunwqLTg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getboottime64() provides the time stamp of system boot. In case of
time namespaces, the offset to the boot time stamp was not applied
earlier. However, getboottime64 is used e.g., in /proc/stat to print
the system boot time to userspace. In container runtimes which utilize
time namespaces to virtualize boottime of a container, this leaks
information about the host system boot time.

Therefore, we make getboottime64() to respect the time namespace offset
for boottime by subtracting the boottime offset.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 kernel/time/timekeeping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f388a83f..67530cdb389e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -17,6 +17,7 @@
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/tick.h>
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
@@ -2154,6 +2155,8 @@ void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
+	/* shift boot time stamp according to the timens offset */
+	t = timens_ktime_to_host(CLOCK_BOOTTIME, t);
 
 	*ts = ktime_to_timespec64(t);
 }
-- 
2.20.1

