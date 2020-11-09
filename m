Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9B2AC351
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgKISK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgKISK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:10:57 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:10:56 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so8906188pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rj8A/Ech+iIHcNTsJ3NqAVJDVYSUQ5lILSrgdq6R7z8=;
        b=Is8kLbd/+CQZy7CHNBAiqe0iDgkURgBzXfbjnFLMVgHrK6XhgMNAPdj0vAxvUOZTvg
         e6UxpBoESYzseMPbsdepKvwN8sQNIDUajvRjRUZOt7AP3wWUCKAXWLOOuWFQj5z+Zb+2
         6PmfBc2y63NtdshfJxsKfLLUaPzck67uicNwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rj8A/Ech+iIHcNTsJ3NqAVJDVYSUQ5lILSrgdq6R7z8=;
        b=nrRBBun16m1Xib9u+WGkJaSsTcVLdZAy1XybscwRiKNIEUGddgJNw7jjWNoVRfCWi0
         ZT09KgDMBHMgLx1PUetjohE+iHGE9mraPqjvQAXI5RuNeX8NyOXnNllfYvHgTNLRR/ec
         aHL5RzNbkCWCNTfNILqZazOLnBNJo9AyaE7k0gOXy1/PFnATXpHbqIIMaBZwOiYCxO52
         /rAxJdTseLJPvHeuxMiuuwyTvyTjYQrpA12BZRJpNpUTx6TOGFut4mXqasatzz3Lepea
         5QeLgO2xk0m3u7QpqLR3s8w5pKtTf9DCpQugiv0aTkcTnER4y1L/SyLPW3eXamoxWpme
         i9aQ==
X-Gm-Message-State: AOAM532b844eZa6WdplPpb/rq1a9wt6jLBfj+A/+odtgPcSLB3d4RWp6
        EtNqs76Z8esOQTkMvsjJnZ2L3Tqi3JgKSrUW
X-Google-Smtp-Source: ABdhPJyKovhGH9cTuVFn5lk50zpHzaLBeeY147x36C1a3JDFMVwrVgWmpRe8GFLD/NxhaPQDpMsmLA==
X-Received: by 2002:a17:90a:87:: with SMTP id a7mr391074pja.95.1604945455578;
        Mon, 09 Nov 2020 10:10:55 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:10:54 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 3/9] dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
Date:   Mon,  9 Nov 2020 23:40:11 +0530
Message-Id: <20201109181017.206834-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

10.1" OF is a capacitive touch 10.1" Open Frame panel solutions.

PX30.Core needs to mount on top of C.TOUCH 2.0 carrier with pluged
10.1" OF for creating complete PX30.Core C.TOUCH 2.0 10.1" Open Frame.

Add bindings for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 37fd456170d2..ef4544ad6f82 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -76,6 +76,12 @@ properties:
           - const: engicam,px30-core
           - const: rockchip,px30
 
+      - description: Engicam PX30.Core C.TOUCH 2.0 10.1" Open Frame
+        items:
+          - const: engicam,px30-core-ctouch2-of10
+          - const: engicam,px30-core
+          - const: rockchip,px30
+
       - description: Engicam PX30.Core EDIMM2.2 Starter Kit
         items:
           - const: engicam,px30-core-edimm2.2
-- 
2.25.1

