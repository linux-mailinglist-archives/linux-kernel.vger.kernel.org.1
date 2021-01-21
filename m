Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD42FDF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436519AbhAUCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733217AbhAUBpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:45:42 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFAC061793
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:44:45 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id v1so159866ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSOj20wU38WLZItU9aq3eVQavxTOlD1bx1NupAfDzqA=;
        b=eAp1RNqvKbKxbEnD3UpsFoJ/pR3X3AHl6MGBYtR/yPr1LVxAx/Z9Lt3Vsl7tuHar6x
         Ilyx1iYvr6zZXsq/3w1IyGRl+vK8K+gVlOPgAh1aHc1yCnC0yarwk0xEEA8XtjGKNMud
         Hr9ypC/PjlLTSN86Lahqi0a3alxucvbPKfOBseUefYkToyjPgU5tjPK7CUPtaxM/9DTV
         fDWXNx3sJNHzZ2JrnkHKyO9d8a4yaiRVFwdMJ0y2HmmxchT1l7pECerCB0h2NJjr3oan
         4RMDKOdT9qbMRc8JbtuvCuZMWUqgtPGrrW3OnO0RLBLAvul4OW8CAoQxK9l9qVflLKKw
         URmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSOj20wU38WLZItU9aq3eVQavxTOlD1bx1NupAfDzqA=;
        b=KqADb/eWPkTLLgy4FxFzM8B7x6G0/XpmaB3uqRABgsYqvDmi8+uOenHCKrrn+6iikh
         HNjCuLJYYmo058fSdAUAMX9dbMPvf/rqxMoXcPqU5qQIzqY/eTvZuo/SlSUfewitdQxN
         wSKLnTPwwc0IQcfQ9MWy/Gtm6tRdO3j7Gu7TmlGI8nPteuYhX6lWGe3KzFf6LKCMd75C
         x130TMvA/pAKmfblPkkk3IOdUeKdptY/wLIRq1z3JESbcnII8O13GJGYotjB6atQUXO1
         +AF+6mlX+AxFH4AgzIilPDCIM2VymOqlTNs5DQ9483/owvKQjT1KZa869ogxBgOG3pLI
         mEVA==
X-Gm-Message-State: AOAM530zo8RIysmKGsjTT4Dmnrl6CVpSuTOyu11JlB9bC4dlN49rjaZN
        jgalEIF1nQhujIVox/NJFUclxA==
X-Google-Smtp-Source: ABdhPJy1vaytfi3EOBpVFrAAruN0P9ZpJCf3x5rAHTjeco2ouzipknDaIW47X4W2NjHRIn1PfHl3iw==
X-Received: by 2002:a9d:20a8:: with SMTP id x37mr2208163ota.62.1611193484808;
        Wed, 20 Jan 2021 17:44:44 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x197sm758026ooa.27.2021.01.20.17.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:44:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom: pas: Add SC8180X adsp, cdsp and mpss
Date:   Wed, 20 Jan 2021 17:44:51 -0800
Message-Id: <20210121014452.1612594-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Audio DSP, Compute DSP and Modem subsystem found
in the Qualcomm SC8180x to the Peripheral Authentication Service
remoteproc binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 54737024da20..f9129e455310 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -16,6 +16,9 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,qcs404-cdsp-pas"
 		    "qcom,qcs404-wcss-pas"
 		    "qcom,sc7180-mpss-pas"
+		    "qcom,sc8180x-adsp-pas"
+		    "qcom,sc8180x-cdsp-pas"
+		    "qcom,sc8180x-mpss-pas"
 		    "qcom,sdm845-adsp-pas"
 		    "qcom,sdm845-cdsp-pas"
 		    "qcom,sm8150-adsp-pas"
-- 
2.29.2

