Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202032FCBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbhATHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:36:38 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11331 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbhATHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:35:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6007dd1e0000>; Tue, 19 Jan 2021 23:34:54 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 07:34:52 +0000
Received: from jckuo-lt.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 20 Jan 2021 07:34:49 +0000
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <linux-clk@vger.kernel.org>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v7 08/14] arm64: tegra210: XUSB PADCTL add "nvidia,pmc" prop
Date:   Wed, 20 Jan 2021 15:34:08 +0800
Message-ID: <20210120073414.69208-9-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120073414.69208-1-jckuo@nvidia.com>
References: <20210120073414.69208-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611128094; bh=J2eYGF7nlgtvx95eMxVK0qjetUmu2BeX6StqIpez1Co=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=IH62ZCRFqEJAWRAbCH0CrgIVZXsS28J8/ZOLAnPGV4khnh46dRPFLeJe0Y3rIQsZj
         ns0E6OBda5c7K0xv0N7pTfD+0aqcEoOkc3nNh0FqvQ4+iATwYVvcZWbRZyzxpbFdO3
         ybWXsfhjd7y5kgJO0CnmdVUTZje4u9SwvlDnTGd8bhCa6MetmixzhBQEyZU3zm1lYZ
         2MSYHPcuEXUARWv24FJhnNjw6inTv/Q2b7mRGEeXnNWiGotB6SYQUxy72ENIzVOL3R
         i0ZfiN+Kh09KKLCcJ0Rb6hkoj/UAQpecEgoVDyifpU4BoEpp/m5MppyNKr5k6fgz3z
         AY9cA9T/R6rSg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMC driver provides USB sleepwalk registers access to XUSB PADCTL
driver. This commit adds a "nvidia,pmc" property which points to
PMC node to XUSB PADCTL device node.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
v7:
   no change
v6:
   no change
v5:
   no change
v4:
   no change
v3:
   no change

 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra210.dtsi
index 4fbf8c15b0a1..83f6d11c578b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1043,6 +1043,7 @@ padctl: padctl@7009f000 {
 		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 		resets =3D <&tegra_car 142>;
 		reset-names =3D "padctl";
+		nvidia,pmc =3D  <&tegra_pmc>;
=20
 		status =3D "disabled";
=20
--=20
2.25.1

