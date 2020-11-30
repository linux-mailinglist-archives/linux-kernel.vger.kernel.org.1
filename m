Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493A62C8135
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgK3Jke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgK3Jkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:40:33 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC03C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:39:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so10031377pfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLxCd/F4fxI6lLKUfeAQgTwipZuT/u/XIJSTRbWtMDg=;
        b=aiVk39RlImBWFTMKuODN3ftmmmuWoy1VwkbteJ0JyNawut652rgM+TyTCmZ+I7o5H8
         zwK4ssBk5PQHdySZ+wxpSzilZaBUPleickaKTW9OHEEQtzrElXl6OBAQjryhlxhbDmPp
         DkVijQ/74rV/1JNos9sj1QHiHhyEUe5hK1+N6XtpO55alaeI4rvJp9n7kfB1HP0LQfR5
         qfiJotOAjspEAaWFPkJl6tT1Pd7KZ+Mgx1dZ25osxdHuctEx4S5x0gMBMMPZByOegiOb
         t4LXIGVg63piNiWHrslp8qRUxtFBl3C8nIdRE5HDTPIQJPvZHyxWs8/gn7zOp1UpUyn3
         MQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLxCd/F4fxI6lLKUfeAQgTwipZuT/u/XIJSTRbWtMDg=;
        b=af+Qic0rQt0oQEZ97qI8sbUiYTlFbaFDgPEsdBKMzExSaYxjU5kXYGWxhL/drsLKrp
         2ivUzH/eACc1NwrNacZh09Zw4WJDwHgTfKT/+bhNJnjqdw0FFzdx8cx2o/fYBWnoroVj
         SW26dR7L7TcSZT08n3sQNgcT0wRiGk7oa/Ycnr3J0+vN6GR9s/h2z/nE6WnHRfPPdf+/
         450k1KgMfFv2Uq86iMLqAfijwO+NTXxre/E3bTVrryII2OWRPg6CMC3lM2dT49dBGLAW
         08QlpRMT7rKPxVA4RlKkIX7YCieL4h3vWMtfEs+G5YdaJ/C6I5EinZ3FFH7uiB7T0RPm
         r4YQ==
X-Gm-Message-State: AOAM530u9gdYarcda35SWuYHWipvYBUEY9MMfseZuBIAu3lnGr2EpWWo
        7NNS2HGWbsRjOJ68nUKqS0uy
X-Google-Smtp-Source: ABdhPJzYIWz+ETyPU8t7ZJKWzHBjfRm+kZmbxBl4JhjLNxa8o8quxc90e95iqDEWoraSPozlIWRs4Q==
X-Received: by 2002:aa7:8744:0:b029:18b:a9e1:803d with SMTP id g4-20020aa787440000b029018ba9e1803dmr17737033pfo.50.1606729187111;
        Mon, 30 Nov 2020 01:39:47 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6c0d:98b:4016:605b:102d:cbb8])
        by smtp.gmail.com with ESMTPSA id u14sm16348429pfc.87.2020.11.30.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:39:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, saiprakash.ranjan@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8250: Add support for LLCC block
Date:   Mon, 30 Nov 2020 15:09:22 +0530
Message-Id: <20201130093924.45057-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130093924.45057-1-manivannan.sadhasivam@linaro.org>
References: <20201130093924.45057-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Last Level Cache Controller (LLCC) in SM8250 SoC.
This LLCC is used to provide common cache memory pool for the cores in
the SM8250 SoC thereby minimizing the percore caches.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 65acd1f381eb..118b6bb29ebc 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1758,6 +1758,12 @@ usb_1_dwc3: dwc3@a600000 {
 			};
 		};
 
+		system-cache-controller@9200000 {
+			compatible = "qcom,sm8250-llcc";
+			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
+			reg-names = "llcc_base", "llcc_broadcast_base";
+		};
+
 		usb_2: usb@a8f8800 {
 			compatible = "qcom,sm8250-dwc3", "qcom,dwc3";
 			reg = <0 0x0a8f8800 0 0x400>;
-- 
2.25.1

