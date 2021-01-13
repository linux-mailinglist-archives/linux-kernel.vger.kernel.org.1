Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763C22F503A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbhAMQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbhAMQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:42:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F711C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:41:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so2819697wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G08JJuzSVjauD2w7RKeXQ1nSbD1Rkjm71UkTsB/zD7Y=;
        b=h/F2lxdrgroIq/ZY7feq74qrpGnTA61pXLA+1K6ZxQ4xipHdZsKQabxegXx/fXVZG4
         go40xzp75VsUfMVjfaRWDi6ePQT9ag/KyKPlFeepMaqsszt6RS2A46MIpjyjjmer7Tof
         e5ah/aAqTMoVBQH4kUIgCfiIwfZfBpaHIoUJHGbtX4aI3TXdOHnnPSFXko8YvLfwyzCA
         I7Y66gaM0frkk6LaXymZ1PVFXETc9mv2q4r33HTYdefp1Avrn+e76kVEPeIrKT04ya5H
         JJHneE3/j586mxObhvRBA1AFdzsAzX2zm5NDznfNB132gdFEShcVMO3tuhKsdiYdjcsf
         zRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G08JJuzSVjauD2w7RKeXQ1nSbD1Rkjm71UkTsB/zD7Y=;
        b=eBWHofYR3B4XZlhw0IlMMMk+TqFShMKKrMlRXARCN+TqNAxwAUw7HO9mwvjRUbiOBO
         ICcO9GuC9ZLOxs09ffIsVpIcTKhnfam5zYd28ciJMuMUW6zsmTctPOYxCHe0wAYEQmYW
         in6j1WdBMjUcWgnd0dScI2n8z534wVdQKRH8E3NCrgQtxI5s6235AAvoIeCOsxWOkFR6
         vqfn/3JaqSJl86tz4pGgDIYdLSFa94ymYZMFYerA1NRjc8xXemo8JiVZKuWWoyHn37UC
         n7DXvzoHGbwtG6pCTCJ5UgofsF0I3Q3ChR2Q6ihLNTdffvV4hOk5JK/c1AR3dmhyvsTE
         e4kA==
X-Gm-Message-State: AOAM533BuP532DMr+wbb9pycVVz9B6zSdcvRxIKJGfEf5vEfMPMVKWED
        EEaOkqcmDOY7Lj7L4bdLjk9URQ==
X-Google-Smtp-Source: ABdhPJzFuuBL8tK9ckvJbxPslXmyXkwKkz5nZ8AT9PUJkNEdBxyUef5M8KNyQqn6Q4B2SaQCfgj50Q==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr3502133wrm.60.1610556092215;
        Wed, 13 Jan 2021 08:41:32 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t16sm3836510wmi.3.2021.01.13.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:41:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 3/7] net: ethernet: ti: am65-cpsw-qos: Demote non-conformant function header
Date:   Wed, 13 Jan 2021 16:41:19 +0000
Message-Id: <20210113164123.1334116-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113164123.1334116-1-lee.jones@linaro.org>
References: <20210113164123.1334116-1-lee.jones@linaro.org>
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

