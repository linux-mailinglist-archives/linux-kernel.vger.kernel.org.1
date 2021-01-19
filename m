Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451272FB4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbhASI5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:57:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6161 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbhASI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:56:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60069ea70000>; Tue, 19 Jan 2021 00:56:07 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 08:56:04 +0000
Received: from jckuo-lt.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Jan 2021 08:56:01 +0000
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v6 04/15] phy: tegra: xusb: tegra210: Do not reset UPHY PLL
Date:   Tue, 19 Jan 2021 16:55:35 +0800
Message-ID: <20210119085546.725005-5-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119085546.725005-1-jckuo@nvidia.com>
References: <20210119085546.725005-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611046567; bh=fMWbCxXN66OVLrsG2zwzPXGHGUm0Z1aSKFkU6EI97W8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=OXgWlOYCw4Z8aMnl1uoD6xlI3VFrl8wFlnP5EgB/rAkdApXrP1ajT8mLbhQNV9ocf
         lcANcNDH0r7wecrQtJnl4OhvBqbwucf+HEhdx0j8P5IH5ikJnJig9VCYPTl4vnDZnD
         CMSnpVSSKO1j7HdwJGonePClfVpBmNJsrOZ0q1Eau/H45RpZ4DG6QT9KAzoUJtlfu7
         NstyrW2X1FV9zvkUyxZjSpEe2juvnLuZXps9kgJYnEZsnOjXmyTsTwZ3jxehkVXJli
         +lFd88iq1lpiSCoDT4u78fhzg9Ct9NnlStTCVeBCv9mXPBiZCtsuEbOiuSfJaNhaTK
         xW9lNz9Kal2fQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once UPHY PLL hardware power sequencer is enabled, do not assert
reset to PEX/SATA PLLs, otherwise UPHY PLL operation will be broken.
This commit removes reset_control_assert(pcie->rst) and
reset_control_assert(sata->rst) from PEX/SATA UPHY disable procedure.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
v6:
   no change
v5:
   no change
v4:
   no change
v3:
   new, was a part of "phy: tegra: xusb: Rearrange UPHY init on Tegra210"

 drivers/phy/tegra/xusb-tegra210.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index 4dc9286ec1b8..9bfecdfecf35 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -502,7 +502,6 @@ static void tegra210_pex_uphy_disable(struct tegra_xusb=
_padctl *padctl)
 	if (--pcie->enable > 0)
 		return;
=20
-	reset_control_assert(pcie->rst);
 	clk_disable_unprepare(pcie->pll);
 }
=20
@@ -739,7 +738,6 @@ static void tegra210_sata_uphy_disable(struct tegra_xus=
b_padctl *padctl)
 	if (--sata->enable > 0)
 		return;
=20
-	reset_control_assert(sata->rst);
 	clk_disable_unprepare(sata->pll);
 }
=20
--=20
2.25.1

