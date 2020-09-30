Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE027DD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgI3A5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 20:57:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbgI3A5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 20:57:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6C585FCF18B047A22E37
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:57:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 08:57:30 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <p.zabel@pengutronix.de>, <Sergey.Semin@baikalelectronics.ru>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] bus: bt1-apb: Fix duplicate included clk.h
Date:   Wed, 30 Sep 2020 08:54:59 +0800
Message-ID: <1601427299-29410-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/clk.h is included more than once, Remove the one that isn't
necessary.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff94..e9e196c 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -19,7 +19,6 @@
 #include <linux/nmi.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
-#include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
 #include <linux/clk.h>
-- 
2.7.4

