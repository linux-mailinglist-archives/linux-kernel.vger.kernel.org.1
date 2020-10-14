Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0F28D905
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgJNDwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:52:17 -0400
Received: from one.firstfloor.org ([193.170.194.197]:44850 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgJNDwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:52:16 -0400
Received: from firstfloor.org (c-71-237-255-61.hsd1.or.comcast.net [71.237.255.61])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by one.firstfloor.org (Postfix) with ESMTPSA id 3BDF7867AC;
        Wed, 14 Oct 2020 05:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1602647533;
        bh=cIq8uq8ZYeVTzAl3ckUpCxX0L9bNiFvMu1BLuW3464A=;
        h=From:To:Cc:Subject:Date:From;
        b=BIhyfR0EFvthqAU+d31/4gOek8K7ZDRLxQ0YO4Qr+hEOLag6nUAW0+mQIXotYXaGa
         vl6/EGgDUW7h+iENcDf2b/OmQc0+AuDDXjGQR2cPBIZZtq26QiMmvAFIzerhQIFx5b
         YHnLL5AxT6e7mmh2UyaKXqvwgGnqrL7T6qZ2ydzk=
Received: by firstfloor.org (Postfix, from userid 1000)
        id CC751A8668; Tue, 13 Oct 2020 20:52:09 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        Andi Kleen <andi@firstfloor.org>, peterz@infradead.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf: Add support for exclusive groups/events
Date:   Tue, 13 Oct 2020 20:52:03 -0700
Message-Id: <20201014035203.4354-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter suggested that using the exclusive mode in perf could
avoid some problems with bad scheduling of groups. Exclusive
is implemented in the kernel, but wasn't exposed by the perf tool,
so hard to use without custom low level API users.

Add support for marking groups or events with :e for exclusive
in the perf tool.  The implementation is basically the same as the
existing pinned attribute.

Cc: peterz@infradead.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-list.txt |  1 +
 tools/perf/tests/parse-events.c        | 58 +++++++++++++++++++++++++-
 tools/perf/util/parse-events.c         |  9 +++-
 tools/perf/util/parse-events.l         |  2 +-
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 10ed539a8859..4c7db1da8fcc 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -58,6 +58,7 @@ counted. The following modifiers exist:
  S - read sample value (PERF_SAMPLE_READ)
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
+ e - group or event are exclusive and do not share the PMU
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7f9f87a470c3..7411dd4d76cf 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -557,6 +557,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
 	return 0;
 }
@@ -575,6 +576,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
 	/* cpu/pmu-event/u*/
 	evsel = evsel__next(evsel);
@@ -587,6 +589,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.pinned);
 
 	return 0;
 }
@@ -1277,6 +1280,49 @@ static int test__pinned_group(struct evlist *evlist)
 	return 0;
 }
 
+static int test__checkevent_exclusive_modifier(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
+
+	return test__checkevent_symbolic_name(evlist);
+}
+
+static int test__exclusive_group(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
+
+	/* cycles - group leader */
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config",
+			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
+
+	/* cache-misses - can not be pinned, but will go on with the leader */
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config",
+			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+
+	/* branch-misses - ditto */
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong config",
+			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+
+	return 0;
+}
 static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -1765,7 +1811,17 @@ static struct evlist_test test__events[] = {
 		.name  = "cycles:k",
 		.check = test__sym_event_dc,
 		.id    = 55,
-	}
+	},
+	{
+		.name  = "instructions:uep",
+		.check = test__checkevent_exclusive_modifier,
+		.id    = 56,
+	},
+	{
+		.name  = "{cycles,cache-misses,branch-misses}:e",
+		.check = test__exclusive_group,
+		.id    = 57,
+	},
 };
 
 static struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9f7260e69113..760506f7a87a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1768,6 +1768,7 @@ struct event_modifier {
 	int sample_read;
 	int pinned;
 	int weak;
+	int exclusive;
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
@@ -1783,6 +1784,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	int precise_max = 0;
 	int sample_read = 0;
 	int pinned = evsel ? evsel->core.attr.pinned : 0;
+	int exclusive = evsel ? evsel->core.attr.exclusive : 0;
 
 	int exclude = eu | ek | eh;
 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
@@ -1824,6 +1826,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 			sample_read = 1;
 		} else if (*str == 'D') {
 			pinned = 1;
+		} else if (*str == 'e') {
+			exclusive = 1;
 		} else if (*str == 'W') {
 			weak = 1;
 		} else
@@ -1857,6 +1861,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	mod->sample_read = sample_read;
 	mod->pinned = pinned;
 	mod->weak = weak;
+	mod->exclusive = exclusive;
 
 	return 0;
 }
@@ -1912,8 +1917,10 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
 
-		if (evsel__is_group_leader(evsel))
+		if (evsel__is_group_leader(evsel)) {
 			evsel->core.attr.pinned = mod.pinned;
+			evsel->core.attr.exclusive = mod.exclusive;
+		}
 	}
 
 	return 0;
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 3ca5fd2829ca..9db5097317f4 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -210,7 +210,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
-modifier_event	[ukhpPGHSDIW]+
+modifier_event	[ukhpPGHSDIWe]+
 modifier_bp	[rwx]{1,3}
 
 %%
-- 
2.28.0

