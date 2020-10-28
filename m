Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA329DB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbgJ1X6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgJ1X4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:56:21 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:56:19 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id d19so534614vso.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wv05kmOFvRldoma6qnDe7plfeMpK62X6ArmvDV4JzoI=;
        b=nV00rakW8JlSD1SHXjoiEXZxrs7z4VK3jGg0yl2ZbPohKluY3m61nbAlcNRZZuat0G
         9Re8IAXm2yVXkSWn6+GjdEM1JXJ3fIJbt1DREEn7HgBaqDEBMpAQq8z/etVLIoJ4lh8X
         06It32w6HxUOxGn9DOzY9vTjzMAHX6BEjddiWDtWQkkjAxM/7ae0PTiKu347bEjscC99
         ZPYh3ck4lSn5YP/+9zYaAIoq9T/AUBBvXcl0IwQFy84Zy4IyQ7YI+nCT/uX0v2y68vF0
         7rpUkHTtGct3nf78uCp7+m+OOlxyHkm5pcJEr66O+5MkutQacG3gz8Q0/K8DSylBr8wU
         Eg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wv05kmOFvRldoma6qnDe7plfeMpK62X6ArmvDV4JzoI=;
        b=WFKNDoX9H499LXoPrwgZJxL/JvL6nJ1ZacTmMB8RmPB7CO7Nnx0xxH1mVj5j9TfZpx
         4lCZpNf/lvCJ6RAHOwG/WTUnhudIUSwuuGiiHQAqgSy4l+R2QLSWptu0fbTHtNUa4rSd
         TrQhGmnaEgFNEKERXMBAtMNt0uNZXgfMn9qjt6EWtY1WrIWu2wZtShpjaU88oxE39tm7
         OExYobNULtwljhlmYJXGgUUAjUV2BLH1to+xGSufkXle5FmQ7DHYtqvH0VAh83jFhXcH
         imIaUqpO3EoOgmOZmIPKUcMcy883g8qU+xvSRtoqy/RvxFFlfnXNZeFsOxyxJcU93mmB
         KhEg==
X-Gm-Message-State: AOAM532f350a/xGqEuKRarEReXWedP0iTBZ6jAfwkdrXt4A6plIo56pa
        ryLfI2xAIGld7uDRVl8EFGehRi89BvUAF//G
X-Google-Smtp-Source: ABdhPJzCxbyMI5u9s8pS+n9iTgmH92Oh+pM1meZA3+X6X7cJKGjPkU7+klC2EYxtJ+2mK5HMrznLdw==
X-Received: by 2002:a62:6507:0:b029:155:3b11:b458 with SMTP id z7-20020a6265070000b02901553b11b458mr6044291pfb.45.1603867124515;
        Tue, 27 Oct 2020 23:38:44 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n6sm4058809pjj.34.2020.10.27.23.38.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:43 -0700 (PDT)
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
Subject: [PATCH v3 4/9] perf mem: Only initialize memory event for recording
Date:   Wed, 28 Oct 2020 14:38:08 +0800
Message-Id: <20201028063813.8562-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needless to initialize memory events for reporting, this patch
moves memory event initialization for only recording.  Furthermore,
the change allows to parse perf data on cross platforms, e.g. perf
tool can report result properly even the machine doesn't support
the memory events.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 31144f586e77..f3dc2d2b879c 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -78,6 +78,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	OPT_END()
 	};
 
+	if (perf_mem_events__init()) {
+		pr_err("failed: memory events not supported\n");
+		return -1;
+	}
+
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
@@ -436,11 +441,6 @@ int cmd_mem(int argc, const char **argv)
 		NULL
 	};
 
-	if (perf_mem_events__init()) {
-		pr_err("failed: memory events not supported\n");
-		return -1;
-	}
-
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
-- 
2.17.1

