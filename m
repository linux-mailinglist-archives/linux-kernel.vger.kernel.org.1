Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7BD2CF4D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgLDTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:34:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48794 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:34:54 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1klGqJ-00070J-Po; Fri, 04 Dec 2020 19:34:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: fix spelling mistake "Peripherial" -> "Peripherial" in Kconfig
Date:   Fri,  4 Dec 2020 19:34:11 +0000
Message-Id: <20201204193411.1152006-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index d99548fb5dde..d45be05640ea 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -183,7 +183,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
-	  Say y here to support the TrustZone based Peripherial Image Loader
+	  Say y here to support the TrustZone based Peripheral Image Loader
 	  for the Qualcomm Hexagon v5 based remote processors. This is commonly
 	  used to control subsystems such as ADSP, Compute and Sensor.
 
-- 
2.29.2

