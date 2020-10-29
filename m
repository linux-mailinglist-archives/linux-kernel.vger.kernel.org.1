Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B629E288
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbgJ2CUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgJ2CUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:20:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w23so1018789wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7e0bJaET19S6NiwsiKrSw9DA5X8tfkfCtJ3heEXMJA=;
        b=nHp8UeY5GDrXnxtkMuDdr1mg1I9aF5qHNdprVTW4e9d3sLnwfJRnNcOY0oY0PjZ2V9
         EQH6a8ZIAPc3rXdEycdFDAKeUChDA1+a/Ove3KsTiR0Nky/vgoxfh25vy62moyBkkcUT
         Zvev+yjYyPbZOaXCxciiivH+zpE6CgJTvZ9WG20uqM24nXAZcl4JSB9LANjJEhDEhYgO
         Ds53bqcwXz0PDvY7tqjQqAtrgY0s3MJr4/JumL3gO/nMJXoQiCPzG/n8x6QStKHhpZpY
         2qt/v8OKgJCunQ6XZW1SmbbJPFMKCHPVGeLdvdNljVOPsyDo9yyZx07l9XIpnCJwqPrA
         mOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7e0bJaET19S6NiwsiKrSw9DA5X8tfkfCtJ3heEXMJA=;
        b=rqVJM0VWM5EwjGbsVdizweWTZwA94Ajp3c/ZCyt8Xn85PCY+v0MW/v4WnaHLvkBU1i
         XfaNEbyxBq7PqePN3HWKkFl8rLOxNIhNUbw/5OKL6eXDSsWBSAXK8vgAP4eEN+gjwKao
         83a5ROgt06NJaeYYPtthiXbsdza1RxRqvUY9KYTxwEAYJgyGryFeCGpV0aRYZrje7/C2
         /s9N5cSRhPmkpgQdF+ILMmOZpsq40GzMbxDIQMzT4C+8K7gZMJPcEaIKIlebzbpLWLlJ
         THIRaaIawzt8B9kPZVpSDgmO2NzSx69/9+jI1ySgZM9vdwiEzTeiI9NeOfk5Tag5rrXR
         d+eQ==
X-Gm-Message-State: AOAM531KkxnVseCb9rT+wgK0heHkkD5tN3CYQdWuyL5obYkllONXEAsZ
        rR+g0ShawnQL3P5FLbpn+CU=
X-Google-Smtp-Source: ABdhPJwueWwXh0oX1tS9MeU1qG/68NmhY01DnD50t1ulWBRXDHphgbCLCLzHfrM0ZnvnD8AErAUJBg==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr1753417wmj.149.1603938029079;
        Wed, 28 Oct 2020 19:20:29 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id m4sm2138937wrr.47.2020.10.28.19.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:20:28 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH 1/5] dt-bindings: vendors: add Elimo Engineering vendor prefix
Date:   Thu, 29 Oct 2020 02:19:56 +0000
Message-Id: <20201029022000.601913-2-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add elimo as vendor prefix for dt bindings, since we are adding a dtsi
for a SoM and a dts for an SBC

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..b877a3516277 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -319,6 +319,8 @@ patternProperties:
     description: Elgin S/A.
   "^elida,.*":
     description: Shenzhen Elida Technology Co., Ltd.
+  "^elimo,.*":
+    description: Elimo Engineering Ltd.
   "^embest,.*":
     description: Shenzhen Embest Technology Co., Ltd.
   "^emlid,.*":
-- 
2.20.1

