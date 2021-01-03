Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A659F2E8E90
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbhACVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbhACVoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:44:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9AF82080D;
        Sun,  3 Jan 2021 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710200;
        bh=YeBj9IQIk+SIKS4WfjRddkPmK6uabnxfal+qub13XX0=;
        h=From:To:Cc:Subject:Date:From;
        b=ALAth+78bCwcRUryP0kiZ6r51b8PJduYmwCkvWX1bNqkQLQ808MCE77/gSq1Chdm8
         57YxPpcqlXhWqWLDryb+ZNtL9rjZuHvKxn5JJNw0YZaV7CTRfDWvpP9zcDe8JnpetO
         ev0Cin8YbeOBsRHqVk2oLLrqyIweX6svvQbGh2KTmhPd0c5i/Y6AfxEL7HG/aaRcNj
         vzyRMcpwvFXztRuArXkxKTi+DlSJhBuVIkhvTgCHasPJfLxn5VhwHIHgZm8jJjEzdo
         SDbbvi5t621sB4MuzDinsx6UBuTkzZJiHMk35mNaVn5hxOO3pNmQJ3WEsNleQhI2oD
         dRf7lP4BHtmIA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@fb.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:43:09 +0100
Message-Id: <20210103214316.1997006-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CRC32 support, this fails to link:

arm-linux-gnueabi-ld: drivers/lightnvm/pblk-init.o: in function `pblk_init':
pblk-init.c:(.text+0x2654): undefined reference to `crc32_le'
arm-linux-gnueabi-ld: drivers/lightnvm/pblk-init.o: in function `pblk_exit':
pblk-init.c:(.text+0x2a7c): undefined reference to `crc32_le'

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/lightnvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 8f39f9ba5c80..4c2ce210c123 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -19,6 +19,7 @@ if NVM
 
 config NVM_PBLK
 	tristate "Physical Block Device Open-Channel SSD target"
+	select CRC32
 	help
 	  Allows an open-channel SSD to be exposed as a block device to the
 	  host. The target assumes the device exposes raw flash and must be
-- 
2.29.2

