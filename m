Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B381245CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHQHDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgHQHAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC522078A;
        Mon, 17 Aug 2020 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647624;
        bh=c2iqZxUTrABiC5JI7O9oyGOZzenMfnAdZyCso0axLWk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BTTL5kEeNVXnm5H1IPfHDRFmBc5CfCWLiVeMC+6c17g5Y71Xrmpcm95XzZfid6QkZ
         I6+zgOLzJuq9KMfoH3aEUvXkVMqvci6Pd8MRXUhkjTDZ5TBxjqWSC8o4pk9zOHMIle
         kvEuu4R7MCCC5QO9XFbsoVl7N+o6/DprIrL3Kuds=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 03/13] dt-bindings: extcon: ptn5150: Make 'vbus-gpios' optional
Date:   Mon, 17 Aug 2020 08:59:59 +0200
Message-Id: <20200817070009.4631-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PTN5150 chip can be used in hardware designs with only reporting of
USB Type-C connection, without the VBUS control.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index 1ddc97db3e61..4b0f414486d2 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -32,13 +32,13 @@ properties:
 
   vbus-gpios:
     description:
-      GPIO pin (output) used to control VBUS.
+      GPIO pin (output) used to control VBUS. If skipped, no such control
+      takes place.
 
 required:
   - compatible
   - interrupts
   - reg
-  - vbus-gpios
 
 additionalProperties: false
 
-- 
2.17.1

