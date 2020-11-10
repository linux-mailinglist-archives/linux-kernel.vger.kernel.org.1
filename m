Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220732AE28D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbgKJWII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:08:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45322 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:08:07 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAM50gJ009287
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:08:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3rEvTXwXGygIkUG9VhVhzqdHFFnaHJcGr6M+z46dO3c=;
 b=XnqC1qp/brZ1ov/fR5B30bwCWzq1eWQnpldStckk9zHzWE7uQQndI15Up+rna1YWJAJA
 0zHu3FD20bqL9GbZrdMVBdLaUBmYwOs3Wnyc/5DrUEoDu7QCYhTDnfkcZ93TngmPS7xR
 ng1KJHTpOPlgiSHZjXPLuDtWW7dwAgsfqug= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pcmjdaju-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:08:05 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 14:08:04 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 32044239AED5; Tue, 10 Nov 2020 14:08:01 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v1 2/3] docs: cgroup-v1: reflect the deprecation of the non-hierarchical mode
Date:   Tue, 10 Nov 2020 14:07:59 -0800
Message-ID: <20201110220800.929549-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201110220800.929549-1-guro@fb.com>
References: <20201110220800.929549-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_08:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update cgroup v1 docs after the deprecation of the non-hierarchical
mode of the memory controller.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 .../admin-guide/cgroup-v1/memcg_test.rst      |  8 ++--
 .../admin-guide/cgroup-v1/memory.rst          | 40 ++++++-------------
 2 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documen=
tation/admin-guide/cgroup-v1/memcg_test.rst
index 3f7115e07b5d..4f83de2dab6e 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -219,13 +219,11 @@ Under below explanation, we assume CONFIG_MEM_RES_C=
TRL_SWAP=3Dy.
=20
 	This is an easy way to test page migration, too.
=20
-9.5 mkdir/rmdir
----------------
+9.5 nested cgroups
+------------------
=20
-	When using hierarchy, mkdir/rmdir test should be done.
-	Use tests like the following::
+	Use tests like the following for testing nested cgroups::
=20
-		echo 1 >/opt/cgroup/01/memory/use_hierarchy
 		mkdir /opt/cgroup/01/child_a
 		mkdir /opt/cgroup/01/child_b
=20
diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
index 12757e63b26c..a44cd467d218 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -77,6 +77,8 @@ Brief summary of control files.
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
+                                     This knob is deprecated and shouldn=
't be
+                                     used.
  memory.force_empty		     trigger forced page reclaim
  memory.pressure_level		     set memory pressure notifications
  memory.swappiness		     set/show swappiness parameter of vmscan
@@ -495,16 +497,13 @@ cgroup might have some charge associated with it, e=
ven though all
 tasks have migrated away from it. (because we charge against pages, not
 against tasks.)
=20
-We move the stats to root (if use_hierarchy=3D=3D0) or parent (if
-use_hierarchy=3D=3D1), and no change on the charge except uncharging
+We move the stats to parent, and no change on the charge except unchargi=
ng
 from the child.
=20
 Charges recorded in swap information is not updated at removal of cgroup=
.
 Recorded information is discarded and a cgroup which uses swap (swapcach=
e)
 will be charged as a new owner of it.
=20
-About use_hierarchy, see Section 6.
-
 5. Misc. interfaces
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -527,8 +526,6 @@ About use_hierarchy, see Section 6.
   write will still return success. In this case, it is expected that
   memory.kmem.usage_in_bytes =3D=3D memory.usage_in_bytes.
=20
-  About use_hierarchy, see Section 6.
-
 5.2 stat file
 -------------
=20
@@ -675,31 +672,20 @@ hierarchy::
 		      d   e
=20
 In the diagram above, with hierarchical accounting enabled, all memory
-usage of e, is accounted to its ancestors up until the root (i.e, c and =
root),
-that has memory.use_hierarchy enabled. If one of the ancestors goes over=
 its
-limit, the reclaim algorithm reclaims from the tasks in the ancestor and=
 the
-children of the ancestor.
-
-6.1 Enabling hierarchical accounting and reclaim
-------------------------------------------------
-
-A memory cgroup by default disables the hierarchy feature. Support
-can be enabled by writing 1 to memory.use_hierarchy file of the root cgr=
oup::
+usage of e, is accounted to its ancestors up until the root (i.e, c and =
root).
+If one of the ancestors goes over its limit, the reclaim algorithm recla=
ims
+from the tasks in the ancestor and the children of the ancestor.
=20
-	# echo 1 > memory.use_hierarchy
-
-The feature can be disabled by::
+6.1 Hierarchical accounting and reclaim
+---------------------------------------
=20
-	# echo 0 > memory.use_hierarchy
+Hierarchical accounting is enabled by default. Disabling the hierarchica=
l
+accounting is deprecated. An attempt to do it will result in a failure
+and a warning printed to dmesg.
=20
-NOTE1:
-       Enabling/disabling will fail if either the cgroup already has oth=
er
-       cgroups created below it, or if the parent cgroup has use_hierarc=
hy
-       enabled.
+For compatibility reasons writing 1 to memory.use_hierarchy will always =
pass::
=20
-NOTE2:
-       When panic_on_oom is set to "2", the whole system will panic in
-       case of an OOM event in any cgroup.
+	# echo 1 > memory.use_hierarchy
=20
 7. Soft limits
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.26.2

