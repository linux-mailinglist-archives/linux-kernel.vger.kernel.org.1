Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6152F67E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbhANRgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbhANRg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:36:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0964D23B40;
        Thu, 14 Jan 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645748;
        bh=SJ+Kx1oHPeloSq393jp+F5VoiD47GhOjY7z0REOmWa4=;
        h=From:To:Cc:Subject:Date:From;
        b=n5S3nxUwMeDXNo08BPrAnbBwUqwobPon4gfUoRurFSjFV2B6t0Nm0Jqb+8zOjnjSG
         8K3kAVkLr+06MF5HCBcGvs18cPZx1WGzm7ZF0eECF28YRz2KA5Apez37nx0slSdksL
         uEMJBi+mB12vx7WxxvE0gQm/hOKv7dmUC0mNvtraq4wMPpa00kTpGwaOH0LmCYtG0H
         Lo/sfUIfoD+vT1KoL0FhQiqXppa/D783co3IMefVrL1hbzvY5fgGwXPP79T9yOdCpR
         QxenEQX+at+AVrVjFVPqpEvK3Ff5YZMGjcxzMMz9zTz2XGNmHfKvAsH0gibd6D96Ld
         XL4Q0+//hMVgw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l06XB-00FQtr-F7; Thu, 14 Jan 2021 18:35:45 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Promote Hikey 970 USB phy out of staging
Date:   Thu, 14 Jan 2021 18:35:40 +0100
Message-Id: <cover.1610645385.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

This series contain just the PHY patch I sent in Nov, 30 from this series:      

        Move Hikey 970 USB support out of staging and add DT

The 3 initial patches address the issues you pointed during your
review:

patch 1 change the logic to use GENMASK and FIELD_GET/FIELD_PREP macros.
It also places all hexadecimal values in lowercase;

patch 2 add a delay inside the retry logic;

patch 3 changes a function to return a boolean.

The 4th patch is actually identical to the patch I sent previously:
it just moves the driver to drivers/phy:
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/phy}/phy-hi3670-usb3.yaml (100%)
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)

Yet, in order to make this series easier to review, I'm submitting it with
--no-merges. This way, you can check the  driver as a hole while reviewing
the last patch.

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


