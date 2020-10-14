Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFBC28DBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbgJNIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgJNIol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:44:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC1C04584C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e18so2121118wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P24ctiPgA/nHDR78H2N6HQcISCla3VGLPTthOKXCcGE=;
        b=W8My26oS7j5Nd3h8LhcLwAO53xxIfSg3+E20CCvPsO3o8gGwYfyc6LTvxquHJ1aKS7
         nB7QQKbMS0aXEGSd0IQYHHD4fI4PAC5fKff+NF3rDtC/XG+8R99hKi1UFGpiJzFbalqf
         t6o7CdI9MK3eHZLjzcTI922TJ7YzilRwt1a4hGjHhPaxZI1dnLp1gYzsEYd8go0OBPbs
         QPPMfu0FT2R17gn472ATHBOE7Fbe+FHhbRVm9l9dz/qkrVALJpM8Sz7O8UYL/QRy0l85
         /qsGEuaLprtgd3SWFcil/8C+mLSQjgpkqJc29FbV1l/wN7U6HliSdLnTQY9k35H7PI12
         Byjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P24ctiPgA/nHDR78H2N6HQcISCla3VGLPTthOKXCcGE=;
        b=HuycY3oADMX6LxAcL/6n1M6/+Zqpjimx0jWOKQ59slL2RLws0AKZ+EvTnU0z3DcRdi
         jx+KxcaQTyjndTdrNUVurD41bSb6fQLGVAttsb5yl6jdou2Z31EwMh5dJYnZchVXx7/j
         g3hI1oO+bkLWuaILmdlirxd+2Ddlo1drJ4p5Xcjs3Qhdh7cnzx8VlWXnsYDMtAxvE5Tf
         pr9QHUZLdZVT3s3L/SSfjlaKITHwBbgrSqAIgs+khLCvXAeq8KCq8o+NH5TLsurKyyQM
         ae6oBycoBaIqn9kyX5bE9R7IKO8sa1kaob4EnTySeBnzKJND7GeegJ5wH6hSCvJ3qv6I
         A/GA==
X-Gm-Message-State: AOAM532GkVwPmqQSJnI2qOY53T4tpwtiBkndFZlf6/iVnILDKWxPiaUI
        gS2p08FDjO4bZCMmV/nAL3vcSg==
X-Google-Smtp-Source: ABdhPJxfe5vwpecxl7PMIh2j3WqAXvvYwTBf1q9JdUXe389ecKpcxE7PWYJGLXJ4XeXaQtiPH029mg==
X-Received: by 2002:adf:e650:: with SMTP id b16mr3299541wrn.350.1602652172767;
        Tue, 13 Oct 2020 22:09:32 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/8] perf c2c: Display the total numbers continuously
Date:   Wed, 14 Oct 2020 06:09:14 +0100
Message-Id: <20201014050921.5591-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
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

