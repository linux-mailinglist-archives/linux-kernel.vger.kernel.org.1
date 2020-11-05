Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6683B2A8164
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgKEOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbgKEOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:49:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14601C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:49:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a3so1926086wrx.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsVx0tqKa5RJACoTi7hCHH0q4zK+zFVU579TR+p2CVA=;
        b=qT/oHbNzoUizwTiWyAsyr0GI8ImlLFG1V6pp1KRWs7xCE60tWaAFco/TTKXO8R7hm7
         isIGCffGUBTNIAkP7q9o1FMHTqwag06K11FsRdD4SZlL7gKKzzDMrXL2FXkl+wtyJwbe
         4yC/gNjnbbRBfhBXyfOEWTO75Wp70tnLIYbW1YrSu86r1YOkb0g4c50GveCP5lAh1nGQ
         bzMxYNwUskDmUiajA6dUDmTL5eSYwIdbSntSH75pJj0d+C8T7kI8XGxGPvRKqlCdn87h
         1jXJg/IW8HcK+n1QCg0kS9lKd9Vr/xLqD6CmY/q6ibYb6tCtVm5fVcJqmzrj3GYvl47I
         AcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsVx0tqKa5RJACoTi7hCHH0q4zK+zFVU579TR+p2CVA=;
        b=bNGUebiM/sFUMfh/3NAWek3nftY3xANasXSv2/aBhNNtmId0p5rukOsd7fISwUDu8h
         Yp0fCA7RHcqlo4MZ9FeH4MY9fccTLeQb19xl1DSiKNHM489wcv/gs8l+e+/ZH6XxbwVB
         RXvuQpR2/2Nu+ZbnGB0JNyXrGI+YJ2AsFE82liyAN1rsvySfEvZm/sWWwygF4Un9h3er
         9QB0dbgoiMXNVaYbL8/lY1Ar8g3Ll3NZCRtmKaxuDhUm3TZDu6huPA+6qRK96o3mUamh
         2GmRdtGrPMwP2mW8HwgwdrPfxvpr+hS2+6+l+QHD1SJwCTFIv5Fr9PwmSBbmAn7okLcx
         pWfQ==
X-Gm-Message-State: AOAM532UJQY9J7psdZPQGdF+LV7E68gbRUM+3WtSjCRNyM9MyQAhdtR3
        OTRMxzFiorPxVIr/+8weH2onsZG+gHVbQveSsQg=
X-Google-Smtp-Source: ABdhPJwToUnj75KVBc+fJmbKsEd+nEXPWq8voPmrSNS6JYY6JoVOpzjGHc5tZWy7zf7XvA1KZc0prQ==
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr3381665wrn.248.1604587794786;
        Thu, 05 Nov 2020 06:49:54 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z11sm3055512wrr.66.2020.11.05.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:49:53 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: arm: sunxi: add Elimo bindings
Date:   Thu,  5 Nov 2020 14:49:44 +0000
Message-Id: <20201105144945.484592-3-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Elimo Engineering Impetus and Initium

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 0f23133672a3..ef2ce3bd2bed 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -201,6 +201,19 @@ properties:
           - const: dserve,dsrv9703c
           - const: allwinner,sun4i-a10
 
+      - description: Elimo Engineering Impetus SoM
+        items:
+          - const: elimo,impetus
+          - const: sochip,s3
+          - const: allwinner,sun8i-v3
+
+      - description: Elimo Engineering Initium
+        items:
+          - const: elimo,initium
+          - const: elimo,impetus
+          - const: sochip,s3
+          - const: allwinner,sun8i-v3
+
       - description: Empire Electronix D709 Tablet
         items:
           - const: empire-electronix,d709
-- 
2.20.1

