Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90021EDAE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 03:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgFDBxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 21:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgFDBx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:53:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09986C08C5C4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 18:53:28 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so2190497qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i858jJWQbhuwRMj8E1/bxOovHVRlGVAzlzhMfpqJNyU=;
        b=iSv3LGf08jzGFo42mX0KR7PGLzCPQauNhYrrp3BXnzbEc2CW7abMVDkozTgcYHf/yf
         s06fyMTLbG0oexq0OXdsjoYiPqq3jub1muv86cBhQuRun9lTu9qyObmSQhH+ZbqwEspx
         j+/cCPcW9aXerBwgotYV3sFiQLISg0OInwfqnT898hy7S+mmH5v2P4oIe7/lJJrdIma8
         qFVD9dKIT603LPHP8ksXAJ9aP8QhIhZSkHv7lEUp1bmgFT3A+SRbUw3uvSz9z8pa6i+6
         oZybQtGht8sq8EH5pgK8aWzj1S21q4RDdPUoKXCQGvEKkHuWOwKWiNyr2lbuh+H8JmMM
         T8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i858jJWQbhuwRMj8E1/bxOovHVRlGVAzlzhMfpqJNyU=;
        b=hv6/vDxJMBugzpPFq1gM5kXlAsk/ltuu0665Cj7kuM3zEzAMPVTcZcC+VSts0zb8sj
         xz9AW0AaA1+zhO6YqjCWocGVDWGVLuqePV0J5UYu7k/vbknZBl6VM7axusZj46IyFt9V
         r0cbWLF3VXJJ5g7PGVg3eBx4d+1EtqEjECM4w8FMjaXsBTaGBZZQC4tR3O3bBKAsDW8C
         MdBUvUEJQr+FRRad0zAYxj+vyTkJpxiqES8ONFddMK8JOlcZH3TCzpwy2IdQikXtPi+U
         ln4+rKqYoh++cSEIpEIHgI/siUWgkLe03J3hjr/Y5UFtVYQYjyrGGaWwe4ZafOpfxSmU
         +QNQ==
X-Gm-Message-State: AOAM532o2q7erkneHQuVUs3qlnnrAqqEIZxWY7FEY0uvWNx6YfsDl6B8
        YtDuuNVPdANRg+viU4hf0HgtpQ==
X-Google-Smtp-Source: ABdhPJy/qVnYPDu7TwQ009JRMbLWRxZ8N0T6NTl5vAfmesQQgKmZ693NBu1XxWhNl9aBfX2gOnZ6KA==
X-Received: by 2002:a05:6214:28:: with SMTP id b8mr2571818qvr.60.1591235607224;
        Wed, 03 Jun 2020 18:53:27 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:26 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/6] dt-bindings: power: Extend RPMh power controller binding to describe thermal warming device
Date:   Wed,  3 Jun 2020 21:53:16 -0400
Message-Id: <20200604015317.31389-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh power controller hosts mx domain that can be used as thermal warming
device. Add #cooling-cells property to the power domain provider node to
indicate this.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---

v3->v4:
	- Removed subnode to indicate that mx power domain is a warming
	  device. Instead #cooling-cells is used as a power domain
	  provider property to indicate if the provider hosts a power
	  domain that can be used as a warming device.

v4->v5:
	Moved the property from .txt format to .yaml format.

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 8058955fb3b9..a4fbbd88ce18 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -28,6 +28,9 @@ properties:
   '#power-domain-cells':
     const: 1
 
+  '#cooling-cells':
+    const: 2
+
   operating-points-v2: true
 
   opp-table:
-- 
2.20.1

