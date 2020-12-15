Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B652DB394
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgLOSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:18:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731342AbgLOSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:15:16 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFHtpbr007133
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:14:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pj93OsIaX3piql+0i3Xe47pdeNMGz1vjnsWecdoHTmk=;
 b=qFJeI5vnk357LEuXCr6B6chrAHgvefoUnbnSmkVNVsEBwZ9qCPXtu8XxdCIFVR2JKPdR
 icv1xrHGOOfLsLmb1bhcLlkWAuV3GRgwSK608r4+ZeNaNSsC1f7xoSgdcDM4JntTTt+O
 IciNquGnsgpD6/HgCfg81R3dPHrVKLyWkUQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35eywbs0k0-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:14:31 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 10:14:20 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AFE2E62E330B; Tue, 15 Dec 2020 10:14:18 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v5 1/4] bpftool: add Makefile target bootstrap
Date:   Tue, 15 Dec 2020 10:14:09 -0800
Message-ID: <20201215181412.1730974-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201215181412.1730974-1-songliubraving@fb.com>
References: <20201215181412.1730974-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=613
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This target is used to only build the bootstrap bpftool, which will be
used to generate bpf skeletons for other tools, like perf.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/bpftool/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index f60e6ad3a1dff..b0e5b29a2c10a 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -130,6 +130,8 @@ VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)				\
 		     /boot/vmlinux-$(shell uname -r)
 VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
=20
+bootstrap: $(BPFTOOL_BOOTSTRAP)
+
 ifneq ($(VMLINUX_BTF)$(VMLINUX_H),)
 ifeq ($(feature-clang-bpf-co-re),1)
=20
--=20
2.24.1

