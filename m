Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93CA213930
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 07:15:39 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:10186 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgGCLPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:15:38 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id 8A042203C1;
        Fri,  3 Jul 2020 14:15:33 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Avoid possible buffer overflow
Date:   Fri,  3 Jul 2020 14:15:18 +0300
Message-Id: <20200703111518.9644-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aspeed_create_fan() reads a pwm_port value using of_property_read_u32().
If pwm_port will be more than ARRAY_SIZE(pwm_port_params), there will be
a buffer overflow in
aspeed_create_pwm_port()->aspeed_set_pwm_port_enable(). The patch fixes
the potential buffer overflow.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 33fb54845bf6..3d8239fd66ed 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -851,6 +851,8 @@ static int aspeed_create_fan(struct device *dev,
 	ret = of_property_read_u32(child, "reg", &pwm_port);
 	if (ret)
 		return ret;
+	if (pwm_port >= ARRAY_SIZE(pwm_port_params))
+		return -EINVAL;
 	aspeed_create_pwm_port(priv, (u8)pwm_port);
 
 	ret = of_property_count_u8_elems(child, "cooling-levels");
-- 
2.16.4

