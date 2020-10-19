Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFD292EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgJSTyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:54:04 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgJSTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:54:02 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOQyE-1knmWm3DTy-00PvQb; Mon, 19 Oct 2020 21:53:26 +0200
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
Subject: [PATCH v4 1/3] timens: additional helper functions for boottime offset handling
Date:   Mon, 19 Oct 2020 21:52:55 +0200
Message-Id: <20201019195257.10728-2-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E0D+k5IGlsCO7DO/+Mosa/rWcIGX2kkdWNEJw34R6y0jWM7TRJ2
 SdMMSye/Vm2OWksDIOO8qRBrY29PVHwiajvVMbmv1ginZcngJ2T4YbqgAdhoPylnreNHCEi
 PDkixxdUByQrvACFpprUCJFr1Rd17gtR3TxF9XQQKb0uxIOp1TtxXvNdZ3q3HysJ59oZPTU
 J3I3LrWpgQjmNAkQG8i5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YHlYm1DG2R0=:/fALJYG+jJB/EAMMJj/KRc
 JtPed7ZQIt9QtKMJtCg95dvFdpRz1TpeDkO1PkZgnjUWaPi+jOwPE05dUz8YzyiVUSi7q62Hd
 mg21AjQyC7ryzTMSZyb36h1tuvad0zFkwQ/UUGd4UsZo/NgPLBbmcwyvH4iqHafYizKJdiAZf
 f2PjGrkHZqX0W5yq6vrI38FP2OzPd5t+MMTyObTlxuGViSMeHngVz+WwZ8CW/O6TWAjMBbbrU
 h9fAcHuJQ8Je4aLIzoKgK02yysiqs0GXQUnSN4lZd06GCUsXLCwYANtItdNX+1+W77RBkFoRL
 Ap0TLiRQ3ip17T1xG2XqXoyemvIlQYKMGUdWACWTlYLYwjkRmmPEbxT9uRNv6oUlF6onpud5L
 IRvXjIjp/DUsolcdZ4zu1M8X6NiGFbrBgk/7smyIARpEfDj/3RWSYDim4N78xHwn39wAsAUjk
 DPFo/a+GxCXRPDhGvwqRs4sLjufAPAw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide functions for time_namespace to subtract the boottime offset
from a timespec64 as well as to apply the boottime offset to u64 types in
nanoseconds.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
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

