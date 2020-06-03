Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044AB1EC7B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 05:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 23:07:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgFCDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:07:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6B78AF30E882D5A8F0C;
        Wed,  3 Jun 2020 11:07:23 +0800 (CST)
Received: from huawei.com (10.175.102.37) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 11:07:16 +0800
From:   Li Bin <huawei.libin@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <liwei391@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH] perf svghelper: fix memory leak in svg_build_topology_map
Date:   Wed, 3 Jun 2020 11:00:58 +0800
Message-ID: <1591153258-59840-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix leak of memory pointed to by t.sib_thr and t.sib_core in
svg_build_topology_map in the non-error path.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 tools/perf/util/svghelper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 96f941e..d50955f 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
 	int i, nr_cpus;
 	struct topology t;
 	char *sib_core, *sib_thr;
+	int ret = -1;
 
 	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
 
@@ -798,12 +799,11 @@ int svg_build_topology_map(struct perf_env *env)
 		topology_map[i] = -1;
 
 	scan_core_topology(topology_map, &t, nr_cpus);
-
-	return 0;
+	ret = 0;
 
 exit:
 	zfree(&t.sib_core);
 	zfree(&t.sib_thr);
 
-	return -1;
+	return ret;
 }
-- 
1.7.12.4

