Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ADE2E1A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgLWIpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:45:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42513 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727168AbgLWIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:45:45 -0500
X-UUID: 19db865d8b104c1f97074ab65c70836d-20201223
X-UUID: 19db865d8b104c1f97074ab65c70836d-20201223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 86269457; Wed, 23 Dec 2020 16:45:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 16:44:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 16:44:59 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hanks Chen <Hanks.Chen@mediatek.com>,
        Jackson-kt Chang <Jackson-kt.Chang@mediatek.com>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v1 2/2] arm64: configs: Support DEVAPC on MediaTek platforms
Date:   Wed, 23 Dec 2020 16:44:52 +0800
Message-ID: <1608713092-26952-3-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
References: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B3CE75607B5BE7C66F125DCA8B8924F0596D453F48C50A29BFD93D2914F3AF312000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support DEVAPC on MediaTek platforms by enabling CONFIG_MTK_DEVAPC.

Signed-off-by: Neal Liu <neal.liu@mediatek.com>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17a2df6..a373776 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -257,6 +257,7 @@ CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_MTK_DEVAPC=m
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
-- 
1.7.9.5

