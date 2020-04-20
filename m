Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC31B1328
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 19:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgDTRcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 13:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgDTRcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:32:08 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA2620BED;
        Mon, 20 Apr 2020 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403928;
        bh=7aBAnRak5Bldx4cBNSXIUSnVBTzqbPpz13Ef8H6bw6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRwFFMZ5PgGHnq4m9KPyYvozIDZo4gptcKMxqi+1sZar+3PKOHpM0m2VaNSD+2Xni
         rUXm/AqGtr8PpVIVz5nJPuBLoK/wkaIs9r7RpSxcc4Sa26VKsXFG4OqoPANudJc6Xc
         aDkRsQn8vt4WFpn2rLfjDC5+R+wQdyKsC7zWN12w=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 5/6] dt-bindings: arm: stm32: Document IoT Box compatible
Date:   Mon, 20 Apr 2020 23:01:23 +0530
Message-Id: <20200420173124.27416-6-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Document devicetree compatible of Shiratech IoT Box.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 3849f1d0e03e..790e6dd48e34 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -39,6 +39,7 @@ properties:
           - enum:
               - arrow,stm32mp157a-avenger96 # Avenger96
               - lxa,stm32mp157c-mc1
+              - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
               - st,stm32mp157a-dk1
-- 
2.17.1

