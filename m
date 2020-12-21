Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECD2DFA01
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgLUIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:37:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22301C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t22so6079532pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/GLEdU5PUmoUlTUA8MPCycBae7xrzYQPB8craiI+fQ=;
        b=jfokoM7LY7YoOjdAbh0EZOPbXolRufEIavPuLZPsWbL3nl5/zs311uWTJjMC5poX8s
         SuMz0UVToA6b/NRBpV1dtXpR3YIScpb27WSXNKj7TR+8p8VAHCJcf+unzAzBZ7qIcWSu
         QARqjx6jNXPSWngjFSSg2iAK9C9rMSOKwS+0TP0NLIy453nadvocBj1m7OK5jMLbEZfZ
         QpPrvxQJxmoG2sBO1E/BRqAPbz24pOTAYkdD3Vt5ykL7EoMc7JsoI1gGP7EiER2OssM6
         YLq0umkvHm9XBsmRs8piG9omiP4EagNxg9BthsAvBbi3V8Q0SHytoftacmN5EiEniK9r
         Muyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/GLEdU5PUmoUlTUA8MPCycBae7xrzYQPB8craiI+fQ=;
        b=MD4D7P9tAuzqopayF/VLP6m5V7DthOHEUroRH75/Q7v9gRMqQ98YDdhy53E4VG2HOd
         xJJlanCLkcfISzJ2DEMMDoj11AvMo5IXtjO8Mtvcxqcc3zjFpGdeWEvJqGYnnSak+fVY
         6uLqLo3Z3Wl4gHFHwMX9r213Gr0HIpzRNL+0hzAotabJ6pLbApYGCYDmiCGa1f/RAmxw
         PhCxgeElBfK8TuoyXXZP17H4R39YzGcHas1MI3MOOBPKfLhjbhvFbzgadLlQ6rHgi9c0
         HqNTYGGOLAhwIKWS9L0Vq5+ESAwat9nY0LrH2yZvwZavO1/ZOhRs2OyyOuNed7T7NySK
         cplw==
X-Gm-Message-State: AOAM531a5s2dVomrFHpvJ0e5sj1VfDMwYc6zUx/DizkFVaGxLOkTBbP/
        nv2etRTfFSiH2v2RdNWm82poeg==
X-Google-Smtp-Source: ABdhPJwENy2lIulfvPKSOtwZoimhAhxrvUiX7fGpdOVI7MzMeZ0dzF9PqZXih/dGlnwv+xPCSU3RXQ==
X-Received: by 2002:a63:d418:: with SMTP id a24mr8339831pgh.73.1608539830707;
        Mon, 21 Dec 2020 00:37:10 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id p16sm15034643pju.47.2020.12.21.00.37.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:37:10 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/7] perf arm-spe: Convert event kernel time to counter value
Date:   Mon, 21 Dec 2020 16:35:54 +0800
Message-Id: <20201221083557.27642-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle a perf event, Arm SPE decoder needs to decide if this perf
event is earlier or later than the samples from Arm SPE trace data; to
do comparision, it needs to use the same unit for the time.

This patch converts the event kernel time to arch timer's counter value,
thus it can be used to compare with counter value contained in Arm SPE
Timestamp packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index a504ceec2de6..bc512c3479f7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -588,7 +588,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_tsc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
-- 
2.17.1

