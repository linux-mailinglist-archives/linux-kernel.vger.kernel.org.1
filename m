Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D889B28E7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgJNUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:00:49 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:58704 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgJNUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:00:45 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id B077DA54A40; Wed, 14 Oct 2020 22:00:43 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: vendor-prefixes: Add kobol prefix
Date:   Wed, 14 Oct 2020 22:00:29 +0200
Message-Id: <20201014200030.845759-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014200030.845759-1-uwe@kleine-koenig.org>
References: <20201014200030.845759-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefix is already used in arm/armada-388-helios4.dts.

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

