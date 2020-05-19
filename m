Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE86B1D8CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 03:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgESBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgESBQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:16:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5201C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:16:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g1so11888622ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Xn5wFnMFGQRN2JrwyG8dxbNaVxUmAM516TWUFCg/W2I=;
        b=eO1MHL1qyescskdPU67V3puqvAaIJ3hQ0IuVAZRGZ6G4uQNsgZWV1Y4u52hnCGFx+7
         Al2xXlkx5mlU74XWek6k3qA9pZTz6sq3iYKdH//4bth9WJc50gDYBtZVTskyNEGbg8zi
         SCLv7IPM2pAadEgkUO/2wCkVrkBcX4Jd0CFXO+2l3xExFCZeAtiDcbQIlVrE9owf63S9
         5yKxy0no1peIFjk/E1rDyTU21U/xw4ByDaImJQ6IP3HOe8LlXbWap/X40QiNQ/ar0yl1
         +YVLGymHUicv+iWc3IyfaVgCr16du/3uAkSc3qM4UzvguGyMH3X/Kb2DcmVVH6xhxU2Q
         vb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xn5wFnMFGQRN2JrwyG8dxbNaVxUmAM516TWUFCg/W2I=;
        b=SLrvJvZPS3hJd7z3gUgw2Ej7GSvA0/KDAOOE8o/0GXRq5IXpUlPFOmO93o2ZVGTMMf
         GJ6Cg/9yf5UPSx+ZgnXiLHloS991giDKYb4nl1xIhEDt6Syo0Xat/yp1uI2xM8DLp38Z
         cCpIOJLDuKJI4lMUwKYuepJg/pd+38R0RVA/F1+lHkKEb0Mnde4fT5/iFUBV5NwIdzvm
         PXdFhRHECRLe7gK4DI4L9y2fpwKm/L2ddmTmepGGNo+V4Y2CZTgF8kMBzZRgvJK1cuzF
         h+PGtabl5/WtXn2sIYdisWMrCLQ3kg2WnfaWAbj1nQ0AbbkzYOQVGJng/aDsOigipO06
         JESA==
X-Gm-Message-State: AOAM5325CYZUljFZ/3msKZsyGjqprL6eFWQ3hZyQqfVdR0Dp0s/WJ6pd
        R6d54PZ287Qaxd+gp4yz+L69CaVX3KNAyg==
X-Google-Smtp-Source: ABdhPJx/741/56BM68xh9y2nZL++XdhisKWGZlXkAWubLodSM7ew4ttbVJtaVvVr+Ykb1aQjtDdR+g==
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr11952050ljo.38.1589851003890;
        Mon, 18 May 2020 18:16:43 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id i8sm4764244lfl.72.2020.05.18.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 18:16:43 -0700 (PDT)
From:   Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Luis Oliveira <lolivei@synopsys.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
Subject: [PATCH v2 0/6] ov5647 driver improvement
Date:   Tue, 19 May 2020 04:16:15 +0300
Message-Id: <cover.1589847910.git.roman.kovalivskyi@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for ov5647 camera sensor lacks some important functionality, such
as ability to query device format and resolution or operations with
power down mode. Patches from Raspberry kernel source tree[1] fixes
those issues and improves quality of mentioned driver.

Changes since v1 [2]:
* Added DT bindings documentation for PWDN GPIO and non-continuous clock mode
* Patch 2: "media: ov5647: Add support for PWDN GPIO."
  * Replaced msleep with usleep_range
* Patch 3: "media: ov5647: Add support for non-continuous clock mode"
  * Added check if bus type is correct one
  * Replaced storing of all flags to storing whether clock is continuous
  * Added of_node_put(np) in case if v4l2_fwnode_endpoint_parse fails

[1] - https://github.com/raspberrypi/linux
[2] - https://lore.kernel.org/patchwork/cover/1223179/

Dave Stevenson (5):
  media: ov5647: Add set_fmt and get_fmt calls.
  media: ov5647: Add support for PWDN GPIO.
  media: ov5647: Add support for non-continuous clock mode
  media: ov5647: Use gpiod_set_value_cansleep
  media: dt-bindings: ov5647: Add property for PWDN control

Roman Kovalivskyi (1):
  media: dt-bindings: ov5647: Add property for non-continuous clock

 .../devicetree/bindings/media/i2c/ov5647.txt  |  7 ++
 drivers/media/i2c/ov5647.c                    | 77 ++++++++++++++++++-
 2 files changed, 80 insertions(+), 4 deletions(-)

-- 
2.17.1

