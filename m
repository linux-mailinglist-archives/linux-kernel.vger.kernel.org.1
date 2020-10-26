Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AB298DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774764AbgJZN23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:28:29 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60472 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1770618AbgJZN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:28:27 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 09:28:25 EDT
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5D20C2E1501;
        Mon, 26 Oct 2020 16:21:01 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id A2oaGvXCwk-L0xKnfPJ;
        Mon, 26 Oct 2020 16:21:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603718461; bh=sT+9Spi7xz4GAW2bOEkLPjqtvHVcypfp3Jv+RAeqjqg=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=uj1CrjG84NbMU6fE+KT1wjrNckltuWXhDtqghDboHv06CoWh0QIozcWgtzg0daY60
         W5TIjiDaEFlD4dRJo+EIk21gNRlGZf7a0lCL2N6GlKdv8oQclUs/zwsNFw1lb2QMVY
         mmeZrCATu851J8JgCjmoDp0nAdFHyIc9GnEifxOo=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [178.154.136.47])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 8kf51WfDhm-L0mib759;
        Mon, 26 Oct 2020 16:21:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, dmtrmonakhov@yandex-team.ru,
        namhyung@gmail.com
Subject: [PATCH v2] perf trace: Segfault when trying to trace events by cgroup
Date:   Mon, 26 Oct 2020 16:20:34 +0300
Message-Id: <20201026132034.80464-1-sivanichkin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  v2:
    - struct declaration fixed (Namhyung Kim)

Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")
Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
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

