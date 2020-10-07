Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566FD2868C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgJGUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:01:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgJGUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:01:11 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MS1G7-1jxTFf10A7-00TQr3; Wed, 07 Oct 2020 22:01:00 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH 2/4] time: make getboottime64 aware of time namespace
Date:   Wed,  7 Oct 2020 22:00:13 +0200
Message-Id: <20201007200015.30868-3-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
References: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TtdGxJuc052LA4JoAQpYc33ga/icKugcRW0L0htSiNDaw06Yi1j
 Y0TrcJ9/B69taE3TIZcimnkVZvHkWlkA8V61nhwDnaF3ydNTY/P1VJXFhLn5l7zGoGKm/PC
 9n6SSWKl9hi1hLVXzStipuYLWTffHse+556Zlh5EvMdhdhEzSsS8bkfXrMbK9IMlQkWRzpX
 HredVY7Y8Du/CRvDa6v7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oq9qsu6qBNM=:oE8BelEru/jV//JqG40IXK
 g3GqJc+7mYYQDL555IiIjf9EAAHCf26I/J/MboZu8rzPMFHCOgU1rr/z9tRWbFPOaxZlQxG1R
 zD1Zo/K/7DmJmIwLh34+8BBlKj2slsVs0BsrwteemKR8pIX3l9Vl5BncnpHfO6zx0EzZ8e2/k
 yBjoI48fqYyRw5LtRWzNqVmCgGQPriNtd4vqmYi5puheZrlx6Wik/ESCvioVKYGgSkadW1cbD
 yFYdJTeCKBYJZHTgWxl1SueqWA9YSRDVi9wWY6LvyJ8+PUAuKYAfpiazJkX/L76Zdorq2WDXN
 92wAgceWowjWXHhg4ccoFT+esAk8xTMlUQ/o4w4pq0q1Cn4R2hTv7vlYqQo2ucR+0Y/hRVJGE
 cToNgh1b0v7gEnkeqAyUV3ufOWlqJk2fPdxf1QX/9aow+sf0H8Ftl4qGCfq6oEsuzrjw66ZQZ
 FSWh6noE816TGNtDWg/WHSdaShs+zJtJAFpqzIb5Y6z7pe3uUkdzA3uP3mSj1IAn9dJGszp+3
 emDP0D7vCeMNRThCLHCZnHbD3oK/FO8RZ+6pq/xDeWFn2uV/YjCnzXqMYbKO8UBQDbB8btofS
 ycg5n8P3igcTe+cspU7sdoQBUp3Cys03T2udbDDpePtqBa6f7qEO1QoSCXPvh3+ZWV2F1CgCl
 eP4fkBCO5P8n2mrAeN3U1qm6A6pS/+KerOP7ZliHMpgSvdUDJIrOHb7qQ/YRQB27LXvnK2NfO
 c9gC9Yo4rp1bVCnGrvnR+SI64vsQ2jX6Bi8Kd3Z3H/oxRVv0HP95+wf1VaU97OJdvnIdC3N+f
 Wxb55PJwFseMDvG3ZSyUdEsjIFiDj1XXQXtr5eMBKF4BtZgXzwB+GUUXOM2IsORng3O9OQt9+
 5h5QAhqaeTBs6P/I0CwQ==
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

