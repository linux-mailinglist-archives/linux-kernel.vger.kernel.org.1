Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88622882F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgJIGro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgJIGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:47:44 -0400
X-Greylist: delayed 106 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Oct 2020 23:47:43 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C540BC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:47:43 -0700 (PDT)
Received: from sas1-5717c3cea310.qloud-c.yandex.net (sas1-5717c3cea310.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3616:0:640:5717:c3ce])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C3F752E147D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:45:51 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by sas1-5717c3cea310.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id rgmzNeaOpD-jpwGHCu2;
        Fri, 09 Oct 2020 09:45:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1602225951; bh=nzzJ1cGOxnVetfEPuT/9nmgY+IAyxnDqgSq/yQmsA04=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=xUEs0V/xYovTlR3UWbaXG7RUnAAYYkwxQURlJUS2lQLddUDCNXAMXd+I85ejCfNZy
         cPXhWqJxlB4Zoyhgf1woQtfET/CRAIuYk+LRLeGEF0tUFeVlNyDOH0zTZ5ak+uXtyQ
         F7P1TBVRAr3+0sjhNvKOSBZ1t2tAt1UhFVh7JVQA=
Authentication-Results: sas1-5717c3cea310.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [95.108.210.65])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id SRjkjS1hBS-jpmC3nqE;
        Fri, 09 Oct 2020 09:45:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     dmtrmonakhov@yandex-team.ru
Subject: [PATCH] perf trace: Segfault when trying to trace events by cgroup
Date:   Fri,  9 Oct 2020 09:45:47 +0300
Message-Id: <20201009064547.62047-1-sivanichkin@yandex-team.ru>
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

Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 tools/perf/builtin-trace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bea461b6f937..cbc4de6840db 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4651,9 +4651,12 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 {
 	struct trace *trace = opt->value;
 
-	if (!list_empty(&trace->evlist->core.entries))
-		return parse_cgroups(opt, str, unset);
-
+	if (!list_empty(&trace->evlist->core.entries)) {
+		struct option o = OPT_CALLBACK('G', "cgroup", &trace->evlist,
+			"name", "monitor event in cgroup name only",
+			parse_cgroups);
+		return parse_cgroups(&o, str, unset);
+	}
 	trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
 
 	return 0;
-- 
2.17.1

