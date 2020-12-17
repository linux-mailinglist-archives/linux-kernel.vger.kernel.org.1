Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B142DD5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgLQROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:14:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgLQROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:14:15 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpwqJ-0008N2-Py; Thu, 17 Dec 2020 17:13:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sti: Fix spelling mistake in Kconfig "targetted" -> "targeted"
Date:   Thu, 17 Dec 2020 17:13:31 +0000
Message-Id: <20201217171331.57376-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-sti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index b2d45cf10a3c..74640bbaeba6 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -50,7 +50,7 @@ config SOC_STIH407
 	select STIH407_RESET
 	help
 	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH407 parts, targetted at set-top-box
+	  Electronics family StiH407 parts, targeted at set-top-box
 	  and other digital audio/video applications using Flattened Device
 	  Trees.
 
-- 
2.29.2

