Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1FF29E156
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgJ2CAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgJ1Vvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B867C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:51:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j5so287773plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TtoZpQPYNEejbPx5DIZkp0HCaCd8AlDlHkvVw7KKz7s=;
        b=EmUSZbBBq3qB5Mwus42iZqe8GxEwp1uEPmc3rh0d08VKW7dNYFbbXiJB/HFD3MjHfe
         YmOLfn7p6YJbgtJDItJe+4AIcXxAQ8dZbcpR/uIHFnLgxL6OU14lI8Erdl22xskjJYPR
         sjt4g46k9A4dm0z0zMfLYoy3AhOq5FGBzfVcqwIRqCEGaRP0NCoxhvDkik8kd+Roq2PS
         b50fzrANkdmY5Mzh/m+mtzQXdx2c5gqtmuBbl3QUN2AIkSgSV8NsylsaBxh1+OwnANEt
         /aGTyD5T+FBwsW8A5NLbfXaB3KcI5ewXmhd2UzqO+JyqgXMA8YQrMFRVe/fDUtxC/ujz
         s9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TtoZpQPYNEejbPx5DIZkp0HCaCd8AlDlHkvVw7KKz7s=;
        b=fNcQyr1rxVx4MzKVWmhvKO+iPyDmggVgJzYdD5sfetuS4vgo+cLC0U7HQpGYzmg9xy
         gAa8P6vuPMKVzwhkk0Sn/wLHL6lN7KlP0UwGLLQrn3C7iBexmU2imLrRaSWbI5Z7FsQc
         Mn2w4F8KS+BLjOXsNYjFq+eV/7tWhIueKdgAVO2NFEEskPZ+w9Dj7HdE2haSe/t4AMfn
         kpN+cm8xG+LhwsgD+JI4DacxcJjc5Nnylx3L0AfwViYEjVieyOvpGPnDOYC7GVicmI/F
         GN0E7clGrHy2Blweqk/JzbeH7WU9FDipzz1t+03Szb7SYj7OQMnBfwdsQ57cJg129Q4C
         5uWQ==
X-Gm-Message-State: AOAM533H9ay13Jo616vSs4tP80slUbV4IcsW5A/R5GgSksl+l7TsyuCm
        DAwPYg53AmjjJ4txfaXVTq7ZaTSt/nDB/4uY
X-Google-Smtp-Source: ABdhPJxxyxLk24HyWV9VW6Mh3dKZzbyameM2F+tG8Rcvg2yewBTlfERd71FuCSUhz+lETr7EqPRmaQ==
X-Received: by 2002:aa7:8bcd:0:b029:160:cb7:b639 with SMTP id s13-20020aa78bcd0000b02901600cb7b639mr5345218pfd.78.1603867134567;
        Tue, 27 Oct 2020 23:38:54 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id m13sm3938939pjl.45.2020.10.27.23.38.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:54 -0700 (PDT)
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
Subject: [PATCH v3 6/9] perf c2c: Support AUX trace
Date:   Wed, 28 Oct 2020 14:38:10 +0800
Message-Id: <20201028063813.8562-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches adds the AUX callbacks in session structure, so support
AUX trace for "perf c2c" tool.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4d1a08e38233..24f4af997aab 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -369,6 +369,10 @@ static struct perf_c2c c2c = {
 		.exit		= perf_event__process_exit,
 		.fork		= perf_event__process_fork,
 		.lost		= perf_event__process_lost,
+		.attr		= perf_event__process_attr,
+		.auxtrace_info  = perf_event__process_auxtrace_info,
+		.auxtrace       = perf_event__process_auxtrace,
+		.auxtrace_error = perf_event__process_auxtrace_error,
 		.ordered_events	= true,
 		.ordering_requires_timestamps = true,
 	},
-- 
2.17.1

