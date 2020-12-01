Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2122C983F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgLAHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:37:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18060 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgLAHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:37:42 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B17TLH9005707
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:36:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mG8kMFe0hpzW7+SS/HuAFCIQXx4s467SNhS2DkUKe0c=;
 b=kF0Ferp9JyDRsSfQPI4WFRMmpX1ETPgWU2OrxVbNfW56SqFEp4MQE5U/TTbW6QJN2pcR
 /O9je+FdcoT5Cu6sw/cX0RuXtcmbc50F/U3KROuQrs/UKebacG6cG9TlIbg6yf4PMnmF
 /QDbzC7VJ42v6vaKA3B6GKIloCGRlr34kYw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 353uh4uvf7-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:36:59 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 23:36:56 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 8D8DA62E5919; Mon, 30 Nov 2020 23:36:52 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [RFC v2 0/2] Introduce perf-stat -b for BPF programs
Date:   Mon, 30 Nov 2020 23:36:45 -0800
Message-ID: <20201201073647.753079-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_01:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=1
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=824 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces perf-stat -b option to count events for BPF programs.
This is similar to bpftool-prog-profile. But perf-stat makes it much more
flexible.

Sending as RFC because I haven't addressed some known limitations:
  1. Only counting events for one BPF program at a time.
  2. Need extra logic in target__validate().

Changes RFCv1 =3D> RFCv2:
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
 tools/build/Makefile.feature                  |   3 +-
 tools/perf/Makefile.config                    |   9 +
 tools/perf/Makefile.perf                      |  52 ++++-
 tools/perf/builtin-stat.c                     |  59 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 215 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  71 ++++++
 tools/perf/util/bpf_skel/.gitignore           |   3 +
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  96 ++++++++
 tools/perf/util/bpf_skel/dummy.bpf.c          |  19 ++
 tools/perf/util/evsel.c                       |  10 +
 tools/perf/util/evsel.h                       |   5 +
 tools/perf/util/target.h                      |   6 +
 tools/scripts/Makefile.include                |   1 +
 15 files changed, 541 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c

--
2.24.1
