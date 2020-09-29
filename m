Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7912627D96A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgI2U63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgI2U62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:58:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD3C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so5905036pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4pRwrvNXyMRKIj9Fn/DgUQAH01RghXCWFYfTsOnjfa0=;
        b=m1eMpufPj/wvw2y0C8EJgG7faz2tbNqy8g3quGstXJNn4YZBkAkxzlmtpCsr3mPiMP
         CJ0o8U6mp9TXKpMO1zEROBhhNibzP4K1Gne5dJZhK4LMdPdFIFaCwm4FfiVA3SJVVY7D
         EEIQpQkJiFn5dY2jcLHcEDXaJSrfqYHrfniwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4pRwrvNXyMRKIj9Fn/DgUQAH01RghXCWFYfTsOnjfa0=;
        b=dnpQ58Iud3JtguV16hokwZ9fZuEXUk67qsZYqY9AhS709cXjKB3lYnUt2gge6X1e8p
         3xm/i9FNQ+qeT9x4q+f4N9qincwFWmxEpk+USrwdd2+TybWtv8dliFfpM/pP0StNBP7j
         A352eMq+lDJ1lsgt9ANK+nFqwXnzbcUsJ1H37Clbpc/F7fDSWDFmqOIlIDczkfOWQklA
         zeNXq40EKIg+4+fK2pXupIkDCn+Zdi+ZLKeKUdR0Z85RgaC/soX/1ql5gbD+Y+iARj1S
         14i8ykQUDWvvMQlg5aWDMnosdZH+80GcDvYlmvnKbxot2PTgeEaUKtnRXV5yYOhnPx0c
         89LQ==
X-Gm-Message-State: AOAM530iZpO8JA63C5QcCQ96Hc27YUJsT+1CvnwfBuso+GJbE65MKRoc
        JzEdTG3s1quNShKUAI7iw1UQ0g==
X-Google-Smtp-Source: ABdhPJy9sRB/lJrHXeYixFNPKCLeQ5nYf74j9ANW4WGhd1Ad/e9mhDNcXF8hcT2N/uDCLr0RPkah/g==
X-Received: by 2002:a62:6490:0:b029:13f:c196:bb77 with SMTP id y138-20020a6264900000b029013fc196bb77mr5673609pfb.14.1601413107709;
        Tue, 29 Sep 2020 13:58:27 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id k7sm5488101pjs.9.2020.09.29.13.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Sep 2020 13:58:27 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sc7180: Add soc-specific qfprom compat string
Date:   Tue, 29 Sep 2020 13:58:06 -0700
Message-Id: <20200929135741.2.Ia3b68ac843df93c692627a3a92b947b3a5785863@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929205807.2360405-1-evgreen@chromium.org>
References: <20200929205807.2360405-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the soc-specific compatible string so that it can be matched
more specifically now that the driver cares which SoC it's on.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6678f1e8e3958..f1f8bbc0b37bc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -660,7 +660,7 @@ gcc: clock-controller@100000 {
 		};
 
 		qfprom: efuse@784000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,sc7180-qfprom", "qcom,qfprom";
 			reg = <0 0x00784000 0 0x8ff>,
 			      <0 0x00780000 0 0x7a0>,
 			      <0 0x00782000 0 0x100>,
-- 
2.26.2

