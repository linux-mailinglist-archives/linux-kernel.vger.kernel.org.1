Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220D82B961F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgKSPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKSPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:14 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:13 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t21so4500610pgl.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=fEp1h3gaPJR7nar5j3PpHMBX1/sb/5qDsYvwvh+fnmsEHgN+7jQfX/8/sBrYEIefTr
         Ti9Muj+F3fo24KF38/JAKMHclZg0rEDjnrj9NfXDqXI0GY9fo9lhr/q2mtTAnZn0kb9Z
         JPUvdun8B4z/h6mRPPuEZtShmzlZQjF1yYpr541waGHTxNcraNvdnlX4T6N6p2+32zuR
         paajmVvAFrMl2RA2cC7UMhGc82AaA1LUtSqGfwn+84s7qwCji6xS8e6qbV/ESVV3Jmie
         8kzmyvNTD/8tcLiYE/R4h9eV9wUqdyutzXjBmb4ypgYe8rPDNxxXoMfLPUWjT5yG5LV2
         OEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=pa+mQTZgfKXRP8xkWcMlxF1NpvueGyl/W/BgMG2L38qRBiUenwHBIVzNRnjRJXYF1S
         zmRvrSj6lIv6ZS9XqfqWEOoE5RCIYMyaoNRtiRZlawY3n+B5aGjXGO+gM/f+wh3MfTT7
         Ohg5Kuxw4L4leytTrF7ZzvViWxzgKuWhtjjKY+Fw6q9UbZ4YzMveJ+I5yUNznvpMQODu
         X/cuq8oYF1MPD+RGxOy0WUKBEFDUuFPm/l4mmOYd4i1asvtJGGN7Jnm9Hpe3O9sYU+8m
         cBQGbC/jgOqPlS8P/rFw8sXMztq0Bym+7Mq9pg62kkXJZkRq4TGtgISdy4IzKaHlTkPL
         hBNA==
X-Gm-Message-State: AOAM531gp/U4HCHaLcz/9BOhZkgwEFt83PMOCWF4Iu1IAKuS+bk9ynTa
        MIqMQvYlH87vnotlmEBfUr2BCw==
X-Google-Smtp-Source: ABdhPJwXpJHgQD4X1NWIfilkx+2/X6lgps059GVgTh+xrVOrzcvIUOpOdb5V+AGgzKGpFntsxVBkdg==
X-Received: by 2002:a17:90a:e2cd:: with SMTP id fr13mr4961633pjb.97.1605799512958;
        Thu, 19 Nov 2020 07:25:12 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id d188sm122830pfd.86.2020.11.19.07.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:12 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 05/16] perf arm_spe: Fixup top byte for data virtual address
Date:   Thu, 19 Nov 2020 23:24:30 +0800
Message-Id: <20201119152441.6972-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To establish a valid address from the address packet payload and finally
the address value can be used for parsing data symbol in DSO, current
code uses 0xff to replace the tag in the top byte of data virtual
address.

So far the code only fixups top byte for the memory layouts with 4KB
pages, it misses to support memory layouts with 64KB pages.

This patch adds the conditions for checking bits [55:52] are 0xf, if
detects the pattern it will fill 0xff into the top byte of the address,
also adds comment to explain the fixing up.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 776b3e6628bb..cac2ef79c025 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -24,7 +24,7 @@
 
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
-	u64 ns, el;
+	u64 ns, el, val;
 
 	/* Instruction virtual address or Branch target address */
 	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
@@ -45,8 +45,22 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
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
+		 * specific pattern in bits [55:52] of payload which falls in
+		 * the kernel space, should fixup the top byte and this allows
+		 * perf tool to parse DSO symbol for data address correctly.
+		 *
+		 * For this reason, if detects the bits [55:52] is 0xf, will
+		 * fill 0xff into the top byte.
+		 */
+		val = SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload);
+		if ((val & 0xf0ULL) == 0xf0ULL)
 			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
 
 	/* Data access physical address */
-- 
2.17.1

