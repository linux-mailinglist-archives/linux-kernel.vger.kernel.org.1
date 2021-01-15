Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCEE2F780F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbhAOLyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbhAOLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 335FE23730;
        Fri, 15 Jan 2021 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610711642;
        bh=vfu1OjshkGKWmIWdZW1iqNrjjZhuMQiQnXFARLVMfZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T20nFi/T2VFZFQPhvSd7v6X8B4RQr1Ay9Hra0xCsTjsugZRGTDiwxQqNG9nPtOuRb
         dNCHtbGATs5nYhak9X2X/ZsQEMf+x9R31lNwcB3/wH2FM9I/yFG7EtWQUDyjxAFh3b
         eE4PbRbwGzUmNhucWz/rfy4Lt25kcIWxW69rYTT90l15rOkrw6mrVOCoCFxSgX9N0M
         IyeTSXTe0bShSPIZCZaUBNyh3Vt52PbMtaCsgooU5uzYLfmR4NWiOziwpGAJ4UJXzQ
         t2Iw4960M6gLj8TWGmkb91fFJENgTAhLi6PHxaeaKfg5CBDwUC3J+qqN/phHMoXgmS
         tU2Pb43h2l2VQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l0Nfz-00FzCD-P3; Fri, 15 Jan 2021 12:53:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: hisilicon: hi3670.dtsi: add iomcu_rst
Date:   Fri, 15 Jan 2021 12:53:56 +0100
Message-Id: <5762e4fa293bf0b807d039dd979d6af2a2f5fa38.1610710288.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610710288.git.mchehab+huawei@kernel.org>
References: <cover.1610710288.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required in order to support USB.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 2dcffa3ed218..4e73c4614a71 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -194,6 +194,12 @@ media2_crg: media2_crgctrl@e8900000 {
 			#clock-cells = <1>;
 		};
 
+		iomcu_rst: reset {
+			compatible = "hisilicon,hi3660-reset";
+			hisi,rst-syscon = <&iomcu>;
+			#reset-cells = <2>;
+		};
+
 		uart0: serial@fdf02000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf02000 0x0 0x1000>;
-- 
2.29.2

