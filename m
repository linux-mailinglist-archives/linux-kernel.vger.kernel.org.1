Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1728F513
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbgJOOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388305AbgJOOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F8C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so3798287wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mtQ8uyNtDhsuh9Mh2rIa3Rt4zzP6rPyAQ+1jNbZKvzA=;
        b=oNfHw1ry9LbPWWKd9A9z6F/anUcWQ4gKMtV/rXCs6JuZdH3DkRQ2MTa1CI5QGpr4Td
         CiYEfsnK4EstBIAi7iADm6eg5+j+XeuPAQGGX/N3EgiooCJwJV7T0ELWEgQyw+sboOVY
         SRVlUxb+UD6AHKoE7uP94EtSHO9WP+aAnRl5aEDYUZE/4KsnhRf00CGP0xsyFgCIK4LA
         x/yQ8LC4bbGlZhdXE55Yw2cUUtbAXrS0RkVOkXqj0LMnM7gb+p2xi5sZfScecp2qDy4u
         mbwa2/rKixBhLHmTOV9OptQy7+WNuQowMIHrBtR811899+unSj3jUqpnzsMkqEYt0Ys5
         rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mtQ8uyNtDhsuh9Mh2rIa3Rt4zzP6rPyAQ+1jNbZKvzA=;
        b=PT36OjkWngj14CwxFc7ltRwztVsUwnUsDYV1lphfkC/PyQIIMtrqdaryPhc91VuGw4
         XLj5tlZSLko4rnKeK1HWnmRUQn+ksM6zRwgpz5c+NyiEiuW787bvuzCi0DMRXF4DPRVM
         S1YxHLAOuKkhDZIJgVD7GgKkWH+sH8rlhd3cQmPGq9BfbuQtyWQN3Q2Gaw68qKeOzivV
         G8C+i+MYPsZ12AoetO4dQX5nOKsnsa1rjw8A1ETDW5ZJQpws1i/KKPI/twZZ8XoNWZgx
         kG1AGqdvHhDiCP/eC1xsJyEGVYN5d07OKtKNatV6wn4RgTdkrbfTqchXtaFnHSC5BE5S
         lN1Q==
X-Gm-Message-State: AOAM532kWkmYsmUJZNiplOuS9/knmfuY6BtG+VcSVD6kG5duksgelYQ8
        oioaReQDk1QUqQCuDUIHk115Ww==
X-Google-Smtp-Source: ABdhPJyLOg+uifPc4RAeAoJhsK1Xrrw0Z+1QvA/0i+3K2vL/F9trEq4nYybLoyzWXF8wvo37c4Ky1A==
X-Received: by 2002:adf:de89:: with SMTP id w9mr4757889wrl.212.1602773168896;
        Thu, 15 Oct 2020 07:46:08 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/9] perf c2c: Display the total numbers continuously
Date:   Thu, 15 Oct 2020 15:45:40 +0100
Message-Id: <20201015144548.18482-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To view the statistics with "breakdown" mode, it's good to show the
summary numbers for the total records, all stores and all loads, then
the sequential conlumns can be used to break into more detailed items.

To achieve this purpose, this patch displays the summary numbers for
records/stores/loads continuously and places them before breakdown
items, this can allow uses to easily read the summarized statistics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5938b100eaf4..e602b7891ce9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2846,13 +2846,13 @@ static int perf_c2c__report(int argc, const char **argv)
 			"dcacheline,"
 			"dcacheline_node,"
 			"dcacheline_count,"
-			"tot_recs,"
 			"percent_hitm,"
 			"tot_hitm,lcl_hitm,rmt_hitm,"
+			"tot_recs,"
+			"tot_loads,"
 			"stores,stores_l1hit,stores_l1miss,"
 			"dram_lcl,dram_rmt,"
 			"ld_llcmiss,"
-			"tot_loads,"
 			"ld_fbhit,ld_l1hit,ld_l2hit,"
 			"ld_lclhit,ld_rmthit",
 			c2c.display == DISPLAY_TOT ? "tot_hitm" :
-- 
2.17.1

