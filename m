Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A323B2F67D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbhANRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbhANRg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:36:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B2623B3E;
        Thu, 14 Jan 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645748;
        bh=73sR10wECqQUqw6UkBdoCbc/733OkO6ECg5/oQb+LQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFccHtsKtL5qDcip5eZIxIfmB39zezQtiUiUUCj+L02donxBAokNeN3+Yfeq3C0r/
         /6Zx/QaQM8FaD8zVel+ywI8brPGTuUmMx/fNtSLunbw1ZMzPqxF2J6PBXxAT0/WhIh
         eFVUzuk2/Q+MPajQsHCYz+JrnXB77zkPG3DAH49ntVW9lqPtTYHmgX+zNFIQxJsVA9
         NoLn5rzbg/YxAZRRB2PEBI8OkYzjMGoUI+f0stFYjtZrC8K5l+RWG1EldV4wz36aLL
         ke99OSDquFC2FinF2tU0RXVks4U8/jQuFzNiQipubPN1gxbh21/hapza48Q1G3ijmR
         Uesf3+1iVYqQA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l06XB-00FQtv-HK; Thu, 14 Jan 2021 18:35:45 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] staging: hikey9xx: phy-hi3670-usb3.c: adjust retry logic
Date:   Thu, 14 Jan 2021 18:35:42 +0100
Message-Id: <8a5d59d49acba14d0cc9f8e720d9892a21240d22.1610645385.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610645385.git.mchehab+huawei@kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of running a loop up to 100k times, add a small
delay inside it, running it up to 10 times, waiting up
to 100-200 us.

It should be noticed that I don't have the datasheet for
this PHY. So, not sure if this time will cover all
situations.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index 722cabaa9bd9..cffe6c58dfd7 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -185,7 +185,7 @@ static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 static int hi3670_phy_cr_wait_ack(struct regmap *usb31misc)
 {
 	u32 reg;
-	int retry = 100000;
+	int retry = 10;
 	int ret;
 
 	while (retry-- > 0) {
@@ -198,6 +198,8 @@ static int hi3670_phy_cr_wait_ack(struct regmap *usb31misc)
 		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
+
+		usleep_range(10, 20);
 	}
 
 	return -ETIMEDOUT;
-- 
2.29.2

