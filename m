Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1334E2DC0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLPNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:15:51 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21098C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:15:10 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id 51F22400B4C55Sk011F2XH; Wed, 16 Dec 2020 14:15:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpWdx-00BAa1-VX; Wed, 16 Dec 2020 14:15:01 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpWdw-005XVU-SW; Wed, 16 Dec 2020 14:15:00 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Healy <mikex.healy@intel.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] crypto: CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 should depend on ARCH_KEEMBAY
Date:   Wed, 16 Dec 2020 14:14:59 +0100
Message-Id: <20201216131459.1320396-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Keem Bay Offload and Crypto Subsystem (OCS) is only present on
Intel Keem Bay SoCs.  Hence add a dependency on ARCH_KEEMBAY, to prevent
asking the user about this driver when configuring a kernel without
Intel Keem Bay platform support.

While at it, fix a misspelling of "cipher".

Fixes: 88574332451380f4 ("crypto: keembay - Add support for Keem Bay OCS AES/SM4")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/keembay/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/keembay/Kconfig
index 3c16797b25b9497d..6f62c838a3fa0b2e 100644
--- a/drivers/crypto/keembay/Kconfig
+++ b/drivers/crypto/keembay/Kconfig
@@ -1,12 +1,12 @@
 config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4
 	tristate "Support for Intel Keem Bay OCS AES/SM4 HW acceleration"
-	depends on OF || COMPILE_TEST
+	depends on ARCH_KEEMBAY || COMPILE_TEST
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AEAD
 	select CRYPTO_ENGINE
 	help
 	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS) AES and
-	  SM4 cihper hardware acceleration for use with Crypto API.
+	  SM4 cipher hardware acceleration for use with Crypto API.
 
 	  Provides HW acceleration for the following transformations:
 	  cbc(aes), ctr(aes), ccm(aes), gcm(aes), cbc(sm4), ctr(sm4), ccm(sm4)
-- 
2.25.1

