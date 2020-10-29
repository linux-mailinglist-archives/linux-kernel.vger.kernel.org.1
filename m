Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6525029DC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbgJ2AaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgJ2A2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:28:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE6C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so471889ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XL0p4jUGnrhzOC6YPdWcbPrW/C0smRCADsbdxD0rIUo=;
        b=MLjsILPmIR/nu0yGnq6LaBexXCUIMYA9QFD+BmVbZ65ibV1KuYMc+lhoD8DxAY2a9q
         OH7qT2thblC9rXZSJLxYkry1FnfeBWu8C393jJrq97f4DNPhmCsakx4Tz9O9KlFhajKL
         2OZ8fZ/mibKVqtCiocLNPHiEWwX2Opov1EhVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XL0p4jUGnrhzOC6YPdWcbPrW/C0smRCADsbdxD0rIUo=;
        b=Rq2DBrw2wSJlheORaU/kmLueIc227R0wmrWUQPIzxzpiuyBqJPMdtDjmR4C+ekzs2B
         H50GGuMxYKuATNtQ7XrznoZs3vWP6cP4pjEt5NIafAse35iG9Cxx79DmErB72kAvdvvj
         yTD0wBfWphTOZztY/XNYSV2Of+tEQOwMw1xxcdZNREb2xSsgWobgVGi4PQFP0cl5Qpr5
         yiEIqT+Pvf1zqHoMRLcN0gLH0M+/MRvvaFg2Nn50MMWoupHM2/mPS4gFiiTI2F6zJfve
         f/OQRIt0Ol4lgqK0voVjISpL4DOEy6jeGGL/0YJa96aIuxE6gsTV/wmSuDRhjuv2Wdtg
         S7/Q==
X-Gm-Message-State: AOAM53325Dlwjo/2Otil6aHHL4iSLnlrQvQqk6ixTfr41SFezsG6Lloh
        lfqCVqRGHyAvSGlwd2nch1b96Q==
X-Google-Smtp-Source: ABdhPJwie3Lc6uDBwa//k2O0uXN6sPLbXwjUESLHWrECCCoJOD0gRgRwVcIQaa/h7BDUUnOCMivSDg==
X-Received: by 2002:a17:902:ba96:b029:d5:f36b:44af with SMTP id k22-20020a170902ba96b02900d5f36b44afmr1438100pls.51.1603931325468;
        Wed, 28 Oct 2020 17:28:45 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id u13sm743625pfl.162.2020.10.28.17.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Oct 2020 17:28:45 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: qcom: sc7180: Add soc-specific qfprom compat string
Date:   Wed, 28 Oct 2020 17:28:25 -0700
Message-Id: <20201028172737.v3.2.Ia3b68ac843df93c692627a3a92b947b3a5785863@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029002827.1729915-1-evgreen@chromium.org>
References: <20201029002827.1729915-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the soc-specific compatible string so that it can be matched
more specifically now that the driver cares which SoC it's on.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6fcffd588a7d6..f5ef2cb6e68c2 100644
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

