Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2170729A83B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895944AbgJ0JvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:51:16 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:45032 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895781AbgJ0JvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:15 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 05:51:13 EDT
Received: from sas1-5717c3cea310.qloud-c.yandex.net (sas1-5717c3cea310.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3616:0:640:5717:c3ce])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 0DFA52E150C;
        Tue, 27 Oct 2020 12:44:05 +0300 (MSK)
Received: from sas1-b105e6591dac.qloud-c.yandex.net (sas1-b105e6591dac.qloud-c.yandex.net [2a02:6b8:c08:4790:0:640:b105:e659])
        by sas1-5717c3cea310.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id CJ9YNxQAdI-i4w0taHC;
        Tue, 27 Oct 2020 12:44:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603791844; bh=K3VfyojhY8OJ0Wn3cWDdoFkxsgNE4fP8GmslFxhfUtU=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=zrvx8/9ODZjbQRcEcYJ4/L6Tle9k1fbx28Ep4Qn7e6twQlfO+8LHhaVsAqN+1hC9Z
         ghYJnPAQoEoIEfbxZJzNuYJKEj1jBzd7w80WdnTQCRxAACKIG4XnFmq4kGEYsiklaX
         mJcp+DHJWwJTBxJJ8xB0VeYvsawY+9ZMWNsICQF4=
Authentication-Results: sas1-5717c3cea310.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 37.140.163.55-vpn.dhcp.yndx.net (37.140.163.55-vpn.dhcp.yndx.net [37.140.163.55])
        by sas1-b105e6591dac.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zReNbf03PH-i4nSe09A;
        Tue, 27 Oct 2020 12:44:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, dmtrmonakhov@yandex-team.ru,
        namhyung@gmail.com
Subject: [PATCH v3] perf trace: Segfault when trying to trace events by cgroup
Date:   Tue, 27 Oct 2020 12:43:57 +0300
Message-Id: <20201027094357.94881-1-sivanichkin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 # ./perf trace -e sched:sched_switch -G test -a sleep 1
 perf: Segmentation fault
 Obtained 11 stack frames.
 ./perf(sighandler_dump_stack+0x43) [0x55cfdc636db3]
 /lib/x86_64-linux-gnu/libc.so.6(+0x3efcf) [0x7fd23eecafcf]
 ./perf(parse_cgroups+0x36) [0x55cfdc673f36]
 ./perf(+0x3186ed) [0x55cfdc70d6ed]
 ./perf(parse_options_subcommand+0x629) [0x55cfdc70e999]
 ./perf(cmd_trace+0x9c2) [0x55cfdc5ad6d2]
 ./perf(+0x1e8ae0) [0x55cfdc5ddae0]
 ./perf(+0x1e8ded) [0x55cfdc5ddded]
 ./perf(main+0x370) [0x55cfdc556f00]
 /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) [0x7fd23eeadb96]
 ./perf(_start+0x29) [0x55cfdc557389]
 Segmentation fault

 It happens because "struct trace" in option->value is passed to
 parse_cgroups function instead of "struct evlist".

 v3:
   - missed commit message (Namhyung Kim)

 v2:
   - struct declaration fixed (Namhyung Kim)

Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")
Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 44a75f234db1..de80534473af 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4639,9 +4639,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	err = 0;
 
 	if (lists[0]) {
-		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
-					       "event selector. use 'perf list' to list available events",
-					       parse_events_option);
+		struct option o = {
+			.value = &trace->evlist,
+		};
 		err = parse_events_option(&o, lists[0], 0);
 	}
 out:
@@ -4655,9 +4655,12 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 {
 	struct trace *trace = opt->value;
 
-	if (!list_empty(&trace->evlist->core.entries))
-		return parse_cgroups(opt, str, unset);
-
+	if (!list_empty(&trace->evlist->core.entries)) {
+		struct option o = {
+			.value = &trace->evlist,
+		};
+		return parse_cgroups(&o, str, unset);
+	}
 	trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
 
 	return 0;
-- 
2.17.1

