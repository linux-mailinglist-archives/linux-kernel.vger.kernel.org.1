Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368332F9D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbhARK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:57:19 -0500
Received: from comms.puri.sm ([159.203.221.185]:59652 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389700AbhARK4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:56:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9EF4ADF4E4;
        Mon, 18 Jan 2021 02:54:52 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h9x9gjKGJP1Y; Mon, 18 Jan 2021 02:54:51 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 1/9] arm64: defconfig: Enable vibra-pwm
Date:   Mon, 18 Jan 2021 11:54:17 +0100
Message-Id: <20210118105425.425-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210118105425.425-1-martin.kepplinger@puri.sm>
References: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

The haptic motor for the Librem 5 uses this.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 15fe99544c67..91a034924a70 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -392,6 +392,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
+CONFIG_INPUT_PWM_VIBRA=m
 CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
-- 
2.20.1

