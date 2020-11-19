Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C62B967E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgKSPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgKSPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:42 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473BC0613CF;
        Thu, 19 Nov 2020 07:43:41 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so6973446wrw.1;
        Thu, 19 Nov 2020 07:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrWkzF6G7CvNew/hvBSLy3vrV8xmYkd2jnRsQsz2yOs=;
        b=F0O2naeWQcy29Dq2ulABrio89G0TpqV3ft/JVNAvlGKX7QlaNt7hG13X9TxWD2JfxM
         UCYb8OP4K2LWn4Prpp6Be6FcZZQT2gtA+k9M2H+o2FUMbTFKUBchfLkdxnbqdyF9+Fei
         ZUmjuE1SYtQH0+Q1tvgKSnAtF0gPZlfd8b9BeOI9jc0XpqQIoLzcJYu5f7+yHKrHfPxH
         RzDkO+sMnYOZqRtUar2Y/oOAbmHFaFKt1289fw5EmY3z1evidvUvU5KFcB7SHFQfACYK
         2biBTkq3n6CWDBbeO4cKR3zfrLGN0+Y3jG2WXTVdhBAAfSXQO3MwZysmriUhIswSWQBj
         vtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrWkzF6G7CvNew/hvBSLy3vrV8xmYkd2jnRsQsz2yOs=;
        b=Q9IFTwwOKZdXKU5xbGjZ27ZBvvkkxxvLoWYbfdb5v5Mjn24QYlosa/i4W0yaJiIlnQ
         I7D+JXR0IGvhpbMPVi5TF7pCC8k7J/0OpT+TunSKuQMx6MkEuePD5CPq7g++7bVAK209
         d01SA9BvXLUH0BhqOBsAmVuTuPY6fIRc6V0RDmiOVgqGp162vC0I7yqY2LIJEFddpCXq
         lfD1kl2WKID4k9pIIeEpcHVKQCe5VyFD84CvJUMtFjI2KD4j7+2VkObX9FNL91VSFpv/
         lBhB0vlYGOH7K6+m+t/5MCKCPnPsHaV48M4IVNvFfEFAR7TXNl++O1N9TLBjgg3e6pGq
         h4YA==
X-Gm-Message-State: AOAM530gksqetLIeO/CrJPwa7wzsjhZNsLGsPOrQ+DtTyjSYg2UjmyCJ
        4w5VddY8hUc0BSRCBVkHsmo=
X-Google-Smtp-Source: ABdhPJwvpMG7Qj2YNmGtK+GMt6Yqw8AsKAJJGYtCHgizT9XuhoglTUXAuJMM7YuejzX0HyX9C3IknQ==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr11774075wrq.210.1605800620422;
        Thu, 19 Nov 2020 07:43:40 -0800 (PST)
Received: from localhost.localdomain (234.red-79-158-79.dynamicip.rima-tde.net. [79.158.79.234])
        by smtp.gmail.com with ESMTPSA id w10sm181303wra.34.2020.11.19.07.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 07:43:39 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, neil@brown.name
Subject: [PATCH v5 0/4] MT7621 PCIe PHY
Date:   Thu, 19 Nov 2020 16:43:33 +0100
Message-Id: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the PCIe PHY found in the Mediatek
MT7621 SoC.

There is also a 'mt7621-pci' driver which is the controller part
which is still in staging and is a client of this phy.

Both drivers have been tested together in a gnubee1 board.

This series are rebased on the top of linux-next:
commit 4e78c578cb98 ("Add linux-next specific files for 20201030")

Changes in v5:
  - PATCH 1/4: Recollect Rob's Reviewed-by of bindings.
  - PATCH 4/4: Recollect Greg's Acked-by for removing stuff from
    staging area.
  - Make Vinod's review comments changes in [0]:
    * Use FIELD_GET and FIELD_PREP apis and avoid multiple *_VAL and
      *_SHIFT custom definitions.
    * Remove phy-read and phy-write internal functions and directly
      call regmap_read and regmap_write in 'mt7621_phy_rmw'.
    * Change some traces from info to debug log level.
    * Note that I have maintained 'mt7621_phy_rmw' instead of use
      'regmap_update_bits'. This is because in order to get a reliable
      boot registers must be written event the contained value in 
      that register is the same. I have preferred doing in this way
      instead of using 'regmap_update_bits_base' passing 'false' for
      async and 'true' for the force write. If this way of using 
      'regmap_update_bits_base' is preferred just let me know.

Changes in v4:
  - Bindings moved from txt to yaml so previous Rob's Reviewed-by
    is not in the new patch with the yaml file.
  - 'phy-cells' property means now if phy is dual-ported.
  - Avoid custom 'xlate' function and properly set registers
    when the phy is dual ported.
  - Add use of 'builtin_platform_driver'.
  - Added a patch including myself as maintainer in the
    MAINTAINERS file.
  - Add a patch removing patch from staging to make easier
    the complete inclusion and avoid possible problems might
    appear in 'linux-next' if the series are included.

Changes in v3:
  - Recollect Rob's Reviewed-by of bindings.
  - Make Kishon Vijay suggested changes in v2:
   (See https://lkml.org/lkml/2019/4/17/53)
  - Kconfig:
    * Add depends on COMPILE_TEST
    * Select REGMAP_MMIO
  - Make use of 'soc_device_attribute' and 'soc_device_match'
  - Use regmap mmio API instead of directly 'readl' and 'writel'.
  - Use 'platform_get_resource' instead of 'of_address_to_resource'.

Changes in v2:
  - Reorder patches to get bindings first in the series.
  - Don't use child nodes in the device tree. Use #phy-cells=1 instead.
  - Update driver code with new 'xlate' function for the new device tree.
  - Minor changes in driver's macros changing some spaces to tabs.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2020-November/148864.html

Sergio Paracuellos (4):
  dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
  phy: ralink: Add PHY driver for MT7621 PCIe PHY
  MAINTAINERS: add MT7621 PHY PCI maintainer
  staging: mt7621-pci-phy: remove driver from staging

 .../phy}/mediatek,mt7621-pci-phy.yaml         |   0
 MAINTAINERS                                   |   6 +
 drivers/phy/ralink/Kconfig                    |   8 ++
 drivers/phy/ralink/Makefile                   |   1 +
 .../ralink/phy-mt7621-pci.c}                  | 103 +++++++-----------
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/mt7621-pci-phy/Kconfig        |   8 --
 drivers/staging/mt7621-pci-phy/Makefile       |   2 -
 drivers/staging/mt7621-pci-phy/TODO           |   4 -
 10 files changed, 53 insertions(+), 82 deletions(-)
 rename {drivers/staging/mt7621-pci-phy => Documentation/devicetree/bindings/phy}/mediatek,mt7621-pci-phy.yaml (100%)
 rename drivers/{staging/mt7621-pci-phy/pci-mt7621-phy.c => phy/ralink/phy-mt7621-pci.c} (76%)
 delete mode 100644 drivers/staging/mt7621-pci-phy/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci-phy/Makefile
 delete mode 100644 drivers/staging/mt7621-pci-phy/TODO

-- 
2.25.1

