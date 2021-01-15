Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B762F8656
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbhAOUKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbhAOUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:10:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5AEC06179A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so7030010wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G08JJuzSVjauD2w7RKeXQ1nSbD1Rkjm71UkTsB/zD7Y=;
        b=D2amWQb9S98u/P5DUNkplruHJE6hVhzLyueXRjLidi8RMYlvYJAhCpbqxHg8k2MQjo
         1S5+7meCyWYbaXQZbhA1FJq7SfDR4nLyt3j+Jt6tJEev8HvJlVpqybhK+MTf4jK6+e2h
         HS9/myq1P0yBGJaqe2Pdye8TlfM5DlRC8+TwEZ7Z/eiUi1viUgUJV0tIxTxisRLNHbl8
         mizOpFQFPPkvu5KawxfqOWdEdA8g3UnjMV4D+VIDsTy6ig7B1lsk04d/E48bCNSbazJh
         Jhh4KjgIY+FL2YJRew11Mc6SL7julFqzizygkgUi6ACy04C3SN41sqQ8XmA7gQqzqJ0g
         uRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G08JJuzSVjauD2w7RKeXQ1nSbD1Rkjm71UkTsB/zD7Y=;
        b=nAW8P7t1QX0q6RpfTiGSmy9s0s0Qisxd9B7B+VuZr/Uiso774eNme+ulmrgf+OHZkQ
         gFkWBNbPMQvGNvEI3BILPUMoUYX7OALRenTQ9vsjNXUYkK9Of971BTisbgabGl9YyebQ
         Z3MeJ8J6VhyhQ0C42hUBPord3GqcH4TosdrEGOJE52f//Ouc59qFOdTGVbX/u2vA56Yh
         pn+GwzZHwQ2exw+YEWsLTJSlbq4GzMt5ourGjsoYkEBnrDe3zhN1f6V0p1D71quXYFNv
         IPWIAgkJTdiaHw4Fj7bb3+bTFZS5aKN4WIArNW/bcJK5ZQrMl6BNdTJC/b7UaocF7+QU
         4Dtg==
X-Gm-Message-State: AOAM530uQcX2O0jMSAYsXPidbQV+/g8fUkLKlsnnpxPLzwqSpDZoZ7J6
        3pOXvSVqsUdpnr0Pj3vQqVrxtg==
X-Google-Smtp-Source: ABdhPJxfwfguWvKcJ2QuCcwdTin9mx4tSWoLnGUHJZrmHg1o0XwnvHiDMbU3NCBvaVyzrd7wiS0Lsg==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr14392232wrn.179.1610741359077;
        Fri, 15 Jan 2021 12:09:19 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id d85sm9187863wmd.2.2021.01.15.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:09:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 3/7] net: ethernet: ti: am65-cpsw-qos: Demote non-conformant function header
Date:   Fri, 15 Jan 2021 20:09:01 +0000
Message-Id: <20210115200905.3470941-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115200905.3470941-1-lee.jones@linaro.org>
References: <20210115200905.3470941-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ethernet/ti/am65-cpsw-qos.c:364: warning: Function parameter or member 'ndev' not described in 'am65_cpsw_timer_set'
 drivers/net/ethernet/ti/am65-cpsw-qos.c:364: warning: Function parameter or member 'est_new' not described in 'am65_cpsw_timer_set'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 3bdd4dbcd2ff1..ebcc6386cc34a 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -356,7 +356,7 @@ static void am65_cpsw_est_set_sched_list(struct net_device *ndev,
 		writel(~all_fetch_allow & AM65_CPSW_FETCH_ALLOW_MSK, ram_addr);
 }
 
-/**
+/*
  * Enable ESTf periodic output, set cycle start time and interval.
  */
 static int am65_cpsw_timer_set(struct net_device *ndev,
-- 
2.25.1

