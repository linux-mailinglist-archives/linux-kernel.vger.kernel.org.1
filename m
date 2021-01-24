Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D81301D2F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhAXP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:28:39 -0500
Received: from m12-11.163.com ([220.181.12.11]:43618 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbhAXP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qiH8y
        DnOdrgk+by1MixH/4jWCILOKNLS/w4DP5LFk68=; b=ZYORYY3qjst5k2J4JkRYb
        Wk8qcb1vkYOHB3i0ZIaxZ+/DGjypozlNKk8OVbmTPOp9gOX9FuIehNmrYGW26EtT
        jG2J9kzp6KPIu+eKgXK7LgKY4+q6/7M+caft72fdjafhObBoWqmvJhHrKOfb7XJh
        C9cFPWrzBeL7A3n5iQOxdQ=
Received: from yangjunlin.ccdomain.com (unknown [119.137.52.0])
        by smtp7 (Coremail) with SMTP id C8CowADn92uAhg1gG8CWKQ--.24963S2;
        Sun, 24 Jan 2021 22:38:57 +0800 (CST)
From:   angkery <angkery@163.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH v3 1/2] usb: typec: tcpci_maxim: remove redundant assignment
Date:   Sun, 24 Jan 2021 22:38:53 +0800
Message-Id: <20210124143853.1630-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADn92uAhg1gG8CWKQ--.24963S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DtFy7GF4ftry5GryDZFb_yoWfKrXEkr
        1xWFs2vr409F9Yqr1jyayfZ34FyrWvgFsa9F4vqrn0ywn8Cr9Fgr90yr15ArZrGF4UtryD
        Wrn8Wr4SkFZ8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUexMa5UUUUU==
X-Originating-IP: [119.137.52.0]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBCwIkI13l+ThXfAAAsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

PTR_ERR(chip->tcpci) has been used as a return value,
it is not necessary to assign it to ret, so remove it.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
v3:remove the newline modification.

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

