Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7B2F865E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbhAOULO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbhAOUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:10:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA61C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so5258833wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1CB49mzZZUw/61JRz0eEUr9QqVKx7SA3GZtjiem/4A=;
        b=XZVdyPclrbT2uhxikgAxnyIS/ZX1qGmCB8LbBl3vmin7FjsAsxRottUyPI83R0g3lU
         +4Q7EX9573V1O6kGhPJdJJKT6hRRq96wUP4l95wA8rl3xpo90ptufBd2CZWkbmugECIw
         bfjO1EOjYV6zg0/S5sBgJjUeFp9vLqAB8vc7Oy2Y6M8wZBTfGqdfw4VI/6NIO5I0y/c0
         INaxZ8czTplEQT+SU1KBPk5SbbbO3giYgFjXLHrXLtukvEywqvOsUCxmO1tHSjKSLQj8
         0uoJ8Pj7N0SlrVletx9yTWLzIHNMPfbq/KjdpRTwEySsiVz6JzCVlrVrflyFcM2Tp2In
         E6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1CB49mzZZUw/61JRz0eEUr9QqVKx7SA3GZtjiem/4A=;
        b=B85P+OGKyrbE4IiUTFzx9Jom2OszccoraQcy+QEA2FpmuGc41XpInfK8OpWLTCkGjY
         uYMlGW+mbekxUskBSy9/2zWbbcafwB+m2KY8IBZTykcD6pwKJu7xKT5gdO9A+y/pYmPI
         12GwSXiThZr9nx4Jxa0by7yXgdbgv7WSbhYQn3erjv+X8xLSv7XPZ28kut9fLeLt8cAl
         cIMnz8IojwsqK7HMZ5pR5DFNsjFPvXEow8uCDY7WmyQif9qh15Be0f2YOzuA+7QkLoKX
         gIv5nsgTy4zMOU7Swd6SHsGkAKkI8e1aMXCei4NSahx4ehd07nBVEEYTtfRB1VyIrNXS
         iGaQ==
X-Gm-Message-State: AOAM533A//Sk5okfRIeL/4bZqruhmwToJ7Jm6M01gnxy2vPoDUJvpIFW
        WrVnZx2HuZ7WE2umtxQysVIv7nLWU2nDw6mM
X-Google-Smtp-Source: ABdhPJzPRnnSXQx1D6qljyZv+mLSE16/5yzn1TrX3tu+KrVYQEGeVQXzTU1sS031YhYKSUQ+M6B2hg==
X-Received: by 2002:adf:c64f:: with SMTP id u15mr14322350wrg.270.1610741360557;
        Fri, 15 Jan 2021 12:09:20 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id d85sm9187863wmd.2.2021.01.15.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:09:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 4/7] net: ethernet: ti: am65-cpts: Document am65_cpts_rx_enable()'s 'en' parameter
Date:   Fri, 15 Jan 2021 20:09:02 +0000
Message-Id: <20210115200905.3470941-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115200905.3470941-1-lee.jones@linaro.org>
References: <20210115200905.3470941-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ethernet/ti/am65-cpts.c:736: warning: Function parameter or member 'en' not described in 'am65_cpts_rx_enable'
 drivers/net/ethernet/ti/am65-cpts.c:736: warning: Excess function parameter 'skb' description in 'am65_cpts_rx_enable'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/ti/am65-cpts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 5dc60ecabe561..9caaae79fc957 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -727,7 +727,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
 /**
  * am65_cpts_rx_enable - enable rx timestamping
  * @cpts: cpts handle
- * @skb: packet
+ * @en: enable
  *
  * This functions enables rx packets timestamping. The CPTS can timestamp all
  * rx packets.
-- 
2.25.1

