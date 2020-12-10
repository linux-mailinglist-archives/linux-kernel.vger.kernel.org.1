Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71DA2D5901
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgLJLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:12:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9489 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbgLJLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:12:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsB736CQxzhplq;
        Thu, 10 Dec 2020 19:11:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 19:11:43 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <tony@atomide.com>,
        <pavel@ucw.cz>, <christophe.jaillet@wanadoo.fr>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: cpcap-usb: remove unneeded conversion to bool
Date:   Thu, 10 Dec 2020 19:11:56 +0800
Message-ID: <1607598716-16108-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:
drivers/phy/motorola/phy-cpcap-usb.c:146:31-36: WARNING: conversion to
bool not needed here.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 442522b..c276f7c 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -143,7 +143,7 @@ static bool cpcap_usb_vbus_valid(struct cpcap_phy_ddata *ddata)
 
 	error = iio_read_channel_processed(ddata->vbus, &value);
 	if (error >= 0)
-		return value > 3900 ? true : false;
+		return value > 3900;
 
 	dev_err(ddata->dev, "error reading VBUS: %i\n", error);
 
-- 
2.7.4

