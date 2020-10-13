Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC928D217
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbgJMQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:21:28 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:41386 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJMQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:21:26 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 12:21:26 EDT
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 931E8A53275; Tue, 13 Oct 2020 18:13:42 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: vendor-prefixes: Add kobol prefix
Date:   Tue, 13 Oct 2020 18:13:39 +0200
Message-Id: <20201013161340.720403-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013161340.720403-1-uwe@kleine-koenig.org>
References: <20201013161340.720403-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefix is already used in arm/armada-388-helios4.dts.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..b2cbdad45846 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -545,6 +545,8 @@ patternProperties:
     description: Kionix, Inc.
   "^kobo,.*":
     description: Rakuten Kobo Inc.
+  "^kobol,.*":
+    description: Kobol Innovations Pte. Ltd.
   "^koe,.*":
     description: Kaohsiung Opto-Electronics Inc.
   "^kontron,.*":
-- 
2.28.0

