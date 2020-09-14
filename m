Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF92268DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgINOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:30:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgINO3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:29:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D6A25FE1965FA672D4A;
        Mon, 14 Sep 2020 22:29:39 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 22:29:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <airlied@linux.ie>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] agp/uninorth: Make two variable static
Date:   Mon, 14 Sep 2020 22:29:30 +0800
Message-ID: <20200914142930.10496-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/char/agp/uninorth-agp.c:510:32: warning: symbol 'uninorth_agp_driver' was not declared. Should it be static?
drivers/char/agp/uninorth-agp.c:538:32: warning: symbol 'u3_agp_driver' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/char/agp/uninorth-agp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 62de7f4ba864..06db04cdc377 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -507,7 +507,7 @@ static const struct aper_size_info_32 u3_sizes[] =
 	{4, 1024, 0, 1}
 };
 
-const struct agp_bridge_driver uninorth_agp_driver = {
+static const struct agp_bridge_driver uninorth_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)uninorth_sizes,
 	.size_type		= U32_APER_SIZE,
@@ -535,7 +535,7 @@ const struct agp_bridge_driver uninorth_agp_driver = {
 	.needs_scratch_page	= true,
 };
 
-const struct agp_bridge_driver u3_agp_driver = {
+static const struct agp_bridge_driver u3_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)u3_sizes,
 	.size_type		= U32_APER_SIZE,
-- 
2.17.1


