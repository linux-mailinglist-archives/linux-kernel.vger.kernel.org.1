Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E12AE9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKKHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgKKHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:13:03 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38601C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:02 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d3so514835plo.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=Igz14EE18JuS1uRt7Ub+9dKZxkOsuzxqdFdkW7ZrQ7QfWjoccPH7fxptxqVaZ27ZzO
         7WcRwiHbbeXYton7kVRHuXb9FbZr3hHElDhadU7DjhOgUbqY6yFJ5j5vc8C2QGH82ZSb
         yFBc7US3zpLI7nuZSfi6XspkJWwU5yQiZztUNt4PM+IprqOdZNh694jBPPfYsnv9qXqk
         77bDjPj1yd44+n2MOrH/+CVB8vS7MekN+UmWmw6FujBQcHS4WosgPDEsPq1dYmXsRzQh
         tMMcG2TR0Oo1Xe4FNx781MNrOI0ugZ+vtMY4wrb+p9nIdr/V9xUlwZojyD5r3YL4uchU
         QVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=Vyw7pbPgqgIuIXQCNzSYR/fbAtJ21PUhePXyfxDIOTEhbPTaitHCRlVlShhODvGU1V
         onw7lWd4hnxwkAiAw4vEKltFaKh0ZzVY0zgCgDj8aNTpArg9hK+3+axss6D0K62tjV9+
         FJYM7gWfXGzFYNk/giozO3ULLBQAS6MnkhgwH7zCPo08MVb1EEDI8plY+5DyNzTp18lJ
         XC2h6hKZg+4RG1DcwDiJeDWhr7fAdowlHUrd2uky8KN8doCqDDY8M5KzCe+GsXPSu0UA
         LipXowP3EsPrOYpBG+JF9yCcA4JrukXgN7knX3YAWoSSta1WFhKQRAzele0PqrJtKDpa
         sg1Q==
X-Gm-Message-State: AOAM532abF9wFDQvEdTVCjJktEspuJKy+3nau95pX14QYv2B7vu6zNvn
        HoVPR1ZXn4ZYa7ulHoeKKnmROA==
X-Google-Smtp-Source: ABdhPJxKIwcXz5cYVEpALVVnZxVfkyJw6p0eN3pSfjTTfF+JoeLHQs87QU48oGxywztkmU8058m3TA==
X-Received: by 2002:a17:902:c412:b029:d6:fea3:429 with SMTP id k18-20020a170902c412b02900d6fea30429mr20370120plk.50.1605078781759;
        Tue, 10 Nov 2020 23:13:01 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id j1sm1238059pjn.5.2020.11.10.23.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:01 -0800 (PST)
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
Subject: [PATCH v8 11/22] perf arm_spe: Fixup top byte for data virtual address
Date:   Wed, 11 Nov 2020 15:11:38 +0800
Message-Id: <20201111071149.815-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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

