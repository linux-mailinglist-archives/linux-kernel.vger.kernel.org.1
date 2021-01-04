Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE72E9D11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbhADSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:31:36 -0500
Received: from vern.gendns.com ([98.142.107.122]:38750 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbhADSbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gV5aKHVUEZnAeGLfqRBaMp9PWEXfnOtqUD0uh69C5XY=; b=F5QNPN4Cnbma6YuU5ZoaSTmGta
        wDeWfh/CYzsghaG7G6QhsymUH2dK2yoH7+rM5hxIJEtKZAPqT99RLzrANq/wf3VISOoCUoQ0tFoU8
        OI4WDrAVv6QKc9P+zFK2mQonEA4Fn9BsDok7B0JGcg1YkwoUVtPNJyTUMDpBkRNvS7BsanLePdGJA
        7H3Zcib8l8nVbAjPIIiKw18jKi1lJyu/lSYrUY+qTfA2mTk3BWFwdrqYU+RfJQniM1LDSDH9l5cjK
        MCWoIu5zbr043bUcbxC3HCKaiwAEKIH1+Kx1ZPTF5OugHqvWNgQyf5v4UkR/nYZS11RFM3tc+H52R
        LYYSGRnQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51064 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kwUd1-0002rB-RP; Mon, 04 Jan 2021 13:30:51 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
Date:   Mon,  4 Jan 2021 12:30:20 -0600
Message-Id: <20210104183021.330112-2-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104183021.330112-1-david@lechnology.com>
References: <20210104183021.330112-1-david@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a "ti,am1806-pruss" compatible type for the PRUSS found in
TI AM18xx/OMAP-L138 SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 037c51b2f972..a6ed23fdbc00 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -61,6 +61,7 @@ properties:
 
   compatible:
     enum:
+      - ti,am1806-pruss  # for AM18xx/OMAP-L138 SoC family
       - ti,am3356-pruss  # for AM335x SoC family
       - ti,am4376-pruss0 # for AM437x SoC family and PRUSS unit 0
       - ti,am4376-pruss1 # for AM437x SoC family and PRUSS unit 1
@@ -321,6 +322,7 @@ if:
     compatible:
       contains:
         enum:
+          - ti,am1806-pruss
           - ti,k2g-pruss
           - ti,am654-icssg
           - ti,j721e-icssg
-- 
2.25.1

