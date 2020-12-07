Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C662D153B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgLGPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:55:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39181 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:55:12 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kmIqC-0001CM-Kz; Mon, 07 Dec 2020 15:54:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fix spelling mistake in Kconfig "seleted" -> "selected"
Date:   Mon,  7 Dec 2020 15:54:20 +0000
Message-Id: <20201207155420.172370-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the help text of the Kconfig. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8fb61a285c76..4010bae52351 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -87,7 +87,7 @@ config PPC_WATCHDOG
 	help
 	  This is a placeholder when the powerpc hardlockup detector
 	  watchdog is selected (arch/powerpc/kernel/watchdog.c). It is
-	  seleted via the generic lockup detector menu which is why we
+	  selected via the generic lockup detector menu which is why we
 	  have no standalone config option for it here.
 
 config STACKTRACE_SUPPORT
-- 
2.29.2

