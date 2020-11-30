Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316542C9208
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgK3XGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgK3XGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:06:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:06 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so18591411wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kQXnB1X19UeBITbciJ7mvtj+74IYaiZ+Jn+cqruHHuk=;
        b=LCMThEDvu5tOOImUt1qTvDRzbSFoV1ytPweqan7G2TAver5sFM0wxdKmQswXwqOgi1
         1kxyHgfaILs5ogIR4gCYCVTrHoSnNT8elnmZRUr/Vg2p2xiHePhRVUgvgBtahfsRZB1X
         mJQO8SJwaqhPZnyUBVnOQ/UW1l+SLOmFj/2bDXMtpCPu4JXxIQy+dOcbNARpbosuY8fo
         RAEHs1FFLfAFMhkEpvvKK08OE/HOAjbYuD0Jce3OhlmmRU3Pxne5vLPAqJpA0FE2FpmV
         QIkB3usO7IYZoUBRe40FHm9lyi7o7DAkAhZVNmNskIXzYd18nnJowvEudud4sCcBOB6e
         d4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kQXnB1X19UeBITbciJ7mvtj+74IYaiZ+Jn+cqruHHuk=;
        b=gtb7qIMsQ5MhcKU9/6PnWWyc4DZ8A2aOvxnFaD7iJxZeTyoW8k6jjsZqDCOvb10TIA
         4Xk5f97+NhDpdXdYPH2x/5UJyzHxdmMrkL8hRKpBqRMHUUYd9oeeKiryul6+t8V8k+1h
         ZSQhH41ZNPL93PWbO0c2oq39+6rpaqpCt87/AzPpd+ZAV8mMKGRjwnsCKgz0qbiGQzdY
         kpcfSiFjnst5vbxEbFMIWP7KzmQJpZmElBLw+P4jLH6T8QDJ2yXpOIx9yFj6Z4GXuTZT
         i/IP0ZRJG5/uvHqobFecqR5496D2nBAzQJj90J/yUXJaaUfno+OfkPR3yILKzGm5g8Vh
         rOTw==
X-Gm-Message-State: AOAM531mMD4355QEWUSAVsGA0snZfpkHP/kvKxBhL1vuNgeyR/cFxyaf
        +Z4ohTUualNDTZbS45sIM1Xk1A5/CO8m8A==
X-Google-Smtp-Source: ABdhPJxogWIeS5K+Kyg7YwmOZbfVwi3gZv+XxvAAulYn9B9YxZTJVU0NtcryfTpz4BaRVmXiQSXPDA==
X-Received: by 2002:adf:f3cf:: with SMTP id g15mr30941507wrp.71.1606777564616;
        Mon, 30 Nov 2020 15:06:04 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id p4sm30427985wrm.51.2020.11.30.15.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 15:06:04 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v2 0/3] drm/mipi-dbi: Type B bus support, drm/tiny: MRB2801
Date:   Tue,  1 Dec 2020 09:05:33 +1000
Message-Id: <1606777536-14783-1-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Durnev <mikhail_durnev@mentor.com>

Hi All,

This patch series is aiming at extending the mipi-dbi bus driver
to support Intel 8080 type parallel bus (Type B) over GPIO and
adding a new driver for ILI9341 display panels with 8- or 16-bit
parallel interface.

It was tested with the MRB2801 display module [1] that had
a connector compatible with the ALIENTEK STM32 development board.
The module was connected to Raspberry Pi 3 via GPIO pins.

The parallel bus is implemented partially. It supports only write
operations from the host to the display. Read operations would
require switching GPIO mode between input and output back and
forth. But this implementation is very simple, and GPIO mode can
be set for all used pins to output once at initialization.
The RD pin of the display has to always receive the logic high
signal to make sure the data bus pins from the dislay side are
always in the high impedance state. Otherwise the display module
as well as the GPIO controller of the host can be damaged.
To be on the safe side I recommend using protective resistors
for all GPIO pins conneced to DB pins of the display. Resistors
of 10 kOhms are just fine for RPi 3. The WR and DC pins may not
work well with 10K resistors. Although there is no need to protect
them, you can try using 1K resistors if you want.

Bit banging is used to transmit data over the parallel bus from
host to display. There are two numbers that contol timings. They
should be defined in the device tree via the wr-up-down-delays
property. The first number is related to the write control pulse
duration, and the second number is related to the write cycle
duration. For ILI9341, the write pulse cannot be shorter than 15 ns,
and the write duration cannot be shorter than 66 ns. Delays of
10 and 51 ns respectively allow to meet the specifications on
RPi 3. Faster machines may need values closer to 15 and 66.

[1] http://www.lcdwiki.com/2.8inch_16BIT_Module_ILI9341_SKU:MRB2801

Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>

v1 -> v2:
	- Moved the definition of mipi_dbi_machine_little_endian()
	  out of the "#if IS_ENABLED(CONFIG_SPI)" clause. That static
	  function is used in mipi_dbi_gpio_init which does not need
	  CONFIG_SPI enabled

v0 -> v1:
	- Rebased on v5.10-rc6
	- Replaced "dbi->spi = 0;" with "dbi->spi = NULL;" in
	  mipi_dbi_gpio_init

v0:
	- Based on branch rpi-5.10.y
	- Tested on Raspberry Pi 3 Model B V 1.2

Mikhail Durnev (3):
  drm/mipi-dbi: Add support for Type B
  drm/tiny: Add driver for ili9341 with parallel bus
  dt-bindings: panel: Add bindings for MRB2801

 .../devicetree/bindings/display/ronbo,mrb2801.txt  |  42 +++
 drivers/gpu/drm/drm_mipi_dbi.c                     | 134 +++++++++-
 drivers/gpu/drm/tiny/Kconfig                       |  13 +
 drivers/gpu/drm/tiny/Makefile                      |   1 +
 drivers/gpu/drm/tiny/ili9341_gpio.c                | 290 +++++++++++++++++++++
 include/drm/drm_mipi_dbi.h                         |  30 ++-
 6 files changed, 499 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/ronbo,mrb2801.txt
 create mode 100644 drivers/gpu/drm/tiny/ili9341_gpio.c

-- 
2.7.4

