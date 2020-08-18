Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6582B248879
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHRO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgHRO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:59:05 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B1C20855;
        Tue, 18 Aug 2020 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762745;
        bh=N9m1FgTkMXzb7asNBOTSJMVC597BzkfitmOhKQFXisw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4W79oqYljQKZINdpmmf58uXUxoWC6XPgUDtqOckmdfcUU9B4Bx+bNdvkbwQcTxEU
         lKu9awniBVpjHw0dErudTRvyRLPiVGxoRqBsScoomirltR3ytoxp29B9N8exM9W09k
         276CzA8VYbaTcPnpV4dTqE5AV8tL05QYT88eD66M=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k834p-00EGAi-5S; Tue, 18 Aug 2020 16:59:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: mfd: hi6421-spmi-pmic: Simplify the compatible string
Date:   Tue, 18 Aug 2020 16:58:56 +0200
Message-Id: <12bdc9b4734e156098408d0d27256abdc91ac283.1597762400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597762400.git.mchehab+huawei@kernel.org>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is clear that this driver is for PMIC. So, get rid of
it at the compatible.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 7817c0637737..64b30d263c8d 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -323,7 +323,7 @@ static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
 }
 
 static const struct of_device_id pmic_spmi_id_table[] = {
-	{ .compatible = "hisilicon,hi6421-spmi-pmic" },
+	{ .compatible = "hisilicon,hi6421-spmi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
-- 
2.26.2

