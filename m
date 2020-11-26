Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD93B2C55F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbgKZNjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390460AbgKZNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:39:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F061C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:39:04 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so2201130wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asMRiFXnX8bIejsGLdsKd//d7tf76QwNOuS+l2qSTCE=;
        b=zW7MMznPCETTHz4zROspqv2du3yYqsKX1Nfw0azktaP1HEVWUt3rMdVPlaq6yXMbas
         3yhr+cEAE3vWmkLa004JLlNztUcdiKLbHZX/WXD8OecqJaKU6rRdTr6KDwoTkxL3CNVO
         Hooa3JFwUyXKWcKVkVSPkM/see7T/+iT4C7uYPUhc1sKNCz8imewjTl8rkB6saX5y1DG
         xng30XCWW/ZPK5fflNXYYEHQxD8AmjRPSeOnBXjtkN6b0bd3oAHshuPsqWmy2fY+rpli
         lvsH3xtIxn2vT0ihIIc5DmsRf+yHHQeNPDHo2BOF78pRHtZqFTwoKteElv+IdzaQeBoW
         CHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asMRiFXnX8bIejsGLdsKd//d7tf76QwNOuS+l2qSTCE=;
        b=K+ErW2RB6t56NX7Vsd1gkCA7Jx0KJzTIW4BRv2oXuHMwpOdHmdnDEulaCBGWP4aore
         8oGOmY9tBOtmjIvX7bcCQmxqXrguIH3/1RmlKZgu8f6rlRt7boOwPC2qvAbsUT6PQ1/b
         vW7nRcJI1/dlZIClKEzUwYcslH9vil1OFgxPWn4jXmMtsa3tkP5r6G9X7ogfwmm14WIk
         cXC099UCTHK/mdk/frEwhoVxpSejBx5+fLgaRW8rILpukZiQ99jvX7M4tM7ewR2NL8CZ
         JIV/6Zal8zG6LO/110hOmm7IdDqj1NqbTSWFkH2CmfKB45LLvahg6toBjJgm8IYz9V0L
         M7vw==
X-Gm-Message-State: AOAM531GLU/yIu5/6UXF7U0O9ruepaNh3OBikAcSZsuHUJiBsS1LkvNI
        SEE5Ahs1A92gF+ADKjYlkRljaw==
X-Google-Smtp-Source: ABdhPJzl4D8fEEpQ2tRn+/Qdw0W+XFDT2YGhmLvOlXBtJXOVwoqzejps9snDILVpDq6S1uQGjbdsEA==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr3778199wrp.27.1606397943010;
        Thu, 26 Nov 2020 05:39:03 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id s133sm7035825wmf.38.2020.11.26.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:39:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org
Subject: [PATCH 4/8] net: ethernet: ti: am65-cpts: Document am65_cpts_rx_enable()'s 'en' parameter
Date:   Thu, 26 Nov 2020 13:38:49 +0000
Message-Id: <20201126133853.3213268-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133853.3213268-1-lee.jones@linaro.org>
References: <20201126133853.3213268-1-lee.jones@linaro.org>
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

