Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4F19E4BD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgDDLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 07:52:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39309 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDDLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 07:52:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id e9so10691295wme.4;
        Sat, 04 Apr 2020 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7JWQaNHlZkGey2CYstynUU1J9hNrgdTpL9zcYilbqk=;
        b=KMcn9it08ctna9tgMEQrsjpXRPY/0IlCndUov70cazbmUWifl1XfERwQwaWbxb8fnc
         CLSlKcbbvKF41FGA533Eo8T6KEFilYbQfMX6N8aj2xG5UyjGjz1EHWEzRMlxi47pQ6l/
         JbVRLrHt/o1cYKG4K+Cbl8/dAuKYYNau7sL18LJTBtmT5ZB7yvb5lxVrEYqrw+VOQPLg
         tHdn3DP5eElLfpIwficpxfYtQwSeKfIcHOzvNeTewtwjILWrUU9eROXl2mfMeT+3XpiG
         D2wB2Z5h4oRkvkYHL/5jX95ZgLH6PaAb1G/9UpiUXrBwceXrAL3QjS4G40EoPA50iojj
         fLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7JWQaNHlZkGey2CYstynUU1J9hNrgdTpL9zcYilbqk=;
        b=sLhRqWa+EXS7YZlA34Zjgk3dAqITRZXKCYxJG0WI8gkDHztQaH0uDRqUblUT+JQBMo
         kn44FNUjGSvkMj07zUVDqAWTla6o3bjgg+diKEBCw1Xdx+4ifXV1c4rv3/fYvfRpLAll
         5FFCXxGOcOTREezQKyRsBb7c6ILI0DkxInmvKRwKblFkGAGdYJG9At9jvjSVHL7nsYM8
         cdjnxZIu7FHsLAAuVDQinoUGs1KpWVdxSGoL5VQ/t0EE/YyXZch1YsPQBq0FUJpJu9zB
         GWIsQM60PWAHN/m1pz99C5+D+vKzl+Dpjnfpzls2l5Dnn9s8VLF+VvmmD79gkenjReQv
         9t3g==
X-Gm-Message-State: AGi0PuZuBNG9xiHNPCnGIuXdVti+gRtFCXDA77/6ZNuKQpZrjCzCkNcQ
        4U9pl68RP3hRqrPsK/dfEcT0u4O3
X-Google-Smtp-Source: APiQypJOBCdxMEJ3ncc/Kkyn7t6jJ/t0d4nR31OFtbx1bKw5Uw1QEC7QFaR1ybRs/cSapZBPKEkpqg==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr12504001wmi.29.1586001154733;
        Sat, 04 Apr 2020 04:52:34 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g186sm16183276wmg.36.2020.04.04.04.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 04:52:34 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: sound: rockchip-spdif: add power-domains property
Date:   Sat,  4 Apr 2020 13:52:25 +0200
Message-Id: <20200404115225.4314-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200404115225.4314-1-jbx6244@gmail.com>
References: <20200404115225.4314-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'power-domains' for rk3399,
so add it to 'rockchip-spdif.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v3:
  Add reviewed by
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index f381dbbf5..c46715265 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -51,6 +51,9 @@ properties:
   dma-names:
     const: tx
 
+  power-domains:
+    maxItems: 1
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.11.0

