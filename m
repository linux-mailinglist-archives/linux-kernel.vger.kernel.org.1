Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40C52B1E57
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgKMPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgKMPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:11:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF9C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:11:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a65so8796660wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDb+qGYh4jaDsxTGRVPLfVt0JRuZgSgBAjphkUAKACo=;
        b=Llv0egOeptdbtiCOvKJGb6sU57rqiN7NoU47tMPz+peEyLwmcFGW8cmAdhmy5lam+h
         SwnlJ9H2WQGK00K9mh5jG1Lvm2A9hwyOpVxqRjTGk0bgxNDaRKgumhHj15yxYbbZLuEx
         skOr4B6K3YHgDMqQE+O0pGWykcPdSOYERYqCHyJ5yq3jkH4BeCrjUbZedEALfk/leXrn
         1xfnqP2EveeJ5CcWBImKyMCxexhXZVLIdpTg1KhDTM06X2cEuPv4g+NnPNg+Krw44x2C
         7V5U46UMhOIsOlFTCI76SUOIdKzNYrdcLLejGPDsnipwmhiN+DTWSD57/OU71qisnguW
         DpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDb+qGYh4jaDsxTGRVPLfVt0JRuZgSgBAjphkUAKACo=;
        b=uJrkXniohIxPbRb6kaF1UmVz4ttlHT1Y/6Iu7k6KjLpLP1FpMkxiv/eUgsPkoRUgrY
         n3hQ0PsBB5Osdsy7svs6QMq747I2paQr5NOv2Nc62d0+kj3/KdMGp5kLL1aLfIXCG04/
         slzHlJ7xiBQTtzLuUSQVQpYoxrPCBourc+KUcx/Gwmxb2l2Qy/C01f4sVEoBD1eqKTEQ
         3eXxQkYhoZQgwnOde/KtI3y9AzJZa/vsfQC0OiURhpmiEZv+cJiHTrgVH2Cowr0KA7L5
         BOlkM9i/0Di5AtR3izco+fWkyPjZnZJbhfazOPnOZTuG/eSQ81Qar3a6WPrrB3bcocha
         mE/g==
X-Gm-Message-State: AOAM530lRHdH4x74LArRuIeps/E86R6Ao6eh88KkruspTLR1jInSqbfr
        N+rResN4uBN2ky+30lEO9nzO9A==
X-Google-Smtp-Source: ABdhPJwXz8vCn1sUmIlvsaEiDFEvNCldmwgH+ELIBf2xjQr36P+xSFupk2UF49g/ZqQDtsBvi+5a7A==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr2988883wmi.124.1605280288509;
        Fri, 13 Nov 2020 07:11:28 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n9sm10527195wmd.4.2020.11.13.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:11:27 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 2/2] phy: qualcomm: Fix 28 nm Hi-Speed USB PHY OF dependency
Date:   Fri, 13 Nov 2020 15:12:25 +0000
Message-Id: <20201113151225.1657600-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
References: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Kconfig entry should declare a dependency on OF

Fixes: 67b27dbeac4d ("phy: qualcomm: Add Synopsys 28nm Hi-Speed USB PHY driver")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/phy/qualcomm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 9129c4b8bb9b..7f6fcb8ec5ba 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -87,7 +87,7 @@ config PHY_QCOM_USB_HSIC
 
 config PHY_QCOM_USB_HS_28NM
 	tristate "Qualcomm 28nm High-Speed PHY"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
 	select GENERIC_PHY
 	help
-- 
2.28.0

