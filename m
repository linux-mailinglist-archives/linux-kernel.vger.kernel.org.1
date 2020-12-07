Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9652D0DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgLGKCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:02:30 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:42664 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgLGKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:02:30 -0500
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 05:02:20 EST
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 10BCEEF694;
        Mon,  7 Dec 2020 17:49:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from zxing.hoperun.com (unknown [61.155.110.138])
        by smtp.263.net (postfix) whith ESMTP id P48105T139714124306176S1607334547556994_;
        Mon, 07 Dec 2020 17:49:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <598cefafa60468ed8a0fc307f86a7219>
X-RL-SENDER: zhou_x1@hoperun.com
X-SENDER: zhou_x1@hoperun.com
X-LOGIN-NAME: zhou_x1@hoperun.com
X-FST-TO: arnd@arndb.de
X-SENDER-IP: 61.155.110.138
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Zhou Xingxing <zhou_x1@hoperun.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zhou Xingxing <zhou_x1@hoperun.com>
Subject: [PATCH] misc: isl29003: Fix typo for get/set mode
Date:   Mon,  7 Dec 2020 17:49:05 +0800
Message-Id: <1607334545-2091-1-git-send-email-zhou_x1@hoperun.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation of get/set mode was same with get/set resolution. It is
a typo absolutely. This patch updates these bits operated by get/set
mode.

Signed-off-by: Zhou Xingxing <zhou_x1@hoperun.com>
---
 drivers/misc/isl29003.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index c12406f..703d20e 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -127,13 +127,13 @@ static int isl29003_set_resolution(struct i2c_client *client, int res)
 static int isl29003_get_mode(struct i2c_client *client)
 {
 	return __isl29003_read_reg(client, ISL29003_REG_COMMAND,
-		ISL29003_RES_MASK, ISL29003_RES_SHIFT);
+		ISL29003_MODE_MASK, ISL29003_MODE_SHIFT);
 }
 
 static int isl29003_set_mode(struct i2c_client *client, int mode)
 {
 	return __isl29003_write_reg(client, ISL29003_REG_COMMAND,
-		ISL29003_RES_MASK, ISL29003_RES_SHIFT, mode);
+		ISL29003_MODE_MASK, ISL29003_MODE_SHIFT, mode);
 }
 
 /* power_state */
-- 
2.7.4



