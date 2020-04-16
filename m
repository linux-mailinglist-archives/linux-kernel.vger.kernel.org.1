Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A446C1ACCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506818AbgDPQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733250AbgDPQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:11:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DDC061A0C;
        Thu, 16 Apr 2020 09:11:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q19so8395385ljp.9;
        Thu, 16 Apr 2020 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjk4TOp9DkEsXeH5hQNnG1jF9KFMqVg6rNNTj7d/UsU=;
        b=pCslmX6HHeRy1aIXeE2iB+WUUY97k3WpjhJQ3tuVJiT7xNNL3gyBew9f0yczKv3VSg
         8PFxLNzAGmCe9yJxSh8RtpjM1eVeT9bQeHYsEflL6A8dw9xdaOEMf366PlgGN+BJxSpy
         gibrbk/S0O8983Q67jH1WI66mRlp4FKIUwiMCdOU4QbdEIgccxMvsDgHHW6UJNtFyBSx
         T9oVvVIEm0rXkoYkRkFJVGL05kC5iwEFRX3JdnCz7dFf0pvBbNi/6WW8grMW+0NdgWCh
         Bk064XUIPKOITiAMzp+vgnmddB/FQhoT/K3HbTEAgBc9rRUPbT7mY1HI5xMlUzpmUY1R
         17Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjk4TOp9DkEsXeH5hQNnG1jF9KFMqVg6rNNTj7d/UsU=;
        b=OTpgx57KhvQ1/VbzYthvRZOvmjrGnDPyA2RnOMvqMKY+SN5uoXeS6qmYRFmYRm4xFs
         uZ9cuDQfjVao7g1f6cyAS7QiNzjGc2ORsqMV3fE1Y/WFfWYFHonCVziMfpAerNlkNSmg
         cTl4FnpL1eHasia2gfLGmgbQ4pu/vaTWRwv/I4xU2Qgrsr+uGvNFFpDmWPufd0ZjXZfP
         cPktiN9V0M8sBbh+GJG1y6DF599RZ3DnHzEcmbJ9vieTpGTOaJbQtDuIZIl7qn6FG2cg
         LRtwM7PBwlqy7tsq8ZBCeLM6U7qySU3f/dUrhKgJ//GStqFXhVMljkrV+3O7/UrrSgVy
         A3wg==
X-Gm-Message-State: AGi0Pua+Iedw20+qarF0K+TSY2JVUJehW74bvDcZ/hJ1y5xwLZ6T/vRX
        3MgljrIvXcWczEneyO0B1dw=
X-Google-Smtp-Source: APiQypIvfSNHxElBHhLWG0Z1ZuQbfUSaL8aCI4tk6aUmgDRnkeS7tGTkifA2seZfzFf/2WAxv3gz4Q==
X-Received: by 2002:a2e:5851:: with SMTP id x17mr69352ljd.183.1587053473297;
        Thu, 16 Apr 2020 09:11:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id 125sm15702234lfb.89.2020.04.16.09.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:11:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Thu, 16 Apr 2020 19:09:53 +0300
Message-Id: <20200416160956.16468-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416160956.16468-1-digetx@gmail.com>
References: <20200416160956.16468-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer is a hardware and electronics corporation, specializing in advanced
electronics technology. Acer's products include desktop PCs, laptop PCs,
tablets, servers, displays, storage devices, virtual reality devices,
smartphones and peripherals. Their web site is http://www.acer.com/.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66a7382add95..357aecba3e45 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -27,6 +27,8 @@ patternProperties:
     description: Abilis Systems
   "^abracon,.*":
     description: Abracon Corporation
+  "^acer,.*":
+    description: Acer Inc.
   "^acme,.*":
     description: Acme Systems srl
   "^actions,.*":
-- 
2.26.0

