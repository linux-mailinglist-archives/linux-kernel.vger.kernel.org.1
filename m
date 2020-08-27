Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2447C254C70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0RwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 13:52:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49822 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgH0RwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:52:20 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RHos2s021672
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=t0u1GdS/GsDLLXOwIOkkJ5krxovYtPBEXfJM9OWBdus=;
 b=EAAmWl8CFRNeBxb/vm8dscjZ6A+3HX3FxAB08KXrXDccC2vlxMAP7tc31Ww0D7D7przJ
 0r7mpgscIpIeuCTVdJyTsGJ/zvL1HaFCSPPHPRUHdBiylUBuTc2ca2CctScdmrJWDpfb
 oyYMd26MmC2/S3xXrtgQEEZDo59HHauCK0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 335up66kmh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:19 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 10:52:18 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 32FE23922485; Thu, 27 Aug 2020 10:52:16 -0700 (PDT)
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
Subject: [PATCH RFC 2/4] mm: kmem: remove redundant checks from get_obj_cgroup_from_current()
Date:   Thu, 27 Aug 2020 10:52:13 -0700
Message-ID: <20200827175215.319780-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200827175215.319780-1-guro@fb.com>
References: <20200827175215.319780-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_10:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=621 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=1 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are checks for current->mm and current->active_memcg
in get_obj_cgroup_from_current(), but these checks are redundant:
memcg_kmem_bypass() called just above performs same checks.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9c08d8d14bc0..5d847257a639 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2919,9 +2919,6 @@ __always_inline struct obj_cgroup *get_obj_cgroup_f=
rom_current(void)
 	if (memcg_kmem_bypass())
 		return NULL;
=20
-	if (unlikely(!current->mm && !current->active_memcg))
-		return NULL;
-
 	rcu_read_lock();
 	if (unlikely(current->active_memcg))
 		memcg =3D rcu_dereference(current->active_memcg);
--=20
2.26.2

