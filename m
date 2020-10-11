Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1528A7E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgJKPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:00:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbgJKPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:00:25 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQdpG-1koDsv3EgA-00NmLo; Sun, 11 Oct 2020 16:59:51 +0200
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
Subject: [PATCH v3 1/3] timens: additional helper function to add boottime in nsec
Date:   Sun, 11 Oct 2020 16:59:22 +0200
Message-Id: <20201011145924.6554-2-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
References: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8YfIYKqXlcPNLnzmWPJ+x9+/e1ujppJubSe/TPQDd8Rn58cDmpq
 tg2cm5wwyBG859KTGhNz4pBmzGgAxilMXF7yniHkDVgH6fTxA6DbJGDdrhZBeOEhpFZNrL1
 QLg8AScPecLAslNwsjf+f0iS4N2YqLLHl2c3N4j88/21Qqvt5bzHnFLepKhuRDHisP/zbMb
 YBfR3g2AYrPEmeDewl5Iw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IPJ/mBIcng=:tiv14oVAT7eOHBldoc2LoD
 UpWC3PJPnXPzIHK5N4703e4IYC1uJTaUuZLB1IC5MQ50UzmATU5kUqygYoo6yx0rmv/2x8hR4
 Ub0vxDM6Vz2vI43cdTJy+KvNhbwY9eRrRc8DLxsctskvaP1mZqN5AaL5w0tZYLZMl2i4RJJzv
 TcHJYIocu6CvyYzB3b/isfrl6Rcm/EDocLI+7F30lBzW+6glJK/WFtuR8iD9SA2pLyInKOeEF
 C6O/ZrLL21vLtRYjNJ3OmMlyJS2ZKEdiN117mCW2nEOV+jU/7ibqVQwrBTCCBJEMaLlNduoZ3
 LA7QDOta74va89K6T5hSz4saLFoz3QYiv0gYbIHUBQilNKIoW3u7ESCyr2JWTieS/n/CTUuM3
 gpELCyuNj3pnRumdMdtyJY8tRdmE6uaBf+wRWKa5KGo2dPtGCvVPIgjDeIjl6EqH+gUKZDI3p
 Kv7Y32b3x2deCeyKOcJrm04hPk0XaBeBAv1kONKpGCV6oeM4uMgm22h14s9wbQBoQBD+hn7Yg
 JMcWC2fu6lSTq3NlFF1XRvh9FKGl5kTvHNkuGLhdlMeL0guklc3ECPlH+QhqteR5CdSDcSG0n
 XF232+5m9UyqSkeahmiCe5bCcBtlZV2x3MUBd2YR7CP78tOOhncO4kdUhieg46o0yUELhiIm2
 SffU1QC5oLwk77cGGuGI3aybAlZmge7WdUYZH5YmauPUV8yUxFu3mneSrfez+49713hsS8M2Z
 aJCWhXpsOPQMd1R6vBVQoHQBL+mBUEu82/V9KS0QlJGPct0CjeFNxG2BtrtOJMsBYsrT80Mwd
 cMC0yL1ekQLkQTnA7imAk1mt3/K1JpBno6igWBaGB8OkN2rsdbSSfd0ThY0y3OBJgYaNyIbe2
 ZVuZdRpA38oN31G3hRlA==
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

