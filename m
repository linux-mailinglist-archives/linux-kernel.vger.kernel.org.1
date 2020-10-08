Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5928770E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgJHPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:23:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730550AbgJHPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:23:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F1048925BDBB8E7CC12;
        Thu,  8 Oct 2020 23:23:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 23:22:57 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <irogers@google.com>, <yao.jin@linux.intel.com>,
        <yeyunfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <=linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] perf jevents: Fix event code for events referencing std arch events
Date:   Thu, 8 Oct 2020 23:19:28 +0800
Message-ID: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event code for events referencing std arch events is incorrectly
evaluated in json_events().

The issue is that je.event is evaluated properly from try_fixup(), but
later NULLified from the real_event() call, as "event" may be NULL.

Fix by setting "event" same je.event in try_fixup().

Also remove support for overwriting event code for events using std arch
events, as it is not used.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 99df41a9543d..e47644cab3fa 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
 }
 
 static int
-try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
-	  struct json_event *je)
+try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
 
 	list_for_each_entry(es, &arch_std_events, list) {
 		if (!strcmp(arch_std, es->name)) {
-			if (!eventcode && es->event) {
-				/* allow EventCode to be overridden */
-				free(je->event);
-				je->event = NULL;
-			}
 			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
+			*event = je->event;
 			return 0;
 		}
 	}
@@ -678,7 +673,7 @@ static int json_events(const char *fn,
 			 * An arch standard event is referenced, so try to
 			 * fixup any unassigned values.
 			 */
-			err = try_fixup(fn, arch_std, eventcode, &je);
+			err = try_fixup(fn, arch_std, &je, &event);
 			if (err)
 				goto free_strings;
 		}
-- 
2.26.2

