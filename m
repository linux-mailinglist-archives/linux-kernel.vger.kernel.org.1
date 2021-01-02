Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091612E88CD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhABWGD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:03 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:36243 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhABWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:02 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-8jTTWlXpO6KBC4XiuJjHJw-1; Sat, 02 Jan 2021 17:05:07 -0500
X-MC-Unique: 8jTTWlXpO6KBC4XiuJjHJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694BA107ACE4;
        Sat,  2 Jan 2021 22:05:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943CA19727;
        Sat,  2 Jan 2021 22:05:02 +0000 (UTC)
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
Subject: [PATCH 06/22] perf tools: Make perf_config_global gobal
Date:   Sat,  2 Jan 2021 23:04:25 +0100
Message-Id: <20210102220441.794923-7-jolsa@kernel.org>
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

Making perf_config_global global, it will be used
outside the config.c object in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/config.c | 2 +-
 tools/perf/util/config.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 4e0455a6bb5f..6984c77068a3 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -526,7 +526,7 @@ int perf_config_system(void)
 	return !perf_env_bool("PERF_CONFIG_NOSYSTEM", 0);
 }
 
-static int perf_config_global(void)
+int perf_config_global(void)
 {
 	return !perf_env_bool("PERF_CONFIG_NOGLOBAL", 0);
 }
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index bf68e4acea73..2fd77aaff4d2 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -39,6 +39,7 @@ int config_error_nonbool(const char *);
 const char *perf_etc_perfconfig(void);
 const char *perf_home_perfconfig(void);
 int perf_config_system(void);
+int perf_config_global(void);
 
 struct perf_config_set *perf_config_set__new(void);
 struct perf_config_set *perf_config_set__load_file(const char *file);
-- 
2.26.2

