Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF292E9173
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhADIJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:09:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56992 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbhADIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:09:10 -0500
X-UUID: 59ac8a1e283b4a18babd3db1594273c4-20210104
X-UUID: 59ac8a1e283b4a18babd3db1594273c4-20210104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 819731398; Mon, 04 Jan 2021 16:08:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Jan 2021 16:08:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 16:08:26 +0800
From:   Argus Lin <argus.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, <agx@sigxcpu.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        <argus.lin@mediatek.com>, <wsd_upstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/2] arm64: Support pwrap on MediaTek MT6779 platform
Date:   Mon, 4 Jan 2021 16:08:21 +0800
Message-ID: <1609747703-27207-1-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pwrap on Mediatek MT6779 platform.

change since v1:
  - adds pwrap node at mt6779.dtsi
  - set CONFIG_MTK_PMIC_WRAP at defconfig

Argus Lin (2):
  arm64: dts: mt6779: Support pwrap on MT6779 platform
  arm64: configs: Support pwrap on MT6779 platform

 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 9 +++++++++
 arch/arm64/configs/defconfig             | 1 +
 2 files changed, 10 insertions(+)

--
1.8.1.1.dirty

