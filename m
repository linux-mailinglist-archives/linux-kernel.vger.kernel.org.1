Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8381ED823
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFCVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:44:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D4C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 14:44:08 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E7CED37C;
        Wed,  3 Jun 2020 21:44:07 +0000 (UTC)
Date:   Wed, 3 Jun 2020 15:44:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] irqchip: Fix the description of the Loongson PCH MSI
 controller
Message-ID: <20200603154406.189594a5@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 632dcc2c75ef ("irqchip: Add Loongson PCH MSI controller") appears to
suffer from a lack of copy-and-paste fixup, with the result that the
KConfig description describes the wrong device.  Avoid potential user
confusion by getting the right acronym where it was meant to be.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 66b9a68f5e9f..d7c920afcfcb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -550,7 +550,7 @@ config LOONGSON_PCH_PIC
 	  Support for the Loongson PCH PIC Controller.
 
 config LOONGSON_PCH_MSI
-	bool "Loongson PCH PIC Controller"
+	bool "Loongson PCH MSI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
 	depends on PCI
 	default MACH_LOONGSON64
-- 
2.26.2

