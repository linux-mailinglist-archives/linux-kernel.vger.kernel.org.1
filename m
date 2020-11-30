Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE82C92D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbgK3Xii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388923AbgK3Xih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:38:37 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E9C061A04
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:37:20 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o8so13727270ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsjXW+SLSKSrfHn1CqagqnbZw4XU3N/TAztNinypVjg=;
        b=hYy+DZEJyJzOHZoxoK+DNUyda5xJ2kazBTI9CY1dIXh22kg/6PL+5p6rgvtLDQ9MsL
         Gz8IvMelRpuZ1SLEAnDKNo9Qc/OLcI4xJXwM87F32ab6dZBM+nzUKa2TXAvvn+Aj2eBi
         US0xYm+99L2LlrZ8MSgsm28ryb9iD2p5tVz9JodIcXYWP2ZdnUOg1NOh5oGrgtqt+jKs
         2IeUmR/F1tt+sby5YfTj8wLF2J3g5uvsP8WV3uPRnn8nlXI4q4dv+i3t6dB2A1DCbm8q
         pCV9dJfrnLZXB4Pw97Irq1EKCuKwy2NqFSXL0Z4N4Iwkf67hHrikOyapKPaV2lux/o02
         bqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsjXW+SLSKSrfHn1CqagqnbZw4XU3N/TAztNinypVjg=;
        b=Hi+tQ5XZKBi3Tr6bC8u8UynT90mSXW1FaziyhRkYwWjDGs0/OutAY39WI9UocsjGvQ
         v0KdFsoW5OYBsc7duJ2vUwwUz45JrIQvXTvG/OLJw2h0THpsA7TR1b0622pvzBKQSd6S
         H8bMmZ0sW5ZFZkvb+k+oggxOzJw6ICnUaU+0twQtoEE9cueFktiA2LJ/UpZY4ydn3NYu
         uq3Nj5VuXfsIROsw41rn9Ls68w+BTZw/VuGZWB6eaGujsfhJWHZ+EWCtXADQ8X8gfolH
         +sObojBec67aZbjBIi3jgnieesMaGcecBsyiVQLX8flxBlrTYal4bbzA2b73wDaiqD0H
         +ezQ==
X-Gm-Message-State: AOAM532Xh420HjKJor8jQx1Q+LcsQCM+Yoe1xxcw8fEkCcATlpozjNkZ
        AV9WGY5+xbcgZ1PKQgKiFWnWwGCf9WErDg==
X-Google-Smtp-Source: ABdhPJwfbclSsXZOqnaN2E+ROCvh/w4iRGVrOEOb7mO2y1iDTAslrvTlUKQQ7vWtvpMTQ2Dx/y6YiQ==
X-Received: by 2002:a05:6602:2ac4:: with SMTP id m4mr156903iov.97.1606779439805;
        Mon, 30 Nov 2020 15:37:19 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o195sm62574ila.38.2020.11.30.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:37:19 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: ipa: use Qtime for IPA v4.5 aggregation time limit
Date:   Mon, 30 Nov 2020 17:37:11 -0600
Message-Id: <20201130233712.29113-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201130233712.29113-1-elder@linaro.org>
References: <20201130233712.29113-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change aggr_time_limit_encoded() to properly calculate the
aggregation time limit to use for IPA v4.5.

Older IPA versions program the AGGR_GRANULARITY field of the
of the COUNTER_CFG register to set the granularity of the
aggregation timer, which we configure to be 500 microseconds.

Instead, IPA v4.5 selects between two possible granularity values
derived from the 19.2 MHz Qtime clock.  These granularities are
100 microseconds or 1 millisecond per tick.  We use the smaller
granularity if possible, unless the desired period is too large
to be specified that way.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index f260c80f50649..b4c884ccb77d2 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -638,14 +638,38 @@ static u32 aggr_byte_limit_encoded(enum ipa_version version, u32 limit)
 	return u32_encode_bits(limit, aggr_byte_limit_fmask(false));
 }
 
+/* Encode the aggregation timer limit (microseconds) based on IPA version */
 static u32 aggr_time_limit_encoded(enum ipa_version version, u32 limit)
 {
-	/* Convert limit (microseconds) to aggregation timer ticks */
-	limit = DIV_ROUND_CLOSEST(limit, IPA_AGGR_GRANULARITY);
-	if (version < IPA_VERSION_4_5)
+	u32 gran_sel;
+	u32 fmask;
+	u32 val;
+
+	if (version < IPA_VERSION_4_5) {
+		/* We set aggregation granularity in ipa_hardware_config() */
+		limit = DIV_ROUND_CLOSEST(limit, IPA_AGGR_GRANULARITY);
+
 		return u32_encode_bits(limit, aggr_time_limit_fmask(true));
+	}
 
-	return u32_encode_bits(limit, aggr_time_limit_fmask(false));
+	/* IPA v4.5 expresses the time limit using Qtime.  The AP has
+	 * pulse generators 0 and 1 available, which were configured
+	 * in ipa_qtime_config() to have granularity 100 usec and
+	 * 1 msec, respectively.  Use pulse generator 0 if possible,
+	 * otherwise fall back to pulse generator 1.
+	 */
+	fmask = aggr_time_limit_fmask(false);
+	val = DIV_ROUND_CLOSEST(limit, 100);
+	if (val > field_max(fmask)) {
+		/* Have to use pulse generator 1 (millisecond granularity) */
+		gran_sel = AGGR_GRAN_SEL_FMASK;
+		val = DIV_ROUND_CLOSEST(limit, 1000);
+	} else {
+		/* We can use pulse generator 0 (100 usec granularity) */
+		gran_sel = 0;
+	}
+
+	return gran_sel | u32_encode_bits(val, fmask);
 }
 
 static u32 aggr_sw_eof_active_encoded(enum ipa_version version, bool enabled)
-- 
2.20.1

