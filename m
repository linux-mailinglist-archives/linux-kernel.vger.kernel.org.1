Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6E2E7422
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgL2VSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgL2VSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DCCC061796;
        Tue, 29 Dec 2020 13:17:37 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n26so19692627eju.6;
        Tue, 29 Dec 2020 13:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZsCNkN85nxcjHndILQJS9ROnacIon9C3Mpq9KGPza8=;
        b=A2/bGzBbvxJj6VohH6PRPwbzdCrWk/o4Dw2YsL7mMhPuUfcVR90KuAjea2RYp/HUgP
         8aGHGXUUsXd+SsRbw0kuZeS4/i2coH9FN+0r8zFsjRYI9oMLSW9S4TdkpjQN4NlD6Fyx
         mLlBZHiNFnkChnbx9cZGJMN6mEc5Dv1UzRE25pEQ9WEeUbSKHHvGrzQ7T4Jk/xpJeb+b
         PzpG1PwlcRwMIVZB6xCOfugo3lPk2Pxr2Obpq29hodfjSyFSixzhHBcSWhGkelz3sPaz
         wdQ5+BgxsOeEVFNGVtU+j4NcdAE4HrCA42gbnjclL27nIjmfZs8kQNVRlrSHZjcYVNqT
         6QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZsCNkN85nxcjHndILQJS9ROnacIon9C3Mpq9KGPza8=;
        b=bclcHMuW6/RPE5U5ntJWHkcVYDTntSumDv0eCorv4+K1DjYRKeIHoA6/hRPR+7wwpu
         WmAmtmG8TpfRQ6yOE2FbalgTHh08uhj2CmjeDohiN3nOBokhr0l/1iadTtX+/EUMUGam
         L8zVc3yI/ZduWyiN+jm1Ij1p7RvYu0RRQlcXAZf5ANCGKLlNdLHCRnnphx73Nf/UDGLx
         fAuddtXuAJSm4qM7WlTK2QcED+ANAVBMSNCO48GRxo3apgECsTTMRb2gCVeddIaxflvs
         WkmonL93ObpbP09ixUtIwK4bEVdaAkFYj1aus4D2mmgmePztY5H4sYt1Sv0JxlZRYQSV
         a5rw==
X-Gm-Message-State: AOAM532zEJ9O6EChi7JaXkcy7Yy5dTdb5IqKK2LvoFQxj25hJ3aHynEp
        IEHK/LHXoMlo4s36mFjHFsk=
X-Google-Smtp-Source: ABdhPJzgEeAIUf40ZDWNZEvPNmssEHznd8TTZ+IOnHbzBtPLihjBURzNTpvtWXbWmev2rtEGU0xVjw==
X-Received: by 2002:a17:906:b287:: with SMTP id q7mr11089326ejz.311.1609276656009;
        Tue, 29 Dec 2020 13:17:36 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:35 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/13] arm: dts: owl-s500: Add Reset controller
Date:   Tue, 29 Dec 2020 23:17:18 +0200
Message-Id: <4da1db3425321525bc97022370d8a6a149bca091.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S500 SoC DTS.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 arch/arm/boot/dts/owl-s500.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index ac3d04c75dd5..a57ce7d6d745 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 / {
 	compatible = "actions,s500";
@@ -188,6 +189,7 @@ cmu: clock-controller@b0160000 {
 			reg = <0xb0160000 0x8000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		timer: timer@b0168000 {
-- 
2.30.0

