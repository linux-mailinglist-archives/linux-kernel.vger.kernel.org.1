Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593822E88D6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbhABWGf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:35 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:21874 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727390AbhABWGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-GDyyDExqNUCLI6mU2s9Syw-1; Sat, 02 Jan 2021 17:05:37 -0500
X-MC-Unique: GDyyDExqNUCLI6mU2s9Syw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EF49800D62;
        Sat,  2 Jan 2021 22:05:35 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C725B19727;
        Sat,  2 Jan 2021 22:05:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 15/22] perf daemon: Use control to stop session
Date:   Sat,  2 Jan 2021 23:04:34 +0100
Message-Id: <20210102220441.794923-16-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'stop' control command to stop perf record session.
If that fails, falling back to current SIGTERM/SIGKILL pair.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 56 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 260bcffd9ae8..e45a1acaad18 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -502,11 +502,33 @@ session__control(struct session *session, const char *msg, bool do_ack)
 
 static void session__kill(struct session *session, struct daemon *daemon)
 {
-	session__signal(session, SIGTERM);
-	if (session__wait(session, daemon, 10)) {
-		session__signal(session, SIGKILL);
-		session__wait(session, daemon, 10);
-	}
+	int how = 0;
+
+	do {
+		switch (how) {
+		case 0:
+			session__control(session, "stop", false);
+			break;
+		case 1:
+			session__signal(session, SIGTERM);
+			break;
+		case 2:
+			session__signal(session, SIGKILL);
+			break;
+		default:
+			break;
+		}
+		how++;
+
+	} while (session__wait(session, daemon, 10));
+}
+
+static void daemon__stop(struct daemon *daemon)
+{
+	struct session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list)
+		session__control(session, "stop", false);
 }
 
 static int daemon__reconfig(struct daemon *daemon)
@@ -545,11 +567,25 @@ static int daemon__reconfig(struct daemon *daemon)
 
 static void daemon__kill(struct daemon *daemon)
 {
-	daemon__signal(daemon, SIGTERM);
-	if (daemon__wait(daemon, 10)) {
-		daemon__signal(daemon, SIGKILL);
-		daemon__wait(daemon, 10);
-	}
+	int how = 0;
+
+	do {
+		switch (how) {
+		case 0:
+			daemon__stop(daemon);
+			break;
+		case 1:
+			daemon__signal(daemon, SIGTERM);
+			break;
+		case 2:
+			daemon__signal(daemon, SIGKILL);
+			break;
+		default:
+			break;
+		}
+		how++;
+
+	} while (daemon__wait(daemon, 10));
 }
 
 static void daemon__free(struct daemon *daemon)
-- 
2.26.2

