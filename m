Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3F2F7817
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbhAOLyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbhAOLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3723823877;
        Fri, 15 Jan 2021 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610711642;
        bh=DmAtmPatw2EY8p2iSFBHPlHoDcRywFbV5L9riDHjlwI=;
        h=From:To:Cc:Subject:Date:From;
        b=BonyO8NkmRWZvGcQ5r6dL+IcN6xEZQ7N+gXYKeHIp//LF8jAOMF3F84I42LtbQ+T7
         /2VgvA2ICf6/uySCT9K3TozEPNNB4jbSytQMA7vfJB5J+gg4lwXlIdOQoxIH4mTvrz
         wWtZJ41cWsAxcxx5S2xMDfBzjOeB1bOZ2X7iw9tbzUabW75suxdH4NzcQlim4F1cHd
         ivD+X0t0rvt70Xpsev96LBScXh0BaCS1VRp4Nya1o1dVopNJ/Z86GqkCRG+E0s5rbF
         cvjOLBQEW3yxJ6qz8BAFor8f27FvSAr26S37ZEvpUoY6pAo+HzwVF+Z0bOPIixFvs+
         bjSu200hTuQAA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l0Nfz-00FzCB-OF; Fri, 15 Jan 2021 12:53:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Added some missing DT settings for Hikey 970
Date:   Fri, 15 Jan 2021 12:53:55 +0100
Message-Id: <cover.1610710288.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hikey 970 device tree has a few missing pieces that are required
in order for it to be able to support USB and DRM drivers upstream.

Besides PM, USB and DRM specific bits, the hardware's binding
for I2C buses and pinctrl are missing.

Those DT bindings come from the official Linaro Hikey 970 tree:

	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9

Changed in order to apply cleanly upstream.

PS.: The changes from this series were submitted initially on this
patch series:
	Move Hikey 970 USB support out of staging and add DT
	https://lore.kernel.org/lkml/cover.1605530560.git.mchehab+huawei@kernel.org/

I'm opting to split such series into separate patch series, in order to 
make easier for review and upstream merge, as the original series
was mixing patches for different subsystems.

Mauro Carvalho Chehab (3):
  arm64: dts: hisilicon: hi3670.dtsi: add iomcu_rst
  arm64: dts: hikey970-pinctrl.dtsi: add missing pinctrl settings
  arm64: dts: hisilicon: hi3670.dtsi: add I2C settings

 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  77 +++
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 548 +++++++++++++++++-
 2 files changed, 614 insertions(+), 11 deletions(-)

-- 
2.29.2


