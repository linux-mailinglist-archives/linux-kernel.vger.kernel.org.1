Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0742C205D75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgFWUNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 16:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388585AbgFWUN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:13:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C192145D;
        Tue, 23 Jun 2020 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943209;
        bh=T5OdWZpmKmI0YXdOZW0OM8SJtXzWE8Mg9kUKTxJwYNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4x+t9kXaTFQUpI2PTzM+rwBAYjLa3b0ZIdtTSeG5nXXoEjI1n7rg3+Ux5YSWE8xY
         y04nORhr2rHS0dd3sQqnc7lHjIGjWsqY7PRd7f9w918msVLiz2Kow5ZTbSkWEVd2Bt
         KcdSTDH7JNyuUd44NNvpUJ1Mooy6KcAc+cvF49Uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 272/477] mfd: wcd934x: Drop kfree for memory allocated with devm_kzalloc
Date:   Tue, 23 Jun 2020 21:54:29 +0200
Message-Id: <20200623195420.422611082@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 652b7b6740eb52d98377a881c7730e36997f00ab ]

It's not necessary to free memory allocated with devm_kzalloc
and using kfree leads to a double free.

Fixes: 6ac7e4d7ad70 ("mfd: wcd934x: Add support to wcd9340/wcd9341 codec")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 90341f3c68101..da910302d51a2 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -280,7 +280,6 @@ static void wcd934x_slim_remove(struct slim_device *sdev)
 
 	regulator_bulk_disable(WCD934X_MAX_SUPPLY, ddata->supplies);
 	mfd_remove_devices(&sdev->dev);
-	kfree(ddata);
 }
 
 static const struct slim_device_id wcd934x_slim_id[] = {
-- 
2.25.1



