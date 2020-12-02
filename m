Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B72CBC9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbgLBMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbgLBMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:13:50 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B166C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:10 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id l11so1034342plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r65t216Thxq+mYFTpyT4OjGg2gXVDw4eagVlWivHgyg=;
        b=dl3n5kTaebML2GhZwbAP/6F4kv/fdUQcJ20w30Xc5N6mA4IDp+rLVfV6Xz4dwNa6dz
         BH6K7tDoDnUBzg26WpYX20IcA2fa/4MT7d3aVlkF5Gyth8R3E3tbPgMrmEuH5WrOpWLe
         qSlmc6FraiSiHuONamreL/pDStzt0u9RCx3VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r65t216Thxq+mYFTpyT4OjGg2gXVDw4eagVlWivHgyg=;
        b=L3ZraZRj7ThErpxEJBVd7zryHxtk6bngBkT4By2EwDn0GKJpvQqQtclRRdZX7ig9Yf
         s8giJPuN8WH4XZRWU1sYlEF5gyBQ+9rLZBrSZh6aEftgYeAfhQ0DutLdmqgNRVoYgEbW
         mK4iHhLKLmPFZIauIbVV8BxB0w+Mo5CfoRdF2UOeEfaeMat3bV10c9l+iSCEvQ+iXfkF
         owVhx04bca+bRbzbKN7rfl4zGQgNkF/kOSJbHFXjm5CBjUiTUAiXrFsdsXgdUYz8gpS8
         322DMGGf4G6lYN1Pb67AV3ZILjhO9nKzCNSxC/MihJu9f3woMdOX24ExTUQ2T81Zelj8
         miNw==
X-Gm-Message-State: AOAM533rfDWREXK0lTS7jr93D11WUAxRfr+ue8EJkOXGSptTlbO83LD1
        XHxmkIEIb/qeamUhElYK2Ur5Ug==
X-Google-Smtp-Source: ABdhPJx220bSGOq0ad9GZPmlbsoPPyCBbcw+sBeq+ZCAQwNxUN12eJrAm7ba4uluze/gsWvmjnitGQ==
X-Received: by 2002:a17:90a:a785:: with SMTP id f5mr2079869pjq.219.1606911190167;
        Wed, 02 Dec 2020 04:13:10 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:09 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 01/10] arm64: defconfig: Enable REGULATOR_PF8X00
Date:   Wed,  2 Dec 2020 17:42:32 +0530
Message-Id: <20201202121241.109952-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PF8X00 regulator driver by default as it used in
some of i.MX8MM hardware platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 867cc4a5f00f..b070ecf61fdf 100644
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

