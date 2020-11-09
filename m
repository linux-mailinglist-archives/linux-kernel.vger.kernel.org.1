Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC472AC180
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbgKIQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgKIQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:56:42 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:56:42 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id g7so8903732ilr.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08abeJNv4qBy1pxGXBXjopswc7xkT9rkpPsBR41Sgkw=;
        b=KL/auJzZZwrzzz6b44y5xBOCRS7ddo7BcGzGvZoWBcYBjI0XKteyMvgudYWwFSRUUC
         oMRcZNeftE3rvnBFKQzreOTI6w78f/rpgka+cSUlJQqwsXYa3PYbFS+dTIRnCE2yaJUQ
         jHnxcoPSC90eDU8kj+QqYrwTjDD8pF+9ZVrtnNQRpxxWFX5GTJ1WM+f4QpGrnb9ouyuT
         RH8lEupKZpIncv80GVNnTUvx9b0foUYKdxH+J/k5X0Gjbkxzv04TKtfUAkR7mNJ+LSeg
         2nPnbNcc/C6KZDnsjAkGSCmKVQMmbgal3Bx6m7YQ7OLRuswEgC8r9/1QnlEJwFxXQiJ0
         UmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08abeJNv4qBy1pxGXBXjopswc7xkT9rkpPsBR41Sgkw=;
        b=KYeEf9G1qfobRfJrCZQAoj77RX+gZI8sTAsCvXyKWwCltjoK50jUI1tvNL4WUxrc4W
         cKjdJUcEyf5Kuof1I8doWxztusMvhTTghq9dFQrdutpFjB6KY90OlEpmiAr4ckWAIxlh
         lTitqJ7kbjvcjJEVu+ztaG3FADTcPRqAx98J034uz6tOompdiI5qxmIhHjC3JIzczfoE
         oD7Bs0gFaXqk23MNPGw48WBbk7k1SBXAsfiOX1XHHSafH+3S8briQx2+uC6HFMtP39sK
         LYHfr/ooTl1C0xGus477BY6x7VddrOLCQZ7XyQdgzvoy2JRPvOddkm1HfhQzrz/H5TmN
         IEGg==
X-Gm-Message-State: AOAM531DNWxXZV4ELVLPlTtxyEg79meAYJB6lyMMpxOJaSRK9rBLFoQp
        mFq0GTozPEEfEMlnf1owRoDGr1OLm3KguiN4
X-Google-Smtp-Source: ABdhPJyCbMQfcBEEJALAiGHIGlgTEHuPE3Oxu7sZGivhmdKQAZeCjpJXn/RfFguxPoD9K7s3BKZ41g==
X-Received: by 2002:a92:1548:: with SMTP id v69mr9529474ilk.68.1604941001239;
        Mon, 09 Nov 2020 08:56:41 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j85sm7576556ilg.82.2020.11.09.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:56:40 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: ipa: get rid of a useless line of code
Date:   Mon,  9 Nov 2020 10:56:33 -0600
Message-Id: <20201109165635.5449-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109165635.5449-1-elder@linaro.org>
References: <20201109165635.5449-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete a spurious line of code in ipa_hardware_config().  It reads a
register value then ignores the value, so is completely unnecessary.

Add a missing word in a comment.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index d1e582707800a..bfe95a46acaf1 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -335,7 +335,6 @@ static void ipa_hardware_config(struct ipa *ipa)
 	ipa_hardware_config_qsb(ipa);
 
 	/* Configure aggregation granularity */
-	val = ioread32(ipa->reg_virt + IPA_REG_COUNTER_CFG_OFFSET);
 	granularity = ipa_aggr_granularity_val(IPA_AGGR_GRANULARITY);
 	val = u32_encode_bits(granularity, AGGR_GRANULARITY);
 	iowrite32(val, ipa->reg_virt + IPA_REG_COUNTER_CFG_OFFSET);
@@ -787,7 +786,7 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_mem_exit;
 
-	/* Result is a non-zero mask endpoints that support filtering */
+	/* Result is a non-zero mask of endpoints that support filtering */
 	ipa->filter_map = ipa_endpoint_init(ipa, data->endpoint_count,
 					    data->endpoint_data);
 	if (!ipa->filter_map) {
-- 
2.20.1

