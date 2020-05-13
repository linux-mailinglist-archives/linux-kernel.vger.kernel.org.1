Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD151D03FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 02:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgEMAzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 20:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbgEMAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:55:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F005DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:55:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so10355474pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aVsTRV0Vd7AjARuX1FSoP3j3p4vMbsUynYNIWG2zcg=;
        b=ITZ6s8nfqeBtfn0oVoLGCgrnjOV1Xy0pZ3QdECW67KsV/hkeylPh/9bZ5pY1ytrDEv
         MYdwBAJh+8DHuXK6VaGPgTKlQozijma7VAZhrA2jziS2Wlfl2Aj0GO+oGXYBdvOHYkNI
         1zyQX/hfzOnC2niIDuG1u0ohwO0xg+hWVawxT9+Pn0+2OOKKwn0xZv2Qvv+BXw3KPfaT
         Ba0QGr4CYQTEmMg3MUxArtF/PEekKi386oRGyi9pXGwCAQiIgxbtoqYViHsSJgREiy1K
         Y7ilsmDsR0Th/RdJdnf+j5yqKLOCA3bz1sKYYSDzKdxvqgerEGPd3qk7PmVJDXYSzYoI
         zGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aVsTRV0Vd7AjARuX1FSoP3j3p4vMbsUynYNIWG2zcg=;
        b=Qmq0Q0I22YYjZUPX/8OsZNO2+/t3mIqCHRiuIefpeA2D1qkyNz6tObO5oXyAOxrp9I
         rabqhnQNnGAe0gjC2+2W+Fq9z5ton2gYLYBvTEXz4PaD9De9OjhLAQIEzAQ7LGz4lYVo
         q/gyUdX/Tygtr7XO0+fQ5O/ZUDwGSSqAsBBcHhyd1hB1YhzmE1akdzBNZs5VOSlws+p6
         K/CPs+KvzJsP1flBMZ5FgXb04/wTcykEzpclAgF+mV2S4lzMThdC7WUv5u3eLGdQIpcc
         v793yEVS1/WOc3S+mXuEvSSrTE++pICGVUSpyOnqKUNEm1UH6ylFtX5IG2HHx1ZBMj6f
         k43w==
X-Gm-Message-State: AGi0PuZapQz/Nuju2OpD62w2zV7dKTyMJlGZ1176+eOjQSRabpH4puk7
        Yyo0dvFRQw6GEbKDeMGb0IlmLg==
X-Google-Smtp-Source: APiQypI3O4oBkDtpKaBNHwg5f+8AZEbJC5eKmdrym5Hi5g9Mw7N4wvHIlkhR/lrQNiEANYIJvRADLA==
X-Received: by 2002:a17:90a:da05:: with SMTP id e5mr32780994pjv.140.1589331329287;
        Tue, 12 May 2020 17:55:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm11057428pgh.25.2020.05.12.17.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:55:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] hwspinlock: qcom: Allow dropping the intermediate TCSR mutex syscon
Date:   Tue, 12 May 2020 17:54:37 -0700
Message-Id: <20200513005441.1102586-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all modern Qualcomm platforms the mutex region of the TCSR is forked
off into its own block, all with a offset of 0 and stride of 4096.
Update the binding to allow the hardware block to be described directly
on the mmio bus, in addition to allowing the existing syscon based
definition.

Bjorn Andersson (4):
  dt-bindings: hwlock: qcom: Migrate binding to YAML
  dt-bindings: hwlock: qcom: Allow device on mmio bus
  hwspinlock: qcom: Allow mmio usage in addition to syscon
  arm64: dts: qcom: sm8250: Drop tcsr_mutex syscon

 .../bindings/hwlock/qcom-hwspinlock.yaml      | 65 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 11 +--
 drivers/hwspinlock/qcom_hwspinlock.c          | 72 ++++++++++++++-----
 3 files changed, 124 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml

-- 
2.26.2

