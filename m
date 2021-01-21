Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C042FDF93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbhAUCVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbhAUBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:42:14 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:41:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id d203so541968oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDflA4yuNTlUbw0Uk2L5jr8nyCGDHDhgCKlPACVW+1g=;
        b=K3YD9LsG8u5dpfbZjWZY3o2EqkT0dLIbH8Str3bKPZKDO/xTC7248HblIFSQdH6gq3
         Hj8dRyuAXAJms2l20d+A9dohnMqld/goXJxUs1KNc/ZyfQL8GiDwLYaP8BAQ9lrRBUHd
         o6scXg/wrc1UL0ZljC9NszpZBLl2epW0z+kqT8XbsBC1wAKN38uz4a7HVuDLeg8amBgC
         fYittVc06ERjaytZlUs/LFmI0df40TqrP1ABqz+gOk4jdE4NLrBn7Q3lXYS9Vry400Jc
         lb6y3dXuQkmAsVXq2Tq6rIHZtxEpHiWLZRkGuovGYnpt6+g+Z8aiEHkrKOCuR9J9PDgo
         swfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDflA4yuNTlUbw0Uk2L5jr8nyCGDHDhgCKlPACVW+1g=;
        b=i7M610CYftUElWLLg417F/KqYmsUq4DV6rJkVjFuqeYpNW9AtJ63dOrnyG/gh4jaOc
         dCvT6bkBy3pvzhwYeyZLj0/fSmiZP5huSn5BdsZJ9ZMiM1f7k+UKt6UMqFmyJhQ8aMKw
         g6sdYDlOpeebWIyRm3YTufgBC2AsMblgekFdFs7NO6dpek6zzDz68MwBrDCkX8z7Pmm+
         tgWCj877E+W7C+dK2ULacDbhaB0l/YkNJXYj3x3Cuj9FNA679dhnXBKhu7OvTTaT1md4
         jjC6QFiB6sM9pHlUtl9HHFpObNPQLQqbDAJ+dBUEUi+cF8Px3Qj8AT5PyhK/XxMUZdVP
         HxVg==
X-Gm-Message-State: AOAM531ZGeIj9TXeofU3ZneUAIxdCYc1ffZtEahZViLjcWNBMoqVmz5t
        INFZeXLCJCGEMl4UxaC5cmiDmg==
X-Google-Smtp-Source: ABdhPJybFlKXr/4AOpsYKgduJCZR1R1j77s4XDXoJeasKfYBlC8PNPODPG3h/YsrzpMmQ/xyhgvVEw==
X-Received: by 2002:aca:c4ca:: with SMTP id u193mr3298388oif.178.1611193282998;
        Wed, 20 Jan 2021 17:41:22 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j1sm766978oiw.50.2021.01.20.17.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:41:22 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mailbox: qcom: Add SC8180X APCS compatible
Date:   Wed, 20 Jan 2021 17:41:29 -0800
Message-Id: <20210121014130.1612454-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Qualcomm SC8180x APCS block to the Qualcomm APCS
binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index ffd09b664ff5..ec4054087bc1 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -24,6 +24,7 @@ properties:
       - qcom,msm8998-apcs-hmss-global
       - qcom,qcs404-apcs-apps-global
       - qcom,sc7180-apss-shared
+      - qcom,sc8180x-apss-shared
       - qcom,sdm660-apcs-hmss-global
       - qcom,sdm845-apss-shared
       - qcom,sm8150-apss-shared
-- 
2.29.2

