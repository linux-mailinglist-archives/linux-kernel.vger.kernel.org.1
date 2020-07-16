Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1389221C94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGPGYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 02:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGPGYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:24:43 -0400
Received: from localhost.localdomain (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CAB2067D;
        Thu, 16 Jul 2020 06:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594880683;
        bh=jDxq2s4+qRcPbe1fDSoTutptWGHWlRtBmurlhOTUS5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=2e8UonfAMHujElyoWB9CaxmvFI41nLbZv2bWXod1qvhhn02e237B40CeGfhTzhhOb
         cuxLgwXHA6ILaXwkNXgf0PcUgC3K7bAg6gTP5O89QdQg5OjETBVzOAXdFrvZQ3Co3f
         2FU50Mj6bQwBUIsjzTn9Cw3k/5BFw4bzRfaVllZU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] phy: sun4i-usb: explicitly include gpio/consumer.h
Date:   Thu, 16 Jul 2020 11:54:27 +0530
Message-Id: <20200716062427.71763-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver uses GPIO functions but doesn't include the header explcitly. Add
that to fix build errors when GPIOLIB is disabled.

drivers/phy/allwinner/phy-sun4i-usb.c:367:11: error: implicit
declaration of function ‘gpiod_get_value_cansleep’; did you mean
‘gpio_get_value_cansleep’? [-Werror=implicit-function-declaration]
drivers/phy/allwinner/phy-sun4i-usb.c:707:22: error: implicit
declaration of function ‘devm_gpiod_get_optional’; did you mean
‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
drivers/phy/allwinner/phy-sun4i-usb.c:708:11: error: ‘GPIOD_IN’
undeclared (first use in this function); did you mean ‘GPIOF_IN’?
drivers/phy/allwinner/phy-sun4i-usb.c:815:21: error: implicit
declaration of function ‘gpiod_to_irq’; did you mean ‘gpio_to_irq’?
[-Werror=implicit-function-declaration]

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 7e09ad6a0b42..585d0a59e712 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/extcon-provider.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-- 
2.26.2

