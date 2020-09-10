Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35F263CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 07:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIJFyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 01:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgIJFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:52:47 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D8920B1F;
        Thu, 10 Sep 2020 05:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599717166;
        bh=cPpGIaPhlkZ9mhUTZGuqUk5ZYn/m7WTcl+uGX4hsYYk=;
        h=From:To:Cc:Subject:Date:From;
        b=X7VlLZFvuaXg+r/uKOE563Jo6oEbIu4KoWXNloJIa7xv3ZIVyoaphepMbsNIVFfJD
         mDiHZgCBbUwaXawjTyF2FTLMD9HdCIhh2FPt3+VyMWUm8fP7xmvaRPRA+fgeEH520n
         vnoFmT4qmaDcbIV0ICEh68f08d6ST5yDXeY4rK3g=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGFVj-00E1Ye-Jr; Thu, 10 Sep 2020 07:52:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Add PHY USB3 drivers for Hikey 970
Date:   Thu, 10 Sep 2020 07:52:33 +0200
Message-Id: <cover.1599716786.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the PHY layer needed in order to support the USB
functionality on Hikey 970 boards.

v3:
- split a namespace patch on two (one with code changes and another
  one with dt-bindings changes);
- placed just the PHY driver on this series. Another series will add the
  USB HUB driver and the DTS changes required to enable USB support
  for this board.

Mauro Carvalho Chehab (6):
  phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
  dts: phy: phy-hi3670-usb3.txt: use a consistent namespace
  phy: hisilicon: phy-hi3670-usb3: fix coding style
  phy: hisilicon: phy-hi3670-usb3: change some DT properties
  dt-bindings: phy: convert phy-kirin970-usb3.txt to yaml
  MAINTAINERS: add myself as maintainer for Kirin 970 USB PHY

Yu Chen (2):
  phy: hisilicon: add USB physical layer for Kirin 3670
  phy: hisilicon: phy-hi3670-usb3: fix some issues at the init code

 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
 5 files changed, 762 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c

-- 
2.26.2


