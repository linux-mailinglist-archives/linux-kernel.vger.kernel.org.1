Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68222CC6E0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbgLBTmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbgLBTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:42:43 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:42:03 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so1712300pll.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvAOwNmdYOyvWyeZNvhCHF3LfAeECMn+7Hjxf8t9J1s=;
        b=gy5HC6qBf/rWcUZ+Sfh2GojdKYh6AT8Qn8XNz6FddLTBmperuqZBINYxPGGm5YMZ+j
         ZHDi08zxvW46Iz8DM0/m+BYiNaI66+LvjzI/psYk9xrcQ18GispzE8jnBfUaHKivggpm
         oAKu0xwGvWjVUYB1Xcqc+We5XNs0O6l7tXTNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvAOwNmdYOyvWyeZNvhCHF3LfAeECMn+7Hjxf8t9J1s=;
        b=iUZMtHaZlawWgswK66KcTdtrL+NVfyGOG77o3eIE8qTIxxIRjbcIGTn+sgdiBbhQbO
         vFKnX/fOk+9/JWmuq4LyvsflGVNsttRs0CURT/0uLyuIvbBVS/7BJz0cjwAnqhANQBj/
         E2GaHeRBZGEZ4hJnRjrjcR6EhkYRVpJR9Yh/WoxqpSpU489VmR4bqb+bud+vGlxNBtiP
         6X8DybHCPS+rhFk/jN5+Vr3wZIY0M+HfH9w7FSVB/WEfJ1CbhxIOeGntSNFYYI7KA4Tt
         fsnsLIfg/3geEZfsRuagOEnUgY/dAPosSlMI+y+gfwumD/6oW4VOYaD+GThPJrtgO2sF
         OjOQ==
X-Gm-Message-State: AOAM532WeXCtUvA1/56JafuUZuQQiM4SjnskH2UkxYzPUi8UmBq3YCBA
        ehVzIptGIpE/jeo6+xg6AHZfmU1X8/SQ+GbU
X-Google-Smtp-Source: ABdhPJz/ypCRmZpZn10dvtf0gS7cDmUuFl+cXXnBdfkjX46iVD+PSRCN3jFiPvr7mwh4dijXo12CYg==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr1399908pjs.102.1606938123289;
        Wed, 02 Dec 2020 11:42:03 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:29ad:2220:8aff:e226])
        by smtp.gmail.com with ESMTPSA id o29sm576496pfp.66.2020.12.02.11.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:42:02 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] arm64: defconfig: Enable REGULATOR_PF8X00
Date:   Thu,  3 Dec 2020 01:11:49 +0530
Message-Id: <20201202194149.180058-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PF8X00 regulator driver by default as it used in some of 
i.MX8MM hardware platforms like Engicam i.Core MX8M Mini SoM.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- update the commit message.

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

