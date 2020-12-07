Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65EA2D1385
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLGOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:24:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36648 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLGOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:24:56 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kmHQw-0003JI-DO; Mon, 07 Dec 2020 14:24:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: ltc2992: fix less than zero comparisons with an unsigned integer
Date:   Mon,  7 Dec 2020 14:24:10 +0000
Message-Id: <20201207142410.168987-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several occurrances of a less than zero error check on
a u32 unsigned integer. These will never be true. Fix this by making
reg_value a plain int.

Addresses-Coverity: ("Unsigned comparison against zero")
Fixes: e126370240e0 ("hwmon: (ltc2992) Add support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/ltc2992.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 69dbb5aa5dc2..4382105bf142 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -480,7 +480,7 @@ static int ltc2992_read_gpios_in(struct device *dev, u32 attr, int nr_gpio, long
 
 static int ltc2992_read_in_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
 {
-	u32 reg_val;
+	int reg_val;
 	u32 mask;
 
 	if (attr == hwmon_in_max_alarm)
@@ -534,7 +534,7 @@ static int ltc2992_read_in(struct device *dev, u32 attr, int channel, long *val)
 
 static int ltc2992_get_current(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
 {
-	u32 reg_val;
+	int reg_val;
 
 	reg_val = ltc2992_read_reg(st, reg, 2);
 	if (reg_val < 0)
@@ -558,7 +558,7 @@ static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 channel, l
 
 static int ltc2992_read_curr_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
 {
-	u32 reg_val;
+	int reg_val;
 	u32 mask;
 
 	if (attr == hwmon_curr_max_alarm)
@@ -609,7 +609,7 @@ static int ltc2992_read_curr(struct device *dev, u32 attr, int channel, long *va
 
 static int ltc2992_get_power(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
 {
-	u32 reg_val;
+	int reg_val;
 
 	reg_val = ltc2992_read_reg(st, reg, 3);
 	if (reg_val < 0)
@@ -633,7 +633,7 @@ static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channel, lon
 
 static int ltc2992_read_power_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
 {
-	u32 reg_val;
+	int reg_val;
 	u32 mask;
 
 	if (attr == hwmon_power_max_alarm)
-- 
2.29.2

