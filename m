Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C928DBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgJNItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgJNIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:49:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD4C045851
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so2165491wre.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Isihx/56GGS13NejOttVXnL0e3+MIrS0JceAJ0r1Nag=;
        b=s6bfrRs/rKmXQL0MTSkamhLjbwQ7K9hPrZ5HIJmRXE2qyrzfkHltutlRSKlG558Pga
         FI8TA7RCzWFCUFLi9KWb6lzXPRLl2UjcI0U7swuR4PVzuZKTkJnDnniv38uisDN8h9mV
         E2uZczaanttcu3n1lHAr1Yf9uSyCwpS5eSXYdFoT3a++VTYgRxDrirlenh4Ltsyx3otx
         8A/jCMhp4BZ/noRNHDa+Xht6zOfvQAEXZqzRc3OFnEDWZT7TtImES2GTzR3T0ojItUTA
         /XM/mhyXpYb7NRMnKGeh6xedcyVKusZMFp1IQc7rUXXT4fHP4gKceGkP1LNaNQWTUR1g
         7nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Isihx/56GGS13NejOttVXnL0e3+MIrS0JceAJ0r1Nag=;
        b=TbujDjK5oZJfbsRzan3gR2T/yhDgbeKYNob4odyAGsjcQWRxUrKOWDge4ldkIZFu4P
         KVa58UWwrFmf8HOBlKYmQ3b4liAJ/12vCKJMPqC5eR24ESd1J9RnGsXJroRrOi/bfMxi
         c5QhHlJpu6nlfTbT8QkAxYRmhtuYgBNp2A/z8D55LfenaYOWA80IHfGkRlVPIJBGfi3t
         D2aVZ/tcCoBZ+oMA8UsYynuiU2ZOkk4wNpcs5l2iY4D0m/bi7c3eR2NUqZMdqINWL6jG
         XJwAMwHWdNpe84A5N1GmwH+jy3JhqOTbaE8Uq/P6OVKbhpUdUQu6CgICufJV8sQB+QsQ
         5Awg==
X-Gm-Message-State: AOAM532ymBAC1bC63tP4cvLpJOCEgfhNhsN9easH2LnibB1Qc26kAoi4
        CLCcZJdE2IyGbjLR3i94UhJHFQ==
X-Google-Smtp-Source: ABdhPJxVzCqF20yQyc7QGUZ2QR4Bn67HXEkyoFmaKtGKq/bnkSTlwIE/Rbp64Jl9gSqzAteT8Pj0ew==
X-Received: by 2002:adf:9f42:: with SMTP id f2mr2948327wrg.388.1602652178944;
        Tue, 13 Oct 2020 22:09:38 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:38 -0700 (PDT)
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
Subject: [PATCH v1 6/8] perf c2c: Change header for LLC local hit
Date:   Wed, 14 Oct 2020 06:09:19 +0100
Message-Id: <20201014050921.5591-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the header string "Lcl" with "LclHit", which is more explicit
to express the event type is LLC local hit.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

