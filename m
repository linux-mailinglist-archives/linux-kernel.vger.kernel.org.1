Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9F29E484
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgJ2Hkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgJ2HYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2DC08EAC2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so881628plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=FiPWNC8JD2mdCUmgmwW11vi/r/SSPWadXGth5IWT/AQwG1saKPFcOmyoudo1DkJk+0
         atdbIhyKK8ACmpWoqccy35vKdC/17r9yYIJJAuNZzUib7xGCVfgqP6AgFF0LWHINSeif
         f7tmKSNmPzB0gcIhLqXQ/A+r7H6xc0uSIpbz3O79ajsqI56ySTHP7h4+PQ4LtN+hiUHB
         D+3Yrh82cZjc/fXepkIrHdRyaPuLlU3APqGFGoy1l4AJ/JinhgopiuG5ytVbzesAk854
         ihZTMKtNxBO44Lo/dkRDJC6QG9bgRb064mqS+zOlNFiCTRDrivd0grDzO2VBtZjV+Zw9
         zdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=Gof+b2PrIiCPr4CcNSfm/OUfhY26szh+M8r9SIa0ixRCt27HO60cxdjmYywDX9ac0M
         9OV6ntoFMt7bk4rdWZlLNkmCLmi021GaacsKFaods4oCKdXzTtDXBcteoYY0RTjFcua+
         CYz2tkc3PFpeKZ0X4YfZoEfVkN+C/5YzEly7A4aJGB58ZFKHR6w2WET7mxjE8/GAnDvS
         CiVJwe21AtIVCS+GY3BO0ZMkG1cgc2nO4Kw9bHdWOnjtHSWuiGVZDxUg87OaRtZFLFTV
         CAyaDLjwxNe8w39tiSbpW/1IkC7F103tPh2I8Jg1a0bnQ+UIDXI0JGGxu8pCrTf7eMor
         0p0g==
X-Gm-Message-State: AOAM533Asqs8YcXorD+LT1Jbrj9vyvIZjhG6x8SBU/JWqIbyqLyIOCBf
        /Z1tejHr+8zKEAJRmyE8RewXCw==
X-Google-Smtp-Source: ABdhPJwXvJzElcL8YmPPzuoUoNmcSKJMEItHP/rClxya1kL+maT22u+VrR+4pHbs8RT0Udix0uOv/w==
X-Received: by 2002:a17:902:d710:b029:d3:7e54:96d8 with SMTP id w16-20020a170902d710b02900d37e5496d8mr2695564ply.65.1603955989355;
        Thu, 29 Oct 2020 00:19:49 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id nl3sm1424487pjb.16.2020.10.29.00.19.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:19:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 02/21] perf arm-spe: Fix a typo in comment
Date:   Thu, 29 Oct 2020 15:19:08 +0800
Message-Id: <20201029071927.9308-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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

