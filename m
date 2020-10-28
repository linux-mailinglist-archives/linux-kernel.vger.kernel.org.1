Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE129D658
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgJ1WOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbgJ1WOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B335C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:14:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so594184pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s43f85+WbHjGIt0fEgoku0r8l29LSpKBU8YM5eW/h3c=;
        b=aXL55zqiNE0mMnQt+yR2/P2FG1Gg0c33k6O5L/MPe6rK/dYDoSPeB9CRfPYVPtocEP
         Ir7yE9gozl5H6q2FsBs6TPu1gIcXByKSIAIo46fcK8rNUnfrAgYKkP7BevUqZaAbFueR
         j/YGSZq99VWicSeBrDovoycoDIOngbnqGBXrBA/8FQaIBu6rdrc7WtsC+OyYwcMS6tBi
         Zug3bRiTpPCj8nXR9QaaWMBtCStvwIR2xLI7cGqrL8aAMqOHDXs88KAImgD9N3+Gx04A
         4hFwv/Nu3gqQFZ48nPZHGqkyYsDI4NWTQR9R6R7FkC2gLUBR1QQ0vkjlWWd1YF+h++Gd
         tNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s43f85+WbHjGIt0fEgoku0r8l29LSpKBU8YM5eW/h3c=;
        b=CTU5KCEP/2sc0qpPW9sw61aqFAs0Bo6ybgilaednPy/GiSL4dw00i7A6jwNvd6gXwW
         XHwJwtnzfR1fHShC1OeydaJ3ecTUTd8xbirZpWOV4o/84jBWrnhwacAzd0jM/Cn0z8UC
         KURnyPIAkOu0jZUUfihqm+XXQYzSJZsnDIieADyKh/v169obT4pBq1ncQoIpsfpKrK/z
         iK6u6dxM0msDQLnrlokx8o/gjIQkhRYpBvQiQVkpyDgQdu8dccWXBdskfT3DWqSZ2TPl
         8TaDOHJqwJd7YR5VosR+HvbSchI4A9TyAP/4oy3FRI9PCVJt3Svt7vlEAJPoD5o9PZ5w
         7g1A==
X-Gm-Message-State: AOAM5325ES/2dpaDiN5FGcJ0NBPx2tBXu6omYZyeVEaiyw63iaks/dsM
        GhqQ8n+Jq/EpV/DPngu0dk3t9hIlRzOmPyJo
X-Google-Smtp-Source: ABdhPJz67PzC+3Wvsw8DNWphJhyUwxKjOFsLopMwrao+z3oypgBaWbA3EQIOQs6lqOs79QVntzAvyA==
X-Received: by 2002:a6b:3c14:: with SMTP id k20mr849364iob.12.1603914114829;
        Wed, 28 Oct 2020 12:41:54 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m66sm359828ill.69.2020.10.28.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 12:41:54 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        sujitka@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 1/5] net: ipa: assign proper packet context base
Date:   Wed, 28 Oct 2020 14:41:44 -0500
Message-Id: <20201028194148.6659-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028194148.6659-1-elder@linaro.org>
References: <20201028194148.6659-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of ipa_mem_setup() we write the local packet processing
context base register to tell it where the processing context memory
is.  But we are writing the wrong value.

The value written turns out to be the offset of the modem header
memory region (assigned earlier in the function).  Fix this bug.

Fixes: ba764c4dad7bd ("soc: qcom: ipa: clocking, interrupts, and memory")
Tested-by: Sujit Kautkar <sujitka@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 2d45c444a67fa..ecfd1f91fce3b 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -89,7 +89,7 @@ int ipa_mem_setup(struct ipa *ipa)
 	gsi_trans_commit_wait(trans);
 
 	/* Tell the hardware where the processing context area is located */
-	iowrite32(ipa->mem_offset + offset,
+	iowrite32(ipa->mem_offset + ipa->mem[IPA_MEM_MODEM_PROC_CTX].offset,
 		  ipa->reg_virt + IPA_REG_LOCAL_PKT_PROC_CNTXT_BASE_OFFSET);
 
 	return 0;
-- 
2.20.1

