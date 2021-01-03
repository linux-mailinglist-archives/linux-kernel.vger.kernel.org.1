Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68CF2E8E8D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbhACVnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbhACVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:43:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1207E207FB;
        Sun,  3 Jan 2021 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710178;
        bh=HFbAff8REzmBaLboQEAcDQ0tQ/Dw45kdlKYr8pVEu0o=;
        h=From:To:Cc:Subject:Date:From;
        b=buk1xPEsrRLk1CcOz6hENxYQyH0VSkdRrKh9nIayS+Uxy+J9C4uqnwyrAsqfs9MOO
         ZSrI6cLeqUQ0GLXMR/yzokXh+wEqPyU16UYNE/QrlhbBSe09YGyxvQxk7PuBgf7HxQ
         F1VOTyKxjgkJM7WDJldw8s0peomMW+JlrQpp6AVcqyfWaKVdRaA77kYBuI3wAHD5Ja
         Czobe+mRX4w67keMOmCkZVxX1tO+Kb/Cbxx9anvvUV4PGoCq5iM51fgfQm96QDXdZR
         erlunpwRRAI18wt8bvgUEQs4u8aGS01GBzF0YctBMjMVP2xti5QfreGgrAXCM57mqt
         Onopj93cbqQig==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Philip J Kelleher <pjk1939@linux.vnet.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: rsxx: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:42:39 +0100
Message-Id: <20210103214254.1996764-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without crc32, the driver fails to link:

arm-linux-gnueabi-ld: drivers/block/rsxx/config.o: in function `rsxx_load_config':
config.c:(.text+0x124): undefined reference to `crc32_le'

Fixes: 8722ff8cdbfa ("block: IBM RamSan 70/80 device driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 262326973ee0..583b671b1d2d 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -445,6 +445,7 @@ config BLK_DEV_RBD
 config BLK_DEV_RSXX
 	tristate "IBM Flash Adapter 900GB Full Height PCIe Device Driver"
 	depends on PCI
+	select CRC32
 	help
 	  Device driver for IBM's high speed PCIe SSD
 	  storage device: Flash Adapter 900GB Full Height.
-- 
2.29.2

