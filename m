Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857022FDBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbhATU5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389560AbhATNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:51:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CDBC061350
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:45:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a1so1853284wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vztiGMVp+rvsTFKWIicHjtSmUWk3pLrrjlnb+8+XkDo=;
        b=dT23SxdOb6Y9xBCRkwxpCNfTfrakj5EBLLf4T+faZJW08iKW0fi9uK2B3r4T30FBKD
         7pplan8HZA/ALOtNoucFcoyrdNXk6WK9TdYPVycsTU/y3+hsUUWqv0EcUDGHdaZk5itv
         KIbip9A4PwPa/iNuPzzggi4NCQYei8DYW2SoLUV1HzRDaYh95EKo/GFRHrKrfan1Iun8
         gevAszK/9Hugka5fd4wRLR3ZUZf6Yw1aRStp8tcXN6SqDDC7CXB122x0G3PWIiKRHCCk
         tSDGLAz74kBHcGFdQHvTrGxrLkyMPAaxdmbnFILm/0grNEuwpAWJuUrU0PAb+QepuHl0
         utDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vztiGMVp+rvsTFKWIicHjtSmUWk3pLrrjlnb+8+XkDo=;
        b=atY3q/Bm1CJOPSyfwLnMSzrTPVsaiGZiHVMpG1gjSvjQ0PF+pzITKC2I5zlC6S4b4r
         iGosaAfaGD92dOVdAnJa9dwabLDOCHKXE4IBT+KiZU3Dj6zZATywFT6o+5ms61hQca5L
         9aA+FXrrjBRS3LLZ/qiUHXiuhyQHhBWHDxnWVJmKceu5UMdiFQwVElF91utwyjnKH/Bb
         jJhq3PV2KXEVHrqnLE5z1HdgS+qtOUHieRLDcl+B2ltp+Mg7N/81qIbjeD9Sf9I8844d
         49GIi+AeA6L6WWsUCOpxpyzxOXxMxAstFy4FAdZJ/LQ3SNuX/2iwm2CsfU/MkcfVOZIu
         S22A==
X-Gm-Message-State: AOAM530+D7tuF+GdMLYsu19jHvHWS2HpV1RgTlvoKsA5tpIiq4dN57Sb
        GvtAKf5UELeEme0EroZ3G3KYoQ==
X-Google-Smtp-Source: ABdhPJzcDDIc++DKDwG28GvjCyGwlaq/0VFE1rXnXTpPxCR3vv7fJqFE0CqOMkofHxMEDJckZgd75Q==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr9173834wru.43.1611150299729;
        Wed, 20 Jan 2021 05:44:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:93b3:1f80:ae7b:a5c6])
        by smtp.gmail.com with ESMTPSA id t67sm4224075wmt.28.2021.01.20.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:44:59 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        vkoul@kernel.org, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v2 17/22] MAINTAINERS: Change CAMSS documentation to use dtschema bindings
Date:   Wed, 20 Jan 2021 14:43:52 +0100
Message-Id: <20210120134357.1522254-17-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120134357.1522254-1-robert.foss@linaro.org>
References: <20210120134357.1522254-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the complexity of describing multiple hardware generations
in one document, switch to using separate dt-bindings.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47fad204d6aa..4008e321a584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14684,7 +14684,7 @@ M:	Todor Tomov <todor.too@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/qcom_camss.rst
-F:	Documentation/devicetree/bindings/media/qcom,camss.txt
+F:	Documentation/devicetree/bindings/media/*camss*
 F:	drivers/media/platform/qcom/camss/
 
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
-- 
2.27.0

