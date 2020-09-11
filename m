Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A82667A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgIKRq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgIKMQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:16:53 -0400
Received: from mail.kernel.org (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D33221F1;
        Fri, 11 Sep 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826608;
        bh=nqPEIxhJ0CUB3B7N7XL2HG4yzGnwWiswA1e/1ulRWQI=;
        h=From:To:Cc:Subject:Date:From;
        b=aON9SDNkMYpO4VaSkPeRCfHgFt+jy/4FC7NeFl0q5OOw27wTixJtpDa/TZfVDV3cO
         YpNe/ZwK6SPwz/8zKQk2rh37JPHRY/RWsNxcXCRXDBMKS6gdO+CYMNb6vhkQTYm5v5
         rxiirhv1HrlYTUm30AaYTLEGKXmbKBpTkIIXf4v4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGhyv-0006W9-RE; Fri, 11 Sep 2020 14:16:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Subject: [PATCH v3 RESEND 0/8] Add PHY USB3 drivers for Hikey 970
Date:   Fri, 11 Sep 2020 14:16:36 +0200
Message-Id: <cover.1599826421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

PS.: I'm re-sending it, as the c/c list was wrong on the first mailbomb,
due to a bug on my script that were adding e-mails from
get_maintainer.pl.

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


