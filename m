Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84126D959
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIQKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgIQKmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:42:23 -0400
Received: from mail.kernel.org (ip5f5ad5d2.dynamic.kabel-deutschland.de [95.90.213.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F366021974;
        Thu, 17 Sep 2020 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600339342;
        bh=9k9zMYoo7wLOALaUaUO6kuKmP2XcikxIb3HqIINf7VU=;
        h=From:To:Cc:Subject:Date:From;
        b=EPQGk1AIsg3Z+pONCVNoO3iIhe2T4DJKru8TzuTb3Co84VOHkjZEJXzucW8M+Mn9d
         U7ciA6959RmEk6fLE+x9AHEOlh7NFu32eO1smz8ctXlb8JCmP5hEjtF4ZeLTc8p+ej
         AfHtKHfAAm7e08Js6/NWjwlW2g5X+/zJsDSUcTrI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kIrMp-005WZQ-J9; Thu, 17 Sep 2020 12:42:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] Add a staging driver for Hikey 970 PHY laywer
Date:   Thu, 17 Sep 2020 12:42:04 +0200
Message-Id: <cover.1600338981.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This series add the phy layer needed for the USB stack to work
on Hikey 970. 

The main difference against v3 is that I'm sending this one via
staging.

In order for this phy to actually work properly, we still need to
apply one quirk patch at dwc3, which fixes some issues with
USB HID driver. 

I'm working with Felipe and Rob in order to add the quirk on
an approach that would be acceptable for both DT and dwc3
maintainers.

Due to that, I'm not sending the final patch that adds the
the needed dt bindings for this board. 

Thanks!
Mauro

Mauro Carvalho Chehab (6):
  staging: hikey9xx: add build for the Kirin 970 PHY driver
  staging: hikey9xx: phy-hi3670-usb3: use a consistent namespace
  staging: hikey9xx: phy-hi3670-usb3.txt: use a consistent namespace
  staging: hikey9xx: phy-hi3670-usb3: fix coding style
  staging: hikey9xx: phy-hi3670-usb3: change some DT properties
  staging: hikey9xx: convert phy-kirin970-usb3.txt to yaml

Yu Chen (2):
  staging: hikey9xx: add USB physical layer for Kirin 3670
  staging: hikey9xx: phy-hi3670-usb3: fix some issues at the init code

 drivers/staging/hikey9xx/Kconfig              |  11 +
 drivers/staging/hikey9xx/Makefile             |   2 +
 drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 671 ++++++++++++++++++
 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 ++
 4 files changed, 756 insertions(+)
 create mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
 create mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml

-- 
2.26.2


