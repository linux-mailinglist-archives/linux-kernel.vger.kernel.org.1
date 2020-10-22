Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36429615B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368339AbgJVO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368325AbgJVO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8318FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c77so2437824wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=uV/BnPItpd0/Az2qZpJytINy0nX1JKeHgMciGlLfdrAyYcCUILVzbzpPmVxuHBGRaf
         wRfTRM64KWKCYYc0RTJ2Cp+rPat1KqiOjoie0+NPGLHi7ZhBYjBhoLz1AfxW71DmWXMC
         /lBOI7oXuobDFZLuo7vOi2bYfAEu6S/blYspnwlZfASl+vh5S5VvQyR2V3TaXSoI5Aqi
         tfgWv8zOC6lYicgeEzKYBdv3mFCrw8kaSQIui5heZGn50hV8/7K99eYOCFYW1nBmbbiU
         9mqOx8U+uUZTuwDuSYb+dupBKJzGMXMLutjlJDi/6EybYjyZvQuuhTMjSEcoijd4NN+u
         oImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=fKdXZMLWxW0gWYKpEQffZtrS1iXoaqfobjGGvtGUyYc2CM8dLvlsZuZ8+TFMI8sp0j
         61uf/6j5UAEZ8192Sihbfrdh7GVo9GdOj0wt/5AA1GAihi/GSS5ynKNC3RA6Y4zYu6lm
         zqrXY+zrN/icUVi7xi94G07SNrzJjWSXVBzR+UUmbCvViAT+RzenDo9a6WbUXVCOgicp
         yD65m70DRSvSEcanxo1ufV9MO1uLxjLRCJhk5qTVPsgkFG2LRD+xcEqPDWMceJ+iASWm
         KWx0X5l4DJ/yoLDWVtIhcj3bU3VY/UgS9r0fHeZ9f2HtHl5nWkjVAIRt0V8/jXgTlUZa
         8y9g==
X-Gm-Message-State: AOAM533+X7PuBhCzPY5jrmDsMy4OfCs2e8kK8i8eBzdG6JhWEhIEdD0I
        8IiSs0RFt3EuLae7UlyxChgFTQ==
X-Google-Smtp-Source: ABdhPJxbDCh2wCulB5XlPw5Xbe2aECAhkIIeoM293N1EbpTiDmfa4klh51L1lAz5uBKqW/RIPsGVoQ==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr3065727wmq.171.1603378712275;
        Thu, 22 Oct 2020 07:58:32 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 02/20] perf arm-spe: Fix a typo in comment
Date:   Thu, 22 Oct 2020 15:57:58 +0100
Message-Id: <20201022145816.14069-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
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

