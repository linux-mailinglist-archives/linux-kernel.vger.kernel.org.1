Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADD828F528
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbgJOOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389103AbgJOOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6111C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x7so3854636wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IMFJ0vLiBmnvDLHd3ga8rTZbEXYm1jZifm/X8El852k=;
        b=DgMLmkMwLXb4OQMBQfqMdXRWVCQnXbjNtT8FyGHqud0Ts14qLn4fKcPr5+755Me/ck
         onqAeODuEDberi+B4ohlGsXZhJdG8vhtMu7bwPvZFLYuE7HmmeOER04WmEfaOUn1eUIu
         eCXQBtTvU6d+cbTPidmA6PjdMrHX3TvX28P5q7nDZOZoXr9dMaVwoXbB6vSsWoCjuiJS
         skLdXwXEIqpMt921sNHFMajM3jVNN2BbLn3aPDNWJdGSNA0WMWadubCZ3b8JYTS19dp2
         s5IbPdyReeuvpVLaVHFds8nu/vQHTKiynTQLEkmQqApfH2AjZ/b4KxcS2UOQ7yYktqjf
         E7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IMFJ0vLiBmnvDLHd3ga8rTZbEXYm1jZifm/X8El852k=;
        b=VPql5+Pbd9r8FzV+cSt/rJhHhEpozsTjs7MJUX0FacwsaCAYhOIFrP7I9hHewt2deE
         s8o9RXHoP9yhXtaUdm4+htKaIM4KJh7SpR5giJRGB1XdW04eWtvNGLoLKdI/jPfI278D
         IhsgpEcvsnaS5rTYndsH+fELk5FmHtA5Kjp0QrZY5FQoz1TsHH4N5o1ZPlGqVPF2KJ0d
         QggmtVEsgdQbMlsKv55ElKvu5GAD8acpAwcqX03neQtNk5XSJL0Wp4Oeh6dngMELfStX
         ha6Dcn+6XYfShow/KyOnPuqKmZ5e3M37coXmyakYA/CD13wPxfn/4VyZ9d6t/4klc0lp
         24OQ==
X-Gm-Message-State: AOAM533u78lOkNIuk3qP1r5yyBZv+C35fkgyIaDxgT2Mh6PMSf07hXxt
        dtiGkZ/RK1cIDoHnGpK4MScFeQ==
X-Google-Smtp-Source: ABdhPJwizB7XQytI+FENbQOwKOF6ejVQw0Un9BU07KRWHy+EFfE9c+xOs+zI+A5NvBomldLXTJqBVg==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr4856398wrh.206.1602773177472;
        Thu, 15 Oct 2020 07:46:17 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:16 -0700 (PDT)
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
Subject: [PATCH v2 6/9] perf c2c: Change header for LLC local hit
Date:   Thu, 15 Oct 2020 15:45:45 +0100
Message-Id: <20201015144548.18482-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the header string "Lcl" with "LclHit", which is more explicit
to express the event type is LLC local hit.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3d5aa21020f2..2292261b40a2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1432,7 +1432,7 @@ static struct c2c_dimension dim_ld_l2hit = {
 };
 
 static struct c2c_dimension dim_ld_llchit = {
-	.header		= HEADER_SPAN("-- LLC Load Hit --", "Llc", 1),
+	.header		= HEADER_SPAN("-- LLC Load Hit --", "LclHit", 1),
 	.name		= "ld_lclhit",
 	.cmp		= ld_llchit_cmp,
 	.entry		= ld_llchit_entry,
-- 
2.17.1

