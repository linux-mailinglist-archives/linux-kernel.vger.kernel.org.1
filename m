Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2C29FBE6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJ3C7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgJ3C6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B9C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so4023744pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=ZT0iBg0uDQT2uPwfSlAacIVHkMxqameoi/wLr5UTpRa5Vq0Vc2f+0dYwDqZQ0bcBUR
         AQN0sSC/7j7Vr1Xpqob7lYA+YT3kM56LU8HdHdQraFM/ZD3bb35nuTaQwIxZ2b9SPkh7
         i38rfSwgpNUHCPS0FGrreixyoeXpvtv5xfdqKNxOayJkvYkU5dgT8PJdglP+pk0ggxgW
         milQ6Q3wIei08Ol+1QC02LoIRKFYm6LmWYRIn8KgfsWMTtpCTXWUmerBSpP67WvD52K/
         z2O2DccQ/oDDcT5bHyRALc3r79ju96pZtO3ZlpJBuL2RI3y9PrjTUlgOeQJKxYLaMcHW
         NZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKtpSb7ggyuP00IKgz0kuA1rF3BXU0c9G0aSMbhomVk=;
        b=Rxu/iYpgzcp9fcltBDKBsbd1q+9P8M982hyJ66uuLazFpXcer83N0F3x4ZoRVELGtj
         uU/9Y1qpy/o90BvH2jTUErt9e9gxbcijmnUVDWgTF8K+HS9kMXTWZGvDd80YCkOa0iy+
         JdWdWk+7omJSPL7tDOTzA9Kg0oLoWNOXRxcT+LcYN1UVd650PmnNhcTIVzrKcrshz93f
         PLHt/VzE3lrFLCX0Gts78xrUBuQEGA16tRdrN28PbRLo6jk40Y88My3rv5dURD6EluxJ
         Egb1Sajt5Hx6gI3+IAFzteIfdSdkGUgtBUm8fSC4h3Z2fYPYOhx3xhByyK8DZE5NY9MA
         wbPA==
X-Gm-Message-State: AOAM533CTaHkNiEkux4L3+UfZdto4Wrt/SdhrS7w/v0TOvfFZu4hEXeK
        KpAEsSyShp2NSGjyxlnSXQyCow==
X-Google-Smtp-Source: ABdhPJwSJ6e7eTajMS2md54UO0lsDwOYUQ2Wg18Zcepb73KrSNE4nS5gGdFMuTtDAyZyVly72QbU8g==
X-Received: by 2002:a63:234c:: with SMTP id u12mr297045pgm.149.1604026716504;
        Thu, 29 Oct 2020 19:58:36 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id b1sm4172462pft.127.2020.10.29.19.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 10/21] perf arm_spe: Fixup top byte for data virtual address
Date:   Fri, 30 Oct 2020 10:57:13 +0800
Message-Id: <20201030025724.19157-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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

