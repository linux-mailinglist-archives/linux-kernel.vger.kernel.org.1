Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319BF2FD7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbhATSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391597AbhATSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:04:36 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DCCC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:03:55 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f132so25931522oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0c/YZ8GjVTyP0w+VrpQ2AmOJVqjrISAFl9tsDI76YM=;
        b=m7s2uKE2WCxSZn2wLO2vYX7Euav+c2Ak6HnopbS/GJRBt/XTC+atumqnMnAUs1+x/5
         A80g6czwDlidrwjxfaoqEc6vQc/YEHoOyYA5YKD5PM1wJjEzSRJ9ljsWl3jFAmfB3Isy
         LJRWCNB6HxnFe8KM8+awbM9twcpaHaQEtS11llI3mSY4p36W8O1BQlhcst+egEZazry+
         h/vX4ikLeotfK96E+7Ik7ju11zhAlG5xuuT9ML9sAKbHtxamD5mGa/2buyIVPUHwqade
         Zhqq7wQ2ibWwhqUyEi1WAa7yGqswSJHw7kjQ1utWxW90y7b6QToLsL2h8c6ETq4DdrCO
         06NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0c/YZ8GjVTyP0w+VrpQ2AmOJVqjrISAFl9tsDI76YM=;
        b=NR2NWy1SLQUTB5RPIVn98DOIyRicZiGU1P03+k+V7vUm9N3wuVAu7dWXXUlnGovaxH
         C9k8Ysv/OVxK3fRynSdxEk1YITjOiTklTFYLixxjCjcUjx1dkYyE/SmBaezrWxRJvcQ/
         O13mYL9i6fhO/MBV8CJNWVJ6wrCFJtlxsRaYx4ipaXKSpzcu9TeSqWmsB4GPe0qGcyeA
         HLBBN0duN2vy0Pkq4P8ap5Z1j72LHqhJx/UiZVMig9hPntNaaYgL0171I5BzHiHTGV0Y
         Msh4mr1MygE01cBzqSGvKl5B1zwnse+3b9hT9T6Um7hoMQ1yEi8DXrnTxeRd6ynNQIpg
         PmvQ==
X-Gm-Message-State: AOAM533XmiSJ0MwSnfGwpLuYUMPp0whAAqR3EkhjuMa3XdHsx1p1N/tp
        IdxZzw9wDPO3OC/N6E3P4g2ZAg==
X-Google-Smtp-Source: ABdhPJwPY/Qtx36Vw0VkDh29SyG9rkmTQemhiiJHu7Ba1no56dfgF4UL15rJtGE794O4rIyCvoav8A==
X-Received: by 2002:aca:c188:: with SMTP id r130mr3726383oif.99.1611165835041;
        Wed, 20 Jan 2021 10:03:55 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t2sm545263otj.47.2021.01.20.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:03:54 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: media: i2c: Fix $id of renamed ov5647.yaml
Date:   Wed, 20 Jan 2021 10:04:03 -0800
Message-Id: <20210120180403.1580423-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent rename of ov5647.yaml missed to update the $id, resulting in
a binding check error. Fix this.

Fixes: 1b5071af8240 ("media: dt-bindings: media: i2c: Rename ov5647.yaml")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml
index 280c62afae13..429566c9ee1d 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/media/i2c/ov5647.yaml#
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov5647.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Omnivision OV5647 raw image sensor
-- 
2.29.2

