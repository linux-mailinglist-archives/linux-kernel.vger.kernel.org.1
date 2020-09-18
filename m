Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87377270882
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIRVre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:47:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50874 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIRVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:47:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kJOE8-0004eE-21; Fri, 18 Sep 2020 21:47:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/emxx_udc: fix indenting issue on a couple of statements
Date:   Fri, 18 Sep 2020 22:47:31 +0100
Message-Id: <20200918214731.48750-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A couple of statements are indented too deeply, remove the
extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 4ceaf1ead123..a30b4f5b199b 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -2163,8 +2163,8 @@ static int _nbu2ss_enable_controller(struct nbu2ss_udc *udc)
 
 	_nbu2ss_writel(&udc->p_regs->AHBSCTR, WAIT_MODE);
 
-		_nbu2ss_writel(&udc->p_regs->AHBMCTR,
-			       HBUSREQ_MODE | HTRANS_MODE | WBURST_TYPE);
+	_nbu2ss_writel(&udc->p_regs->AHBMCTR,
+		       HBUSREQ_MODE | HTRANS_MODE | WBURST_TYPE);
 
 	while (!(_nbu2ss_readl(&udc->p_regs->EPCTR) & PLL_LOCK)) {
 		waitcnt++;
@@ -2175,7 +2175,7 @@ static int _nbu2ss_enable_controller(struct nbu2ss_udc *udc)
 		}
 	}
 
-		_nbu2ss_bitset(&udc->p_regs->UTMI_CHARACTER_1, USB_SQUSET);
+	_nbu2ss_bitset(&udc->p_regs->UTMI_CHARACTER_1, USB_SQUSET);
 
 	_nbu2ss_bitset(&udc->p_regs->USB_CONTROL, (INT_SEL | SOF_RCV));
 
-- 
2.27.0

