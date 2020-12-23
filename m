Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2932A2E1A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgLWIpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:45:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727647AbgLWIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:45:45 -0500
X-UUID: 35eaa4650bfa465787ff4bcd3c5bd573-20201223
X-UUID: 35eaa4650bfa465787ff4bcd3c5bd573-20201223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1444448160; Wed, 23 Dec 2020 16:45:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 16:44:59 +0800
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
Subject: [PATCH v1 0/2] arm64: Support devapc on MediaTek MT6779 platform
Date:   Wed, 23 Dec 2020 16:44:50 +0800
Message-ID: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E55EF3BCC1D3543E29E3A994920BF510B092B2B41B1AD44441134DE25061BF842000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds DEVAPC (Device Access Permission Control) support on MediaTek MT6779 SoC platform.

*** BLURB HERE ***

Neal Liu (2):
  arm64: dts: mt6779: Support devapc
  arm64: configs: Support DEVAPC on MediaTek platforms

 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 8 ++++++++
 arch/arm64/configs/defconfig             | 1 +
 2 files changed, 9 insertions(+)

-- 
2.18.0

