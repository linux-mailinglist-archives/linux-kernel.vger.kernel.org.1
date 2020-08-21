Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8724CED8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHUHSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgHUHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F7C061349
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p20so1032770wrf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7w3jE69M/e5e/80kesqbMY/Z/0HVdXG9NSX8Y6W1xc4=;
        b=YiZI5pLzZI5/jEU6hI6Ahuit8iLuJTNlIDoDhTz8w4icHiZokTBWxZL7BEBOFGYKfp
         DLyl9+y7diiZvjqBr4YmFUF5HtM9OSjokpbiJR3YQujobmuOHkPx+ZCYFj4almTunJus
         PwNzus7n2mgOozuanDA8NATcuOMlRF7JmLOjvh6W6bdtLLWxs+M7DIuUiySGZTtjHa5X
         6gLPcXs7q7hdMPybJrZcRllyPM46IM7wC+wH/cmmQvfuyCj/iHohO/IheQ868oJfkcpL
         gSsEsTEsx0ilnQiPgEenoM8aFBGOPzo6bg4Rys2QspkpWTjKcjNR3XQnPEWPV4ac7A+l
         QmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7w3jE69M/e5e/80kesqbMY/Z/0HVdXG9NSX8Y6W1xc4=;
        b=E71QpYjktVcGPEorFYZ3TD1MlfXDl87AaW/wJIX6MA/HNLrVdOT39p2w4vMOWdBvUF
         aOlyPqr72j5xt9FMz3f2rvrmj/IFKe4/6wXZFlBFKds2aZsx6mTAWkmBgvdscDb9ZgVQ
         ZLQxHhOS17ExQpBIIEdg4LlpFNrr/wlVrJOioIYQmyjonjyD53Y7PuzFSxkFa+t6+MvY
         zIccq6h4Z7YXBxFn/fsj3UvbAOV6lmp7ZgarNYz88L5C4k9k/AGsrPIIoqKEWT7LjZzT
         PDtoWp//e/6tMJOx+wICgJfYzCpUlPqlWflytVB4Y71Rau9OfUNVMp28QGzyxFkJFTP0
         Q3CA==
X-Gm-Message-State: AOAM533kIY9VzSBn1stEs+96k6t64HzYb3ZZTs+cC7RdKWSbwixZ7clz
        LlEDM4sav8NmAQnKBlLlK+MyQg==
X-Google-Smtp-Source: ABdhPJxUSUDPq3M8uao0qRBxZAxzyyVIFHGzofqo5byjgpz1iO0yVuhN9yWqk9RI93Dz3W0ALi5HZA==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr1417390wrg.102.1597994240654;
        Fri, 21 Aug 2020 00:17:20 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 26/32] wireless: ath: wil6210: interrupt: Demote comment header which is clearly not kernel-doc
Date:   Fri, 21 Aug 2020 08:16:38 +0100
Message-Id: <20200821071644.109970-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/interrupt.c:652: warning: Function parameter or member 'irq' not described in 'wil6210_thread_irq'
 drivers/net/wireless/ath/wil6210/interrupt.c:652: warning: Function parameter or member 'cookie' not described in 'wil6210_thread_irq'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index b1480b41cd3a0..f685bb62fbe7a 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -645,7 +645,7 @@ static irqreturn_t wil6210_irq_misc_thread(int irq, void *cookie)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * thread IRQ handler
  */
 static irqreturn_t wil6210_thread_irq(int irq, void *cookie)
-- 
2.25.1

