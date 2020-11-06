Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748B42A8C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgKFBnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732788AbgKFBnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CDBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so2854974pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=MtjfMslU1NGbWZU2cLroLiemtQf0qxtMfLbbBa0N4d8yAVyZN8ZICcemCxyuzZ9f2+
         cDEdv8v4jLvx2k0cxP/zTi5QfKCeeWFMxuTCatlY4a0ZS9MLfzFnvqNZF1rwl09kRn5R
         ckfkGworLZ8xa6Egr/iezViVGciL5xxBT3OgcwaEUU9m7WAzU95XR6SUwamP5CW/TcaN
         Zw/+7xxaXOCV8xjSFDkiB/qCrYAJjwWPmiZyU6lS1ZyI/XKhu+0gJ29RnmzWH3zKsehq
         Or5UOuJIr0GuZnXMDEzPVd8ywBp+JnLfxbfKnh1ECAgOVbc9dnk7t0/UwRfCX/POoOb4
         z6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=d0L9oXxNBR8wjp7Tgam5tyQNS6ueEP2pTH1d/GCBzzdfN67DyaRCo6mCA2gnevmI39
         1kGaKBzSf8w4B7bCVibeld6fJnwC0U7KdIAiiguWpoKLqqo7FccE/tDdRLKQ7YtCI+a/
         ZwMYEgLzQT7o6hzvbJvaXUhkUZ7QsFjim3rYFisrVNTPJUkhhoQUdd83o4UqQpqX7vop
         xfM25mo+uwGOgVKeZ505U4DYddaoktMAF9ZcLz3lmN1sf6sUxir4ofaH42JuibS8bXc1
         wFzE/wSrs4Qop8dq/UsQNwFnYPGHYltj3Df2WAH2tLEQHeQyHEcz++5+I29Z7xWe2BRm
         Sxow==
X-Gm-Message-State: AOAM531satNzn7n7RHtu0jI0ef2AYI1Sa+A9BTKqg/aOGkCoGI0DOomS
        FMk0ynHRJ8O8qk8aLW8blmfMKw==
X-Google-Smtp-Source: ABdhPJxchVNUv/0CrK10wKQ+4QeRNDkPjQNkCzBJFv2BAv6rgdY/OQkUU6s9hFT0VFrMWAvpu/XpeQ==
X-Received: by 2002:a17:90a:fb8e:: with SMTP id cp14mr5033485pjb.16.1604626985003;
        Thu, 05 Nov 2020 17:43:05 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id z7sm3714893pjc.41.2020.11.05.17.43.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:04 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 11/22] perf arm_spe: Fixup top byte for data virtual address
Date:   Fri,  6 Nov 2020 09:41:25 +0800
Message-Id: <20201106014136.14103-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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

