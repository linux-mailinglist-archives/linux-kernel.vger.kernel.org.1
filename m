Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2807D269996
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgINXWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:22:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB95C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:22:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so844124pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKuhn1regCZVDoX3h2lEOSZS8zUVJ7H4Ys0iUFFRsoY=;
        b=fyYcPMhwyrF6nCl1gutRTy6+uYGqtXsuBzNouaMcZnC8zfq4cTfDlgGaTaH6tVzBDK
         +/vwW/VYW536ss95M0s/dgRRUy5tgY4KWKFW5EAm0l5YePXGT9lNP8Mhkl3aq9r2uuA4
         57xXOzvYuCr6rhg3EsvHTxt3lo7xn7w+C0puo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKuhn1regCZVDoX3h2lEOSZS8zUVJ7H4Ys0iUFFRsoY=;
        b=Rl69FfsRfTB9Y17DR1F6zhwQ2CAvjpbiR/F1itrwHADmTIjjBfRsXE9tBChMbMUv5f
         WEgj8V94cFBJ0xOQRBKeyo/AjDd1iAflsU3JO9xxKNbC2QGqBU99EZxdgx+Lsql8wwk1
         fmDUmks6sVoU3UTrHA/xv9q1E8BjQIhXACgDhtGNGkQrUZ/YUrI414dvhHsDH8JBcWPO
         gO2/tj8QpgwjBqcMfmpodlTlhIosJ4RPSFC7p4EJZ4tkHOTOvWZCGxDr6Cpn4ODsEQaQ
         vs0Sr7lo10pt1QPhvBIcfddBE9QNSMY/j49tx7x20OvmvbyPpGYlWEnLdB+P0tr3SG/f
         mb0A==
X-Gm-Message-State: AOAM532hwRqJKIymmg+nwul43UaHXTEk1pGQHLs8pprwCkczz7KUuX2y
        nTym3p62gIbQiPQF8fY1HLrw2w==
X-Google-Smtp-Source: ABdhPJxD8qxz9xfVX1SDHHRBSkFQY51OkpwTWZj7QW8ySrog4NFhfV0N2kdwjrCKqnzgHixNNNumXg==
X-Received: by 2002:a63:2042:: with SMTP id r2mr8126100pgm.349.1600125739517;
        Mon, 14 Sep 2020 16:22:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p29sm9099993pgl.34.2020.09.14.16.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 16:22:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: trogdor: Add labels for type-c ports
Date:   Mon, 14 Sep 2020 16:22:18 -0700
Message-Id: <20200914232218.658664-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some trogdor board variants only have one USB port, so add a couple
labels to these ports so we can modify them later.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index a6b9beb29be9..f46d331bab47 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -544,7 +544,7 @@ typec {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			connector@0 {
+			usb_c0: connector@0 {
 				compatible = "usb-c-connector";
 				reg = <0>;
 				label = "left";
@@ -553,7 +553,7 @@ connector@0 {
 				try-power-role = "source";
 			};
 
-			connector@1 {
+			usb_c1: connector@1 {
 				compatible = "usb-c-connector";
 				reg = <1>;
 				label = "right";
-- 
Sent by a computer, using git, on the internet

