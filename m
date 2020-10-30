Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3750A29FBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgJ3C5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgJ3C5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:57:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82E6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:57:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i26so3972875pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=q75yvgvoeG3h29pQXmuVlGS5srC7x9Gl81NCvP811R7h7xz9j3BPySFup5NJkdQZX7
         lYJNjic5ap+0HdAvQe5YPRcDPbkf6n9BJkQfWs6KNarShvSdmcemzE761Gfb3cfA1Mev
         CzPZuc7SmEbD65JbzJmnxQikQEgvTZnUp1OisJ4T88DfGO6fQWaJ7FLVR4H6rjkFzlpp
         kG67G5onMZwFAGX+3Dg3RJHkYIJQTeRl3SeYT+Yf9E9LwNIyUMzCglpPNfdaBKSZe+ds
         U1NhRW7njuY7MtfU/jn/eSYdmE0JauzN55uJCHLag16REbCUXKkw9egMqc5gZlHwINnZ
         sToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=bn6f9CQebQhGIuNLxtEmMH65bDgP2XozrXBSCYJYRsPSM+CIXzPVjiV/V1/X6xGgw5
         9C/YsOuVeUTpuHVT0hlrKf2kcwmlOrkIGZGX2cr69oKsXyXn1AHb49eefy90yDpYCDnx
         izrUOUGURC6o/kpdZwz3nUCQgdGQSkIMQXCR02DUZJa3Id4KCsoc2ZQlQfSGiaSzOAXm
         k45InSl8pDE5kCS5WavVp5sHOazLK1RNK8QZbtGPxqWes9t4IwYCTzYNUzNWdo6XmGL7
         Dyb1VdinHvrD450asRwZeCGlDhWHZpONcJSFPLc/PxX/I7/rNVp7QfNI83feWJeuBhx7
         NYkQ==
X-Gm-Message-State: AOAM530lU/U2nLt2OP1xjcbvTvn8QT8zV/9MflZCv5tKrrT4TBPoisLv
        +12M0nUNobNe+JZfopSKr+zEfA==
X-Google-Smtp-Source: ABdhPJwtRJ2AYzpeZHGh33LaP+sY2wvjIAvVdWsPYRTmJ56yJOwT8TBEftF3u4qg3Qao7HjTsohV7w==
X-Received: by 2002:a62:5382:0:b029:155:6333:ce4f with SMTP id h124-20020a6253820000b02901556333ce4fmr7237855pfb.28.1604026673374;
        Thu, 29 Oct 2020 19:57:53 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 194sm4216258pfz.182.2020.10.29.19.57.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:57:52 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 02/21] perf arm-spe: Fix a typo in comment
Date:   Fri, 30 Oct 2020 10:57:05 +0800
Message-Id: <20201030025724.19157-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: s/iff/if.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 46ddb53a6457..7c7b5eb09fba 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -142,7 +142,7 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 
 	/* we use index to identify Events with a less number of
 	 * comparisons in arm_spe_pkt_desc(): E.g., the LLC-ACCESS,
-	 * LLC-REFILL, and REMOTE-ACCESS events are identified iff
+	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
 	packet->index = ret - 1;
-- 
2.17.1

