Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC74A2B9EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKSX5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgKSX41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:27 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52113C0613CF;
        Thu, 19 Nov 2020 15:56:27 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id y17so10370113ejh.11;
        Thu, 19 Nov 2020 15:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/kom7NijqsMwRJVpqdKHhmhpkXVyd91CqXAnZ7knhQ=;
        b=hjsfJ1qJwWPEkq3pqY3/lcezS9BfVdTSxGeoYe+fR3pMjo117Ql2YvrcX8CWLWRbwJ
         QcgQTJ0DB7VrSCxSAGjoNjro0kSkxhF9iEZtFy0jPRjy3qLRjX7VxgYC743MB3oaGAKk
         /GPKnjEaNqIgKTRHiXcUSuP60AI8gHixIo0S+SviQGec+caR1hlhBEqCKT3o1OR2s5Xt
         Yak41QcQw/L8Hk7oEwi/qNc1hH0/88lcqxrsBpJPlJlDjw9gaocX5i/ejGef9zn6wTLo
         TXx5ssevijIuBIYTGeZIiWsiwZ3ablI4lYZHOtI3Oj4NAylsuZwygRqnNGsSsKx2EXVz
         L6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/kom7NijqsMwRJVpqdKHhmhpkXVyd91CqXAnZ7knhQ=;
        b=nQ/B8UBhqgVWrYGQphcD3JZCByp30uK1PG4F61C+OR14hnKhS8+S+f/Xx1bOswGWK1
         zQ+lQE8Pmu3vKJHXL68po1QBWLGMifw5sUBC1e5+89d6exJreUnmpU83SGgJWDLoWn8y
         mYr7vQSkchDRpUDeIBGds4IGM2tYKe5w/qJjcFfmyOopVzQAJQLyPMxAxlJ8MMbVPoUk
         5l3BeFerFsDCWPvIqu3KIB7p6dwQbpzgZ65ZakkzWDFKvlXA6LwRwq9+0DMhbcomN8oW
         fyxbhs75ePTk4kiDGQs7KeGQxgTjTJohYt7sT0e0OCDXJJURF7oBL3eNXTduyoJQ/jRK
         nWMg==
X-Gm-Message-State: AOAM533kSTg1cGuNZqgUFCDVe1JkN52eNN3AR0GZiwrbW1/NTn+PHB1f
        z4F2dY5kvDBTq+Il36GqfJ8=
X-Google-Smtp-Source: ABdhPJxKEaj29J0PFKCynZb2N8TsEbOqaDyZgd+JmzRUpUUx5mbKaiKyBpcwzYgoRqjeDSyZKdvFMA==
X-Received: by 2002:a17:906:4dd3:: with SMTP id f19mr28748547ejw.364.1605830186082;
        Thu, 19 Nov 2020 15:56:26 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:25 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2 08/18] dt-bindings: mmc: owl: Add compatible string for Actions Semi S500 SoC
Date:   Fri, 20 Nov 2020 01:56:02 +0200
Message-Id: <713f57f4a66fff9a50a8d93643a7987d6560becb.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string corresponding to the MMC controller found
in the S500 variant of the Actions Semi Owl SoCs family.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index b6ab527087d5..b0d81ebe0f6e 100644
--- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -17,7 +17,9 @@ properties:
     oneOf:
       - const: actions,owl-mmc
       - items:
-          - const: actions,s700-mmc
+          - enum:
+              - actions,s500-mmc
+              - actions,s700-mmc
           - const: actions,owl-mmc
 
   reg:
-- 
2.29.2

