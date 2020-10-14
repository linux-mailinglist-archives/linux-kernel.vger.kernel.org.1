Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DC28DDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgJNJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:40:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33859 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgJNJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:40:53 -0400
X-Greylist: delayed 160822 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 05:40:52 EDT
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7D6ED1C0009;
        Wed, 14 Oct 2020 09:40:50 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be,
        laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: media: renesas,csi2: Add V3U support
Date:   Wed, 14 Oct 2020 11:44:39 +0200
Message-Id: <20201014094443.11070-3-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014094443.11070-1-jacopo+renesas@jmondi.org>
References: <20201014094443.11070-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string definition for R-Car V3U.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/media/renesas,csi2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
index 533c2f181db7..4dbcda6b1788 100644
--- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
@@ -29,6 +29,7 @@ properties:
           - renesas,r8a77970-csi2 # R-Car V3M
           - renesas,r8a77980-csi2 # R-Car V3H
           - renesas,r8a77990-csi2 # R-Car E3
+          - renesas,r8a779a0-csi2 # R-Car V3U

   reg:
     maxItems: 1
--
2.28.0

