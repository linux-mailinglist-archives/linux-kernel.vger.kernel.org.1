Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17328EA44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgJOBiY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Oct 2020 21:38:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388471AbgJOBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:38:23 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09F1cMPb025126
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:38:23 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3463ask5jc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:38:23 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 14 Oct 2020 18:38:01 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 166952EC7F8D; Wed, 14 Oct 2020 18:37:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] fs: clean up is_mounted() check with extra helper
Date:   Wed, 14 Oct 2020 18:37:39 -0700
Message-ID: <20201015013739.1969680-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_12:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxlogscore=708 adultscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add is_real_ns() helper validating that mount namespace is a valid one.
Use that from is_mounted() and clean up prepare_path() that open-coded similar
check.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/d_path.c | 3 +--
 fs/mount.h  | 9 +++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index a69e2cd36e6e..300bf675f097 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -119,8 +119,7 @@ static int prepend_path(const struct path *path,
 				continue;
 			}
 			mnt_ns = READ_ONCE(mnt->mnt_ns);
-			/* open-coded is_mounted() to use local mnt_ns */
-			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
+			if (is_real_ns(mnt_ns) && !is_anon_ns(mnt_ns))
 				error = 1;	// absolute root
 			else
 				error = 2;	// detached or not attached yet
diff --git a/fs/mount.h b/fs/mount.h
index c7abb7b394d8..0b0eb18ba80a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -92,10 +92,15 @@ static inline int mnt_has_parent(struct mount *mnt)
 	return mnt != mnt->mnt_parent;
 }
 
-static inline int is_mounted(struct vfsmount *mnt)
+static inline bool is_real_ns(const struct mnt_namespace *mnt_ns)
 {
 	/* neither detached nor internal? */
-	return !IS_ERR_OR_NULL(real_mount(mnt)->mnt_ns);
+	return mnt_ns && mnt_ns != MNT_NS_INTERNAL;
+}
+
+static inline int is_mounted(struct vfsmount *mnt)
+{
+	return is_real_ns(real_mount(mnt)->mnt_ns);
 }
 
 extern struct mount *__lookup_mnt(struct vfsmount *, struct dentry *);
-- 
2.24.1

