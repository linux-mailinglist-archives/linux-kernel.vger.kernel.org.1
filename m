Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6262279B37
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgIZRRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIZRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:17:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847BC0613CE;
        Sat, 26 Sep 2020 10:17:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so2851819eja.2;
        Sat, 26 Sep 2020 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG0sk5gJwIk5to3pVTC+CHGoKi541Yu4qsHVRvmfuGA=;
        b=u6SGGmZT2Aw3JlmvK2NRx9niQND85bs6j6cgPYztlvRudRyeA0fJAaz0k8kRnc8DS0
         NiD6F/I+2y40LNTZ2SXDuDylzdDjDptR+S11OP3MQ8uE4i95ktmzEh9dfridaaLcCMJA
         H6LQiL4W9uQVJfN+qrBS9etaHxHtKVtHbhOMfoIxzuoOc5kRpJTCAzNneH0zWknAcHc+
         Deyk9bFKBhqLavQrYgdy20c4zF612yPLzNnF6QuQYpz4K96r+QB29y2HX+i8Omfui3a6
         V9BlwnF9DlfoKZeRxWspvdxW47aFuvYscxO3FvveOIdid2j8urbnSeAW2zAkdZLJoaJi
         ng1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG0sk5gJwIk5to3pVTC+CHGoKi541Yu4qsHVRvmfuGA=;
        b=KmffoiP7IA4nSx7AswBSnRncB0WqSTOEuEwf6KDQK/XdVd9yeWdlzklHne36m/QNXq
         uoj71BJZep9yUEVLUI62dbIgl5M1ufFmZ5G64pViU/7ZmAnslmDHo2VFzSu3l1IyZsbW
         674T4/JYf+IAB743GMjPclHMSYRST50DL5Qt+FRmUiVnicEBRfLN83xPCu4iJZbo+UAt
         1jy44Kin9TcQti5oYY60xJNKxAtFtaB/eCGIg5hEv+KlxJnn0vUP21xKLREDRbB/ZCou
         5wadtNnLgYJGQNkhFhf9ONgkIM6ynPK6LM8rfaMsqZ0z+9IAsdzOVxSRCT4W/XCnj91d
         5Q7g==
X-Gm-Message-State: AOAM532LRP71dG+7wxVt4CMzJkFQOXLQfnZLl8YrYpuA5IwIDo2ZH5H7
        U47bkUb/d6XsSIrWXNZwVu93SCfc+jY=
X-Google-Smtp-Source: ABdhPJyAM8YjMjt7Zj7pgJx+F4qQF7rl/yT21zRuRsX8EudchM2LPJSuhNdDnIvqiJavi6rkJW/ZAA==
X-Received: by 2002:a17:906:4a8c:: with SMTP id x12mr8450691eju.271.1601140669108;
        Sat, 26 Sep 2020 10:17:49 -0700 (PDT)
Received: from xws.fritz.box (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id u13sm4625589ejn.82.2020.09.26.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:17:48 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/5] platform/surface: Create a platform subdirectory for Microsoft Surface devices
Date:   Sat, 26 Sep 2020 19:17:09 +0200
Message-Id: <20200926171714.721406-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As has come up in the discussion around

  [RFC PATCH] Add support for Microsoft Surface System Aggregator Module

it may make sense to add a Microsoft Surface specific platform
subdirectory. Andy has suggested drivers/platform/surface for that.
This series follows said suggestion and creates that subdirectory, as
well as moves Microsoft Surface related drivers over to it and updates
their MAINTAINERS entries (if available) accordingly.

This series does not modify any existing driver code, symbols, or help
text.

Thanks,
Max

Link to discussion:
  https://lore.kernel.org/lkml/CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com/

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Maximilian Luz (5):
  platform: Add Surface platform directory
  platform/surface: Move Surface 3 WMI driver to platform/surface
  platform/surface: Move Surface 3 Button driver to platform/surface
  platform/surface: Move Surface 3 Power OpRegion driver to
    platform/surface
  platform/surface: Move Surface Pro 3 Button driver to platform/surface

 MAINTAINERS                                   | 10 +++-
 drivers/platform/Kconfig                      |  2 +
 drivers/platform/Makefile                     |  1 +
 drivers/platform/surface/Kconfig              | 49 +++++++++++++++++++
 drivers/platform/surface/Makefile             | 10 ++++
 .../platform/{x86 => surface}/surface3-wmi.c  |  0
 .../{x86 => surface}/surface3_button.c        |  0
 .../{x86 => surface}/surface3_power.c         |  0
 .../{x86 => surface}/surfacepro3_button.c     |  0
 drivers/platform/x86/Kconfig                  | 31 ------------
 drivers/platform/x86/Makefile                 |  6 ---
 11 files changed, 71 insertions(+), 38 deletions(-)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile
 rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_button.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_power.c (100%)
 rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)

--
2.28.0

