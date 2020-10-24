Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4E297A65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759194AbgJXC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759162AbgJXC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:59:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:59:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l18so2758380pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qk/Q24uKS39WZNcG5ZV9esraD5KJhyJ79A9IAxWqPQE=;
        b=NLcqQNW4WYC8MjUEfwTo4NVcLjlEralTmj3C1BOn/roojvEOdQtSShKL8Hyfw4HEAz
         UpRO3964oMBXE2Q7bVcWpAEYoNjbCzC3Vyd8jBY7sYqyorZfENICBgojgdMvrlULLx8P
         2ruUkKX4vpZL3B/2bF0YCoo8z9kGK/d4s7tobxwZt2C1gu7Y2vb/iJYmqUfTHmpoz1LI
         SvVmRh1mtj4l380FAL7rv/0U/L2/RZ6d1F90nKwOeGVc8KbpV6NgHJXd345r4kC8fl2B
         9vn85WoBVDFfGI4zZ30LcywBlGK+d+CX9+gcP+9jl4WPe2idO92AEhDfRgCWHuKTnVam
         pvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Qk/Q24uKS39WZNcG5ZV9esraD5KJhyJ79A9IAxWqPQE=;
        b=O8ZTqJsUHG40g86wvbad9aDDEo+trpwE5ILuCHhQJs7N/n1IOIu7jnqcHz4n267wyo
         Fbt5il91LjoukAPZkw0JlbFgI5FOyKWk18qSNk34FcL0wGDal5x0Hcf8VRFvU0gNEwZu
         h/Z+2q8uv8AKXcYkrq7dnxS17pXsQt6mTjEy08DDAqLRJ0CyKiGZl4D+IxIVjVvqAeIP
         4k7Iop5+7ieaLiXPtfFG66MswX3rFLVyn4aTZqEj4jzyRp5yAaGDTqMUN6ccJ6mAu4ia
         ibwELwR3mS/Qd6nkE9VGgRfs14nj80U+8sM4n9ORU+h0WwSc5CpjdvEpUWjN7aSrojXk
         jn8g==
X-Gm-Message-State: AOAM530UmIjk6gemDD+p+c2COAuBs3Fvxf6uU8xNRg4+GZCbVi+vI0Sv
        f141TqiFxx1icFOn1QS54TU=
X-Google-Smtp-Source: ABdhPJxLFuyjQvMoF6L5mBwYfM7zAM6Aut7TEkDM9wdE1heza97KOxNUZ0r+yHZB5kdLPXjGZyTwZA==
X-Received: by 2002:a63:d442:: with SMTP id i2mr4460485pgj.181.1603508364822;
        Fri, 23 Oct 2020 19:59:24 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id s10sm4038235pji.7.2020.10.23.19.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 19:59:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf test: Use generic event for expand_libpfm_events()
Date:   Sat, 24 Oct 2020 11:59:17 +0900
Message-Id: <20201024025918.453431-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that the UNHALTED_CORE_CYCLES event is only available in the
Intel machines and it makes other vendors/archs fail on the test.  As
libpfm4 can parse the generic events like cycles, let's use them.

Fixes: 40b74c30ffb9 ("perf test: Add expand cgroup event test")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/expand-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index d5771e4d094f..4c59f3ae438f 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -145,7 +145,7 @@ static int expand_libpfm_events(void)
 	int ret;
 	struct evlist *evlist;
 	struct rblist metric_events;
-	const char event_str[] = "UNHALTED_CORE_CYCLES";
+	const char event_str[] = "CYCLES";
 	struct option opt = {
 		.value = &evlist,
 	};
-- 
2.29.0.rc1.297.gfa9743e501-goog

