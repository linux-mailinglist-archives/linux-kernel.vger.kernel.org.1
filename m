Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1421D7724
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgERLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERLcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:32:14 -0400
Received: from ziggy.de (unknown [213.195.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003E220842;
        Mon, 18 May 2020 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589801533;
        bh=hRLEeBysdZ6kFgUDeK0lA09a2o6jYmHQePruxEGS3qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDbdd/TVoB29vYhR7SyvYdqoXqfsSo2Dhjv1/4o2cftfqpn5Xaa3rgIATVBpxnbOm
         2wWJehgaWj6C7SD9IMWELUnHRGQLjb0eA7KD3DxJR5IAeRhGY37WNwjGdPZcqxTJrf
         jB4XfDFEeYVyy06Uiyw6gx9eNly0gV+QEs0P36Ys=
From:   matthias.bgg@kernel.org
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     mtk01761 <wendell.lin@mediatek.com>, devicetree@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] arm64: dts: mt6797: Fix mmsys node name
Date:   Mon, 18 May 2020 13:31:56 +0200
Message-Id: <20200518113156.25009-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518113156.25009-1-matthias.bgg@kernel.org>
References: <20200518113156.25009-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Node names are supposed to match the class of the device. The
mmsys node is a syscon as it provides more then just a clock controller.
Update the name.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 136ef9527a0d..3efd032481ce 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -233,7 +233,7 @@ uart3: serial@11005000 {
 		status = "disabled";
 	};
 
-	mmsys: mmsys_config@14000000 {
+	mmsys: syscon@14000000 {
 		compatible = "mediatek,mt6797-mmsys", "syscon";
 		reg = <0 0x14000000 0 0x1000>;
 		#clock-cells = <1>;
-- 
2.26.2

