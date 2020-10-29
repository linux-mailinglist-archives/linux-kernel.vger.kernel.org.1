Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC529ECDE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgJ2N13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgJ2N13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:27:29 -0400
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE592075E;
        Thu, 29 Oct 2020 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603978046;
        bh=3xJWe00B8QkCFemzMOCZwnC4kVuKqQ12Vg4IsVId2oU=;
        h=From:To:Cc:Subject:Date:From;
        b=j2rccWYpzlZQfVUU3zpO+8TsftyqoHIN9+kw0bOEllOvtlASnCsFY2GXBhhsYil0x
         9Jz+5Fer5sKJ/NxfCDwCl0dHtcvM6RSlgOdZnaTNnTqkK+SQ/mQCzAgxwjanpUY2I1
         7aB+wDosXi3Cg8qhJJJNtIJbcISH/0sndyn7Vijw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [RESEND PATCH v2] MAINTAINERS: add Dan Murphy as TP LP8xxx drivers maintainer
Date:   Thu, 29 Oct 2020 14:27:20 +0100
Message-Id: <20201029132720.13962-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milo Kim's email in TI bounces with permanent error (550: Invalid
recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
credits and add Dan Murphy from TI to look after:
 - TI LP855x backlight driver,
 - TI LP8727 charger driver,
 - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Sebastian Reichel <sre@kernel.org>

---

Dear Lee,

Could you take care about this patch?

Best regards,
Krzysztof

Changes since v1:
1. Add Dan Murphy, do not remove the entries.
---
 CREDITS     | 3 +++
 MAINTAINERS | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index cb02b9923a52..2a214a47c67a 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1910,6 +1910,9 @@ S: 660 Harvard Ave. #7
 S: Santa Clara, CA 95051
 S: USA
 
+N: Milo Kim
+D: TI LP855x, LP8727 and LP8788 drivers
+
 N: Russell King
 E: rmk@arm.linux.org.uk
 D: Linux/arm integrator, maintainer & hacker
diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..9d74b222f9ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17529,20 +17529,20 @@ F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
 
 TI LP855x BACKLIGHT DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+M:	Dan Murphy <dmurphy@ti.com>
 S:	Maintained
 F:	Documentation/driver-api/backlight/lp855x-driver.rst
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
 TI LP8727 CHARGER DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+M:	Dan Murphy <dmurphy@ti.com>
 S:	Maintained
 F:	drivers/power/supply/lp8727_charger.c
 F:	include/linux/platform_data/lp8727.h
 
 TI LP8788 MFD DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+M:	Dan Murphy <dmurphy@ti.com>
 S:	Maintained
 F:	drivers/iio/adc/lp8788_adc.c
 F:	drivers/leds/leds-lp8788.c
-- 
2.25.1

