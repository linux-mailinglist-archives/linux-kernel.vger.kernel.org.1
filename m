Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA23B2F355E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406177AbhALQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406165AbhALQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:26 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B4C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:15:45 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id FsFi2400C4C55Sk01sFidR; Tue, 12 Jan 2021 17:15:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzMKb-0037ih-TH; Tue, 12 Jan 2021 17:15:41 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzMKb-004eW7-02; Tue, 12 Jan 2021 17:15:41 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Mark Gross <mgross@linux.intel.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] crypto: keembay - CRYPTO_DEV_KEEMBAY_OCS_HCU should depend on ARCH_KEEMBAY
Date:   Tue, 12 Jan 2021 17:15:40 +0100
Message-Id: <20210112161540.1109016-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Keem Bay Offload and Crypto Subsystem (OCS) Hash Control Unit
(HCU) is only present on Intel Keem Bay SoCs.  Hence add a dependency on
ARCH_KEEMBAY, to prevent asking the user about this driver when
configuring a kernel without Intel Keem Bay platform support.

Fixes: 472b04444cd39e16 ("crypto: keembay - Add Keem Bay OCS HCU driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/keembay/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/keembay/Kconfig
index e45f1b039380feaa..ce0516e32ce4ff82 100644
--- a/drivers/crypto/keembay/Kconfig
+++ b/drivers/crypto/keembay/Kconfig
@@ -41,9 +41,9 @@ config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
 
 config CRYPTO_DEV_KEEMBAY_OCS_HCU
 	tristate "Support for Intel Keem Bay OCS HCU HW acceleration"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
 	select CRYPTO_HASH
 	select CRYPTO_ENGINE
-	depends on OF || COMPILE_TEST
 	help
 	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS) Hash
 	  Control Unit (HCU) hardware acceleration for use with Crypto API.
-- 
2.25.1

