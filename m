Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D66F2C64FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgK0MLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgK0MLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:11:46 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9EC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:11:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e8so4434593pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kInwNk/ThkAgXZIESon1lxicNanN9RlxTXl9tfSYT+I=;
        b=zZXMT50j8fpsSR9O3vwTH0Ef9TewOi3i33MIdyzu2LDCBfr/dzO7RxkYlcA/vgwign
         oGU1ScnOIElX2ANISgkRCZPSeIfpBDN/kfWYTysfbdzPgUYa4jXUzOK6G+/O8fXNMn83
         Et8YtCexsSG1yhO50qJADx9Z3hfzd30kdHTpdUPWimJe7fdA3VfNQKKXSxtzQ+Ae2jOX
         BSj65UltBzWDmBtswd4tPuNJhR0MqdnzF/69JgAQXx+3FVO/BuyhfGQ+jea8+5MT3ymk
         YzEx+eFFLQk3ncak3iP6PyH0ey3f8qyDBQ1pW2M4IyvdLPM6K6R18zN4nUYcSEqFHvVq
         Y6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kInwNk/ThkAgXZIESon1lxicNanN9RlxTXl9tfSYT+I=;
        b=FQlEBACM8cwBZqVm9nzum76612gC87ZfyT25mDOQZ9HeTGwO/9RzH3E6FxUemPx5J5
         XCgl+iYxO7sVX5oHBpJHyrdymqwJjjtzyIF4CmnT69AI8GZqop+Spiv0BQ2n2oWoK3ea
         nGcK50GgoSqaTjtq5JfHBorK8lUNKBxWGrUmJPmlIgIz30lTfzhtfke3DVB4TYIkYc/8
         +Kzia8KIPsuERwBaGk61ZoiaRRGAEsRMZFYOAzTkTi4cC5Syq+ZEZbWZg41pDDf/rHRN
         InqqIC/L56p84+gHv9XuD7wfDGdgZtLdQMT+hGXceTx7eM1PkmLlud9s/qJafQMGPvzm
         8EIg==
X-Gm-Message-State: AOAM531olRdaEI7ryHsYOCnyuX53jVWT9z3OOCTPB/QzylF5liYXhk40
        xchBcQuhzK9vDG/9mEPu1chk
X-Google-Smtp-Source: ABdhPJy6w3VuqZfxvgs7p/xNNoQ4aWfZ60iPK6rbgnuMp23sdlb4oCMycDPoZeG/kjghWZfBzOvrlg==
X-Received: by 2002:a17:90a:aa0e:: with SMTP id k14mr9718005pjq.153.1606479104900;
        Fri, 27 Nov 2020 04:11:44 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:480:e2cd:2509:49c2:a270:1438])
        by smtp.gmail.com with ESMTPSA id g8sm7318790pgn.47.2020.11.27.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 04:11:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: msm: Add LLCC for SM8250
Date:   Fri, 27 Nov 2020 17:41:25 +0530
Message-Id: <20201127121127.158082-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127121127.158082-1-manivannan.sadhasivam@linaro.org>
References: <20201127121127.158082-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC compatible for SM8250 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 0a9889debc7c..c299dc907f6c 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -24,6 +24,7 @@ properties:
       - qcom,sc7180-llcc
       - qcom,sdm845-llcc
       - qcom,sm8150-llcc
+      - qcom,sm8250-llcc
 
   reg:
     items:
-- 
2.25.1

