Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF82FB773
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404720AbhASKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404492AbhASKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:45:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FF612312E;
        Tue, 19 Jan 2021 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611053086;
        bh=73sR10wECqQUqw6UkBdoCbc/733OkO6ECg5/oQb+LQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDIcbPAb9o6Mk2q/aSQ4tBHvN0nXxtIZASJtDRoiQDeKXEuBcNO857UKzqqc1t4vO
         EEWHS8bk5vr3uzaM9pCCUZNagjSgDsSwatD3ROTUmPQD0LAqqAf+XFOGYuPfx7x9Wz
         mF0aZLGi/tkPu+7F17oiw65ESM+HbL6MX+BNPRM3CzE1NwUknbGsPKx7Jk/agsnEgw
         osOM1zd6nJ8sygeyhPB1cGtwRNI4iT0BdgpEqHZdeH9+q+4Pv39bWfzPJplAGRNGkI
         lhBhbmZJVDuewj5FC18y320PflUXVEHOcAhw4Cl0P+sEhe/8zjsWgAHo+LcjF4MMfQ
         7Wqahle3pu6bQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1oVA-000u2H-5k; Tue, 19 Jan 2021 11:44:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] staging: hikey9xx: phy-hi3670-usb3: adjust retry logic
Date:   Tue, 19 Jan 2021 11:44:40 +0100
Message-Id: <b653d7d6073de176598a5026c41b1a845f360c9e.1611052729.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611052729.git.mchehab+huawei@kernel.org>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
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

