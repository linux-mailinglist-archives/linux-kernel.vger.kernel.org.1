Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1D2B8AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 05:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKSEve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 23:51:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgKSEvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 23:51:33 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AJ4ohPm012475
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 20:51:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=PmKS75Xrv7Kke1VkeKehrXT+xlpU2bXjjyoz5QH6p18=;
 b=YGWiUhzEfPokrz5UwWyERddMOTo6OGY8Dm/QM6zH0jr4LQzcuVBBMmFOKtrF0nl7SI8R
 FqiIHOK3CAehle0h4aYbx/bPFtW3KcjQXUNi8aP/k26Qdusu+w25lxZ79OG4MCmNDQfp
 y5SI6BNU7tA23Kmi5MkchTQ8BcCEisJLJ1o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34wfdq1nug-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 20:51:10 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 20:50:59 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BF83A62E572B; Wed, 18 Nov 2020 20:50:51 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [RFC 0/2] Introduce perf-stat -b for BPF programs
Date:   Wed, 18 Nov 2020 20:50:44 -0800
Message-ID: <20201119045046.1491106-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_01:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=979 malwarescore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011190035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces perf-stat -b option to count events for BPF programs.
This is similar to bpftool-prog-profile. But perf-stat makes it much more
flexible.

Sending as RFC because I would like comments on some key design choices:
  1. We are using BPF skeletons here, which is by far the easiest way to
     write and ship BPF programs. However, this requires bpftool, which
     makes building perf slower.
  2. A Makefile is added to tools/perf/util/bpf_skel/ to build bpftool,
     and BPF skeletons. This keeps main perf Makefiles simple. But we may
     not like it for some reason?

Some known limitations (or work to be done):
  1. Only counting events for one BPF program at a time.
  2. Need extra logic in target__validate().

Song Liu (2):
  perf: support build BPF skeletons with perf
  perf-stat: enable counting events for BPF programs

 tools/build/Makefile.feature                  |   3 +-
 tools/perf/Makefile.config                    |   8 +
 tools/perf/Makefile.perf                      |  15 +-
 tools/perf/builtin-stat.c                     |  59 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 215 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  71 ++++++
 tools/perf/util/bpf_skel/.gitignore           |   3 +
 tools/perf/util/bpf_skel/Makefile             |  71 ++++++
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  96 ++++++++
 tools/perf/util/bpf_skel/dummy.bpf.c          |  19 ++
 tools/perf/util/evsel.c                       |  10 +
 tools/perf/util/evsel.h                       |   5 +
 tools/perf/util/target.h                      |   6 +
 14 files changed, 571 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/Makefile
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c

--
2.24.1
