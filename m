Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E70283BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgJEQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJEQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38483C0613CE;
        Mon,  5 Oct 2020 09:03:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so8768920ejb.6;
        Mon, 05 Oct 2020 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42Qi3VO7NRTej5cplCYyboZcnsHY1nA6NBWFFEr6V6o=;
        b=C5ImITkHcQClAxKYORGt+pq3Ng8N5cfnsM4CFI3hNOLqKZmEY52SnJTkETILT1MCFF
         osg+spGp/3H/KRzN7huMtDCZ6OyAZorEepwrytDB465uZXMbgSkHiNf6T5gxUJdpN34s
         SKJNCKWfcOm9qS1KpN0WLbg3/CDk2yNttFT+1/PWKuQOJwD0kt7MExTIEB8DDomqlSw0
         0WBZI+Zpx3SDzyHJO9XK/q5+kbMmuGvCumEx+Qfu5Px/GQsJNoax9Cdz+N7jhbDn+oQF
         4QNaGyIzPOUrBmFcFECmf/g2AOMcp3931kgpUefQLmLCmfJ83hzUZf6mOFCvWD54qf3G
         G38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42Qi3VO7NRTej5cplCYyboZcnsHY1nA6NBWFFEr6V6o=;
        b=Gte5azU3/tNnjbAnwYC6ImzgVDUQKOYqP+RKxz697JNcxJZseqqkACYg+m41CughkA
         eP7nAU2yhLEyKLOhEwjN+RVOnalG+ZESf+7BhPpyTJEOqleA2BAmQTNFy6DpYrW8vf/f
         OXaPMy2NoyxVSvvltY2IROXnuq9T8nUnMogjFmyn+RM2I0gqxF7ed01QDIf8i0bI6Nny
         KPy6OozFT5/MA0lB4oWYRYfZpeyjos/fmgpgKg4DB2svN+YLP43NAKd6Io9MwFCW0zxC
         FQsTCQO7sNy7F+jl50sshGz2QoFY+ywtwC/23bJ8c1dGxfyQfLn12ExyckhLhnoXOv3I
         e9Dw==
X-Gm-Message-State: AOAM530QegbSzdtfo0yChZEeVNj9I0+oKyQxTqw6XWZ8MYkbS5lYa7D0
        XAbf9EvCEHOa+yFFKK8Bi3OB3nsnIIA=
X-Google-Smtp-Source: ABdhPJzdii5+nDaWOuWdn9Kli3u/1DCwnzQ+KVpyDo7YOFh6TIv0d0/kJJjPLQ5kenNavIEdT+bULA==
X-Received: by 2002:a17:907:40bb:: with SMTP id nu19mr417461ejb.246.1601913809416;
        Mon, 05 Oct 2020 09:03:29 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a952.dip0.t-ipconnect.de. [217.229.169.82])
        by smtp.gmail.com with ESMTPSA id y3sm51788ejk.92.2020.10.05.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:03:28 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2 0/5] platform/surface: Create a platform subdirectory for Microsoft Surface devices
Date:   Mon,  5 Oct 2020 18:03:02 +0200
Message-Id: <20201005160307.39201-1-luzmaximilian@gmail.com>
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

Changes in v2:
 - Rebase onto linux-platform-drivers-x86/for-next to incorporate
   changes in Maintainer file.

For more details regarding changes, refer to the individual patches.

Maximilian Luz (5):
  platform: Add Surface platform directory
  platform/surface: Move Surface 3 WMI driver to platform/surface
  platform/surface: Move Surface 3 Button driver to platform/surface
  platform/surface: Move Surface 3 Power OpRegion driver to
    platform/surface
  platform/surface: Move Surface Pro 3 Button driver to platform/surface

 MAINTAINERS                                   |  3 +-
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
 11 files changed, 64 insertions(+), 38 deletions(-)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile
 rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_button.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_power.c (100%)
 rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)

-- 
2.28.0

