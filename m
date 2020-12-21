Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81B2DFA04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgLUIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgLUIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:38:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE2C0611CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b5so6046461pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qC/KW84FKO1uWhq/iQKC4RiY953AolFLy2isLyLZ8NU=;
        b=vDLV4T67hukz2oUaAa1PZI+7ZJ5RWYBI8jxvfsQm7BqJAaysxlklN3BMcW/yrwqqZF
         ku43TiGnv6Q5splpxewS9S/gSbL/hf9scarV/rD9Cqay2CWD8E6F1pefrx8gHGQkgiD7
         +nF3+1Qr9ClrHts2Qytx2rulMU/VBfbnhRGkR3nGjkdPYRWoXebPnX4vPyzLf1Wu3eoK
         4lVC7PIknGcf+jraTOnruEf+LCoCq4XqsKZnKlplrmdIIBvsyVi8QKPnsVv4DsVK1w8G
         7iFSMVAgPoK6gi3tLM7KKWgqBQ8a/E6L7YX0Ot2gcA74guf2jJ0686L33Op//3jPK9X/
         twbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qC/KW84FKO1uWhq/iQKC4RiY953AolFLy2isLyLZ8NU=;
        b=oIzEBbO2D4sjwah/oKaFyEHFsRJ7jrRzuTlzjXi8/ZHQ4PTQAKz7v3tWZqRgzvrT6i
         a4xkv6+KukgmkIUmkAcDI8u7qFrT3lLc+HOl8gSAnMuY4Ngv83lGk27Qmdb0adDu/KBj
         dCBOIjx9kfFUWKJZzdno0CPsZmQcF1cQNMgbT21Nb1cZTPmY8UuuPjs6KcfX6aRrn5gp
         8Mu3cB9CNBv8AXtYxU72wDdkNv5ZP0KpAiaWMNU5YqBPkC7cFGfCbLSNyu5eta4IDqsX
         QGGEm0Ff1gq6iWwslRAEoRX4XSdntQojcDCWfCmHmCdDQ4k5++ob7kjajtrn7vJp27sw
         0bQA==
X-Gm-Message-State: AOAM531A6wLrorCbhJVNS/IZURwy/kcbmanhn5dgOjTvIBkczzsae5Kr
        mw68/SWr1focbquegUyi7BJb9w==
X-Google-Smtp-Source: ABdhPJwMhcaqiDCjJnO9qL88BjjIIl3m/LvWB3vcbRFpwq9cI6Z3pS+rP1nmveSeTumqt9WmLvMTEA==
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr16499862pjs.141.1608539841122;
        Mon, 21 Dec 2020 00:37:21 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id r68sm15829563pfr.113.2020.12.21.00.37.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:37:20 -0800 (PST)
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
Subject: [PATCH v1 7/7] perf arm-spe: Don't wait for PERF_RECORD_EXIT event
Date:   Mon, 21 Dec 2020 16:35:57 +0800
Message-Id: <20201221083557.27642-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
perf event) for processing trace data, which is needless and even might
cause logic error, e.g. it might fail to correlate perf events with Arm
SPE events correctly.

So this patch removes the condition checking for PERF_RECORD_EXIT event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 6bf2e4ff5342..7b7812eea117 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -636,11 +636,7 @@ static int arm_spe_process_event(struct perf_session *session,
 					sample->time);
 		}
 	} else if (timestamp) {
-		if (event->header.type == PERF_RECORD_EXIT) {
-			err = arm_spe_process_queues(spe, timestamp);
-			if (err)
-				return err;
-		}
+		err = arm_spe_process_queues(spe, timestamp);
 	}
 
 	return err;
-- 
2.17.1

