Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B032D1528
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLGPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:51:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39124 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:51:52 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kmIn4-00012n-Tn; Mon, 07 Dec 2020 15:51:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ixp4xx: fix spelling mistake in Kconfig "Devce" -> "Device"
Date:   Mon,  7 Dec 2020 15:51:06 +0000
Message-Id: <20201207155106.172057-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is spelling mistake in the prompt text in the Kconfig. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-ixp4xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index f7211b57b1e7..7cf06c4fd8e7 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -7,7 +7,7 @@ comment "IXP4xx Platforms"
 
 config MACH_IXP4XX_OF
 	bool
-	prompt "Devce Tree IXP4xx boards"
+	prompt "Device Tree IXP4xx boards"
 	default y
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select I2C
-- 
2.29.2

