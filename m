Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AF72EC6E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhAFX3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbhAFX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:29:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71BCC061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:28:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l23so2456522pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mplvAp8whw34LAYnqeklV/5vxdb+fGvzxnYtKABvplo=;
        b=FT4+sdO5OvqVz04X9n8jVLvb/B56M4PZkQraMSPep8YVlihjlVOOdRrwRlp58wT0rR
         j2XvfT/Xs5M/3OxP2D9Hszw6n9Y8/W7hREbETL+VaOZA4wj/KFHjHDp9BHbujJuqYSXD
         AZ0BXhC3CA8KWz1gGIFMh+fTDTZHXckIPYglU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mplvAp8whw34LAYnqeklV/5vxdb+fGvzxnYtKABvplo=;
        b=i5bAhZMgveW2S7D6xcdvAr35RxIAOniURhCCez5OKJvfEzNw49WIRSjZyMrF6AIXv8
         cVDZOXWXP1esiEDerlV9Mqu4Lob9q8UEOMt0w7/O8GRM5kujeqz2na5ZQO36hgjDbY/w
         I5zwqQVqj9RvnaQMk5ob3wWR7t1lP51bkvU3D4vCUl3JhfGWEX0NHknnMoKPydbVUY/U
         qsG1xRxSl4uQ2d+BELbOVL50TQ02NayhsuvsGcc2yCpzXX+E9PWMDOaaCQbZEJSjxceH
         YN1Yl2sIb10fd23ZxCQcC6yTMcUborZjGiPSz9k2iWtjuMH6MKe8s68V+BI9ZG/Ro5t3
         ksEw==
X-Gm-Message-State: AOAM530PokSdpqJfrjLP+bdVUszP3cznat5vWPNRvi8X9Ddc4HyWfVOG
        SSZjr+v/TBsSMVtkAW0/CDQGbQ==
X-Google-Smtp-Source: ABdhPJxVSvw3Gj/2eOyJ6wAlHtuPkcaee+9YCZ0VJbk/bY+sCD54K0MoV2ieN/FeCRk9e+vlA0Ap5g==
X-Received: by 2002:a17:90a:6f01:: with SMTP id d1mr6539613pjk.155.1609975735433;
        Wed, 06 Jan 2021 15:28:55 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id a18sm3686047pfg.107.2021.01.06.15.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:28:54 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Add "dp_hot_plug_det" pinconf for trogdor
Date:   Wed,  6 Jan 2021 15:25:49 -0800
Message-Id: <20210106152537.1.Ib4b5b0e88fdc825c0e2662bab982dda8af2297b2@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have an external pull on this line, so disable the internal pull.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d76200d2b373..e3a3d809448f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -936,6 +936,13 @@ wifi-firmware {
 
 /* PINCTRL - additions to nodes defined in sc7180.dtsi */
 
+&dp_hot_plug_det {
+	pinconf {
+		pins = "gpio117";
+		bias-disable;
+	};
+};
+
 &qspi_cs0 {
 	pinconf {
 		pins = "gpio68";
-- 
2.29.2.729.g45daf8777d-goog

