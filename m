Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50ED2EAAD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbhAEM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbhAEM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:29:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2CC061383
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:33 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c22so21143228pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxQ9bQtIikQWDcNYhJoOP9WcMBp1b/WtsV26IjiPkCU=;
        b=UhugPWEIBZUPPw2cCeZde9yuLdlhdeiopaaoFSSVHqObHCAv59LydmJN/FBAHc6Cqc
         b2H5+wIi0zzJ4jf0R9DO4x3oO3go+DZCsFZ4f3Im2IZ/iMlVBVa9lRLM/p0DZOvv3I17
         UFcAHXkHO1mqvZRzAcZSk2D2cHaL8JR1cW2m/8AH6i0Fgr/oztfTdQa6Im0ujslaunid
         E/s9Xnb4prNaw73XgqM6SXIxkt6600t+j9V/eFos01DKqxH6zBvLe+xoOHjn3pgjMLpQ
         PpLGpGDsfCXoeiJpIH3GQDeirlwCpo/R/gG8cjKx/JDd6VDF+i19LXmXbEi0YfdPiQ5f
         tCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxQ9bQtIikQWDcNYhJoOP9WcMBp1b/WtsV26IjiPkCU=;
        b=hJhewNqgktDspRhNY/udJLZS8Brdttst/0dmcrj6aN+AxbVnC1PEltVomJ4YRL6FFn
         x/yvSov64/P5RsbwMmAZhvn9cJPds8Myk6gLW9WbmNyAw4o8d7uc7mSATX8kZtir0VGw
         L0rpOYelxHl4+AyxTfh8B4kU7lLnxDIUrQMlPJPccJ2ZItsz8eNgf+CRwPV7/zMjORh5
         Ev/hsKgWhwSa9BUa2euTfx5Yy1j7Bb5tNlIC4jdaib/xJGfR/ceJgTsYX0pwQpF/v1dv
         k1qonhgqCi93FFV8iwhAxWSkGHRCF5Y1fNv/bhMFXup8KH4IPsAjVxmaUShIO1WoZ4xP
         v/Hw==
X-Gm-Message-State: AOAM531MBNpLd5TtOpwI9PLSL6ps6gfaykeAgdFVeU/3MvQXKxxY01LZ
        g/VMQ28YO9vuOrRGDbQ6OLJe
X-Google-Smtp-Source: ABdhPJxBvHdXkX2j2SBnLoEJr0jLt1fBDvQ7PW2bOUln5256Uk2sqPMUjyvtNlpybwJhBmgnHxvfUA==
X-Received: by 2002:a63:f608:: with SMTP id m8mr11036249pgh.11.1609849652601;
        Tue, 05 Jan 2021 04:27:32 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 11/18] ARM: dts: qcom: sdx55-mtp: Enable BAM DMA
Date:   Tue,  5 Jan 2021 17:56:42 +0530
Message-Id: <20210105122649.13581-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable BAM DMA on SDX55-MTP board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 262660e6dd11..74ea6f425c77 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -25,3 +25,7 @@ chosen {
 &blsp1_uart3 {
 	status = "ok";
 };
+
+&qpic_bam {
+	status = "ok";
+};
-- 
2.25.1

