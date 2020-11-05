Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B472A751F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbgKEBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKEBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:55:26 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D443C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:55:26 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id j24so256747ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=granulate.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqVJZh5R4b0upFaHIKbbvK1EuK7eSb8uOUfKK5wvca0=;
        b=H/yoa0G+f1T7wV9L4s8DMnkd3WINezv5JYD+GVE3JEsOWz6RiJlCTjyc/FqTdie2zR
         kAmYA9aR8r5Qh6LJtJvFJV4Yo07bkgq8ZGsyD64H/e09GD0QuJpiVdAIy6YOoO3R3jWa
         EH/siG/J341BKZtJ6oQ401cpXakzlWxhDCdJLG8oSmOZ3rp3/CVp2SbE7vPPyi095R8A
         aKV/9pi25UkxkSQZoFy++sG0QgDjrXDyKyg9uqhVYZoM7lTwsjFKd1JzA20cUTrKwAX/
         WlowpbGFtgw3PkDNBPsUi/K3Ao2V+Gewxk2IVR1mCxoEUZt18Tk19XV2S3KsN5O8gXgb
         H01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqVJZh5R4b0upFaHIKbbvK1EuK7eSb8uOUfKK5wvca0=;
        b=A/IB183/h8xjZqVHMO8KFCRKmA7l+OwWMufz8IStlWKtrQbAcv8+cwAVFZg/xFMOai
         agIkLUyDiuhI/tTUy2bBwpota1QwJpCZe3jLdsahdzN6W1AnWOIp7M8qpH1v8xiW76D0
         hq50/0nEypt9zflCU2QboGmv7C51D1+Stl5dcXJzlIlCe1XZ+9cJFZDUPWedrj6J1Z3m
         noLY3JRdaae+9zsxBVmK7nSOL1pSnKNBjaokHW9y7F6nO5INOApL6PXKLyoxqR+TbdMO
         YTx6RjeiSwC7FRVx8EIHVXpkh0OqdWAGNMjEBu+qDiA031FcEerwKwsfMst5KjztCjnW
         3SCw==
X-Gm-Message-State: AOAM5326QQN1YNrv79BymWKdIkC0v0qNn9lt1DWiAkXlPvsM8VwVJM/n
        fSamUvIhlLb8Gtw+suDEO/2ClUTVEkEWCPf8
X-Google-Smtp-Source: ABdhPJxi3Z9nqSMxIsb4RGYEC0u58IyNjZCYisHSttVMOTeSinR4csNi5inAkqpOl/QOAo7k9Wtrzg==
X-Received: by 2002:a17:906:ca54:: with SMTP id jx20mr29218ejb.541.1604541325350;
        Wed, 04 Nov 2020 17:55:25 -0800 (PST)
Received: from localhost.localdomain ([5.22.135.99])
        by smtp.gmail.com with ESMTPSA id m27sm80084ejg.3.2020.11.04.17.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 17:55:24 -0800 (PST)
From:   Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Subject: [PATCH v3 1/2] perf tools: Add 'in_pidns' to nsinfo struct
Date:   Thu,  5 Nov 2020 03:54:18 +0200
Message-Id: <20201105015418.1725218-1-yonatan.goldschmidt@granulate.io>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201105014833.1724363-1-yonatan.goldschmidt@granulate.io>
References: <20201105014833.1724363-1-yonatan.goldschmidt@granulate.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides an accurate mean to determine if the owner thread
is in a different PID namespace.

Signed-off-by: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
---
 tools/perf/util/namespaces.c | 11 +++++++++--
 tools/perf/util/namespaces.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 285d6f30d912..f4b3512d8dd2 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -66,6 +66,7 @@ int nsinfo__init(struct nsinfo *nsi)
 	char spath[PATH_MAX];
 	char *newns = NULL;
 	char *statln = NULL;
+	char *nspid;
 	struct stat old_stat;
 	struct stat new_stat;
 	FILE *f = NULL;
@@ -112,8 +113,12 @@ int nsinfo__init(struct nsinfo *nsi)
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
-			nsi->nstgid = (pid_t)strtol(strrchr(statln, '\t'),
-						     NULL, 10);
+			nspid = strrchr(statln, '\t');
+			nsi->nstgid = (pid_t)strtol(nspid, NULL, 10);
+			/* If innermost tgid is not the first, process is in a different
+			 * PID namespace.
+			 */
+			nsi->in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
 			break;
 		}
 	}
@@ -140,6 +145,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
 		nsi->tgid = pid;
 		nsi->nstgid = pid;
 		nsi->need_setns = false;
+		nsi->in_pidns = false;
 		/* Init may fail if the process exits while we're trying to look
 		 * at its proc information.  In that case, save the pid but
 		 * don't try to enter the namespace.
@@ -166,6 +172,7 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 		nnsi->tgid = nsi->tgid;
 		nnsi->nstgid = nsi->nstgid;
 		nnsi->need_setns = nsi->need_setns;
+		nnsi->in_pidns = nsi->in_pidns;
 		if (nsi->mntns_path) {
 			nnsi->mntns_path = strdup(nsi->mntns_path);
 			if (!nnsi->mntns_path) {
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 4b33f684eddd..1cc8637cf885 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -33,6 +33,7 @@ struct nsinfo {
 	pid_t			tgid;
 	pid_t			nstgid;
 	bool			need_setns;
+	bool			in_pidns;
 	char			*mntns_path;
 	refcount_t		refcnt;
 };
-- 
2.25.0

