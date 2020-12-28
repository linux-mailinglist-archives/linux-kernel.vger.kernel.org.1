Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C42E69D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgL1RmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:42:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727743AbgL1Rlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:41:53 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BSHYfF6013383
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:41:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ysenkaz4xmHiGN9QNiiBDXf9aT5VS5bVRHvXpXtXS3s=;
 b=L8pLPuigLh1MGa12MmPBNbq1C71C0KMQiCkWSNgL2nzk2OFGw/3tyvcBZRX84V8MlQeY
 VL4fn7x9QGShcU3W3tk1Jq/oPsNcWxTFexqloWhd6KSv4U5EmKKuY1vO0RtnSBMR1+Ky
 CqBk9E2d16DmnaWlGnT0p6O0pDlxtiYYAP8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35p1j5xr9p-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:41:11 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 09:41:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7914B62E2D3A; Mon, 28 Dec 2020 09:41:08 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v6 4/4] perf-stat: add documentation for -b option
Date:   Mon, 28 Dec 2020 09:40:54 -0800
Message-ID: <20201228174054.907740-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201228174054.907740-1-songliubraving@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=5 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280111
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

