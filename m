Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0155720439B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgFVW1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbgFVW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D02C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n5so14610327otj.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3ZFx1cfGWfklPrTeX40d9zi2JN5zxamR5nNhJdd1zY=;
        b=lenyekESd+AuK62A5GNcrVp+7OjlGZmtfudQp34AKbhG8XSyh8/muGNxC0Ltki6FxD
         /HDcSkmd4dEEBZa+TVdBJ3HzhcddDAiXVcLdYcJL+haUWvuY/All2cguRXZD04TjUb0r
         kYaNn+hMEr/CGTycCjTQNMfR6sRKwuzllKA7aCoOcX3b3fe+t/2PdAakDXy2qcKylUAF
         E1Vq5HTTED9bbRug6VX4C6GQS4HnIvZrAJ3EkhciFXqeiHfDSs0p2Qg3BP9f5fa40vFd
         cHID1Q5qLataqK9Jv5I3Fmidasvfhevjh5RIRaG7lRPUELD03tp0uo3Q14YerGJ0k2ZG
         1s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3ZFx1cfGWfklPrTeX40d9zi2JN5zxamR5nNhJdd1zY=;
        b=HhL+1LAq0lzOCByCEv7w8r8Myut65ExOGITlXtJ2mrzTAp1ELj+WJYqXkcF+b3AsZp
         bxV4kN3PH5iLDE+PfduC2QtOehu0BlJlzIhtXAZ6zV7bjb9ktu4VHtFLifEK+ehWEIFB
         RTrdbTAtTKAQnkyg6CQf4WhnDyMarStLoUHAWCrfA4vdm92UJucipzaOslPfx2A+/QDj
         q0dYlJqgKAEmGEGu5BeZiVZQbyCelPnq1dXeI9vhJB264SrCPqOfnavoN06i/YTUuoDK
         AfcxBMDUzMcYZstBs/uuAYMJDP0gOqRfaY5i3DJIY0ZJtWKeHU8MaiLZK7hqRIFgfnbU
         L66w==
X-Gm-Message-State: AOAM532CxxJMYZVz5Vl/f/6FdBp3PVFiLfuJtuI2+NS9+tExkWG/ao0L
        l33SeiIYghEJYdza2vVy0ZxQiw==
X-Google-Smtp-Source: ABdhPJwkU2JG/VrosT1dEkPudQ2bGBO7dvIDqhuNzL5d1V1W+B916h0xOJP0969Km4tIoz1LB/Z4Mw==
X-Received: by 2002:a05:6830:2089:: with SMTP id y9mr16718014otq.308.1592864859777;
        Mon, 22 Jun 2020 15:27:39 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h36sm3589304oth.37.2020.06.22.15.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:39 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] arm64: dts: qcom: sm8250: Add IPCC
Date:   Mon, 22 Jun 2020 15:27:43 -0700
Message-Id: <20200622222747.717306-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the IPCC node, used to send and receive IPC signals with
remoteprocs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e583a01cbcf1..74a7ca96177e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-sm8250.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -329,6 +330,15 @@ gcc: clock-controller@100000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
 		};
 
+		ipcc: interrupt-controller@408000 {
+			compatible = "qcom,sm8250-ipcc", "qcom,ipcc";
+			reg = <0 0x00408000 0 0x1000>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#mbox-cells = <2>;
+		};
+
 		qupv3_id_2: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
-- 
2.26.2

