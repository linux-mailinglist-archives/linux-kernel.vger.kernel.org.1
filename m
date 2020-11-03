Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD32A566A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgKCV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:27:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733263AbgKCV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:27:40 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A3LFQvQ030454
        for <linux-kernel@vger.kernel.org>; Tue, 3 Nov 2020 13:27:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=yCke0IQHgrkifTuQ0Dl6dNGewQHXJuLVGHnNeFGrg0s=;
 b=L4luCOIZI/FjNwF2ydDRfM7kwgCPJdUkLkJ7LANF4ZuEmz2NN0SK3i7eqz/l2aJwRjc/
 AcSgT3UijlqJ+3phDhM21l3876FSPZYo8wIrDb4aC/1AivRrCs5t8lKeScEELRIT0eZP
 j+3tqC3HaNHkqzRKB/A6HNAVXticwfj+QvE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34k9k3ahrx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:27:38 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 13:27:37 -0800
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 5A5F8202668E; Tue,  3 Nov 2020 13:27:27 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 0/3] mm: memcg: deprecate cgroup v1 non-hierarchical mode
Date:   Tue, 3 Nov 2020 13:27:22 -0800
Message-ID: <20201103212725.3716088-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_14:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=565 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=1 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030142
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

