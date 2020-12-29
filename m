Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1D2E74E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL2VnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:43:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25574 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgL2VnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:43:03 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTLUe4Z002470
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:42:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=R9kPP/lEoBHNr359JNbzFz6x5hJOHrDNpor5qic2pe8=;
 b=U8WJ+ZRDP4fPjLMinfj0KADPqp5GnuGwatGaHWhHLwRI47NLrxvpnkZ324VPFiNprikt
 X5hR1JFamcbG2LGxF1Az8mcRlHHQrJxIkUM8OpNmpr3+vZVA0r/mhcQidwLeksMj10AF
 Gjx6jDrhexI0ElDn0hnaMF8g+ljKDI8jnag= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ppads2yw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:42:23 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 13:42:21 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BB8EB62E4F0A; Tue, 29 Dec 2020 13:42:19 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v7 0/3] Introduce perf-stat -b for BPF programs
Date:   Tue, 29 Dec 2020 13:42:11 -0800
Message-ID: <20201229214214.3413833-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_16:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012290132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces perf-stat -b option to count events for BPF programs.
This is similar to bpftool-prog-profile. But perf-stat makes it much more
flexible.

Changes v6 =3D> v7
  1. Merge documentation change with feature change. (Arnaldo)
  2. Fix python import perf. (Arnaldo)
  3. Other small fixes. (Namhyung)
  4. Improve allocation/free of bpf skeleton. Also added assert()'s to
     debug a segfault.

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

Song Liu (3):
  bpftool: add Makefile target bootstrap
  perf: support build BPF skeletons with perf
  perf-stat: enable counting events for BPF programs

 tools/bpf/bpftool/Makefile                    |   2 +
 tools/build/Makefile.feature                  |   4 +-
 tools/perf/Documentation/perf-stat.txt        |  18 ++
 tools/perf/Makefile.config                    |   9 +
 tools/perf/Makefile.perf                      |  49 ++-
 tools/perf/builtin-stat.c                     |  82 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 297 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  72 +++++
 tools/perf/util/bpf_skel/.gitignore           |   3 +
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
 tools/perf/util/evsel.c                       |   9 +
 tools/perf/util/evsel.h                       |   5 +
 tools/perf/util/python.c                      |  21 ++
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat.c                        |   2 +-
 tools/perf/util/target.c                      |  34 +-
 tools/perf/util/target.h                      |  10 +
 tools/scripts/Makefile.include                |   1 +
 19 files changed, 696 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

--
2.24.1
