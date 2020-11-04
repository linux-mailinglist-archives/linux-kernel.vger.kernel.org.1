Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9627E2A603F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgKDJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgKDJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:06:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03784C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 01:06:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so2026298wrf.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szFDNNaKEVDZSNkDXGPen7gT5j56LfEHgacJ/wxEkwY=;
        b=N/4knhJ7uTG/9yLA1FSuCU1flqXLayCobZP7LJXfq0bxqg/f2LQPv0S3+gwUmPrlvH
         ZcTQ8cmH725ndJazq3KjmCYX/gRdGKIjWOqFDqJ6Ca3yHBeMCHLvqP7MbavdbqsWv3p7
         tp/mtcK62uAtazyujW3FsYwtTv4ejBYtpMZufYjm5/EBuvnxhGiyARiEFh4oHYBpof1m
         FLMvr9ZE4WvZuj6VUoTmr+5MZIXNoqFQDTh/Kl6S82TH08rzQYQ/zWqOYCHsy8sFvrDU
         fZFsELF54BVdt4TghACs9PCg0x+aj2lcb0j+QMwz5ImUWToz4/E/k+BHprYQ7ZeD/4CF
         aBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szFDNNaKEVDZSNkDXGPen7gT5j56LfEHgacJ/wxEkwY=;
        b=AgqthyxofDeGTKHFnzaq8Qsn/THQ7IhOXvW4SnR0rqB9A+uX+FXcky1ofFeLieCGd1
         lLF2pYh+VuFfi0IvTbSh4Ha5RLsHK51VFfa6eg/HRHCwKBlJ//igYIh9KRtL2XgzuQD1
         PWpGL+fClpPklspNzmelzQu9/hi2ZjSQjHSFfJQip4E5bcbeTlp+9aqhicxoRS7CAP/k
         WWPVIgL0psudL4dica7e+xDMxgwtPiiQjCt9l8gS/69e4SFDTKv5Lsit/pe6ZOPGs2Z/
         VN/4Kh7N6ezRmyBebXw0hVX97Bz5qAPhN28mBA/xJm6knNCp4Daga+h3uyaV7czPAaho
         eH1w==
X-Gm-Message-State: AOAM531LcDu6pIN2aOjxzw7UxywIZKGKR1ii2WFhnaX8PvYXnRk3nDwn
        rxeEmHgtPNfTksKHhVmWORx4KQ==
X-Google-Smtp-Source: ABdhPJzIJXs0rqnpGfYOPLHG8ZWucjsENoRrdaQl4vWak5XVOqN2jes5DesM6dPTbX7FugMpqk+Mjg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr31727752wrl.415.1604480790781;
        Wed, 04 Nov 2020 01:06:30 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id e25sm1607823wrc.76.2020.11.04.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:06:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org
Subject: [PATCH 06/12] net: ethernet: ti: am65-cpsw-qos: Demote non-conformant function header
Date:   Wed,  4 Nov 2020 09:06:04 +0000
Message-Id: <20201104090610.1446616-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104090610.1446616-1-lee.jones@linaro.org>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
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

