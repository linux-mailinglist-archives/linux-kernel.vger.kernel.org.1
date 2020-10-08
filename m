Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78E4286E34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJHFkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:40:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgJHFkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:40:35 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8QNs-1kM0wx3P7I-004UXh; Thu, 08 Oct 2020 07:40:23 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v2 1/4] timens: additional helper function to add boottime in nsec
Date:   Thu,  8 Oct 2020 07:39:41 +0200
Message-Id: <20201008053944.32718-2-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:puzRsvxLTJXK+fV5CUi0HZ3T1AlsKk7+FZxJjysPbO4QpGJE59U
 qyqW6Q7QW2G9X7T2Wf4FqiInVQr6rBXrelwAWzw4SLC8udN/xd0JeIptbEx63h+7dglyP3W
 yQho3OrBnxJG8+GA6MeEn8dHgOP/QIOG+pCyHBrqhVLWG8/CVxU9u5hkTGcHY+ihRXCzslH
 My8KDlGj3XzgUPHCCK7mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+AMmvSguBMw=:BV/yZ2JTGVzM6KxdelU/Lx
 Ece5bIi9D2HgV7BtXuDI6OZVxAb4XFCuiPmMo+//iN4lqGT3RGwowthMAB/fF6xPGf+jiU6SO
 ab3UpNz7uF7Yny45wLB8jeX+iNUoJDbnygzkEuIMODw1+2iaOVYWt83vyrbc8YKmBrD00hMxn
 HTAKY13q1TYDBVG07po49xljkUIAW71nGxMpp39690un9N5Q7T6ajjXRg/WA1GUrtjGyhy7sr
 FKeyOXNEIqcWxg/ovBS/wVeDBVS72mdWeFJK9SRhbW07zwbdkt91Nm/yMPmGV4KFL0xYE2ouc
 TTf8abyxA5ycddt2Xw9V6KZhypV+VuWpmu64ngY/Rb2sIl0XLIVoVhNgOZwKVd1LrODuu2qfP
 +VMxY+qRiO11Ud46FBcT9/AW+gQ1TeRnKswielL4McUDWFnTY+eVDPsq8un0WQZMZTW3vAmMf
 7+43UMS1WZrh+vKEXSkvvjCNuXht24IwU1udxcPhI2gPh0HuLGdDEWqPrF8KjAnSligPnXW2I
 O1ZDApCQB8jlkPYN8jYMtzlM1beLFSeIeohJlXaEl+QmiqNCQDzVx4bi13rbioRDA0J68iqcS
 /gJUq94xJGBIG5Zkz9obD+ctdp26dBdYYZ1OgeQpXPh4SZYrjCbHOyU32J4HAw5ws6UfBIaGK
 +tGsojtZRgzh8TekO9aDgCScG0gmVovzJDZaB4pKDRIFsbpD+N2NjW3Jd7/UQz65sKp7kxo7V
 1X1rwc8bc5HTdAHBj7qxLnniq7O2Kywad3jEIgTi7RsBC9T3pm5FA9jVZ25VNP5wd3Bx2zKGD
 bLLHIKziNI85R0xhI53xXWjMAS1zi/oQD/A9KJZuGrtKZIcOGmxIk5fF1taYhl7F9110dVgvl
 ljR6CEDWIWwmKzixH6Xg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a helper function to apply the boottime offset to u64 types
in nanoseconds.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/time_namespace.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 5b6031385db0..5372181010f9 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -77,6 +77,13 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 	*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+static inline u64 timens_add_boottime_ns(u64 nsec)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	return nsec + timespec64_to_ns(&ns_offsets->boottime);
+}
+
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *offsets);
 
@@ -130,6 +137,12 @@ static inline int timens_on_fork(struct nsproxy *nsproxy,
 
 static inline void timens_add_monotonic(struct timespec64 *ts) { }
 static inline void timens_add_boottime(struct timespec64 *ts) { }
+
+static inline u64 timens_add_boottime_ns(u64 nsec)
+{
+	return nsec;
+}
+
 static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 {
 	return tim;
-- 
2.20.1

