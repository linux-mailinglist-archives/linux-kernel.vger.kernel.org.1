Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3B2DA5EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgLOCCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgLOCAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:00:53 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D3C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:00:07 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g20so9268450plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnlCzHUVCybhHldFJhWEPSZE9ZpbbHF1qUk9jUYAFQU=;
        b=aWdZIveoMtBwELeO863NjnSXIgTdt/yoPVdDhxd/+jEhFPgiqXDzgMIjLub02RBf+C
         qQerLkQ5tiHtF0MjgCc4H1sRfOZg52NgDJN5Y4hu4qlFGxNA2G3WDIflKCfd/M39pgsq
         huLwVqW5C4UZpXjsfkW2kc3EJHsnlzpl/18iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnlCzHUVCybhHldFJhWEPSZE9ZpbbHF1qUk9jUYAFQU=;
        b=KbsZ15emK6gHE35g+24gvW/hZG2M+XS3Zmt/gx1mpANwLPg50IH2v8o/DCtZTaE4ef
         bPDblB0RHtUkiEy7wTEe2nOhQNqJThPaaizFwvhfFf8ODFcq21+q6vy3UWe90sP0r06f
         pPPe9HPmTovo8U9i+eyr8NJRcmcnxQC2rPn2M5eCs6L/qEl7BWlvaK0a8eCgUuLVolTS
         GOqK/beyoT95zj9KCBgmB+vO8nkdLWqC/FER5wWDtEbR5UAaEMRah2Gy2SIV2KK1amtr
         WGJPLK82eI/RwkNytDYqqfKlDP8vPwya2dvovBTcIXqnkRtgTYtRxvD1AGlkk9X+j3EJ
         jAqA==
X-Gm-Message-State: AOAM530n1aEBP2h9RfH34kB19SA8vMBCtphGlsNlX5oLMOm9UFpOgwUn
        36mjZdc7ZO3aRYIZU0tvOjZNjgqv4qRltQ==
X-Google-Smtp-Source: ABdhPJwsA50X67NyFPXh45Vlde5fBA/radYRHZkQ2QeeSkumLCTrR4bFO4QEXRF+joLtMcmtOLGAcw==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr27738380pjb.48.1607997606792;
        Mon, 14 Dec 2020 18:00:06 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id iq3sm19549352pjb.57.2020.12.14.18.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:00:06 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Tanmay Shah <tanmay@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Drop pinconf on dp_hot_plug_det
Date:   Mon, 14 Dec 2020 18:00:04 -0800
Message-Id: <20201215020004.731239-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't put any pinconf here in case someone decides to invert this
HPD signal or remove an external pull-down. It's better to leave that to
the board pinconf nodes, so drop it here.

Reported-by: Douglas Anderson <dianders@chromium.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Fixes: 681a607ad21a ("arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 22b832fc62e3..268fa40a1774 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1468,12 +1468,6 @@ pinmux {
 					pins = "gpio117";
 					function = "dp_hot";
 				};
-
-				pinconf {
-					pins = "gpio117";
-					bias-disable;
-					input-enable;
-				};
 			};
 
 			qspi_clk: qspi-clk {
-- 
https://chromeos.dev

