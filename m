Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD32CE7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLDGOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:14:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36160 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgLDGOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:14:07 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B467i7P019128
        for <linux-kernel@vger.kernel.org>; Thu, 3 Dec 2020 22:13:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=PpabM8rEMH4roP3HJQzPR4kB+m9mly7MpR542KUn0Zo=;
 b=MoMjJgJdWwD0AWV/YPh9gfvdEPwRoO0g2+Cee+lz9Nn0jSB3L5t9FV+EnDL1hI86l7xe
 sn0bjIldXkaybYy6xLA2X94WFYxdBX3vJ0K5VDaTKFWaXBQjSiDPQPtZoHJSO4OAFF1n
 usCCeVQVx1w/A5U/+Kqnkk5/poyTUUkasSI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3562ma9au0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 22:13:25 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 22:13:23 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4190162E596C; Thu,  3 Dec 2020 22:13:16 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 0/2] Introduce perf-stat -b for BPF programs
Date:   Thu, 3 Dec 2020 22:13:08 -0800
Message-ID: <20201204061310.3196812-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=1 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=817 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces perf-stat -b option to count events for BPF programs.
This is similar to bpftool-prog-profile. But perf-stat makes it much more
flexible.

Changes PATCH v1 =3D> PATCH v2:
  1. Various fixes in Makefiles. (Jiri)
  2. Fix an build warning/error with gcc-10. (Jiri)

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
 tools/perf/Makefile.config                    |   9 +
 tools/perf/Makefile.perf                      |  44 ++-
 tools/perf/builtin-stat.c                     |  77 ++++-
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
 16 files changed, 637 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

--
2.24.1
