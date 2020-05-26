Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1819F034
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgDFGAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 02:00:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36336 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDFGAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:00:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so5497159plo.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+uZMfBZv12Nq4DU6XHRgLdqk7yyEBTks4MoCu3V16w=;
        b=SJBpzLN8cZ5bsVFizs2mSYop/ikIqT2uLbv4hR80BL8LBfrFSUrqxu+VSeZKuZbZXK
         aVGcRn8y/D8GV5sR9REBmlyfBLogrSRL3Rf1R79m1gjpOnymFvURwo0irgHI87oTs/MO
         4RKTVuuWHnd0k09FmATYaRWDqMgwldzsA8yV42fjeg1ILCzZ0M+cl7Gr67TLCHZOhPpk
         9ByphToDAjJwRa+klKcSs43mfUTuMrM+5z6fDbwF9xcQI7/ZDQOH9Wm1ZYVBQiGejD33
         RcH2YKt1+We57xvkTnxOZcMca6yWODRFhMJyclDxi/EfPfJmURII30Mbaw7PQEBsvc6M
         Nn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+uZMfBZv12Nq4DU6XHRgLdqk7yyEBTks4MoCu3V16w=;
        b=OudW1R0F6f8lAVay4g4kXPsm+YLI/akdg3tF9pAgvWIKIVOAfPypK6rI2H4NwVTDuQ
         aW6PSa/CEvH8eQlKfCqIDXXMtL6iTr3Uko00EY7BXmLSnLrBUGnSUMQZHvyNfTjw3EAS
         l6XpKQw1zqjsdRMlnmJpaT/9OyIuVqtNZ/YPxTGBTeTibZ4Cg4NHpxYmqt36RDpqyvWK
         88nrk2xgROsgm4EBzLlejrdOsD3Y5Ci2mR+A+sJc1SCVKBIsz2FKYuTu2Hs4pdr6HKcj
         WbpTW4hBkl0J/8lyE0knH8vBUm6dhjP6RFLeFehyKa4dQmVbdoztDuq+MX1psNEO06To
         edYw==
X-Gm-Message-State: AGi0PuYPckeCgZZrdCuX0a6g9v9gZZU0qFNPxd9yL4Feccea0RrEtrnw
        6FWmOpX8jZunPe58ERpgpaoTuA==
X-Google-Smtp-Source: APiQypK02cIrQa2bOqRgzm15ePaxfOCT5LWvMZq/McP6IafAcS0bfx4MMbkfC01e575Gql/Wc7qPnQ==
X-Received: by 2002:a17:90a:2103:: with SMTP id a3mr24949763pje.181.1586152846668;
        Sun, 05 Apr 2020 23:00:46 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s61sm11806003pjd.33.2020.04.05.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 23:00:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: Specify UFS device reset
Date:   Sun,  5 Apr 2020 23:00:49 -0700
Message-Id: <20200406060049.227029-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some device the reset line for the UFS memory needs to be tickled in
order for UFS to initialize properly, add this to the ufs_mem_hc node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index d92a22e67b67..99f197cc0505 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -623,6 +623,8 @@ bluetooth {
 &ufs_mem_hc {
 	status = "okay";
 
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
 	vcc-supply = <&vreg_l20a_2p95>;
 	vcc-max-microamp = <600000>;
 };
-- 
2.26.0

