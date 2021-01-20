Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C962FD7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389456AbhATSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390513AbhATR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:59:58 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ACCC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:59:14 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 9so25978892oiq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3U6vYGtVByg2m5erRhHMzBzAjaP5prWspvQEAVY9PBM=;
        b=BqVUi1lHHvSjnBV1pZlQumIEQjIPfYjmend3IeZrB4kymw0W0EBFwYxIBa9xtpIJXv
         t8JsEZN8aXoaKP9glxERsAufIB6lmV6RfQxH8tEvfXB5QLV3q3qd1Sf5GWvEzeSPK0a0
         vw9ehStEHB6v1ru32ioXtxy7ebo2fPzFtps1neFaKjpt3AD7PMSKrIH8OLI2KeoT6Jty
         D5zOJZs3huE7HniE37GXu6sRfpKL4qzjfGiA0dChn12nRzHDSnSI5lQUkT4dRDtT7m8B
         V8HPWyg3stVghFtEizTYR/jb5ASFjZU5p2sq/mnSeRYa/sQ6k+7WvA11GQC1APLkIfAf
         +vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3U6vYGtVByg2m5erRhHMzBzAjaP5prWspvQEAVY9PBM=;
        b=diccTnOA3KGwT6/n6NdkWhj+mwAlBW6l0TYJO1MxBBVdk7GZyxWbK0kW9dx7YYAF2H
         wj+cyfOyLwYIlsUddHPaeBuVehS8hnAc33kyAXbCV67D2Y8veMWQOj0tA9PSyyjQZp7x
         ao4jVxgcp1asglIVwp2kz3AgzlC74+um6EK40q9eyCDo+9791vWp2NhHBgVPr3FF6MBU
         L7PQptSq/SCZl7RB9nDECDsuxmCd6DuD4FDOFPLCcWCvRSNaG1C4UEdeVI8LNcPBQ6Pk
         mO0l7o4Hj6fQabyg8vuv/EdI4mbLt8yzNx9byD5EhTI+eYXC3zzY89uCDq/agfiBZNTl
         7Ejg==
X-Gm-Message-State: AOAM531cEf8rjUMZnCRO2fVyndOB9qVYwxgYMm8xVDre/rCa5bvCAajf
        I5oeh71Xm+6tg4ALhMeGs3Vu3g==
X-Google-Smtp-Source: ABdhPJzMa4naberyKAQmIyMibf+8/N+b6lX58rrLjrB7kNI9H0JT/6aWR2QZBr4hkaZHhrv5qOUoXw==
X-Received: by 2002:aca:a9d3:: with SMTP id s202mr76631oie.140.1611165554215;
        Wed, 20 Jan 2021 09:59:14 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p25sm507421oip.14.2021.01.20.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:59:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dp-connector: Drop maxItems from -supply
Date:   Wed, 20 Jan 2021 09:59:22 -0800
Message-Id: <20210120175922.1579835-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meta-schema recently gained a definition for the common -supply$
property, which denotes that maxItems is not a valid property. Drop this
to clear up the binding validation error.

Fixes: a46c112512de ("dt-bindings: dp-connector: add binding for DisplayPort connector")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/display/connector/dp-connector.yaml      | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/connector/dp-connector.yaml b/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
index 1c17d60e7760..22792a79e7ce 100644
--- a/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
+++ b/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
@@ -26,7 +26,6 @@ properties:
 
   dp-pwr-supply:
     description: Power supply for the DP_PWR pin
-    maxItems: 1
 
   port:
     $ref: /schemas/graph.yaml#/properties/port
-- 
2.29.2

