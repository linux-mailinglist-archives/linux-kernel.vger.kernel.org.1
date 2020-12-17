Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8D2DCEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLQJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgLQJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:45:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3CFC061794;
        Thu, 17 Dec 2020 01:44:48 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a12so55748344lfl.6;
        Thu, 17 Dec 2020 01:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49R7Nns8UoMP9HsytHse60/QY97t97BAUh7L1c4ruI8=;
        b=pIUh3ys2X3Y2Y5mEsoy74nwUq4ANNjgtMacjyxPMO36VYUHX6mQ0/Yk9D+gLo+9Fa0
         I6OD6c7aMPStv52wBeeL0pL5oX08UIKjs0i68rd2u231WALi5cg+/nlQj6swLTyZ8kJO
         qQ/CmhPmAJUBcvq+Df4mH9ZmNjUc7jl0Sxb+T7FO7mmhN8siDabUFQo4+sqy898q07Du
         JuA4lxkbeL+eLVBIelHyEanXMFPfoWQaLAehDuuMeIp+8INmWyPBlzFw8/zb21eLGlsh
         mbKtKs2XcZhHq9YjEVG0c3mhJOJXfuF+rWdoHe7t3HVZxa7QUjjZljjHNqBbEmY/TwDl
         ZrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49R7Nns8UoMP9HsytHse60/QY97t97BAUh7L1c4ruI8=;
        b=uNLalq/Admd/bOFZkVz2Ys88c6Sf5sQkV9Va7MfyP72UOPcA+T28IFh3pH/1SVggLH
         YgFF8VbMMvnNQKUMQeSqAPD1oySBVXgffOS3Kqkm0aGG28OEbvafApQdfsCkSvt8Tm+A
         V2SxlvZgeakpx0UOUl74LpSdENfCd1SbHqw65K49SCKq1TnYt87B0/umBe0CXGu1Xnub
         Z3oCqwmZ/lx6kiZBO1Y3S0FPHAijlRNbxVTagGUmOzZ0vOsDvkm4o2i5V11p1kt+kUtP
         0uA2B8+IWgbqn2g7pIfRw5LW7xFDx09cZg2FpECt9zypt7vqfbkwrg2+rrJPfpBwS2Vg
         Huew==
X-Gm-Message-State: AOAM531C1n8ubSjWIg4kKe3H8hDGJXhRvOyMJEY/vgR3vuU/ImO39zFo
        BciTkA03wCmrH/nOhLQ1tZU=
X-Google-Smtp-Source: ABdhPJz+IYSh/nDYcKK2JYFG48lY6v7Y5jWQQF/8jlkWePyqrR0XyGtBlvr97eHHkoiQVc/5YW2Thw==
X-Received: by 2002:ac2:46e4:: with SMTP id q4mr13924793lfo.413.1608198286791;
        Thu, 17 Dec 2020 01:44:46 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id u19sm613917lji.2.2020.12.17.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 01:44:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Ion Agorria <ion@agorria.com>
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Support Runtime PM and host mode by Tegra ChipIdea USB driver
Date:   Thu, 17 Dec 2020 12:39:59 +0300
Message-Id: <20201217094007.19336-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements Runtime PM support for the Tegra ChipIdea USB driver.
It also squashes the older ehci-tegra driver into the ChipIdea driver, hence
the RPM is supported by both UDC and host controllers, secondly this opens
opportunity for implementing OTG support in the future.

Patchset was tested on various Tegra20, Tegra30 and Tegra124 devices.
Thanks to Peter Geis, Matt Merhar, Nicolas Chauvet and Ion Agorria for
helping with the extensive and productive testing!

Changelog:

v2: - Improved comments in the code as it was suggested by Peter Chen and
      Sergei Shtylyov for v1.

    - Replaced mdelay() with fsleep() and made ci->hdc to reset to NULL in
      a error code path, like it was suggested by Peter Chen.

    - Redirected deprecated USB_EHCI_TEGRA Kconfig entry to USB_CHIPIDEA_TEGRA
      as was suggested by Alan Stern.

    - Improved commit message and added ACK from Thierry Reding to the patch
      that removes MODULE_ALIAS.

    - Fixed UDC PHY waking up on ASUS TF201 tablet device by utilizing
      additional VBUS sensor. This was reported and tested by Ion Agorria.

    - Added t-b from Ion Agorria.

Dmitry Osipenko (7):
  usb: phy: tegra: Add delay after power up
  usb: phy: tegra: Support waking up from a low power mode
  usb: chipidea: tegra: Remove MODULE_ALIAS
  usb: chipidea: tegra: Rename UDC to USB
  usb: chipidea: tegra: Support runtime PM
  usb: host: ehci-tegra: Remove the driver
  ARM: tegra_defconfig: Enable USB_CHIPIDEA and remove USB_EHCI_TEGRA

Peter Geis (1):
  usb: chipidea: tegra: Support host mode

 arch/arm/configs/tegra_defconfig     |   3 +-
 drivers/usb/chipidea/Kconfig         |   3 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c | 327 +++++++++++++--
 drivers/usb/chipidea/core.c          |  10 +-
 drivers/usb/chipidea/host.c          | 104 ++++-
 drivers/usb/host/Kconfig             |   8 +-
 drivers/usb/host/Makefile            |   1 -
 drivers/usb/host/ehci-tegra.c        | 604 ---------------------------
 drivers/usb/phy/phy-tegra-usb.c      |  97 ++++-
 include/linux/usb/chipidea.h         |   6 +
 include/linux/usb/tegra_usb_phy.h    |   2 +
 11 files changed, 503 insertions(+), 662 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-tegra.c

-- 
2.29.2

