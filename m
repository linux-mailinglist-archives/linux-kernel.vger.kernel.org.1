Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23B1D6054
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgEPKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgEPKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:13:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4283EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 03:13:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u35so2251677pgk.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zStSSHGq5gQmDYLVefWI5JuXKhK3ughKSmR37kNuD1M=;
        b=uUvSF0rd51cC55NRN/sKuf1dDFDOpo+/2DWzqnoiAD8CGMXfdng1fgx+/ZUMYdtn5x
         u86nmq7Hs0RFpZZy0Ed9u+K8f4Jq2GCVgmPRc7Og6X5/ocgos+5fZeab8ni5KqYA9hh+
         bzY0cEV2Nl3QSVlhjuOiaV4WjvL7sFNMHd7Qh3JMs9LLmSlgwIdFtZXXRdCCkXrZprfu
         SYlTpo89ZauEf8kcjxfmfLdW5zQGR5uehvwc/IqmkoF5vTZUcYTHUNfDlyKrlaMvm41T
         vU/4lcZpoA+AFU0obKLa0QSl3V07eCsFhXHcRqVqvxuzyK7j9FKI/DqAWeL5ZhfHe6Hg
         kjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zStSSHGq5gQmDYLVefWI5JuXKhK3ughKSmR37kNuD1M=;
        b=GAxVlqMG1qHa7SbCEF13sGaA2KSSQFk6nKfCK5/JqBvnh/eqAfTGTsIhHErec9ZlQw
         WeHcRrXD5ChHZ8VXse4K0VRDx707hKAkJWHUxSZIt7xOak70hSybL0UisvMWDjTIDPuX
         DPbuX8fxzfS+Of1JVaqebrnqCTqFZgK+EyW9zHDX+hKwgS46np1KPw2fU8i/5xwdL/4w
         rOPHOIoCOGzl8EcpSpWBc90v9JCOHtS0Vi1P5Q1CD6zAFo+NMIXQ15LVTxqiUQ49BKIo
         M+Y+kC9BrgWGZzVeLigirccMrZMYvXVFRftAuwf//EByMzGh/4jgp8pg2z8fxLVsxf8C
         LSjw==
X-Gm-Message-State: AOAM533OftlZMpTrAW/o4arC2JSjx5/EArZtwyS5YKb/UCTIndr6EjM0
        +1xl1HtvYg7/ATC+IU7edgc=
X-Google-Smtp-Source: ABdhPJy0bMLh5fPEK32TUYMmK45RyYoIZ7bXW9Q0OU8kWL9sCK5RbQXtKaXsxl3794IFvCaCthKDpw==
X-Received: by 2002:a63:e809:: with SMTP id s9mr6997696pgh.191.1589623983347;
        Sat, 16 May 2020 03:13:03 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.16])
        by smtp.gmail.com with ESMTPSA id x10sm3554542pgr.65.2020.05.16.03.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 03:13:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de
Cc:     broonie@kernel.org, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add new physical regmap bus support
Date:   Sat, 16 May 2020 18:12:27 +0800
Message-Id: <cover.1589623456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum platform uses a special set/clear method to update
registers' bits, thus this patch set exports a weak function to
allow to register a physical regmap bus to support this feature
instead of using the MMIO bus, which is not a physical regmap bus.

Any comments are welcome. Thanks.

Changes from v3:
 - Remove vendor specific support from the syscon driver, and export
 a weak function to support physical regmap bus.

Changes from v2:
 - Fix building errors without enabling CONFIG_ARCH_SPRD.

Changes from v1:
 - Add WARN_ONCE() for seting bits and clearing bits at the same time.
 - Remove the Spreadtrum SoC syscon driver, instead moving the regmap_bus
 instance into syscon.c driver.

Changes from RFC v2:
 - Drop regmap change, which was applied by Mark.
 - Add more information about how to use set/clear.
 - Add checking to ensure the platform is compatible with
 using a new physical regmap bus.

Changes from RFC v1:
 - Add new helper to registers a physical regmap bus instead of
 using the MMIO bus.

Baolin Wang (2):
  mfd: syscon: Support physical regmap bus
  soc: sprd: Add Spreadtrum special bits updating support

 drivers/mfd/syscon.c           |  9 +++-
 drivers/soc/Kconfig            |  1 +
 drivers/soc/Makefile           |  1 +
 drivers/soc/sprd/Kconfig       | 16 +++++++
 drivers/soc/sprd/Makefile      |  2 +
 drivers/soc/sprd/sprd_syscon.c | 86 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h     | 11 +++++
 7 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/sprd_syscon.c

-- 
2.17.1

