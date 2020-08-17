Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25951245E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHQHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgHQHu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5732722BEB;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=2CcidvDqdTXESGqs1Ha/OCKMUNaguD47aMVxDK/J77I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puMGsIbTnIIq6yFDzJx19fI7EmkhGzxfcGF7h/d+glupo8/aGeSBiRle2l1osg79Y
         vmqtKIAbGPAKV/q9zxbzPbNM/8Q7pYEA5vqV3zCE+9e5clUMz0WF9prYo4vl9FZtZT
         6jnkxDiPr4a7XYm0FKHB8JqqZuRHnKB8A79jdGXc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcQ-DT; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 13/16] iommu: hisi_smmu_lpae: make OF compatible more standard
Date:   Mon, 17 Aug 2020 09:50:12 +0200
Message-Id: <2073dc8cc7998cc0019d1b47e243b4193543d080.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "manufacturer,model" pattern for the expected compatible
string for this board.

Most of compatible lines for Huawei's Hisilicon SoCs start
with "hisilicon,". Use the same pattern here for this new
driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index 33aba006d6a1..0f4d7b54193e 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -616,7 +616,7 @@ static int hisi_smmu_remove_lpae(struct platform_device *pdev)
 }
 
 static const struct of_device_id hisi_smmu_of_match_lpae[] = {
-	{ .compatible = "hisi,hisi-smmu-lpae"},
+	{ .compatible = "hisilicon,smmu-lpae"},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, hisi_smmu_of_match_lpae);
-- 
2.26.2

