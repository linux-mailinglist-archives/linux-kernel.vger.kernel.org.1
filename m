Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54502FDF29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393072AbhAUB7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392605AbhAUBq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:46:59 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DC3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:45:59 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 9so531486oiq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4DFohxjHJSYNY3a+F05NUS9S7JPybkMexC8rsO+oRU=;
        b=QsPAqX9TY/BWe9zTDe6MxhOhDLgbLrq8BstQ+sJAkugA/rnzPM6ja1bsYcfTsm5I8d
         MgiH0ztalwjuv5+RngCemJMBt8Bky4zzLuYGfv+8KEUwgMvcXB0fhi1ibjKq/i0gttxv
         RtArzsqusPCsGo9qu/6k1MBMI4xzg7kvxdTP+dMHBiwNmsC3183swtdVLO+AH5JQDdYV
         3sla7AhsXRIZLi+Zz+OGTnMwNXm28VRWy/dYaTlFySMJNLUI3w7JaeOckvj26ovVZWQo
         e0G9ngI5LgmEt6uDeNgc0XKq5R3GSrOWRV8apOeHQIkOBa41G2v1B/oi6UzkM07UEVR6
         l9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4DFohxjHJSYNY3a+F05NUS9S7JPybkMexC8rsO+oRU=;
        b=GIYxSCkCnfIe/jXLJfzg6N/+Y8mlZheF0RxlJzsFzCJl71bArdGeq/wO7IJYmMOsME
         cf2B5oQlq5F+s7iidJ7Eb5qVtG9pOyad9kdkdRrnSb5mVdLgxrAosp8cdiLdKpdmH+h2
         bXtR9W0zl1UrtRZQjnaUe1i4VyVwGxq9ZXiZ59J9x79l8tkdXQk0JekLvYeXz0ZWSDhl
         Eev1PGXQQWFeZ5c/MGGknDv1DcOdfHkwpc70GA1nakHJQDfkmUMGMyWmqN2nGj+A6bWm
         xP4F084POapdACvxypYF3VL8hz30m17kBjQzHd+URktTRcTttEGXnANJYoKYRQCAueJz
         Vc2Q==
X-Gm-Message-State: AOAM533pa1wOO433ZM3IoHNohTwETZ5n1bS0YEONgkmc7stH5oABiz9I
        o3l3x5TbhRZQLH40tk6WCON6cQ==
X-Google-Smtp-Source: ABdhPJwAmlA1rQnLnws7DJI21S9hRZV/VftP5Ut+N8wK9cAeCbbQ4jQCPO3EaDOyxJZth9/GPjKI1Q==
X-Received: by 2002:aca:3784:: with SMTP id e126mr4573366oia.170.1611193558556;
        Wed, 20 Jan 2021 17:45:58 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j17sm784398otj.52.2021.01.20.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:45:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: soc: qcom: aoss: Add SC8180X compatible
Date:   Wed, 20 Jan 2021 17:46:05 -0800
Message-Id: <20210121014606.1612668-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Qualcomm SC8180x platform to the AOSS QMP
binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
index 953add19e937..007139b9a58b 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -17,6 +17,7 @@ power-domains.
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,sc7180-aoss-qmp"
+		    "qcom,sc8180x-aoss-qmp"
 		    "qcom,sdm845-aoss-qmp"
 		    "qcom,sm8150-aoss-qmp"
 		    "qcom,sm8250-aoss-qmp"
-- 
2.29.2

