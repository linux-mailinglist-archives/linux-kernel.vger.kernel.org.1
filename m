Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07C2FE833
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbhAUK5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbhAUK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:56:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDECCC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:56:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id g12so1954207ejf.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n7vyQPX3uPALE1358gqAQz7N/ntgLKSkbInGXz9Zji0=;
        b=qkjQ/pFvBgp/gCR2gs/tVKcH5GN+kzHscswOAkoKSyS1cVEGYw8/sHS1xhj9jKEs3p
         AmThCgKnnIxrggbPdz64RPdUa7Pe49ngYGEDNKss5f3VuQV93wQnzpJ/iEHKjiBJbYr/
         XzrmXMG48li+vFJlbrnWa3RnC3CyXUqjL9KerL/wShthDbEbPrDOAW5j7nQjtdpOfqEA
         8zJP3UXcJa0hVd2ITQUEcHlnYew5II/ylCNlolW+X8bRGW676pz6H3EUrlKhffQSZQaa
         oVKssRoQ/ER8hZCXw3lkQ/IQc5NOrqSD44762o2whdTpLWyLnG9sBnOtVYu6l7S+7Ywn
         5XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=n7vyQPX3uPALE1358gqAQz7N/ntgLKSkbInGXz9Zji0=;
        b=Wl0BPqZk32siB2DEkzdaHfgYXBabcit2L+nvsNlgTNIdUBPXI3oDGljQahbmwJB5H0
         1KvmVIjXxJQCYlw1labc3+mlGlZT7JjpB+xm75j1vcO2zYGU2JpI7MrSll7QNva8AYW0
         opAIScb1viNdnuBVwzelP63qEZeTU1m39tiCDIFw/8SraIcLwxVFULJLKVFV4EbOka2Z
         bHZQVmo3aKPExXg0qokQIAtz+NKBazMzEG4xbg9jlazP/SJsHtMw2hPw6gln+d9cKA4X
         Hd4+pgeWkmaqRS68VRE3P3Fc+Co5796b7XAje49//upLushh052AKQXsqHsmqCCgbgdV
         oGoA==
X-Gm-Message-State: AOAM531+Tt1cLiUs8RjfgA9Pt74uKWMO5RrJZcLDIMcPGeWsygsYsoow
        tRbzw7c5hzN91HUABuF+FWyBI60fcHZmQ8gJ
X-Google-Smtp-Source: ABdhPJx2VleGnV3dYNc5W+JH4VynG0VP7pjQieyjcOK2I4jPVke98qWCngKJk8awVb+J79c4V6XIZQ==
X-Received: by 2002:a17:906:a115:: with SMTP id t21mr8704788ejy.549.1611226565283;
        Thu, 21 Jan 2021 02:56:05 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j23sm2603035edv.45.2021.01.21.02.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:56:04 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: arm: Fix typo in zcu111 board
Date:   Thu, 21 Jan 2021 11:56:03 +0100
Message-Id: <13d064fc4850f96904a04e330cea5295d3751e46.1611226560.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/arm/xilinx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index ae0ef1bf7965..97e77b4e077c 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -108,7 +108,7 @@ properties:
         items:
           - enum:
               - xlnx,zynqmp-zcu111-revA
-              - xlnx,zynqmp-zcu11-rev1.0
+              - xlnx,zynqmp-zcu111-rev1.0
           - const: xlnx,zynqmp-zcu111
           - const: xlnx,zynqmp
 
-- 
2.30.0

