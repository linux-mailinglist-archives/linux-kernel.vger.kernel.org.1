Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA62E8E8B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbhACVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbhACVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:43:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 504A42080D;
        Sun,  3 Jan 2021 21:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710148;
        bh=0k7+YMlmmuoKnr0VdYaRCOF9Xor5RNVXi4oJ3cdQ/Cg=;
        h=From:To:Cc:Subject:Date:From;
        b=Zn5AtAEj4yUkE+OtNW55qQNv+2Z/E70A4ckIUMGV+tczzeezEQpfoXqbNztx8CKHE
         k+D9EWlKadcCLjl5Z2i43eDTs+4rMNnWV6GqUk11pSmML00ULOraVjE5djY2gYDqxa
         DRoSVolSz7bSGhr5xpY/Yw+9ya8GXd/PsFhWz/c/FmRhAhei8/G1UVAA9O0ZCeY3ur
         tSplGcaL9IpzHA9iHRsJbvUh2GKi5V+RHJZbLBMEypxZdal7vfIZXgumRxKXuVqg+U
         pmBT6KaKRyqbro9H+dd2qNZj62uyHKabQCQfOywNgHGKgjPAzRUr1wpBBQo+9iShuf
         miOAsqbM16HRA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Baxter <jim_baxter@mentor.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:42:17 +0100
Message-Id: <20210103214224.1996535-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without crc32 support, this driver fails to link:

arm-linux-gnueabi-ld: drivers/usb/gadget/function/f_eem.o: in function `eem_unwrap':
f_eem.c:(.text+0x11cc): undefined reference to `crc32_le'
arm-linux-gnueabi-ld: drivers/usb/gadget/function/f_ncm.o:f_ncm.c:(.text+0x1e40):
more undefined references to `crc32_le' follow

Fixes: 6d3865f9d41f ("usb: gadget: NCM: Add transmit multi-frame.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7e47e6223089..2d152571a7de 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -265,6 +265,7 @@ config USB_CONFIGFS_NCM
 	depends on NET
 	select USB_U_ETHER
 	select USB_F_NCM
+	select CRC32
 	help
 	  NCM is an advanced protocol for Ethernet encapsulation, allows
 	  grouping of several ethernet frames into one USB transfer and
@@ -314,6 +315,7 @@ config USB_CONFIGFS_EEM
 	depends on NET
 	select USB_U_ETHER
 	select USB_F_EEM
+	select CRC32
 	help
 	  CDC EEM is a newer USB standard that is somewhat simpler than CDC ECM
 	  and therefore can be supported by more hardware.  Technically ECM and
-- 
2.29.2

