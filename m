Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37C12A0470
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgJ3LgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJ3LgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCC5C0613D4;
        Fri, 30 Oct 2020 04:36:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k3so8095884ejj.10;
        Fri, 30 Oct 2020 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1Ao30WPRL4ldSmbvVpiCzCepSQ/TYiLIf3C2FmArRg=;
        b=TxJmHX/uZMIyPoD7cD9IwHru0niymwIo0OtJy1O43o9UzbGMWphcJTYCkNMPhNKR4U
         9vfem1HPGDq/XjWuJMyjnP0X6mky5uPJv12XqAT6Zhe1Cq3QbbxMENgnPZroidAIMdKo
         mesFJTXRPHPtDPinHti37QGfCxP6hPFQvLNEJvi7QqWHSW/yYIpowZM71y0nfBruSRG/
         lbaCQxlYa2Hj0gAp/Gb0OjBWdESA3vN7cGMjCsUKwutNg2tfa9SlTrqiBXCGw+IV0u5K
         MmmqOuOpCxto4bFEgMtYO6rNhTjzezenaB2Wi3Hf2xpPqi7LrOyy6uF2cbYH70tIcLhU
         xW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1Ao30WPRL4ldSmbvVpiCzCepSQ/TYiLIf3C2FmArRg=;
        b=PjZ2iz7JTcmbti6zO/yieycDSUZsmdboGxbB7qkmpIzN32lX/2ea52ZU+rkQTg6iJC
         kcNdLP8pM+MQyepB7/YCL3K66cqQQfxNE/ZhpMs05byuCuUJm7+kQm4QYpXR2DGbk6YR
         8MFGx/RMos89EqdwKMRDeY53Zj/nYQTNoKjx+4kRuEkLhxXYfieCgRXzQIw0eaqVatbB
         ha0KcpAXLERfqI4tzOFA3508DtWeRMsXNGW1PKmzTWzNK97AnzAhPs5CBtOdl5uBdzUl
         ce5SQI9UKOAiL1wPMLkelt/bfBsKmYeqNSJLZ+K1i5gguT/S4HwOpjuPTyztnTs8zoye
         TNpQ==
X-Gm-Message-State: AOAM5317Z+a4LLOuMeMNbB0rbeiywT1EgqbvkA6s2I/843kAzoik1HHC
        g0zm97s89vpZEO8KyKlb2Zg=
X-Google-Smtp-Source: ABdhPJxIip0/RWfWiC0kKWcllNRT03KabTbdeEezl/A/YVnoi/xNqVbj5FD7hERSexhkMB3zz2mscg==
X-Received: by 2002:a17:906:eb57:: with SMTP id mc23mr1913406ejb.373.1604057778303;
        Fri, 30 Oct 2020 04:36:18 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:17 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 02/11] dt-bindings: net: add the 10gbase-r connection type
Date:   Fri, 30 Oct 2020 13:35:46 +0200
Message-Id: <20201030113555.726487-3-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add 10gbase-r to the list of accepted PHY connection types between an
Ethernet device and a physical PHY. This is available as a valid
connection type since commit c114574ebfdf ("net: phy: add
PHY_INTERFACE_MODE_10GBASER")

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
 -  new patch
Changes in v4:
 - none
Changes in v5:
 - none

 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index fdf709817218..cc93063a8f39 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -95,6 +95,7 @@ properties:
       # 10GBASE-KR, XFI, SFI
       - 10gbase-kr
       - usxgmii
+      - 10gbase-r
 
   phy-mode:
     $ref: "#/properties/phy-connection-type"
-- 
2.28.0

