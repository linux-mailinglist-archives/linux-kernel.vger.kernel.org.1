Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C90A28DC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgJNIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgJNIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:54:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E07C04584E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so2148033wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c1KU/u1XvFV1/DzHOJSQxp2UACwpRThoBvf4nVHIH4s=;
        b=pOpOecqsck8XVdzOuzSM9YkCAJ+kNXWZj1ydF5TPQBGk05H7ylk8cBFkDwqMP2nF1S
         UnoC2N+VMbwTJemfGsoC7vghhZNTVqF5bdWIgoBVsf93LjEBlY82U1B0FJnF/3IGLqxJ
         gZRAObabZSDdlsW7Ol35IY4/6z+lSvykLZ6xxx5W1qHjGvQH4fCnqpPL26xm1oStIehq
         Xu7KhlrwT+y0g99OQ1K1SkL8YIYOJsoopGNK2FrytlEB+taeai0EJfI7qDEu8Pv8RtGf
         ZT683sLMDgHc2nKhgf5KD/lLUZN2PkWWrRdRvhDky6zXubkdpfsftTm5DF6eQ02CZIX4
         vNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c1KU/u1XvFV1/DzHOJSQxp2UACwpRThoBvf4nVHIH4s=;
        b=GKdOzzdMt1WvYOf9rY05JcL1s4hCzLCELT/EhrOYqfMsXFdpr7Q7OckuLi0SWzugYs
         uTuLYS9TncRZ9dpQu4pylRcj4BP4t+Hmqzf39JF43PuV/Cf8GRgNT9fV65P95YdFg8tV
         Srpk2aFgoPD8K6AMJkNSILrbFSMCg3MEKf6756lDb/IOPgaaqb/kHLgEwdsUA8eTWHws
         vTSK6gKneA4atlyDZ78v6oDfJ0l9OagHc3DUgPzO5lB8M0um2BZ0BBTd0tBowaPEW7mA
         7Q224lrG/Edb53eDOlL3S+5mlFQh6D4HeHpitnMekKKr3mXJ/KLcs8Dz4LZeODuciGtf
         h7Uw==
X-Gm-Message-State: AOAM5333bvLDXZ7TzNB28n1wmmjba8w93rOXncjUPTyXTXMhZmrKjqLm
        4IZysInKsy0ni+/IFzI3RWIzYmmc1/72jkG1
X-Google-Smtp-Source: ABdhPJyEAsW6HboCy8QLj0zSZzt+UF7xEFo61Zxl4+6jaDTx87R59URFccwsnr62GBm9bAX2dIEeIQ==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr3379158wru.271.1602652175153;
        Tue, 13 Oct 2020 22:09:35 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:34 -0700 (PDT)
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
Subject: [PATCH v1 3/8] perf c2c: Organize metrics based on memory hierarchy
Date:   Wed, 14 Oct 2020 06:09:16 +0100
Message-Id: <20201014050921.5591-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metrics are not organized based on memory hierarchy, e.g. the tool
doesn't organize the metrics order based on memory nodes from the close
node (e.g. L1/L2 cache) to far node (e.g. L3 cache and DRAM).

To output metrics with more friendly form, this patch refines the
metrics order based on memory hierarchy:

  "Core Load Hit" => "LLC Load Hit" => "LLC Ld Miss" => "Load Dram"

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a2ad24799aea..404d4739b8c1 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2852,10 +2852,10 @@ static int perf_c2c__report(int argc, const char **argv)
 			"tot_loads,"
 			"tot_stores,"
 			"stores_l1hit,stores_l1miss,"
-			"dram_lcl,dram_rmt,"
-			"ld_llcmiss,"
 			"ld_fbhit,ld_l1hit,ld_l2hit,"
-			"ld_lclhit,ld_rmthit",
+			"ld_lclhit,ld_rmthit,"
+			"ld_llcmiss,"
+			"dram_lcl,dram_rmt",
 			c2c.display == DISPLAY_TOT ? "tot_hitm" :
 			c2c.display == DISPLAY_LCL ? "lcl_hitm" : "rmt_hitm"
 			);
-- 
2.17.1

