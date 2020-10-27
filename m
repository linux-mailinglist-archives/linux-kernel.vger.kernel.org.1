Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4692F29A2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438967AbgJ0DKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46442 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438872AbgJ0DKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id x10so3826plm.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=G4XuLuMOQcuHysJPX7+R3Gd2f/76VBbKSq7OZj+Q56/J2di4bKkaHOSr9nnVcae5If
         ndpfu1AWKU0fwnYqTsFnStdSjrmXjE7HsVdHO6iZtXHKlin33b4kDuxRekmeHopnlPWy
         owZ1n9We6IRZZlMifAA7epKM2eLJ4w0YV2ws1klDWWFz5oP+BdtcKaN67rGdUXF1JRAW
         GAKanJG/u0fJ+ndp0DYKIDbVjs6L6jyr5lX/2IlzO67Aj1n4+rzljktETtPtJpDR9FlP
         feFfUjoIlfpDv0qsbZ8izqcu3I7q0HvqyMLU9XDruYJXxmo5UsoZuWGjv8D7K42RZh1d
         EpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=pOA273YKkY8SQ25CC7ktWSRXub/duQrLETsM/0/JzKVO6DaQ+QLwS/5qlKPCHK5PpR
         yyRYYhGSWBWWgW67Nk5lkouY8ynxYzzyYgwGE78Ob2E+m2DJpbf2LuFEC0itdKK91DiA
         whXQ+bW3WRpzQcCQij+zewKjpo0dbp6FUQsoo3BcMy3OPjDhBrkizLCWR3KyW2aQ88J6
         gsLEMPln1Iw2R9Pv38GmgueaXMkrTHzdhoPv5Pec2dEqsHU+vgbX0l+DCXHGgpoBmsD6
         neABxaNFOxDU8oUSQ9h/PvsAW+zrRv7ejDfGytL03yzg8/Z/aRCh6oBxTxIH/3LTbMhL
         uWiQ==
X-Gm-Message-State: AOAM533pZRMwr0ROyvsDsLB4gnfDr8NmfB82fRkOI2CX0oC9AVaLkt+/
        DMGz1vSYBi5ozjC/JWDA+xlHlQ==
X-Google-Smtp-Source: ABdhPJytUOkmApgw2fWUtjRE3945lYB3pqTShWkP3+iWH9YiAKqX90jFIAvgRWpPruAc/S6sOZRj2g==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr99930pjb.6.1603768215370;
        Mon, 26 Oct 2020 20:10:15 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z22sm157087pfa.220.2020.10.26.20.10.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 02/21] perf arm-spe: Fix a typo in comment
Date:   Tue, 27 Oct 2020 11:08:58 +0800
Message-Id: <20201027030917.15404-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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

