Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89322E41E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 04:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgG0Cx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 22:53:27 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57006 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgG0Cx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:53:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U3rv6BO_1595818403;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U3rv6BO_1595818403)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Jul 2020 10:53:23 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH] tpm: Fix the description error of the help information in Kconfig
Date:   Mon, 27 Jul 2020 10:53:23 +0800
Message-Id: <20200727025323.26712-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously, the TPM version number in the help message is wrong, which
will cause confusion. This patch fixes it.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 58b4c573d176..8eedb3e704f3 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -62,7 +62,7 @@ config TCG_TIS_SPI
 	help
 	  If you have a TPM security chip which is connected to a regular,
 	  non-tcg SPI master (i.e. most embedded platforms) that is compliant with the
-	  TCG TIS 1.3 TPM specification (TPM1.2) or the TCG PTP FIFO
+	  TCG TIS 1.3 TPM specification (TPM1.3) or the TCG PTP FIFO
 	  specification (TPM2.0) say Yes and it will be accessible from
 	  within Linux. To compile this driver as a module, choose  M here;
 	  the module will be called tpm_tis_spi.
-- 
2.17.1

