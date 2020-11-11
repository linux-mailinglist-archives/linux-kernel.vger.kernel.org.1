Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D80A2AE973
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKKHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgKKHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:35 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A176C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:35 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so1089685pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=Mf3y1Kr54JzlEnZFGoZ4PG1AwT4CcyCm3fDEF7HH9yUWa9DUwa+oqXUePp92zB4bt5
         DK/ixxjwi8NOs8MlLKREetptSW8nVegbpMxiP675BBwSwF9YSTAq0ChY6tfEtIn1NO6y
         6QzckxsMTMHQg/bEgI38GOo7kvbr7mxjPU2cUeXUFMFSCiPu2DfbgjLTyf7TaZYQfklC
         Ec1mKFgyO8+PEcPUuttY/EQSL5/s7OiK9EY5iHSv/Fcqi4sOjWITU6Gipf/DyFRg/m44
         ln/CQF/267r7fcgAuQCb562mqIHyYstxGj7RUZ5FzxH4aNnbJTL5tEuRHL/n12CtKWMV
         AYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=aNZSO1Y4bphPh0mjTmFIYzbZghtY5rmtx8PY8nCgschHBF285r+P8M1VPqtq0s6Zqp
         F8YDVR41uF6bhSoFuy8xwQBIqWFZZNamTJYx4dty+vWt1Rg5V1l0xcmhgDLZlYT7i+xx
         Iu4V0lCi4TJoVopqGypgnIsMZc1LDMgmvrHYjZ/velhImZo5tKl0Eg9r9s4SO4PujyJB
         l9CCablc67bcepNqerLPY66AZEGr3TZ6RK0g3nrn6YhiGsuYwA7BJkt7WlpQ9Qmsnsqb
         I08TZEKY4Ye3pNup40KKpaJuUeZFMClCdlqNdmI+XfXqSlPq1KCO+qJdqZUq3BBX5gds
         zH9A==
X-Gm-Message-State: AOAM530ms2DkjLgh7ci2kTmb4IPKNWrnXux1MQYbCaA00Wq2JDw8M3VE
        XU4v3k181PxrjuOUkdxbx/CNNA==
X-Google-Smtp-Source: ABdhPJxH191jlXb6pIBYRlD1wvvGrHYvuoZ0Qvh0hRcgIjzJYurUaXSJVMITPEoWYNQKfm1//EbCkw==
X-Received: by 2002:a63:c745:: with SMTP id v5mr10690289pgg.389.1605078755018;
        Tue, 10 Nov 2020 23:12:35 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id v125sm1310434pfv.75.2020.11.10.23.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:34 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 04/22] perf arm-spe: Refactor arm_spe_get_events()
Date:   Wed, 11 Nov 2020 15:11:31 +0800
Message-Id: <20201111071149.815-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function arm_spe_get_events(), the event packet's 'index' is assigned
as payload length, but the flow is not directive: it firstly gets the
packet length from the return value of arm_spe_get_payload(), the value
includes header length (1) and payload length:

  int ret = arm_spe_get_payload(buf, len, packet);

and then reduces header length from packet length, so finally get the
payload length:

  packet->index = ret - 1;

To simplify the code, this patch directly assigns payload length to
event packet's index; and at the end it calls arm_spe_get_payload() to
return the payload value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 06b3eec4494e..f1b4cb008837 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -136,8 +136,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
 			      struct arm_spe_pkt *packet)
 {
-	int ret = arm_spe_get_payload(buf, len, packet);
-
 	packet->type = ARM_SPE_EVENTS;
 
 	/* we use index to identify Events with a less number of
@@ -145,9 +143,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
-	packet->index = ret - 1;
+	packet->index = arm_spe_payload_len(buf[0]);
 
-	return ret;
+	return arm_spe_get_payload(buf, len, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
-- 
2.17.1

