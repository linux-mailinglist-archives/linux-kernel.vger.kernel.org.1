Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79AD303E30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392654AbhAZNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403947AbhAZMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C083C03542D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 7so16318294wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=995rP6SFts07/SvvHeFqqlY/SqCHBsfm6ya+Esw8I8M=;
        b=N2pTVZZmJN4uinBZl9xENNGOHve5i9eUD8+RnxP3LdL9D6vMmow8TXoYXxwhlIWJyt
         p08XZLz9O3Jypul8pU3IKA7eyIxCqy0VB0VVsZuL21XZVihIURjKjqcWOA3AOvYjk128
         YH45w98UvW2RPMed6OxTVkd+t+HaL6MaZrsgEijZxAsjg6LJFq/fBzjxeXAjKSGjeeZC
         wzDLJUS952ZBrdn6+Q6Nn2xSJnOocJFwka8GbO4cbM0vd8y9O36aLHN8fcRB2KGOe7TQ
         OvyYDPqO7SWz7wVBSu8BCQ/BCHHOTkKnopWdXGbIlRQuSOoS2FW5h9ME/A9YVn8ZvwDP
         P5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=995rP6SFts07/SvvHeFqqlY/SqCHBsfm6ya+Esw8I8M=;
        b=MqbBy0OfHl2TYtY+fhUdGlubezW4XV8k73wo4PmVQyGnw/FmAB48m3gBRmOL27N1Wb
         ZNvQqHZ3iUFoLkLZAqIqSZ2i1GfrFwxq5tKGYPDs8fXJ3kwXJaJswb6SxcKV+fAm807f
         wTDC3NpyFnU8kz4io44YluI76YJxf2VPAKiTHLNdOpiZ/Yk1UAuExtNo3qUDbUK36EjO
         JKdy535aLHeYle8qNbYpIVkB0izFm76BiNZy7fjJVJPcN8hX11AvknmAWmBzpFaeTqxS
         KW7K1B0sWNfiomQOP5YbEtXubMhy2qs2CMgc8UYmfCDia6N2q7Sxmrk9Mbu8ewhqfO0E
         lmmQ==
X-Gm-Message-State: AOAM531dvoTy+2BZ8CAh/I3q9plLZejWPMF2vUAM3AgrPEFDJm9t3CSJ
        pm49+04/oAoP0wCTCHqNOBQSIa6Spd2++ekN
X-Google-Smtp-Source: ABdhPJxFlwssEpZKCZXVFe6JJUQNnpJ5ZXpj8QSRW0OaQrtBZE2bkPYh1gT/A5Bto1xapUFtcl9w7g==
X-Received: by 2002:a5d:434d:: with SMTP id u13mr5975442wrr.6.1611665164897;
        Tue, 26 Jan 2021 04:46:04 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Loc Ho <lho@apm.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 17/21] clk: clk-xgene: Add description for 'mask' and fix formatting for 'flags'
Date:   Tue, 26 Jan 2021 12:45:36 +0000
Message-Id: <20210126124540.3320214-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/clk-xgene.c:229: warning: Function parameter or member 'mask' not described in 'xgene_clk_pmd'
 drivers/clk/clk-xgene.c:229: warning: Function parameter or member 'flags' not described in 'xgene_clk_pmd'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Loc Ho <lho@apm.com>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk-xgene.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 3fd53057c01fe..857217cbcef87 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -206,17 +206,16 @@ static void xgene_pcppllclk_init(struct device_node *np)
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register containing the fractional scale multiplier (scaler)
  * @shift:	shift to the unit bit field
+ * @mask:	mask to the unit bit field
  * @denom:	1/denominator unit
  * @lock:	register lock
- * Flags:
- * XGENE_CLK_PMD_SCALE_INVERTED - By default the scaler is the value read
+ * @flags: XGENE_CLK_PMD_SCALE_INVERTED - By default the scaler is the value read
  *	from the register plus one. For example,
  *		0 for (0 + 1) / denom,
  *		1 for (1 + 1) / denom and etc.
  *	If this flag is set, it is
  *		0 for (denom - 0) / denom,
  *		1 for (denom - 1) / denom and etc.
- *
  */
 struct xgene_clk_pmd {
 	struct clk_hw	hw;
-- 
2.25.1

