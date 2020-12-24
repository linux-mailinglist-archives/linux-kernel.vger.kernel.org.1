Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE22E26D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLXMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 07:24:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10079 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXMYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 07:24:50 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D1q3f47hnzM68d;
        Thu, 24 Dec 2020 20:23:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 20:24:04 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf build: remove -Wnested-externs
Date:   Thu, 24 Dec 2020 20:24:06 +0800
Message-ID: <1608812646-23489-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since commit c93e4aeed1be
("Makefile.extrawarn: remove -Wnested-externs warning")
has removed this check, so it's not needed here.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ce8516e..b9e8634 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -16,7 +16,7 @@ $(shell printf "" > $(OUTPUT).config-detected)
 detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
-CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+CFLAGS := $(EXTRA_CFLAGS) $(EXTRA_WARNINGS)
 
 include $(srctree)/tools/scripts/Makefile.arch
 
-- 
2.7.4

