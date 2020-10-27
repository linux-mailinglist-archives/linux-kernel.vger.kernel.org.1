Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6A629CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371419AbgJ0Unn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:43:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504992AbgJ0Unn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:43:43 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4i7l-1kQb8Q3p4x-011esV; Tue, 27 Oct 2020 21:43:22 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v5 1/3] timens: additional helper functions for boottime offset handling
Date:   Tue, 27 Oct 2020 21:42:56 +0100
Message-Id: <20201027204258.7869-2-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
References: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LGcxdUQwgpU06/CvTxUIp1QJf4muYyVX3q96Yagp3RyJgHRKVy+
 WxH/cpJd4pgKkWep4eItjKADEN8B57aSzrqhN6Vx80YZ4O+VPmEI7hxzMow+8E1w5Ydz5N7
 EFNkmedCwFUUbFoXqJaKbQo4p0VYsOVgovxKWCT7bs5G2ZVBzpSoYSjiklyhth10q+g/Z7K
 oSWjfH4PTy/AAgJhIN3yQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rbcNAFtE0NU=:TAZ5HoQYvs71M/nnxTrLz1
 8yHbF5dGEqFOftfD0xkPmFFlNrH/mODdcx+yJ0/C6U6auBziAme19CCB7mO265VGriOoBrSVz
 1nJHdkSwhUTHsJjpzcJZrc8UmMCvUapK82pVwzQpGzpVPeIAjT115m3pBhcbd5DfzkRmKN54N
 LFoNPNDTY2fZ0Pth1nldZjRUgpNr0OgP7q20hG7gF4z0ww9LohDmaqYh5rt4C+7S+clkACHnZ
 Q7n01gOQNK9VLPR/t2Pgd0t/WDr6TTzMfvsSyug1INZBmMnv8cVQGRRJBjTjr40VsXmkywbFR
 qPywrWDZK6VYLZm4Z+cjytxxBG0B19HVlwnM4fK+OWNi2ZyR9gNsmvw6+GMjmkEXz12J1J23p
 n0vyOnQY+Cl1tVxrefvQvNxQiKTVMumqwm1NmJpE6xkwzRUtopirayc87n3z2xPEKIoYu1N4Y
 ucePNvtfXw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide functions for time_namespace to subtract the boottime offset
from a timespec64 as well as to apply the boottime offset to u64 types in
nanoseconds.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Reviewed-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/time_namespace.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 5b6031385db0..68770ac9ba89 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -77,6 +77,20 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 	*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+static inline u64 timens_add_boottime_ns(u64 nsec)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	return nsec + timespec64_to_ns(&ns_offsets->boottime);
+}
+
+static inline void timens_sub_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_sub(*ts, ns_offsets->boottime);
+}
+
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *offsets);
 
@@ -130,6 +144,14 @@ static inline int timens_on_fork(struct nsproxy *nsproxy,
 
 static inline void timens_add_monotonic(struct timespec64 *ts) { }
 static inline void timens_add_boottime(struct timespec64 *ts) { }
+
+static inline u64 timens_add_boottime_ns(u64 nsec)
+{
+	return nsec;
+}
+
+static inline void timens_sub_boottime(struct timespec64 *ts) { }
+
 static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 {
 	return tim;
-- 
2.20.1

