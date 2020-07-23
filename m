Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28722B884
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 23:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGWVSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 17:18:54 -0400
Received: from hera.iit.uni-miskolc.hu ([193.6.5.4]:57804 "EHLO
        hera.iit.uni-miskolc.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWVSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:18:40 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 17:18:39 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 2A340A0D;
        Thu, 23 Jul 2020 23:10:19 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zQyqtF7SqN2D; Thu, 23 Jul 2020 23:10:12 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:908:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id 635A1A0B;
        Thu, 23 Jul 2020 23:10:11 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        JC Kuo <jckuo@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH v2 0/4] arm64: tegra: Xavier SDMMC changes
Date:   Thu, 23 Jul 2020 23:09:28 +0200
Message-Id: <20200723210932.8076-1-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out uSD card detection on the Jetson AGX Xavier is not working and
I/Os are limited to 3.3 V. SDIO is supported but not enabled. Also, the
on-board eMMC module is using HS200 only.

Changes in v2:
- fix board name in commit messages
- rebase on for-next

Kind regards,
Tamas


Tamás Szűcs (4):
  arm64: tegra: Enable signal voltage switching on Tegra194 SDMMC1 and
    SDMMC3
  arm64: tegra: Fix CD on Jetson AGX Xavier SDMMC1
  arm64: tegra: Configure SDIO cards on Jetson AGX Xavier SDMMC1
  arm64: tegra: Enable HS400 on Tegra194 SDMMC4

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 46 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.20.1

