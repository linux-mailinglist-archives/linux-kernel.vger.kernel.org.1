Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B899529A300
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442329AbgJ0DLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37419 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441478AbgJ0DLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id 126so82572pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKg08zyJMCR/Obh9fsxLt+/CcExOahzavLAHoNQrPig=;
        b=ZV8wy7ExJVi1Jp1pQhMJF+0Zpn7p3W0nYRpvEtGlKRkqYG+eH66Q5AiQ1Z8TjJhSLK
         AHiqJAGBitDOFq31ZHDIciBdk2UkbNg4JmzBu97zJulp7WvLpJhnm4MaDDiI0dgqmA12
         vTYvD6p+RIphv5htGRz071f6pxKanxjwdTwbrDmSMJlwPNWV0owXb3kBzvQ2XX3E5AD0
         K6hBo4p6wq1Y9clsyPR99gx43A6hoCbetESa+GXlqe+HjHV/x9tyreamY71z9l2Q+H/W
         sEwTat14fi26YxRH4TPPj6cOaYuXqgXRhNSpuaCYmwb0PDHTKvsAfkxEyzyT51YSKXkM
         Gd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKg08zyJMCR/Obh9fsxLt+/CcExOahzavLAHoNQrPig=;
        b=fh/keYPWmVALYte5QRROmtIRhzl/88ZS2xgW7hqbiOEvGDVUQwIImDm3sZ1DA5R0y+
         i433kcvGwPx5ZMPpLzvm/qq7Qs4LDn9438w7or/K2tLnHRKv3gyVS9wVZmEyKTGuS+NU
         55KKrTMMW7HW1/FWFoMOztrhnQn1/r36r7YKQA+/yahPx0inyI1bl3ch+/Fn9z9xKAHi
         Wyj09pnuVRqfitLCf52G4snVFyGanICYktEhNrriA1NlNnwU3lwrRuAN9eJIzMMlEX3J
         N+c8EfJQfafFKeazt+gFYJ2akG79lh2jg2ek1l3yR2FaW2Ax9BrpvSDbf3twdBlOMOMn
         8INg==
X-Gm-Message-State: AOAM531wngu7oxZ/kaZDJm3noPMgb9Xh8f3nxuffDj5bPrgOUPa41aeJ
        ha7OpGkBI8uApu0QsWkVP1+lDeTTeCmA5X6W
X-Google-Smtp-Source: ABdhPJw4anY7d6Tv6a8Osg7z3hY2Fh7JaAWnmiQWZJ46dF1bCja33yU7/0gjrTvanc/18rQnMSof1Q==
X-Received: by 2002:a65:6158:: with SMTP id o24mr98260pgv.120.1603768261000;
        Mon, 26 Oct 2020 20:11:01 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 9sm190541pjs.1.2020.10.26.20.11.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:00 -0700 (PDT)
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
Subject: [PATCH v4 10/21] perf arm_spe: Fixup top byte for data virtual address
Date:   Tue, 27 Oct 2020 11:09:06 +0800
Message-Id: <20201027030917.15404-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To establish a valid address from the address packet payload and finally
the address value can be used for parsing data symbol in DSO, current
code uses 0xff to replace the tag in the top byte of data virtual
address.

So far the code only fixups top byte for the memory layouts with 4KB
pages, it misses to support memory layouts with 64KB pages.

This patch adds the conditions for checking bits [55:48] are 0xf0 or
0xfd, if detects the patterns it will fill 0xff into the top byte of the
address, also adds comment to explain the fixing up.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 776b3e6628bb..e135ac01d94a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -24,7 +24,7 @@
 
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
-	u64 ns, el;
+	u64 ns, el, val;
 
 	/* Instruction virtual address or Branch target address */
 	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
@@ -45,8 +45,26 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
 		/* Clean tags */
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 
-		/* Fill highest byte if bits [48..55] is 0xff */
-		if (SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload) == 0xffULL)
+		/*
+		 * Armv8 ARM (ARM DDI 0487F.c), chapter "D10.2.1 Address packet"
+		 * defines the data virtual address payload format, the top byte
+		 * (bits [63:56]) is assigned as top-byte tag; so we only can
+		 * retrieve address value from bits [55:0].
+		 *
+		 * According to Documentation/arm64/memory.rst, if detects the
+		 * specific pattern in bits [55:48] of payload which falls in
+		 * the kernel space, should fixup the top byte and this allows
+		 * perf tool to parse DSO symbol for data address correctly.
+		 *
+		 * For this reason, if detects the bits [55:48] is one of
+		 * following values, will fill 0xff into the top byte:
+		 *
+		 *   - 0xff (for most kernel memory regions);
+		 *   - 0xf0 (for kernel logical memory map with 64KB pages);
+		 *   - 0xfd (for kasan shadow region with 64KB pages).
+		 */
+		val = SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload);
+		if (val == 0xffULL || val == 0xf0ULL || val == 0xfdULL)
 			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
 
 	/* Data access physical address */
-- 
2.17.1

