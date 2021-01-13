Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7F2F503B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhAMQmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbhAMQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:42:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8493C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:41:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c124so2169334wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1CB49mzZZUw/61JRz0eEUr9QqVKx7SA3GZtjiem/4A=;
        b=nsTL5Y+oaK1QH7nxgpklm0OSpU6gbsvQj/NJeARHrT0Yr7gMgwtpKOO5KN0eg52RSo
         WhXHXUwoDssQdiMnyDK662RZt0upBfAn5BFnVriHbCZxIO9RycB1mfXzwFYCHNodgTfw
         Dx7JH2ZWUIfz7SyWa97EEUCtWBz3JbZenS1TElJkfHpDUlhxoJtpYx9+YOauwogNVRxC
         iTndn1zdVcdLYh4CTJRiJwCoxukKpSj3okUEVrsQ2ds2J68jKmajkh3HXHv+Zj8KIISR
         JxrOuQhIEzmcDMOOuy7BhoqrcNEu/6Y8BsSugbGEdWHbsqMkKDd6Xtr76GGikS/Rqz4Q
         1dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1CB49mzZZUw/61JRz0eEUr9QqVKx7SA3GZtjiem/4A=;
        b=fQCjRXziXMMfnmeXdkI94oqhEJ73P2Ga2aqjRZ9t0/H6oiAAw4Hx51APFS866FsjAk
         hjHJ+yzW4KycP6tyh3entBDWiuSFtgMYpBOn7YyzRkjwr9vNsO+WJ29QvX044HYVvPuf
         diclxKzOCyeh2UlKZ4lmvH9Is8AIWHX45QgnMHIxbfWtQE8n2cEOewCFNNQ8FpV1zKgK
         H+ZCwduSuoBfcFdJ6g+2T4F6LrvxWK9vz+AM5ifLQ/+/gOYiKPYT7/RTRcigdQI8dDOn
         SWq24EH5GO0MEeeVCc54bPWXcVbHO47fd8t/TGrDkGBfnK3+sA3+yH+1KAr3YEoyUPkE
         9Kpg==
X-Gm-Message-State: AOAM532eZ2pMqgX7uf9yV07k0vw0J4z+skqyqhsKzuNZ9o7CBpYyH/ZI
        +wesypYm2bVtnYJqDRq/36Mtrw==
X-Google-Smtp-Source: ABdhPJz2MUloXEMC43jmGpRoJ64ZYD0scfXUmF+qO7P8ql4tAU9MjvcfRcf4GDb4mB0NQEK3/5MqMg==
X-Received: by 2002:a1c:7c03:: with SMTP id x3mr108276wmc.17.1610556093439;
        Wed, 13 Jan 2021 08:41:33 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t16sm3836510wmi.3.2021.01.13.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:41:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 4/7] net: ethernet: ti: am65-cpts: Document am65_cpts_rx_enable()'s 'en' parameter
Date:   Wed, 13 Jan 2021 16:41:20 +0000
Message-Id: <20210113164123.1334116-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113164123.1334116-1-lee.jones@linaro.org>
References: <20210113164123.1334116-1-lee.jones@linaro.org>
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

