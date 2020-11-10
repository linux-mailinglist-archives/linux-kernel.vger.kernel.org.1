Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A852AE28C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgKJWIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:08:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7132 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbgKJWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:08:07 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAM4krg009091
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:08:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Bh/X4g7eg1CB8q7LMWLH94dNX8ID4OwoQyO4pPareSM=;
 b=gcqk0kv9Wccw67j7LH/XGsspTzQNFIxUBpeXpkBYEp8xpF4cTttc70uNy2Vx1P1LoebP
 2umyQU2chGmBhsI/BhvvjJffbAtJXrQXFyvpAJY5fYdmu9zYQo+JGFksBg4J3O2JqliC
 7zL0DvIcEl2zaXoYUQI7imAwZ7aW5pyFeTw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34pcmjdajw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:08:05 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 14:08:05 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 2DA9C239AED2; Tue, 10 Nov 2020 14:08:01 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 0/3] mm: memcg: deprecate cgroup v1 non-hierarchical mode
Date:   Tue, 10 Nov 2020 14:07:57 -0800
Message-ID: <20201110220800.929549-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_08:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=699 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-hierarchical cgroup v1 mode is a legacy of early days
of the memory controller and doesn't bring any value today.
However, it complicates the code and creates many edge cases
all over the memory controller code.

It's a good time to deprecate it completely. This patchset removes
the internal logic, adjusts the user interface and updates
the documentation. The alt patch removes some bits of the cgroup
core code, which become obsolete.

From Michal Hocko:
All that we know today is that we have a warning in place to complain
loudly when somebody relies on use_hierarchy=3D0 with a deeper
hierarchy. For all those years we have seen _zero_ reports that would
describe a sensible usecase.
Moreover we (SUSE) have backported this warning into old distribution
kernels (since 3.0 based kernels) to extend the coverage and didn't hear
even for users who adopt new kernels only very slowly. The only report
we have seen so far was a LTP test suite which doesn't really reflect
any real life usecase.

v1:
  - added a note from Michal
  - added acks and reviews

rfc:
  - https://lwn.net/Articles/835983/


Roman Gushchin (3):
  mm: memcg: deprecate the non-hierarchical mode
  docs: cgroup-v1: reflect the deprecation of the non-hierarchical mode
  cgroup: remove obsoleted broken_hierarchy and warned_broken_hierarchy

 .../admin-guide/cgroup-v1/memcg_test.rst      |  8 +-
 .../admin-guide/cgroup-v1/memory.rst          | 40 +++------
 include/linux/cgroup-defs.h                   | 15 ----
 include/linux/memcontrol.h                    |  7 --
 kernel/cgroup/cgroup.c                        | 12 ---
 mm/memcontrol.c                               | 90 +++----------------
 6 files changed, 29 insertions(+), 143 deletions(-)

--=20
2.26.2

