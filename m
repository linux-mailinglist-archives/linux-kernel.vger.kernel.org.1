Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1198F2CB90E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgLBJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:38:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387860AbgLBJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:38:01 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B29RP7f012443
        for <linux-kernel@vger.kernel.org>; Wed, 2 Dec 2020 01:37:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JJq6mFI+i8uDLTwckDPXLhwJH0RWXn5tfrXuCgK8Bpk=;
 b=IhZVe3aMCSFku384TSEt6MZzFNCF3S8Ca4zeUIzCqZlhypEB5KQSJY7/Zo3vGXqGS1HO
 TO8NtbxG5zw7XKXYiTXQBnVYxjaEc4OBiJA9fZVQbNtFv1ufd0JoONTL6RmG+b/DaXoW
 CLw5UIZrDr2Kx/DQtWHvb608gcKnWqZrRhw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3562m9sgct-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:37:20 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 01:37:18 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A195862E59A5; Wed,  2 Dec 2020 01:37:15 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v1 0/2] Introduce perf-stat -b for BPF programs
Date:   Wed, 2 Dec 2020 01:37:07 -0800
Message-ID: <20201202093709.3374099-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_04:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=1 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=794 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces perf-stat -b option to count events for BPF programs.
This is similar to bpftool-prog-profile. But perf-stat makes it much more
flexible.

Changes RFC v2 =3D> PATCH v1:
  1. Support counting on multiple BPF programs.
  2. Add BPF handling to target__validate().
  3. Improve Makefile. (Jiri)

Changes RFC v1 =3D> RFC v2:
  1. Use bootstrap version of bpftool. (Jiri)
  2. Set default to not building bpf skeletons. (Jiri)
  3. Remove util/bpf_skel/Makefile, keep all the logic in Makefile.perf.
     (Jiri)
  4. Remove dependency to vmlinux.h in the two skeletons. The goal here i=
s
     to enable building perf without building kernel (vmlinux) first.
     Note: I also removed the logic that build vmlinux.h. We can add that
     back when we have to use it (to access big kernel structures).

Song Liu (2):
  perf: support build BPF skeletons with perf
  perf-stat: enable counting events for BPF programs

 tools/bpf/bpftool/Makefile                    |   2 +
 tools/build/Makefile.feature                  |   4 +-
 tools/perf/Makefile.config                    |  10 +
 tools/perf/Makefile.perf                      |  46 ++-
 tools/perf/builtin-stat.c                     |  70 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 281 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  73 +++++
 tools/perf/util/bpf_skel/.gitignore           |   3 +
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  96 ++++++
 tools/perf/util/evsel.c                       |  11 +
 tools/perf/util/evsel.h                       |   6 +
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/target.c                      |  34 ++-
 tools/perf/util/target.h                      |  10 +
 tools/scripts/Makefile.include                |   1 +
 16 files changed, 636 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

--
2.24.1
