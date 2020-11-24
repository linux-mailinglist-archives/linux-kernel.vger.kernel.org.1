Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825952C20A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgKXJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:01:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33110 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730964AbgKXJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:01:43 -0500
X-UUID: eceba556bef9470e9d8f6b70d4e99da8-20201124
X-UUID: eceba556bef9470e9d8f6b70d4e99da8-20201124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1652008574; Tue, 24 Nov 2020 17:01:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 Nov 2020 17:01:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 24 Nov 2020 17:01:39 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Date:   Tue, 24 Nov 2020 17:01:31 +0800
Message-ID: <20201124090131.27257-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lecopzer Chen" <lecopzer.chen@mediatek.com>

Although most of modern devices use ACPI, there still has combination
of APM + ARM64.

In order to select CONFIG_APM_EMULATION, make SYS_SUPPORTS_APM_EMULATION
default is y if ACPI isn't configured.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Suggested-by: YJ Chiang <yj.chiang@mediatek.com>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..5e9e3694015a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -260,6 +260,9 @@ config NO_IOPORT_MAP
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config SYS_SUPPORTS_APM_EMULATION
+	def_bool y if !ACPI
+
 config ILLEGAL_POINTER_VALUE
 	hex
 	default 0xdead000000000000
-- 
2.18.0

