Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233AC29D953
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbgJ1Wut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389620AbgJ1Wup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CFFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:42 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so1255033oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jeJiRaAbKWuyob37GOTyfw/86/Frh0gugFaBK7OFIs=;
        b=hzMACXHJ+NwXdqkR3VVPOC7bnaMcYm3xikDHOfRCzPV9GnJlQeLX8KaMniZD0GSBLU
         Zh19U1m+DhCgqqGIf1H6wvaJdur/uKnZ6AVseodvfX7PzKGaZr289BCRZxsOV2xjcHEj
         R4vpzWP+QJETtzUjqcx2JJzgB6nzmicmMsWTYPKGQSkGjd1r+3XTSRMekQLt3K4Ajcs/
         rJG4SnXh3c4PsLJDz1/pKGTgrhmDTleUkeV4UMuOssmLLbdWKqMu7cj5jksL5LIjP9oN
         2IBT+8iDGCwsUQvAhvcCuG7kz2kDq8Nh0HX+AaYUJ9WmHB/eeLD74BqSHXovJM7Jw2H5
         IxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jeJiRaAbKWuyob37GOTyfw/86/Frh0gugFaBK7OFIs=;
        b=PeWki3uSQ3aJyF/dO8hkIJWP6h7at49utQ6vs5Ips66rg0pjwR1xAkmQakVOcCvus2
         MWwKPhjKZjqAxLhwVnlImMwBZ0JO5W9gFCxfpxJoYWlZQdX5TCmw23kDSatib04/I7MG
         HMjjVyHXmrl428xKTOJRGdVmVSidwTKW2zXMhKDkQZWehFFiJpivEIGamdD+tJspXyGo
         IubGVpIW53utmh5OjC4P+dAPgDHf6Xd2IIzQKmsWs7iBftWLFRIptxcOqOSNiTX7Cq+g
         efBir19nIoaM0nE1DERBqU+aqQFOGkujaIfTXoMqgjIz+IynkHo14gwS964YhnMGp+tu
         wmfw==
X-Gm-Message-State: AOAM533xm0GUK9spjNp7zmQRxPywMn8WSVHMoWhsHFmxPi1uqO5Dy4n0
        q3OJLjKAK9MCtN2Xy0uftEvgasNqULZm2Cxh
X-Google-Smtp-Source: ABdhPJxsPGjoz9Nf8PR1b73ATvv2YKlLUPNIXREg4qMJSV6zUSKNXAfZTYTWxOhh6cbO+s5rkjuhBQ==
X-Received: by 2002:a17:90a:7303:: with SMTP id m3mr5825028pjk.190.1603867129442;
        Tue, 27 Oct 2020 23:38:49 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r6sm4610030pfg.85.2020.10.27.23.38.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:48 -0700 (PDT)
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
Subject: [PATCH v3 5/9] perf mem: Support AUX trace
Date:   Wed, 28 Oct 2020 14:38:09 +0800
Message-Id: <20201028063813.8562-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf memory tool doesn't support AUX trace data so it cannot receive the
hardware tracing data.  On Arm64, although it doesn't support PMU events
for memory load and store, but Arm SPE is a good candidate for memory
profiling, the hardware tracer can record memory accessing operations
with affiliated information (e.g. physical address and virtual address
for accessing, cache levels, TLB walking, latency, etc).

To allow "perf mem" tool to support AUX trace, this patches adds the AUX
callbacks for session structure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index f3dc2d2b879c..87c6074e405e 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -7,6 +7,7 @@
 #include "perf.h"
 
 #include <subcmd/parse-options.h>
+#include "util/auxtrace.h"
 #include "util/trace-event.h"
 #include "util/tool.h"
 #include "util/session.h"
@@ -405,8 +406,12 @@ int cmd_mem(int argc, const char **argv)
 			.comm		= perf_event__process_comm,
 			.lost		= perf_event__process_lost,
 			.fork		= perf_event__process_fork,
+			.attr		= perf_event__process_attr,
 			.build_id	= perf_event__process_build_id,
 			.namespaces	= perf_event__process_namespaces,
+			.auxtrace_info  = perf_event__process_auxtrace_info,
+			.auxtrace       = perf_event__process_auxtrace,
+			.auxtrace_error = perf_event__process_auxtrace_error,
 			.ordered_events	= true,
 		},
 		.input_name		 = "perf.data",
-- 
2.17.1

