Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2B288A68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbgJIOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgJIOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:11:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D54C0613D2;
        Fri,  9 Oct 2020 07:11:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t20so3185537edr.11;
        Fri, 09 Oct 2020 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQO4b2yNCZwtGggHaJW09jdb16yB4LZzWYfRXkA2rMM=;
        b=OCTUH2YmFovxKqkB1R1nzmFtkVxPh2Dp87YUZuiql3+tE82L3hUO+NTxcHPJ6Yv396
         +kMby010IpkICigVtyZgzoqGkVtQNlZzsnIxG/HS8uQ6jnLitMqyoGSrYOKIfzeWbQRM
         VoJ9montT3S5UiMPS2iNdJWNJ0dBk1EolvvQjH1YFCa4UOrJip5Hn1nbGGMBfa+TBj5H
         svvCVai8vAK7fCSqbnrltZ9tvIa3JgnwFaoRCJh26wqMUeaDAT4j1EmW7yz5QEmuyA8j
         v0NwofkN6ycaO2AtgryQSRcAkye7bMbnP+tMf8PAzPQ8iiJkM6jsxnmYIKXnTXrqxmgL
         lLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQO4b2yNCZwtGggHaJW09jdb16yB4LZzWYfRXkA2rMM=;
        b=avmD6SjLn82ExPiKGMaKIdv5mF9w0R1xii+AhHB9wmYTJuInsTE/x8bGJKOjnjWHFt
         NVPF0M2UQIAYRs8gI3ZjPXe3FyRvGaWf5cJuvhYbsflPpDQeWayCFVVUgs/Lqcnt8/bC
         WtSt8biFYLQ4f9Z4u8M8s3YwHo1BCE0DvD3YDP/xzKSa44LHUGbFXZW2Hf373U8F6gg2
         Myq20x2g8I0BfraFhk2O0PeBN0O23v/dkHrmyLvila93OqaTvDKyorY8ZR4cWV66ktxJ
         /f8JtHGAY0pQI7dnWlIF8Mq0SXPBZVUu4DiiLCZoswRiyuYOiGCLpVYLfAOb1bHwDKG/
         PbLA==
X-Gm-Message-State: AOAM531KQxa7p7iLNBVEY7tWXS7zkC9Fl11ZOBsbvvX/T6e62VwyNmkl
        fzocDUZPtZD0jJtXI2V/qU8zueU3SiM=
X-Google-Smtp-Source: ABdhPJyfp3GUr1Yr6gClI/pcemrCrk4oHQhWVCGKyIpF90tLJf2K4mRj6oJun6WNF7YY4c7xfWXcQw==
X-Received: by 2002:aa7:c90a:: with SMTP id b10mr15023504edt.163.1602252710499;
        Fri, 09 Oct 2020 07:11:50 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a236.dip0.t-ipconnect.de. [217.229.162.54])
        by smtp.gmail.com with ESMTPSA id a5sm6184108edl.6.2020.10.09.07.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:11:49 -0700 (PDT)
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
Subject: [PATCH v4 0/5] platform/surface: Create a platform subdirectory for Microsoft Surface devices
Date:   Fri,  9 Oct 2020 16:11:23 +0200
Message-Id: <20201009141128.683254-1-luzmaximilian@gmail.com>
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

  [PATCH v4 1/5] platform: Add Surface platform directory

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

Changes in v4:
 - Rebase onto platform-drivers-x86/for-next.
 - Restructure MAINTAINERS entry and Kconfig option to be more similar
   to platform/chrome.
 - Drop placeholder comments.

For more details regarding changes, refer to the individual patches.

P.S: for Andy:
  I have not added your Rb tag for 1 and 2 as I was not completely sure
  that the changes are as you intended.

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

