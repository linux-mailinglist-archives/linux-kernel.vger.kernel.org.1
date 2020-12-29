Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0352E74E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgL2VnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:43:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgL2VnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:43:08 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTLTlh7019221
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:42:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NFMOwY3uUfWcWMlaIPff4XoMl403m8q0qt5mvj0rpeA=;
 b=Sd2SvmuNp+jlajFSqO7sNImNzQkI3uaZoZjmZl8lLG7ArzdlitxbpfWmGynxFUnZCZ8I
 AKqrdkm892DdvmgCkxxWNiR/SqHNMIZb74F8Y7T3y1ai69z0sFQoPCbYRkMAy9kfSPOU
 RuTRXxLN4rwCjA7X9xq7f26B0yOQ7mYvdU0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35r7f1h750-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:42:28 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 13:42:26 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B84A862E4F0A; Tue, 29 Dec 2020 13:42:22 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v7 1/3] bpftool: add Makefile target bootstrap
Date:   Tue, 29 Dec 2020 13:42:12 -0800
Message-ID: <20201229214214.3413833-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201229214214.3413833-1-songliubraving@fb.com>
References: <20201229214214.3413833-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_16:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 mlxlogscore=615 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290132
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
index f897cb5fb12d0..e3292a3a0c461 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -148,6 +148,8 @@ VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)				\
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

