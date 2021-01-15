Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8D2F740C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbhAOIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbhAOIKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:10:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65C1E2220B;
        Fri, 15 Jan 2021 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610698207;
        bh=Z9dS/80D2fD858tSFphEqa2lTdKTrmr1/55HyD81OWc=;
        h=From:To:Cc:Subject:Date:From;
        b=eXesUTbVzYxLZtqpJiYnWOnuPpmLllRVdiTHHx47tcv78kOhzQeutBhPW6i9uh+9q
         BbuvEokN3oP93Y+frTX0Z6lp87vvvtGyWuisL2WnOKZqBSGyua7bQdPlEKWldVfxkd
         1pp6gCkjP5dGIN0POp4G0kfpIh2pBpr8syjNC+xlPKy2aJOf6GtUNQPz8XQWqZ6hbG
         UvxSJx4HgyF40KlRKbBsFuFrmK/Gte8CrRQ5W0HN5iaMRNWkOUZ/QFb7dvXUr3Q8Q/
         EDq+h1qznfxJ4D5LBO9RKVo0DWV/deGurd0jnA0JWRmDca9jdWj3GsZ/T4xVi2A2cz
         NFKnelBbU2MmQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l0KBI-00FiGG-Tb; Fri, 15 Jan 2021 09:10:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Promote Hikey 970 USB phy out of staging
Date:   Fri, 15 Jan 2021 09:09:59 +0100
Message-Id: <cover.1610697726.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod/Rob,

This series moves  the Hikey 970 USB PHY driver out of staging.

The 3 initial patches address the issues pointed by Vinod:

patch 1 change the logic to use GENMASK and FIELD_GET/FIELD_PREP macros.
It also places all hexadecimal values in lowercase;

patch 2 add a delay inside the retry logic;

patch 3 changes a function to return a boolean.

The 4th patch is actually identical to the patch I sent previously:
it just moves the driver to drivers/phy and add a blank line at the
yaml driver:

 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (99%)
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)

In order to make this series easier to review, I'm submitting it with
--no-merges. This way, you can check the  driver and DT bindings
as a hole while reviewing the last patch.

-

v3: 
- no changes on patches 1-2 nor at phy-hi3670-usb3.c;
- yaml renamed to: hisilicon,hi3670-usb3.yaml 
- Added a blank line after maintainers at hisilicon,hi3670-usb3.yaml 

Mauro Carvalho Chehab (4):
  staging: hikey9xx: phy-hi3670-usb3.c: use bitfield macros
  staging: hikey9xx: phy-hi3670-usb3.c: adjust retry logic
  staging: hikey9xx: phy-hi3670-usb3.c: hi3670_is_abbclk_seleted()
    returns bool
  phy: phy-hi3670-usb3: move driver from staging into phy

 .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 +++++++++++++++++
 drivers/staging/hikey9xx/Kconfig              |  11 -
 drivers/staging/hikey9xx/Makefile             |   2 -
 drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 671 ------------------
 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
 9 files changed, 759 insertions(+), 757 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
 delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
 delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml

-- 
2.29.2


