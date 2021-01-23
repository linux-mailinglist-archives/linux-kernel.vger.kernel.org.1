Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF5301784
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhAWSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:10:35 -0500
Received: from m12-17.163.com ([220.181.12.17]:38700 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhAWSKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dZlog
        IuW7sctk2awWW/go12ku17levD4zYwiADbhmZU=; b=euI2BNUuqnaEbV0HNIUq4
        gwWTHbeguMepe2L2W/hCZdKXyScNHF2Y1ESh7osAqL31mj9rqaFRiY///oxTNU1J
        BTGQqqskD/GfBBiGMzRxl6Qbg/aASMDIiAwGIDI+dVzHEdZXyVa9y8EKjqLS/OLN
        kTzZULOSOSXrt2NmayFgDQ=
Received: from yangjunlin.ccdomain.com (unknown [119.137.55.101])
        by smtp13 (Coremail) with SMTP id EcCowAAX5VxV9wtg1YothQ--.15504S2;
        Sat, 23 Jan 2021 18:15:50 +0800 (CST)
From:   angkery <angkery@163.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] usb: typec: tcpci_maxim: remove redundant assignment
Date:   Sat, 23 Jan 2021 18:14:10 +0800
Message-Id: <20210123101410.1354-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAAX5VxV9wtg1YothQ--.15504S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DtFy7GF4ftry5Gr1xZrb_yoWfZrcEk3
        WxWFs2vr109F9Yqr1UtayfZ3sYyrWkWFsa9F4vqwn0ywn8Cr9Fgryqyr15Ar9rWF4jqryD
        Wrn8Wr4SkFZ8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe3rc3UUUUU==
X-Originating-IP: [119.137.55.101]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBHgMjI13l-YQ6DwAAsp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

PTR_ERR(chip->tcpci) has been used as a return value,
it is not necessary to assign it to ret, so remove it.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 3192663..7f54f51a 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -461,7 +461,6 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR(chip->tcpci)) {
 		dev_err(&client->dev, "TCPCI port registration failed");
-		ret = PTR_ERR(chip->tcpci);
 		return PTR_ERR(chip->tcpci);
 	}
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
-- 
1.9.1


