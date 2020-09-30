Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC60527E5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgI3KCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgI3KCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:02:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD36C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:02:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id jw11so673464pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdW3gm1ADn0oDR7L02Rl9d5NYeVsj7eSjgALVvfgZ3I=;
        b=ZuOjMUlcU/0BCxzdaBgZD+D8ctKAKNUF0ZAcRr4h5GfKC2nPOIbfW6Bgw8Hr4Cy+rW
         XlIgzggikKCuB3GU/3iN6Mj1GhLPDKkZVrIav/DKT7xr4TEvgNbTablPR/TYdIzYOKfA
         xjZxu45JsYpLtRh3gm+I2Z1anDBkqhXklYsyXJ01x89fuQil0MaQ0ih+Uh9cyBwZOqdE
         JF5oRRuhoMR3KAtBh3ChKulEkIDbbyfTB/4Pu7LBb8Q00Gcvx+zJlZrtA2B29rmahVxJ
         cg7IgVRi+vU5DGdXWEgDS0cYJS+SizIpL2vbSuQ4iffFdmQsq5z/BCDbxQYVV5xXNaDT
         wofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdW3gm1ADn0oDR7L02Rl9d5NYeVsj7eSjgALVvfgZ3I=;
        b=k6lWB3ThSWksSqr5nQUseb6aAcS9jfFWZZb9NVYn6dJRd7437MoO+wdvGffShW2MMG
         IrkR9xkdEiXqkddeiF1rpvhRxWoPWhmRYh6lfiOlb8KhLmVU3U0xWi68YLnBOlda2GPF
         H939fGPLXkVdMLKXKYSeDCKe6eFNV/1jQFdoLFcJhY7h+C0ItZj3grCe1QJlUaB6vilv
         5bGfq10j7GHkXXMz2XAS0y3feq7Ww6t7beyLY61tKq0Arbe/LJ1qIz7pmzCFQpggMhQg
         o8wTgaG1nc2QpBvSZ1RmAcHwwudXTb4C4Nq8BNn5DbvU4eJTjqq+EweZg2VYzeG6nCbT
         QpRQ==
X-Gm-Message-State: AOAM530uDPVlVdyjPOqJ1cctgKViQyNiUDmKDTRMl6FHD90vRuPaFWsA
        9LHpSVSJ1GCFb8q+ND1f7isxyw==
X-Google-Smtp-Source: ABdhPJyxMGCvv9VXkgkCXXFTMuzS68luNGAmYgyVhsWR2JEJYGb4R2Bg6mUoxlBWnmZFPk21vnBcfw==
X-Received: by 2002:a17:90a:b944:: with SMTP id f4mr1873953pjw.127.1601460135158;
        Wed, 30 Sep 2020 03:02:15 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id b2sm1890002pfp.3.2020.09.30.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:14 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     stephan@gerhold.net, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: power: rpmpd: Add MSM8939 RPM power domains
Date:   Wed, 30 Sep 2020 18:01:44 +0800
Message-Id: <20200930100145.9457-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930100145.9457-1-jun.nie@linaro.org>
References: <20200930100145.9457-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8939 has three RPM power domains: VDDCX and VDDMX and VDDMDCX.
Add the device tree bindings to manage them through rpmpd.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml          |  1 +
 include/dt-bindings/power/qcom-rpmpd.h                 | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index f136d06b7fc8..919150f426d4 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,msm8916-rpmpd
+      - qcom,msm8939-rpmpd
       - qcom,msm8976-rpmpd
       - qcom,msm8996-rpmpd
       - qcom,msm8998-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 83dae2cabb60..4c07f2402b94 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -71,6 +71,16 @@
 #define MSM8916_VDDMX		3
 #define MSM8916_VDDMX_AO	4
 
+/* MSM8939 Power Domains */
+#define MSM8939_VDDMDCX		0
+#define MSM8939_VDDMDCX_AO	1
+#define MSM8939_VDDMDCX_VFC	2
+#define MSM8939_VDDCX		3
+#define MSM8939_VDDCX_AO	4
+#define MSM8939_VDDCX_VFC	5
+#define MSM8939_VDDMX		6
+#define MSM8939_VDDMX_AO	7
+
 /* MSM8976 Power Domain Indexes */
 #define MSM8976_VDDCX		0
 #define MSM8976_VDDCX_AO	1
-- 
2.17.1

