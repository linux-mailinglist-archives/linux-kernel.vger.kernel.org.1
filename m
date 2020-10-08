Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157D3287623
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgJHOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbgJHOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D5C061755;
        Thu,  8 Oct 2020 07:35:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg9so3722156edb.12;
        Thu, 08 Oct 2020 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EncTmoo5wzlruw9laPBMejb89DhNxx+x6eC9BZ1zPO0=;
        b=nLJu+TIt8GSHAFs/yNLd3r9EXS1CrNeiEecCem0MC+xGe99DDz1ZjnsF93Bm4jX7x3
         u8HqLRbhRUvng6gXhiR7dB0FfJKJKInOCUdOhmJPFBzzs7PeujbW4f3ShmCS45IfKI/6
         o5sCxYwPM7rlTIAxsWc6gH47cHLsEjIS5xVPPBsaUA/pY+WE7qIX2Odej+nW/qQ2Lgbn
         Wpx+YE3IFbgQPhJyvTB9C7GZi1fYFuBpBBH/KE/CA/qQTxSrZM7dT0xEQjjH7vBjpeRm
         gPHr+pTmme96UbiA9Sikb6O7PsQ4ITDbkpXuuuZLOyCuyeC7fRY7rGSWjqcfnmvRGA1K
         0fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EncTmoo5wzlruw9laPBMejb89DhNxx+x6eC9BZ1zPO0=;
        b=LLgwa7Djk9RWWszsbziNCf6Ok/Tz74QRY1X8LiJxvFOwxQIOMNHXyU+vmRlMK7CQdP
         pGq4l4ZlgzZviXaR1Mul0ToxqPqkzOSPxjDu2u6oPMwnmUVLqDANghrwchoba+l7GLX6
         iySD2TZyFGtVDdug4FQR22JJDYivgLJR8155Ihrgwg7pPCV3oJ6D60qr4ycuAqoNtta4
         A0TVxTURFxUvFif1C8YHotiCUzu+XcnQbFXZo/tThog/60bA1BFo5LGFh2FlqJzpjDLQ
         jWduYPbd78RzJwB7mhOaZckn1PqAVB1ZlVJq/CzJkib3PNB/DA9coc91RWj3D5Q+B5Cd
         mpBw==
X-Gm-Message-State: AOAM532+GfVVq3Mx6Z8KnvBlwORuze/vJfByYRzNV7ol680ZqR/swobI
        pPvziYFV4cVRDP9kAfzyhxvif9/vwGE=
X-Google-Smtp-Source: ABdhPJxAq/RCsOyawflx6jJNFq0o1exaC3+MyJ3KaIPZKUVbF7FTTnUZBPkZ2INdFfGMgN76HOFz5A==
X-Received: by 2002:aa7:c608:: with SMTP id h8mr9153779edq.16.1602167717787;
        Thu, 08 Oct 2020 07:35:17 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id b8sm4123763edv.20.2020.10.08.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:35:16 -0700 (PDT)
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
Subject: [PATCH v3 0/5] platform/surface: Create a platform subdirectory for Microsoft Surface devices
Date:   Thu,  8 Oct 2020 16:34:50 +0200
Message-Id: <20201008143455.340599-1-luzmaximilian@gmail.com>
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

More details regarding maintainership can be found in

  [PATCH v3 1/5] platform: Add Surface platform directory

Thanks,
Max

Link to discussion:
  https://lore.kernel.org/lkml/CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com/

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Changes in v2:
 - Rebase onto linux-platform-drivers-x86/for-next to incorporate
   changes in Maintainer file.

Changes in v3:
 - Add separate MAINTAINERS entry for platform/surface
 - Add Maximilian Luz as reviewer for platform/surface

For more details regarding changes, refer to the individual patches.

Maximilian Luz (5):
  platform: Add Surface platform directory
  platform/surface: Move Surface 3 WMI driver to platform/surface
  platform/surface: Move Surface 3 Button driver to platform/surface
  platform/surface: Move Surface 3 Power OpRegion driver to
    platform/surface
  platform/surface: Move Surface Pro 3 Button driver to platform/surface

 MAINTAINERS                                   | 11 ++++-
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
 11 files changed, 72 insertions(+), 38 deletions(-)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile
 rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_button.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_power.c (100%)
 rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)

-- 
2.28.0

