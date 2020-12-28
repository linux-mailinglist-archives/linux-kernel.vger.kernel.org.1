Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46412E69CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgL1Rlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:41:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727742AbgL1Rlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:41:52 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSHZ68N020398
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:41:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=M0ufBGWnkKEV33QMjKoNcX1uFTXrnbP3vhJjRr90O8c=;
 b=d3OONolt759Vax/WNWmmRNKF3DggaojHJxmDXop7Nj2s3IOJq1171C8fKOmfE9berTEB
 kPGKYyCBMS5GWrVAaL7Sr/kX1uAMhESECg+G/WFiqjGygBiYuzPY1GYHGZQ8YZ/Xnx9I
 z81GksXY8JQm4jvgT15JQXn9Ma9O5MDGhBA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35pp4bcd2s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:41:11 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 09:41:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6955562E2D4B; Mon, 28 Dec 2020 09:40:58 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v6 0/4] Introduce perf-stat -b for BPF programs
Date:   Mon, 28 Dec 2020 09:40:50 -0800
Message-ID: <20201228174054.907740-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 mlxlogscore=990 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces perf-stat -b option to count events for BPF programs.
This is similar to bpftool-prog-profile. But perf-stat makes it much more
flexible.

Changes v5 =3D> v6
  1. Update the name for bootstrap bpftool. (Jiri)

Changes v4 =3D> v5:
  1. Add documentation. (Jiri)
  2. Silent make output for removing .bpf.o file. (Jiri)

Changes v3 =3D> v4:
  1. Split changes in bpftool/Makefile to a separate patch
  2. Various small fixes. (Jiri)

Changes v2 =3D> v3:
  1. Small fixes in Makefile.perf and bpf_counter.c (Jiri)
  2. Rebased on top of bpf-next. This is because 1/2 conflicts with some
     patches in bpftool/Makefile.

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

Song Liu (4):
  bpftool: add Makefile target bootstrap
  perf: support build BPF skeletons with perf
  perf-stat: enable counting events for BPF programs
  perf-stat: add documentation for -b option

 tools/bpf/bpftool/Makefile                    |   2 +
 tools/build/Makefile.feature                  |   4 +-
 tools/perf/Documentation/perf-stat.txt        |  14 +
 tools/perf/Makefile.config                    |   9 +
 tools/perf/Makefile.perf                      |  49 ++-
 tools/perf/builtin-stat.c                     |  77 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 296 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  72 +++++
 tools/perf/util/bpf_skel/.gitignore           |   3 +
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
 tools/perf/util/evsel.c                       |   9 +
 tools/perf/util/evsel.h                       |   6 +
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat.c                        |   2 +-
 tools/perf/util/target.c                      |  34 +-
 tools/perf/util/target.h                      |  10 +
 tools/scripts/Makefile.include                |   1 +
 18 files changed, 666 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

--
2.24.1
