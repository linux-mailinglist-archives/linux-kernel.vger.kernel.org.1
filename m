Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C402F2AE96F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKKHMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:28 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:27 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id g19so224526pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=vj9wQLHSPnLEiAPsS2V6Cec5V4J97ZZEeDgCnT1q3oM9g1+7bj5fa/fx5xP6bfsztW
         yI8g3116IcyutTN+/JMCUt/sAGO1sPgNs4oaLg1alrLZwd4EVnvgzBSXARYRjpSxyk5T
         4ZSuNBQ7MrwaqrrYSVQoJqnd8qPzdj5LeYX/R6tnq/TOYFr+FSWdL48C5gzeD7BqlcF+
         AcM4DLUxGZ1JTaassCQmYkQzh8iLVCN6H3Uidrs4d7z1NH9h0dF5ok3UGby/HM9hetAO
         tEeD7q3xh3siwgFlchbr6UFDuDkTRHecO4P3vNDuSEsAa33ffJkT5K5zDqLsuqRY3ajZ
         5EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=eOnH3pN5YzfDMEff87BNHH6E0psFqvX10/govyoh2kXFm0JK0Y47oXdDihIGvFYR+N
         KWBbCjysW8nID4gk4i3Liuj5kX5LutHIylcN75Dv4snBIOA/qqbrzv5LjnpPmRRxXbbc
         HPapxTNBanHYpAQLx8+VDFdcOewNEOKZEAOWxx/sLLHuQJIdnGEhu+KGUe+HEvpYx8+N
         RLZFR0n8eZXsWvjFUsxg+Inv2Dh58KKY/blkhZofbBTq68XcItj+iFE41qI4EnsrWV4G
         KdQ7XZ7tCdX/KTU2TlOrZt2O9nTMI3T/iHUeHp7rhsLcRJACtgqGRABwYh4d0PJk7zQB
         6Jbg==
X-Gm-Message-State: AOAM531j/tKmIIPd5VhdP9D7oZ/hSBmR6DC/ie7H8iMcCd4Qb+nx9yHv
        uNNwK/dTRsYuRKYRC05jNKLlkw==
X-Google-Smtp-Source: ABdhPJwdtZvOf3DM/HNpavKPxqpOkDe3e2iEwP8vhhQ7Uy4n3iO5ycQKgPoXwBcJ9TXSGWoV4RDMxg==
X-Received: by 2002:a17:902:446:b029:d7:cdda:87 with SMTP id 64-20020a1709020446b02900d7cdda0087mr788198ple.11.1605078747321;
        Tue, 10 Nov 2020 23:12:27 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id m20sm1252358pfk.31.2020.11.10.23.12.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:26 -0800 (PST)
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
Subject: [PATCH v8 02/22] perf arm-spe: Fix a typo in comment
Date:   Wed, 11 Nov 2020 15:11:29 +0800
Message-Id: <20201111071149.815-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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

