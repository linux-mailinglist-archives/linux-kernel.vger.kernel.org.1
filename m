Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E12EA7FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbhAEJsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbhAEJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:50 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDAC0617BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:20 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p18so20924788pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxQ9bQtIikQWDcNYhJoOP9WcMBp1b/WtsV26IjiPkCU=;
        b=gLXWwVpAnYxvov2kPbHgZtAHMA3p59g9Y6v0tXubptmNeMnCj+zuprjC7HmBmatMsA
         T3yf816j1QjUXeOOao2eei11r3Akr1drR9i7BY3pjLflZQ8VzjFqk4r7yT6Ac3PEuA9N
         q2+K0WmC/4z0BFrD60+1bITRSHdpmp0FLBFduMdAevOeAhhn9+++AsYl0DSG0tYdHH+X
         yvzotXZuxmU1vB0z/3YZ+a3i1BQCuOeJgBDt4JudVlQkg1iRWOBMWVBK6o6ZxXsHmjyd
         3haxVw7RLkD9PEIe5+wwClxRY7scdiuKyOim4tvVXcO436ureiQSlc7w5qwKtW1NHLh2
         arPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxQ9bQtIikQWDcNYhJoOP9WcMBp1b/WtsV26IjiPkCU=;
        b=OBvbFbH+OJJJSdTFsKVmVNdnzYKUM9/J9nKiHbCIVuykr9OFfVRqrk0I8UarPwT8cu
         wTNMKPn3JPcgaaohE6QCbXwlb8jqTKXNzwyoGa2sZW1gHete0186Y61pzjzfVJt5TDkj
         s5PjEovFDgyh3dj07oU/R3r4E/qo/fCW4+Bl+i2sdfagges0P+XSCBNCvgqEhSWQOUwy
         hHvH113FIiTvNhLxt6k4KUsdSNUWgLJX+d0nc0LAu39sq7Wwbf3g2gsal8yV4etzkwp9
         3lGNLXbsadjoF8gpvEFgz9jpVkySJ63jH06A1BdwABNSipIwc8Ew60z0Gtp/ZGzFV3QC
         +IAw==
X-Gm-Message-State: AOAM531Zbsr26T54ahp6Pq9miY0Kp6IC/wjgW5VwyERmsEXYaQpEwWPr
        Cd2NQGmtdegBcaWpX8h7KwYG
X-Google-Smtp-Source: ABdhPJxuc9ytNQsc6qkTxILJXSxmBDkjFv8XPfeJmkfqhnEal6PtErUQbPncLdwePSjkOMv4bBhH4w==
X-Received: by 2002:a63:c80e:: with SMTP id z14mr74728657pgg.435.1609840039656;
        Tue, 05 Jan 2021 01:47:19 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/18] ARM: dts: qcom: sdx55-mtp: Enable BAM DMA
Date:   Tue,  5 Jan 2021 15:16:29 +0530
Message-Id: <20210105094636.10301-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
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

