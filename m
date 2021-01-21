Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED42FE960
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbhAULy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbhAULt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:49:56 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFF8C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:48:27 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e22so3368568iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6e39kAfCJQxvEQdmc/oDMA8MTPHe7FkK1dKGoyuSSk=;
        b=MjUzmMnMtHugryAIUP4qnuXUMxstLxIJX3Q+4cRAvZpPbzivp4cKamS40MFmnssASk
         X243ad1D3Mckag/zUAt/PRurHnU22NTJsGnWe/gXJ9Hc3Fzaoy7UGu/KX83gEv2GxerW
         ocmhpFeDtvN1ZGWZWYgNsGLW8+f1N7UjY+LZ8kVqVfLNQRjgvPeP6CfQea3YTQa0KueB
         BikLPLzmiIEkDg4dbXxPFFHPcAvfdTl0wnM3tr0mRpjUG5UEu+5F2gNk8vb6iCNjXkw/
         eK0XigvItjIV89cY6zUqQkROjEvkhyFbRiKtwSO7ulm/Wu0RJsbqjlJxsn6Hovd24xjq
         28kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6e39kAfCJQxvEQdmc/oDMA8MTPHe7FkK1dKGoyuSSk=;
        b=qFPJxZCzBxXzTw2kT65zOf1gHxKdWF7qljR/4gtyCn0ueP2lMeEIQbXcNfJz/F9hNl
         3ib3KpAwW2fGM/+3rXsvhYenV//G3gKG3AVH1nFyoJzYhaSWxhgYmB5APdGL6SNE0grr
         nnnYqN9L+50GuwvZmCsrx136wbDfgo13C6AeG21cdJWaWNZaITjm7qn0EvC54GUH6UGP
         CNr2JGUm2xyICoG7NyqNA2dr9hlHzQbXK6pR+5hGHZtMskCu99J4tjSrXDxvP5BnWHEd
         /n1LUF+n1Cz1+qlUCe4fM66pZ4JOOQpVrLfctVX6ZMSTk1mCsNG3NdywrvYCvwo2HE3C
         +YyQ==
X-Gm-Message-State: AOAM530JSFyYK4OFp1laOTZ417kqWISPaPZobXY9vSsza9qNxxTRF7DA
        ff9LEb1aC2eaUNox5ec92k5mAQ==
X-Google-Smtp-Source: ABdhPJxT3jUndpNJDCJ1ywEhrPp6QiS+5rqIySMgJTFbNcWlh2edYJVid7kX3PIY+Gwa1gnrLQweUw==
X-Received: by 2002:a5e:8812:: with SMTP id l18mr10088840ioj.149.1611229706989;
        Thu, 21 Jan 2021 03:48:26 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p5sm2762766ilm.80.2021.01.21.03.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 03:48:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/5] net: ipa: heed napi_complete() return value
Date:   Thu, 21 Jan 2021 05:48:18 -0600
Message-Id: <20210121114821.26495-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210121114821.26495-1-elder@linaro.org>
References: <20210121114821.26495-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pay attention to the return value of napi_complete(), completing
polling only if it returns true.

Just use napi rather than &channel->napi as the argument passed to
napi_complete().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 56a5eb61b20c4..634f514e861e7 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1555,10 +1555,8 @@ static int gsi_channel_poll(struct napi_struct *napi, int budget)
 		gsi_trans_complete(trans);
 	}
 
-	if (count < budget) {
-		napi_complete(&channel->napi);
+	if (count < budget && napi_complete(napi))
 		gsi_irq_ieob_enable(channel->gsi, channel->evt_ring_id);
-	}
 
 	return count;
 }
-- 
2.20.1

