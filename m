Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07852631A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgIIQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:22:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730870AbgIIQTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:19:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B63DC3F8083677D7ACB;
        Wed,  9 Sep 2020 22:23:51 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 22:23:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: ene-kb3930: Make symbol 'kb3930_power_off' static
Date:   Wed, 9 Sep 2020 22:32:53 +0800
Message-ID: <20200909143253.66168-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/mfd/ene-kb3930.c:36:15: warning:
 symbol 'kb3930_power_off' was not declared. Should it be static?

This variable is not used outside of ene-kb3930.c, this commit
marks it static.

Fixes: 753bd752e181 ("mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mfd/ene-kb3930.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 1c32ff586816..eb7312bd6361 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -33,7 +33,7 @@ struct kb3930 {
 	struct gpio_descs *off_gpios;
 };
 
-struct kb3930 *kb3930_power_off;
+static struct kb3930 *kb3930_power_off;
 
 #define EC_GPIO_WAVE		0
 #define EC_GPIO_OFF_MODE	1

