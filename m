Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233792C6AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgK0RxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76418C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so5160306pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rij0KH1Dkx0c0dtAsJPJhqxaQEYYtBan22nB71uEE9k=;
        b=byW8dfwfqducQED5XmXk6bQEjWTUIXAtZk0WlDUmuKtiP6wFRFqdno0mekD+1HGqVv
         Vy0zwk2UZPJ2L+q1N974R9z8kwVNpCtfqKR299RaTjNpWjrwXdiLZow4L3WUSxBG0XyH
         D2LVyArmkRqAJ/iYYEjv9YbAw1nwvdOONK6hw3eGl2eFO7emlyjZDo3bnW1VTP/+bTXx
         EK5RGaNLHnE3j7Ar8H/fFvKKmwogurBEe3KJ0pOCmV4MR7RC79kroG/UR+gupMd/4aOJ
         xwP9TUlHfiUMCaM61rS6LobxcKhms3u7zPx5Y14mtMV7sMocfmuFtNEIQMPEMxsYEUCO
         z3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rij0KH1Dkx0c0dtAsJPJhqxaQEYYtBan22nB71uEE9k=;
        b=gSyNDADoo8KZThJ8Mzg4w6V3za8ECBEO4dW4lRUoe4AUCq0ZkAj/Dhxj/OxJ8+jb8Z
         Uk+hu4zhAWIVjh4RfvD7HsGb4jJxaOTnANeOl8l6vFwuKeJfTEYG0UguSSTwy4/HAiOi
         a1pHA7x05yV5vVNS1llbArs+DJ0CW87LTnoY+ajusHTGh5L7XyVSnBE6BbU8mLmHYSeL
         PxnnB3efDcPMUafwLIaXkTiBmGZVWTmAP/MQALqaviErb7QSXCsNFYimcj82/Tv9AHZu
         mck3vkDnsDljlfo2YoQTtyNGR5RmZn+aGTGO/tZ0U2Suy4opsWd2RhcQ2+UCc6tGML8s
         fQvQ==
X-Gm-Message-State: AOAM532Zn798DTqE4xI1CBwgwHoLXb0snvfTkAyEuGnvpyR0RoUbpQfT
        BQkjlG99UQqsbgq6f6lwHuwtuQ==
X-Google-Smtp-Source: ABdhPJwJkTnVmdAmCwwPnmbp9LBe78MjFmlM5BVzejujiU1U+W2Dj8VfT9TXDmb6sax1CS25KOKQvQ==
X-Received: by 2002:a62:f909:0:b029:18b:588d:979e with SMTP id o9-20020a62f9090000b029018b588d979emr8105544pfh.48.1606499583071;
        Fri, 27 Nov 2020 09:53:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:02 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] coresight: etm4x: Update TRCIDR3.NUMPROCS handling to match v4.2
Date:   Fri, 27 Nov 2020 10:52:46 -0700
Message-Id: <20201127175256.1092685-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Since ETMv4.2, TRCIDR3.NUMPROCS has been extended to a 5bit field
by encoding the top 2 bits[4:3] in TRCIDR3.[13:12], which were RES0.
Fix the driver to compute the field correctly for ETMv4.2+

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index af0ab2f44865..cbbe755d1d16 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -724,8 +724,13 @@ static void etm4_init_arch_data(void *info)
 	else
 		drvdata->sysstall = false;
 
-	/* NUMPROC, bits[30:28] the number of PEs available for tracing */
-	drvdata->nr_pe = BMVAL(etmidr3, 28, 30);
+	/*
+	 * NUMPROC - the number of PEs available for tracing, 5bits
+	 *         = TRCIDR3.bits[13:12]bits[30:28]
+	 *  bits[4:3] = TRCIDR3.bits[13:12] (since etm-v4.2, otherwise RES0)
+	 *  bits[3:0] = TRCIDR3.bits[30:28]
+	 */
+	drvdata->nr_pe = (BMVAL(etmidr3, 12, 13) << 3) | BMVAL(etmidr3, 28, 30);
 
 	/* NOOVERFLOW, bit[31] is trace overflow prevention supported */
 	if (BMVAL(etmidr3, 31, 31))
-- 
2.25.1

