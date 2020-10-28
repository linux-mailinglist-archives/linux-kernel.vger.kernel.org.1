Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C227729D77B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgJ1WYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732945AbgJ1WY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6DCC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:24:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o7so682277pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBMDYR0EtJiH6gOkUzFJE+KFN5Qsrk4p6krIBtwIhQY=;
        b=fnEh14j9cDBnc88fWGILZoJjMrrpmGdYL1bTRj+T1xjRu1K2Ks2NQAFYUGe5B2ybjb
         R59ugAZsEq1NjYJJq6EF9XxOgEMZfGCNp4c8TB259X9ENmQLCIAYnWq1Zbkuj2NhwCMl
         K7ZA84Nxk4FFaIZ014uPBeP2M+AtQdAekEgSh6Jpl9FG6tFLzvoEb+mEDtAGIj88FTiS
         QR9KX20mpBfqPY0f9v5Q3eS2nIpLdbCQ+JGtawRbhQfW/CJcCKPO9f+ZlG7fYQqET9Xv
         O2kQ2qw0ZJMreuKCu3KBJPAYgy+SqIt/fSxYls1y26Wd+TL9hDU8bxwB7b6tMFzVIjtT
         8UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBMDYR0EtJiH6gOkUzFJE+KFN5Qsrk4p6krIBtwIhQY=;
        b=EARZxizmhdY4C/ABqyrEjYodhhxzY1iAi0fntw64TsSQJe3qEWLrwPv1bhWuuX9vKQ
         bbwEG+DpzGvd7fSmRpKEurViaindaJLV3chLG3D9r/+Qq3c7IkVG3VV60Hs8rIvfFZnp
         530CEyCyp+bdhq5kGGmhI8KBXzqDkWXQOCf4ecfnjJmc4wapGSV5Dqz7an3p+zhiaPcL
         /xvjSmmobxSI+QhdjK9iI4//GS8uKeMCkruav+4CL3vTSFZPmcrXBMULKir/Lo2HQUrd
         GRR4P09eim9uUuFGHrGZ6xvlf946IR+y82+f08ov1ez+0SQff5THN16CRTnjXwCyipOd
         eHIA==
X-Gm-Message-State: AOAM532rGq64a0O/qvvL3pp0zWeIXjEVZukqC6U9CfpNBq3ohdEYpyLF
        2kfRkth8mToYzhrmDLW8/3mpxE5NxRCoA2vV
X-Google-Smtp-Source: ABdhPJzr1TfHgCP4mDEFtpROiZSfm2iPeVOUcXnHmUi58oeN1AsIbwFWQnAfW/7h2mAIA+yb/pu+Wg==
X-Received: by 2002:a17:902:6545:b029:d3:d1fc:ff28 with SMTP id d5-20020a1709026545b02900d3d1fcff28mr5989622pln.34.1603867109597;
        Tue, 27 Oct 2020 23:38:29 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id j8sm4229781pfj.68.2020.10.27.23.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:29 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/9] perf mem: Search event name with more flexible path
Date:   Wed, 28 Oct 2020 14:38:05 +0800
Message-Id: <20201028063813.8562-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf tool searches memory event name under the folder
'/sys/devices/cpu/events/', this leads to the limitation for selection
memory profiling event which must be under this folder.  Thus it's
impossible to use any other event as memory event which is not under
this specific folder, e.g. Arm SPE hardware event is not located in
'/sys/devices/cpu/events/' so it cannot be enabled for memory profiling.

This patch changes to search folder from '/sys/devices/cpu/events/' to
'/sys/devices', so it give flexibility to find events which can be used
for memory profiling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/mem-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ea0af0bc4314..35c8d175a9d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -18,8 +18,8 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
 struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"mem-stores"),
+	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
+	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
 };
 #undef E
 
@@ -93,7 +93,7 @@ int perf_mem_events__init(void)
 		struct perf_mem_event *e = &perf_mem_events[j];
 		struct stat st;
 
-		scnprintf(path, PATH_MAX, "%s/devices/cpu/events/%s",
+		scnprintf(path, PATH_MAX, "%s/devices/%s",
 			  mnt, e->sysfs_name);
 
 		if (!stat(path, &st))
-- 
2.17.1

