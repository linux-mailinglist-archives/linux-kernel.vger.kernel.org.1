Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133D1C0488
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgD3SRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgD3SRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:17:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238FC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:17:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d3so3156357pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4e5cFjiNfDap07a6Nfxpdl1UXdqOkxC++rr9/Mc9BPc=;
        b=dmGY2UxEwcZyt7nI6u+U0VG13V/t96oiOFdoFGSDon+/un/GuNmXc2KuVJK2BxDNWu
         NeZsQMDtHTLrDWONVOuXyZLiLi+5tBTDJr4eS4zxAs/ADkPYAhLYEsooIhz8My8ARUDQ
         kwpMRGavs4TMkxiYSgnpAqyXIicxgnREO9NcYTJp4CkFwpJAjdEy9X+gMQxybJUVgCg0
         I7uiE007yjKZ41fGk9Xw0vN7lLnB1MTDOFLH0h0TQysitJvEUWFhvUxuIbaAhgEHggen
         YsAGCsTNyELi4I2lURjo0NNQ2WnprWWI/yi++tNaKg7ZB6BvQxBYIrtuqSBpp7uvyujV
         a8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4e5cFjiNfDap07a6Nfxpdl1UXdqOkxC++rr9/Mc9BPc=;
        b=L2XhiyJ0F+Kw3VUj5B+UHoEWE7+W603kBKatnCQnd0li+cCNuYYTng2Tafxyf+V3N5
         3mSq9XpJf4VL4WjM5E43uXS61dEoIo4ktPEM9Ff1FlfAruBjKJ2iFZQJMPbTDLEwYrYY
         iwtLW49WdXKwNPmrCWvGHZFEOu/RKYF9p6+zRFci/cVdPsikj+ZvUCsbY/G1xouallub
         Nupf9vE7VO0oSFygPbDdYGixc+TKX85D6WWuCpJLXJH9rsJvTfwSqOlcQ+B/79fk7Sfy
         NV8iX+RiHxs+mfFznYkpTnbiCz5YOmKu1JKYPbolGTmARsn91Z/UcXCuSq53OgTx03sB
         YAag==
X-Gm-Message-State: AGi0PuY/mWUTxjuFVwJrMqE0TS4YwGVXGaoI8x2JwN5zcYlsbSrgh1X5
        07Geid5kdwCtGmlPN3WuS+2i7A==
X-Google-Smtp-Source: APiQypLYMpMYYbyXzJla8VvbIOxLhP2i6vpkoVDgCiLbpmpBmrE/HRcq00kHnwAD9Tex0mJyb+jKvg==
X-Received: by 2002:a63:6f07:: with SMTP id k7mr219742pgc.274.1588270672604;
        Thu, 30 Apr 2020 11:17:52 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 14sm415735pfy.38.2020.04.30.11.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:17:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8250: Add TLMM pinctrl node
Date:   Thu, 30 Apr 2020 11:17:16 -0700
Message-Id: <20200430181716.3797842-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TLMM pinctrl node for SM8250 and reserve pins 28-31 and 40-43 on
the MTP as firmware does not allow Linux to touch these pins.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 2adb01ea276c..0c6b936be471 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -348,6 +348,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <28 4>, <40 4>;
+};
+
 &uart2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7050adba7995..9867b0da9d8e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -491,6 +491,21 @@ tcsr_mutex_regs: syscon@1f40000 {
 			reg = <0x0 0x01f40000 0x0 0x40000>;
 		};
 
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,sm8250-pinctrl";
+			reg = <0 0x0f100000 0 0x300000>,
+			      <0 0x0f500000 0 0x300000>,
+			      <0 0x0f900000 0 0x300000>;
+			reg-names = "west", "south", "north";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 180>;
+			wakeup-parent = <&pdc>;
+		};
+
 		timer@17c20000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.24.0

