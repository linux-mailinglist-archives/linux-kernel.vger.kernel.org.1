Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F582F4D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhAMOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbhAMOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:35:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB6BC06179F;
        Wed, 13 Jan 2021 06:34:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r3so2369753wrt.2;
        Wed, 13 Jan 2021 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIOSC/i/0EBgHvOloOEK1Z2ZW040Bk9xwSmCAqjjzc0=;
        b=e7pmBPOqhIan3hhIO6JWLC1arHHV+asvUbHfgotoqUpi5R0ghsLOaDxraSZqAeByoz
         b48rW3GTQN2dY6DuWeCmscEq/9sFetUODmD7LuQ4MZ1swBzA7Gr0fPNPmevI3Q+vcE5R
         Miic01SuTBVpZhOoZnvB4qqjZdoOo0Va/CxQMKXTvSRJLGUrAZzIn3Rpp9rlDx78Xats
         5Zx/hth50Ic9P/twM+k+pn10xPlytBy3jYINVNtwd4w5x24pF8YJxKtcna9RgHC0gab2
         8LODhqsRJZw5stM68CXDeNltXjUt01XMvs2u4YcKZ6nJXyCfRZQy2e7ofQ6wAt9xk6Bh
         qR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIOSC/i/0EBgHvOloOEK1Z2ZW040Bk9xwSmCAqjjzc0=;
        b=ndchDT6qg2A8wVXbkZ/7Y/b96psZF0vZajheo8gRH8rK2XBX6KGDGeTKHzISuX2ZH1
         +kJdQ2GGiUXhkq2vyTV7KTK1ZgW3zksaLL8+R5wnVzCcPoXthE5f3j53xbqrvEqwJWW+
         wQD1Bp69FS3Ew2D6/uSo8VsUq4BcTu334fV0ELatzlsqv+J1LqPPVNSzP9bjmBcefoVx
         lL20TBEKg+OX/HRMadTYkI8jzhX6Ukxvy4YBBiSaFnwpCyqCadZhERXgTR+klxXfdxWq
         W2Y0mnbJUuqhvniAsiElfByPupwrps7S8CiKz+XXUoPx6J9zad4xID5rWH4612ZRoplx
         Oa1g==
X-Gm-Message-State: AOAM531DEBg6/CEPrSRnNXa/2tec7kuXv6e8GQMWmkprIWfYNOx4zHw+
        0aEPPVs5cfuIJakMbseSroo=
X-Google-Smtp-Source: ABdhPJycyReRQaCwTxNxSOYULT3lf1lmq4CiJiUsvbbnbyHcq4nX5XZ4ghxeuKV+4jGqLuYuSGmeIg==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr2968058wrl.104.1610548492537;
        Wed, 13 Jan 2021 06:34:52 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id h13sm3720502wrm.28.2021.01.13.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:34:52 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 3/3] arm64: defconfig: Enable PF8x00 as builtin
Date:   Wed, 13 Jan 2021 15:34:43 +0100
Message-Id: <20210113143443.1148506-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113143443.1148506-1-adrien.grassein@gmail.com>
References: <20210113143443.1148506-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is mandatory for the nitrogen8m mini board
when booting from the sdcard slot.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ca9d03d5cb3..bd6ac11ad6fc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -603,6 +603,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

