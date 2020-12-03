Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687022CD37F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbgLCK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388750AbgLCK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:29:25 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553CC061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:28:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so2211528wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wyWoP5jyt4pdrp5btFVKihgluvIPDgPMzZdR+o5haPA=;
        b=hw6/q45nxmmWi7sNrk66g5wxJBuqR8V2jrzzmO+AB4VonjAcd5xyq+jLx6PPcK+McE
         SVy4Lkep/8tZU545XcJCcbqdcOPYIGcZRw8b/YG7SEovgLH3GIlHQwXqWwowbAbiYlYW
         jqgmH2m0soKlYpmj859+v3bDUDHUe5W4rBfsh8piF/h/hKLAjTsT0OpG5Pq+Uj+SdgQz
         b62WeixHJHZnN9FuxBgwSIWr3obNL6/zNN17+PiqXiD58WcmfEpY+PKNJN8CcV7kIyqB
         P2hy5YdMzf3RXKCBOoeS5KjmYyivDcUj2dg8/ihkOpdF+tsw80XKQ/IdWMnHkPlrWsKK
         pplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wyWoP5jyt4pdrp5btFVKihgluvIPDgPMzZdR+o5haPA=;
        b=OlhEmxIOhYE5uAHT70VstCG3lp2UhdpoTMTbO4oX9t15F6/4ktkRPwDTKB5A3oUoX8
         wsvDCNwoGqKBFNGEGIK/0MDvKVp8q3LP9ZW45qTrL1Dv1HsLyJZ/jDdip79hZZ815M/9
         m0v+lOMI85quqPWevOe4H2pjpHfsJURrAIbBW/oZfSXNrAuZdTb4H88rGA8kE3ERXjGl
         VKQK0cTFg/g/IkU66WoDdGIu04eQd1Isux0HP494AQGrYq7reYpLv9N7IgjfvpeLSsZV
         XKgRKoQgOIp82lxjCUCUQfXSYQXrDDndWiTDHlJYkVTZUViM4r5bdeKq+GUVqnuD5tPD
         ZzPw==
X-Gm-Message-State: AOAM533wf438UjmRFndenR++WYwTweovnCdDMQIMjnyzI4iD4MyUms5n
        XzL423jqqLv3Ycn7AuilcuOGaU4ovc/sfw==
X-Google-Smtp-Source: ABdhPJwnYzay01lLTx+5UOxeAHUD2SIw2hzQJ97P7sMnMzN398unva76/FQzyTVlCM6VnylxnBuQYw==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr2505071wme.113.1606991317108;
        Thu, 03 Dec 2020 02:28:37 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id o13sm847589wmc.44.2020.12.03.02.28.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 02:28:36 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v3 0/3] drm/mipi-dbi: Type B bus support, drm/tiny: MRB2801
Date:   Thu,  3 Dec 2020 20:28:10 +1000
Message-Id: <1606991293-29539-1-git-send-email-mikhail_durnev@mentor.com>
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

v2 -> v3:
	- Fixed build errors reported by the kernel test robot

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
 drivers/gpu/drm/tiny/ili9341_gpio.c                | 284 +++++++++++++++++++++
 include/drm/drm_mipi_dbi.h                         |  30 ++-
 6 files changed, 493 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/ronbo,mrb2801.txt
 create mode 100644 drivers/gpu/drm/tiny/ili9341_gpio.c

-- 
2.7.4

