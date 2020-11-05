Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7A2A7D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgKELok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgKELoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:44:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76589C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:44:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so1396206wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQI+xeoeMjnqFAD8EMXTyLrlsY/8A0KdRklJEpXUEeA=;
        b=Vy1NOyfwf55IVp/CkDPtAtkZi1Nvuaf75YpQTY1on9PWT/7ZFz2G1BPRwWzGKZJw1F
         /3PXxgHk8MR5K2JMJ1+UbuL2uD174grE992YBSjIjEqyZLrWarMiX098HEySoalGfM0Q
         L9UggjR1i5ETMfYNjXuOpBuzTwkRxUG5WPXASr5ZVViQk3WDJVy2DvDA/TFrOV3zcOuq
         LGlDZ1lDeTD0+27HE3T5IGCLK1JHEUuZmtm0u9PBP3cpAA3rFOVO3/uzaD4uAo0YFfxH
         9cdAcHhiKardjxcTLOkAyzvGjSTNYi7C0yX5BUivRlSfgvOU3FkkWN4p9uy7YDPvEE6T
         aIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQI+xeoeMjnqFAD8EMXTyLrlsY/8A0KdRklJEpXUEeA=;
        b=RHjfVOH5IoIL9IlKOxxu+noRR6+hgYmJucx8rR9Uubr9+ZtprfPoN/iLgqYwDuXCEr
         rs2aZRhqNzPcnb6Mj7xKYTmhn2dvJOaxF1oNEUe4iW0ib2NtLtbuABq+qy5+mrMuMr6S
         gQpBMODAUPSnEDFyE+2leRKvEhJ0NdYAHSE9QFPoR1CuqEamMCnK9Vje70Yox2w7jO3E
         BvnU+DWxGgzSQP/QmZaqMPt0i94Z2r29evlrtXWiDNygCK+t4hFF5+7Anop1rIWpk2e2
         flUeitx3JMjqp0RbX6rPTeBh5jYalIqnGH2HNGwLAFNze4aR0wEKMBHnMTXOoHavWCLk
         Oibg==
X-Gm-Message-State: AOAM5329acdO07QfDmelDNUXu3w9z5Y2T1lXJOtppYLRoa3hdNY7rbQW
        P5GWPv3yUK6nekh3ZTqrpEssKQ==
X-Google-Smtp-Source: ABdhPJxs8JnizH47p+OY/DC8h4ITaUWYYNCnLNzcg81MnA9t4I+UOt53fcynmrE6Ua6x328YXdeZVg==
X-Received: by 2002:a05:6000:1084:: with SMTP id y4mr2297571wrw.138.1604576678220;
        Thu, 05 Nov 2020 03:44:38 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n17sm1944845wrw.69.2020.11.05.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:44:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: q6afe-clocks: fix warning on symbol scope
Date:   Thu,  5 Nov 2020 11:44:35 +0000
Message-Id: <20201105114435.22860-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning when module is compiled with W=1 C=1

sound/soc/qcom/qdsp6/q6afe-clocks.c:122:18: warning: symbol 'q6afe_clks'
was not declared. Should it be static?

Fixes: 520a1c396d196 ("ASoC: q6afe-clocks: add q6afe clock controller")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 2efc2eaa0424..87e4633afe2c 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -119,7 +119,7 @@ static const struct clk_ops clk_vote_q6afe_ops = {
 	.unprepare	= clk_unvote_q6afe_block,
 };
 
-struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
+static struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
 	[LPASS_CLK_ID_PRI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
 	[LPASS_CLK_ID_PRI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
 	[LPASS_CLK_ID_SEC_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
-- 
2.21.0

