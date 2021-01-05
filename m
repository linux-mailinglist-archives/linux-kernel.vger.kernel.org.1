Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5082EA7FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbhAEJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbhAEJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:50 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A9C0617BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:23 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z21so20936179pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ4Xyw+lomP5U3AJy8SgFcN3M+pTYg7eIxIz6Xs0pzE=;
        b=FxAZd1YlBC7lGRTKnF8Ryo/EZhj7m/J6ZneN0qbtGCJVci9a3hNIPEuQ6mitQOytm+
         23uAyZRPnn11dFgbeD8uAHzb+uSAd38cv9+K3BotG8PUPNye1V4stcP+G5zzoVjMIKpP
         MIKFGoavXACto2lCytsSI/dqV+aUyTYkH8CWY78+rnGUQBM/4ta7tKRe4Asanjb4UOli
         kBYthoLIIuNMInWGlw0ftHJxipcyfLdG/qCW/tU9yFeUlURCLkox+lOnCMhOH00YF13u
         3HEen24dbtNgwrWHb1XkrwdgClmUDixfltcGwdBRDv+atoT184qOcTVoA/AyWS6DM469
         ysOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ4Xyw+lomP5U3AJy8SgFcN3M+pTYg7eIxIz6Xs0pzE=;
        b=NVL9K7sDkUNgR/T87nnbyU0pbZaYCw/HrPWNaUIY2hFmdTKNGECjOUmC49C2ZrNTEc
         tRIyJGmE13s2t5CVgHU3J0b0GD5baOWOxDy3BKfcoA3/YrxTlJQd94ib2a1ziSz81Zgw
         xwXs6HgcQfdnbXwEwWvUgoubIeZDnr0HZcQ4Qp/4ass+J0y6peagkTEpU/F4lN210ZCj
         UhHFyWIUa1ysXo7nPe2QKQapG28SO/NfojhEnSi7JxcypnLCBKzhurdhy4b1Swvjt1HR
         81yxZFp+Zh0td5hdHj+sblVO6u3Swp+t8M9LdsCM6xPlfoEJzZ66Lhr6QEUEaszCmpif
         jv8g==
X-Gm-Message-State: AOAM533fiEg5vETdji1khus9ldgwLojeC9dmEsJl1D8h3Q7wR32876mp
        e+KuWPPJqQY4DOKlvuIVVhrV
X-Google-Smtp-Source: ABdhPJyapVxBwTzJaNn6ScMB6O1NC7wXtLjcEL2ID3FCcZyAvN4tfMHJ88HqVtvg/tR+Qi/VNeru9w==
X-Received: by 2002:a63:fd10:: with SMTP id d16mr61414130pgh.333.1609840042727;
        Tue, 05 Jan 2021 01:47:22 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/18] ARM: dts: qcom: sdx55-mtp: Enable QPIC NAND
Date:   Tue,  5 Jan 2021 15:16:30 +0530
Message-Id: <20210105094636.10301-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QPIC NAND on SDX55-MTP board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 74ea6f425c77..b8d432a4324c 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -29,3 +29,15 @@ &blsp1_uart3 {
 &qpic_bam {
 	status = "ok";
 };
+
+&qpic_nand {
+	status = "ok";
+
+	nand@0 {
+		reg = <0>;
+
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <8>;
+	};
+};
-- 
2.25.1

