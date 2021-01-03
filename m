Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73A2E8E85
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbhACVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbhACVlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:41:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99523207C9;
        Sun,  3 Jan 2021 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710039;
        bh=X0Qnf29HvUG5MVRglG62WSELeOBBKlggCIn7y1gKqAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=euCS7wCByJf2ytbpHmzliXnBAPCBP+kng8zlCoMHX8V2iMaVOVb/jNKR41/xt4ibs
         9SqDPlUGxJ7e54/jv7UoUC3+cEAW+HgYL/s915ai8k18SudPCIhD+GY0aJp3Npco8r
         H1M2BvxONrw47E3dUPxXrGPhO7Ml/rgLG7icmZjjZzuQhe+uKstj5C/aTSN4XO1VcQ
         2C1qZriJ8ernUuXTNQvpOtBNB9cE5BHItZOYRdZUO4ExtqUR203svEjxib5yeO7AFp
         o2oOUPhTDPRUL9JLAgwQiRDPYGY2LI7KSAZbyTZ4bm3Mjkbwl86hJ5/8n43+zmqwAW
         EMgz6LI0ZSpIA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl819x: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:40:28 +0100
Message-Id: <20210103214034.1995821-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without crc32 support, the drivers fail to link:

ERROR: modpost: "crc32_le" [drivers/staging/rtl8192e/rtllib_crypt_wep.ko] undefined!
ERROR: modpost: "crc32_le" [drivers/staging/rtl8192e/rtllib_crypt_tkip.ko] undefined!
ERROR: modpost: "crc32_le" [drivers/staging/rtl8192u/r8192u_usb.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8192e/Kconfig | 1 +
 drivers/staging/rtl8192u/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 03fcc23516fd..963a2ffbc1fb 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -3,6 +3,7 @@ config RTLLIB
 	tristate "Support for rtllib wireless devices"
 	depends on WLAN && m
 	select LIB80211
+	select CRC32
 	help
 	  If you have a wireless card that uses rtllib, say
 	  Y. Currently the only card is the rtl8192e.
diff --git a/drivers/staging/rtl8192u/Kconfig b/drivers/staging/rtl8192u/Kconfig
index ef883d462d3d..f3b112a058ca 100644
--- a/drivers/staging/rtl8192u/Kconfig
+++ b/drivers/staging/rtl8192u/Kconfig
@@ -5,6 +5,7 @@ config RTL8192U
 	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
+	select CRC32
 	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_CCM
-- 
2.29.2

