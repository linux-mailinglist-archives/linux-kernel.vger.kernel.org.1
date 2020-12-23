Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6F2E1B57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgLWLFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgLWLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:05:18 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65DBC061793
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:04:37 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t22so10187722pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCpNXBLs8298nV11fod2O1HtjRRraxH4UkX4Yv1+PQk=;
        b=rm0mYdbD8d/695juRo4oy1IhUDYL/Y71+amkr3dlh0zAnX5bfUVgOBuvAQND8lHddt
         WVejHFLn4Qt5W3WAA7Gijrl9RvF7URyAu32CGp/dXAIpDiFRIUNUqZAgRfmcynEMPfTG
         65BAtDPIfCoglSwbjtP2urQGVgQux0TtQSDQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCpNXBLs8298nV11fod2O1HtjRRraxH4UkX4Yv1+PQk=;
        b=Q1BfWMguSWv6AbqWgqa/aVL2JfrKcVOJMfyicoT8P4vIJS/Z/UW4XUh9B8b8vmHAsU
         jtb3B/61yj+pBQbpM0Z7r50o3aECJBP6iPjNP2vd259tDESP5EAVP0y/i37Pcb49x+k5
         Ti+f8Nf4yo6wotFCs3s/P5j1PvmsY345BtS9cZfYMEJquINanWzZY68JwzN1rSr7EurV
         lMBPP9hG+yEKKYJ6WjPzbYqftpBXcCNiPZHL3lF8JuT79Sj41Eojnj3E9k+8/cApuLQs
         Y/YGacThuoSyNK+npzDvEhmOFfxoyJ+v5tnnGs8OaTtZjxtawBRMFJh35rwX9TsmU0cd
         GbVA==
X-Gm-Message-State: AOAM5316UAWxiiTG2+7G6+sr1J4CtAPYfX3BVSSPXjbNcXQTuI0tl0P8
        v4dmjbtL0gfLVByhgdvAzEOAoA==
X-Google-Smtp-Source: ABdhPJxA1TmgS+k2PrAa5h6XdzoifIMR7/nUKrYzrTet4Atk7S1muCkIPsTTTIs8XyWpr+0rzjEcpg==
X-Received: by 2002:aa7:8499:0:b029:19e:6c5:b103 with SMTP id u25-20020aa784990000b029019e06c5b103mr23502520pfn.13.1608721477401;
        Wed, 23 Dec 2020 03:04:37 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:eca4:40c1:8784:571c])
        by smtp.gmail.com with ESMTPSA id 3sm23275909pfv.92.2020.12.23.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:04:36 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/6] arm64: defconfig: Enable REGULATOR_PF8X00
Date:   Wed, 23 Dec 2020 16:33:38 +0530
Message-Id: <20201223110343.126638-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223110343.126638-1-jagan@amarulasolutions.com>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PF8X00 regulator driver by default as it used in
some of i.MX8MM hardware platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- collect Krzysztof r-b
Changes for v2:
- updated commit message

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fae83673c3c3..e952c76ee970 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -594,6 +594,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

