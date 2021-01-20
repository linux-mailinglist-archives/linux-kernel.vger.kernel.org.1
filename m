Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B82FDDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbhAUAXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403980AbhATXV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:21:58 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0AFC061381
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:48:54 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d203so125307oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuVWjtozf6tjlsvTP6rUGUhjtA8BmU3safV4j5QLlLQ=;
        b=nlGl7XkCn0rg50zVcDNjsmuukkfEOvpVyBlVcaMu/H4VJ2N65Ja8HThIAVmA0XvKUE
         I3Lt1N0/nKH/HuzFXYl7u4q3a5weK9gxb2QRWGXVeH+KM+fvd7apdKvmNjKqDGva/F0y
         5qs7KuuQAKD86CGeszH9jvRlqrEbHllHJu0HoijQHuMT6QnSmYmV6tbaAbsEI1GQxUNz
         QcOSj4jnh1+80PgrS0RQKVoYEXRmXREsA6hSYsC1ovBriluYFk7VjOugxE4Y0zvYkGtK
         s1KbFvMFDC0elSWxWy3Yioq/fnmb0QKRQmN1fvgUWDoQ/LrezOynlQFJeUy1nVycTBuW
         sXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuVWjtozf6tjlsvTP6rUGUhjtA8BmU3safV4j5QLlLQ=;
        b=smgKBdQk3MbmAfJ+0d8RbhSe3LjCN5RocGhixU7a1rR7iC52Za4EbKRfto1BCYWq8n
         fj1knkv4leTuCburzvUZq3QqvlIa6KbhHwHjq2o88QnRAJ6+1gHQ5EjEUN0HtqC4l+nZ
         X9waEOUGb+RmqKzGr+whlp9Fa4i8m31bRlpJyRVCZYuTDaJOTqg7oTqD9M9XENhr43NT
         XNMNZH8Kq3Vqv5sJffo7bYHUTTC5EO8+vQkw8Q/9cTAtr73Fmi/F+TZboIlz5p95Z4gx
         1DNon6VyVSjnGnvLkAG7KQyunbyp+eztsa9PlUK4bO9/AqpvEPVCxjudrpCWJ7RxpJ5v
         9+zA==
X-Gm-Message-State: AOAM532V/9SBOd6pn6Fi4294XaDjEgRkucuFqF24UcrOyAQMxOgsqKP3
        bZaMK+lSMfDi3g4Yt6IvEbFa4XQ0ApZc6w==
X-Google-Smtp-Source: ABdhPJxZqWHSauMNZuTKTGMF6uVC1ybsgbKaS5vmmG55n9fCvqGa+cEE0LBXhCfO/FIo3QTGqSpuyA==
X-Received: by 2002:aca:4e12:: with SMTP id c18mr3008348oib.68.1611182933617;
        Wed, 20 Jan 2021 14:48:53 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r14sm706740ote.28.2021.01.20.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:48:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: qcom-rpmh: Add pmc8180 and pmc8180c
Date:   Wed, 20 Jan 2021 14:49:00 -0800
Message-Id: <20210120224901.1611232-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMH regulator compatibles for two of the PMIC variants used on the
SC8180x platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.txt       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
index 7d462b899473..ce1e04354006 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
@@ -50,6 +50,8 @@ First Level Nodes - PMIC
 		    "qcom,pm8350-rpmh-regulators"
 		    "qcom,pm8350c-rpmh-regulators"
 		    "qcom,pm8998-rpmh-regulators"
+		    "qcom,pmc8180-rpmh-regulators"
+		    "qcom,pmc8180c-rpmh-regulators"
 		    "qcom,pmi8998-rpmh-regulators"
 		    "qcom,pm6150-rpmh-regulators"
 		    "qcom,pm6150l-rpmh-regulators"
-- 
2.29.2

