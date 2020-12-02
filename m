Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E32CC1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbgLBQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389060AbgLBQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:17:14 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE460C061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:16:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so4585270wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7cVseWE6MIn0vIOshUQxsts71GrP62tJMM0vJ2mEO6M=;
        b=JPMZDn1Q25wUvfxd5NHJUlgs/Y8PdFBXa/MVT0UhCfSDQfXICkj59GPnUm3wuozxG4
         UZ+ZjahG2yZHm8StlaVRYK+lgGj/uTSVF8EBVRoTLCOHYONUqktFbinfdcfvMPQXiXQB
         Fs/eqX57ZpU+WU2wHITndg3sXuIWc4YBUenchkoNPvGD2AAsu1/8l/FCFYUm9odgVGLB
         1AfmO8klAYMdu9+BdSrjmcI3CIVaAAT8apQZTdlJLyYB01vOUnvKTTP+/L78HE6DkqK5
         VI7i96lWnrmSvyHdZXoSxtRgLstxqO9zW0eXwVVgC98IXrcdCdAPPnBjWDYATo89qwDL
         4WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7cVseWE6MIn0vIOshUQxsts71GrP62tJMM0vJ2mEO6M=;
        b=pHgVvLw2eEc9CXAe2jFmWfbLh5o7k9c0YkBEWo0T518LYLZdHfbLxhAvtk1w6NbKAn
         jGPcM3DAenW0Izs2KN6PnIh7mkCMl7/uayHqJClR1BQEJPL93upVFm7e0R4tTk5j5ZU6
         jPkefX8gij88btyMeaJ8RNST6+6O2CPyPPvTTgbn3XN3ixaDIfRafRXdfSNOOv0QMV2l
         OL+tp3b85lbp5xTAfwQnMCUc+hJcSa1eDCdPfBn1lyWGayXTUacORTxzr/R8/LGA/qAN
         S0DycGSQQ4aLClg1BModcvDTA0TSwkiWUokFz1WJ5lIzEfKM+W9bKnG6Y63HgJDth5xP
         ePoQ==
X-Gm-Message-State: AOAM530ARNM/tglsV3tVJGNiV23MvaOZgEV91WnBqn3CXdNC0V/hVvzz
        85Y+Vm7PK2q/iOTiV5Kw6fdULA==
X-Google-Smtp-Source: ABdhPJwSjZL1OPGRCTWiQOlBQXtYSorpd0ICSpOhAQ4VJl5WT02dgUIr5pavqow6fS4l9GahL/u1/Q==
X-Received: by 2002:adf:e44d:: with SMTP id t13mr4422657wrm.144.1606925778652;
        Wed, 02 Dec 2020 08:16:18 -0800 (PST)
Received: from belels006.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id s4sm2644505wru.56.2020.12.02.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:16:17 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 3/4] net: freescale/fman-mac: remove direct use of __devm_request_region
Date:   Wed,  2 Dec 2020 17:15:59 +0100
Message-Id: <20201202161600.23738-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202161600.23738-1-patrick.havelange@essensium.com>
References: <20201202161600.23738-1-patrick.havelange@essensium.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the main fman driver is no longer reserving the complete fman
memory region, it is no longer needed to use a custom call to
__devm_request_region, so replace it with devm_request_mem_region

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/net/ethernet/freescale/fman/mac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 901749a7a318..35ca33335aed 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -690,12 +690,10 @@ static int mac_probe(struct platform_device *_of_dev)
 		goto _return_of_get_parent;
 	}
 
-	mac_dev->res = __devm_request_region(dev,
-					     fman_get_mem_region(priv->fman),
-					     res.start, resource_size(&res),
-					     "mac");
+	mac_dev->res = devm_request_mem_region(dev, res.start,
+					       resource_size(&res), "mac");
 	if (!mac_dev->res) {
-		dev_err(dev, "__devm_request_mem_region(mac) failed\n");
+		dev_err(dev, "devm_request_mem_region(mac) failed\n");
 		err = -EBUSY;
 		goto _return_of_get_parent;
 	}
-- 
2.17.1

