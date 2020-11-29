Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF42C7AD0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgK2Szp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2Szp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:55:45 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E4C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:55:05 -0800 (PST)
Received: from dslb-178-004-174-066.178.004.pools.vodafone-ip.de ([178.4.174.66] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kjRqd-0005jB-5H; Sun, 29 Nov 2020 19:54:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH RESEND v2 1/3] mailbox: stm32-ipcc: add COMPILE_TEST dependency
Date:   Sun, 29 Nov 2020 19:52:26 +0100
Message-Id: <20201129185228.16213-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201024133154.22767-1-martin@kaiser.cx>
References: <20201024133154.22767-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows compiling the driver on architectures where the hardware is not
available. Most other mailbox drivers support this as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
---
changes in v2
- added Fabien's review tag

Dear all,

this has been around for some weeks now. Is there anything else you need
before these simple patches can be merged?

Thanks,
Martin

 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05b1009e2820..abbf5d67ffa2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -201,7 +201,7 @@ config BCM_FLEXRM_MBOX
 
 config STM32_IPCC
 	tristate "STM32 IPCC Mailbox"
-	depends on MACH_STM32MP157
+	depends on MACH_STM32MP157 || COMPILE_TEST
 	help
 	  Mailbox implementation for STMicroelectonics STM32 family chips
 	  with hardware for Inter-Processor Communication Controller (IPCC)
-- 
2.20.1

