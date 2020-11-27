Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAE2C67CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgK0OXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:23:09 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:46386 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbgK0OXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:23:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E1B89FB02;
        Fri, 27 Nov 2020 15:23:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l82Kx_J5hS00; Fri, 27 Nov 2020 15:23:03 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A7EE04070F; Fri, 27 Nov 2020 15:22:59 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] arm64: defconfig: Enable CONFIG_REGULATOR_TPS65132
Date:   Fri, 27 Nov 2020 15:22:52 +0100
Message-Id: <2ceb6e90b2efb980771a3531ddb514ff6ab5d2b9.1606486893.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606486893.git.agx@sigxcpu.org>
References: <cover.1606486893.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by the Librem 5 to supply power to the panel.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 270d326d5f28..22c9e65d1ba5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -595,6 +595,7 @@ CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
+CONFIG_REGULATOR_TPS65132=m
 CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
-- 
2.29.2

