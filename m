Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24996254C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH0Rw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 13:52:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5630 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgH0RwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:52:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RHmgU9019297
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GiSvtA9Y81I+jnIfUZtXBD50esug8S34EMBARaI7nmM=;
 b=foGAK5UqBbB+ZAGapE39yBPIE8Qge42QGP+OTLWgW6wstNydlIEUeOwHk3WUuLyx5qp6
 Ircwsuy0TsTmB9v4GllxJEF+KpBYR2TGUBMEPLo3Rkgvp0nVtp4mkfcIId5xwK1jcsm2
 2GU+ep1AEqxtK+aum6M0RjIdH6k/4x3agHA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 335up86mjs-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:21 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 10:52:19 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 3E5FD3922489; Thu, 27 Aug 2020 10:52:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH RFC 4/4] mm: kmem: enable kernel memcg accounting from interrupt contexts
Date:   Thu, 27 Aug 2020 10:52:15 -0700
Message-ID: <20200827175215.319780-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200827175215.319780-1-guro@fb.com>
References: <20200827175215.319780-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_10:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=1 adultscore=0 mlxlogscore=804 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memcg to charge can be determined (using remote charging API),
there are no reasons to exclude allocations made from an interrupt
context from the accounting.

Such allocations will pass even if the resulting memcg size will
exceed the hard limit, but it will affect the application of the
memory pressure and an inability to put the workload under the limit
will eventually trigger the OOM.

To use active_memcg() helper, memcg_kmem_bypass() is moved back
to memcontrol.c.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 12 ------------
 mm/memcontrol.c            | 13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..924177502479 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1528,18 +1528,6 @@ static inline bool memcg_kmem_enabled(void)
 	return static_branch_likely(&memcg_kmem_enabled_key);
 }
=20
-static inline bool memcg_kmem_bypass(void)
-{
-	if (in_interrupt())
-		return true;
-
-	/* Allow remote memcg charging in kthread contexts. */
-	if ((!current->mm || (current->flags & PF_KTHREAD)) &&
-	     !current->active_memcg)
-		return true;
-	return false;
-}
-
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a51a6066079e..75cd1a1e66c8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1098,6 +1098,19 @@ static __always_inline struct mem_cgroup *get_acti=
ve_memcg(void)
 	return memcg;
 }
=20
+static __always_inline bool memcg_kmem_bypass(void)
+{
+	/* Allow remote memcg charging from any context. */
+	if (unlikely(active_memcg()))
+		return false;
+
+	/* Memcg to charge can't be determined. */
+	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+		return true;
+
+	return false;
+}
+
 /**
  * If active memcg is set, do not fallback to current->mm->memcg.
  */
--=20
2.26.2

