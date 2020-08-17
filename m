Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510BF245D64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHQHLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgHQHLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:17 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96712078A;
        Mon, 17 Aug 2020 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648276;
        bh=39nQdxVqTIxprGokq0YoxR93+Ex5c4kwWK7y065VEFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaHzcnvlkUpCUEXtN+1Kk1qBSussfsSm31fxsP1TntKi3r5lSNHK4NKjrQm939Eg9
         x9VuzdGr+VbY+GAciDolTX+yl40rp0mKBcTgQyydOxFLQdlBFxhoy3fSVK4PAPrA+D
         TLZwjBWCM5IufRUzQLTFL/G8PbYVmD4iLZhO4p5A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIY-00BdjL-TO; Mon, 17 Aug 2020 09:11:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 04/44] staging: spmi: hisi-spmi-controller: fix a typo
Date:   Mon, 17 Aug 2020 09:10:23 +0200
Message-Id: <49798ac555d498c0fd489567643c619c625360f5.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chanel -> channel

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index bc6847f9a5e7..99cf757d76fe 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -306,7 +306,7 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(pdev->dev.of_node, "spmi-channel",
 				   &spmi_controller->channel);
 	if (ret) {
-		dev_err(&pdev->dev, "can not get chanel\n");
+		dev_err(&pdev->dev, "can not get channel\n");
 		return -ENODEV;
 	}
 
-- 
2.26.2

