Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C44A2DB371
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbgLOSPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:15:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731353AbgLOSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:15:16 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFHtO9g000302
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:14:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ysenkaz4xmHiGN9QNiiBDXf9aT5VS5bVRHvXpXtXS3s=;
 b=T193JbASrtoqNTl0YTwyirA/YefahJNPzf7mRvp6eZsHDEB8aEN0rN8fSBBSP//0e9XM
 8rM3rsgMlMBBeW3xGpHKqMxBSGjgOYlHVv5YssFdXShMURnzRUMhCsmykqPmbSn2BSDy
 iU9QWRLQcMhZpO8AfyNGRZ5FEYrSBOL3VAU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35desuc9g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:14:31 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 10:14:30 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 36ECF62E330B; Tue, 15 Dec 2020 10:14:28 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v5 4/4] perf-stat: add documentation for -b option
Date:   Tue, 15 Dec 2020 10:14:12 -0800
Message-ID: <20201215181412.1730974-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201215181412.1730974-1-songliubraving@fb.com>
References: <20201215181412.1730974-1-songliubraving@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 adultscore=4 lowpriorityscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to perf-stat -b option, which stats event for BPF
programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/Documentation/perf-stat.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentat=
ion/perf-stat.txt
index 5d4a673d7621a..15b9a646e853d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -75,6 +75,20 @@ report::
 --tid=3D<tid>::
         stat events on existing thread id (comma separated list)
=20
+-b::
+--bpf-prog::
+        stat events on existing bpf program id (comma separated list),
+        requiring root righs. For example:
+
+  # perf stat -e cycles,instructions --bpf-prog 17247 --timeout 1000
+
+   Performance counter stats for 'BPF program(s) 17247':
+
+             85,967      cycles
+             28,982      instructions              #    0.34  insn per cyc=
le
+
+        1.102235068 seconds time elapsed
+
 ifdef::HAVE_LIBPFM[]
 --pfm-events events::
 Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
--=20
2.24.1

