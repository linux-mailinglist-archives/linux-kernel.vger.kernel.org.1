Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB19F2A5669
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgKCV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:27:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733267AbgKCV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:27:34 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3LEJ22021738
        for <linux-kernel@vger.kernel.org>; Tue, 3 Nov 2020 13:27:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3WegILZCENU7df5tuo5kis2uN70iYKKUcHrJ54xZqZY=;
 b=hgBG4D6G/TGAUWMUhYi/P0DujZtEd9YUeTxQVVynkC6fC/fvueTFlGGmZs4cNPPJ1k4r
 ooOOtETISCtahlG34XyGl6zQI4ZnW5L5m6irSZy7yY6cep3Q9XiMxZOSLFGpORNhyc+j
 +99qMfuj452xvMyIY+hEVKkfacZoYUWSJ3Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34hr6p65mq-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:27:33 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 13:27:32 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 675FF2026694; Tue,  3 Nov 2020 13:27:27 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 3/3] cgroup: remove obsoleted broken_hierarchy and warned_broken_hierarchy
Date:   Tue, 3 Nov 2020 13:27:25 -0800
Message-ID: <20201103212725.3716088-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201103212725.3716088-1-guro@fb.com>
References: <20201103212725.3716088-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_14:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=1 mlxlogscore=831 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the deprecation of the non-hierarchical mode of the memory
controller there are no more examples of broken hierarchies left.

Let's remove the cgroup core code which was supposed to print
warnings about creating of broken hierarchies.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/cgroup-defs.h | 15 ---------------
 kernel/cgroup/cgroup.c      |  7 -------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index fee0b5547cd0..559ee05f86b2 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -668,21 +668,6 @@ struct cgroup_subsys {
 	 */
 	bool threaded:1;
=20
-	/*
-	 * If %false, this subsystem is properly hierarchical -
-	 * configuration, resource accounting and restriction on a parent
-	 * cgroup cover those of its children.  If %true, hierarchy support
-	 * is broken in some ways - some subsystems ignore hierarchy
-	 * completely while others are only implemented half-way.
-	 *
-	 * It's now disallowed to create nested cgroups if the subsystem is
-	 * broken and cgroup core will emit a warning message on such
-	 * cases.  Eventually, all subsystems will be made properly
-	 * hierarchical and this will go away.
-	 */
-	bool broken_hierarchy:1;
-	bool warned_broken_hierarchy:1;
-
 	/* the following two fields are initialized automtically during boot */
 	int id;
 	const char *name;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 621a586e3529..fefa21981027 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5149,13 +5149,6 @@ static struct cgroup_subsys_state *css_create(stru=
ct cgroup *cgrp,
 	if (err)
 		goto err_list_del;
=20
-	if (ss->broken_hierarchy && !ss->warned_broken_hierarchy &&
-	    cgroup_parent(parent)) {
-		pr_warn("%s (%d) created nested cgroup for controller \"%s\" which has=
 incomplete hierarchy support. Nested cgroups may change behavior in the =
future.\n",
-			current->comm, current->pid, ss->name);
-		ss->warned_broken_hierarchy =3D true;
-	}
-
 	return css;
=20
 err_list_del:
--=20
2.26.2

