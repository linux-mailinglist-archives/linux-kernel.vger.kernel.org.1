Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA981B8FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDZMZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 08:25:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgDZMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:25:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 498B9D3412610ACC5D93;
        Sun, 26 Apr 2020 20:24:59 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sun, 26 Apr 2020 20:24:48 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] perf script: remove unneeded conversion to bool
Date:   Sun, 26 Apr 2020 20:31:05 +0800
Message-ID: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue was detected by using the Coccinelle software:

tools/perf/builtin-script.c:3285:48-53: WARNING: conversion to bool not needed here
tools/perf/builtin-script.c:2839:36-41: WARNING: conversion to bool not needed here

The conversion to bool is unneeded, remove it

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 02d64a9..e849747 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2836,7 +2836,7 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				break;
 		}
 		if (i == imax && strcmp(tok, "flags") == 0) {
-			print_flags = change == REMOVE ? false : true;
+			print_flags = change == REMOVE;
 			continue;
 		}
 		if (i == imax) {
@@ -3282,7 +3282,7 @@ static char *get_script_path(const char *script_root, const char *suffix)
 
 static bool is_top_script(const char *script_path)
 {
-	return ends_with(script_path, "top") == NULL ? false : true;
+	return ends_with(script_path, "top") == NULL;
 }
 
 static int has_required_arg(char *script_path)
-- 
2.6.2

