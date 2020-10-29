Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286F729E3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgJ2HUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJ2HUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F1C08EAE0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so868669pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xDcEeC/ZrSKsrWAxe8khkwRlXrkML+LSLQS8WxMvAYI=;
        b=nTBJefzB/14Egff8dWNBCzPRjZDcTzCfp+n0j6irhWv63lRTS+PbTNbyM+cnCrdk11
         xxORdpK0mqQY4sXILXuwiLiVyb6micXDDQJPjrTGp2K5mOYKeckstuoVtBMHJh5/Ck+o
         SIsVpjCdRzirB/Fau5Ik97ObTc5zz7Y3fUQ6T57RekC3brgELoAuWjE3RbPRTHy9XIfo
         GoyvMvW6Pb1nOJj+dl0wdVQGAa8TxBZDr5mDvIBZWwLdTA3tcUb+tHl2CI1SeiZRhkMK
         UwgkCNs2Lt70Suwf3q2HfF6+3LAL0NRyUZBlzDmfRGrEhIykv5TOrhLVzfG9a+DUa7K5
         PpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xDcEeC/ZrSKsrWAxe8khkwRlXrkML+LSLQS8WxMvAYI=;
        b=aWua5QcMsz1ZJj7r2rPGFbMwzjDQnDhw9/zpLYh1JZeuAB/NhDHqcHUYO8XZSSldJ1
         eCnJmsxdnHdYGd0v41mDyWXmJdmw1FMjbSkJNqt4aok1TzAv1IpPCyqezQiqSQB47+zL
         KqD6VeeY+09l1Yh0rWpusoST9VeRUJDcvygQBRjHOSZVf1RhSyLfbyKXrSWlPkrqgFAj
         sQJkhiWn91+086GbU2+iKduby9qH+dgNfieqf3JrfZlXv0b3j/zk9c6ubtGeIgObufoB
         J3BlFfDTGAJMaSamK4f4B/VdyR4a9GvlL50Xa+hAwVh/O55JuZWIBSDQiLE68gj/8sOc
         nt1g==
X-Gm-Message-State: AOAM530/MA4Hmtz/FFDy7kkGdaJoRdqWfng8/crmQEpR5b2YgSjh5zS0
        j9NpJnPJ+aqawaANO8O7VYMBtg==
X-Google-Smtp-Source: ABdhPJwCHRlBuKEvgOfZfjIVXstsNph7DjC6uCbIvpjZPowGFUBCelpuV48MtCbkWS8UstUjzu3ZxA==
X-Received: by 2002:a17:902:bd43:b029:d6:820d:cb85 with SMTP id b3-20020a170902bd43b02900d6820dcb85mr2579569plx.37.1603956029701;
        Thu, 29 Oct 2020 00:20:29 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id j24sm1792994pjn.9.2020.10.29.00.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:29 -0700 (PDT)
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
Subject: [PATCH v5 10/21] perf arm_spe: Fixup top byte for data virtual address
Date:   Thu, 29 Oct 2020 15:19:16 +0800
Message-Id: <20201029071927.9308-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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

