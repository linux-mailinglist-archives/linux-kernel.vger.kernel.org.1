Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63101D9B92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgESPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 11:45:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53562 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgESPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:45:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jb4RF-0003IW-Eo; Tue, 19 May 2020 15:45:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Shimahara <akira215corp@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] w1_therm: remove redundant assignments to variable ret
Date:   Tue, 19 May 2020 16:45:53 +0100
Message-Id: <20200519154553.873413-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read
and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/w1/slaves/w1_therm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index cc4b88056b33..d5f062c05c9d 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -505,7 +505,7 @@ static inline int w1_DS18S20_write_data(struct w1_slave *sl,
 
 static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
 {
-	int ret = -ENODEV;
+	int ret;
 	u8 new_config_register[3];	/* array of data to be written */
 	struct therm_info info;
 
@@ -538,7 +538,7 @@ static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
 
 static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
 {
-	int ret = -ENODEV;
+	int ret;
 	u8 config_register;
 	struct therm_info info;
 
@@ -1499,7 +1499,7 @@ static ssize_t alarms_show(struct device *device,
 	struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = dev_to_w1_slave(device);
-	int ret = -ENODEV;
+	int ret;
 	s8 th = 0, tl = 0;
 	struct therm_info scratchpad;
 
@@ -1523,7 +1523,7 @@ static ssize_t alarms_store(struct device *device,
 	struct w1_slave *sl = dev_to_w1_slave(device);
 	struct therm_info info;
 	u8 new_config_register[3];	/* array of data to be written */
-	int temp, ret = -EINVAL;
+	int temp, ret;
 	char *token = NULL;
 	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
 	char *p_args = kmalloc(size, GFP_KERNEL);
-- 
2.25.1

