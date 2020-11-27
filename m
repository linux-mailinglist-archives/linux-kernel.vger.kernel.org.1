Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C052C6609
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgK0Mws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:52:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:29169 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgK0Mwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606481566;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+4Tlg9o9sDCXRNrOS1zeeXhxYevXjrt4PV7O9T4JgDw=;
        b=Csa1bG/icWR87mf1pvsRpbsNqmhAom6KmdiCY1yjQ5dK+dRXgegWE5duln7fUKT1K+
        2EVf7W9ihBrgL88jElQ/dpuoKadp4jlEwSyZ7TWfNqmy7mR79u2k3CfhTslWecn5qYM9
        qoDY1yFMCFBaIfFo7TV1LcxcYOjlAm0FV4PdxU+9ufqHJuU7W7O9fdMAFMn9G7nrtF3Z
        IZBqsKGu5qFwwseQxkPrB3AojGZqPmDEYSbcu0ona0mim6KkxaDP/+0CMgdDP4z4TrPQ
        8cVJQb39/DEJTt2bOI9tc4Qe80RgBdF3IxyehgLma5qBKeLRKxS1oQ0RWpn6rJYAlezN
        awaA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wARCqgaJY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 27 Nov 2020 13:52:42 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kidEs-0003os-HF; Fri, 27 Nov 2020 13:52:38 +0100
Received: (nullmailer pid 23974 invoked by uid 502);
        Fri, 27 Nov 2020 12:52:38 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH v2 1/3] Documentation: mcp16502-regulator: fix spelling mistake
Date:   Fri, 27 Nov 2020 13:52:00 +0100
Message-Id: <20201127125202.23917-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127093142.GP2455276@dell>
References: <20201127093142.GP2455276@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Klein <michael@fossekall.de>
---
  No changes in v2

 .../devicetree/bindings/regulator/mcp16502-regulator.txt        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
index b8f843fa6092..d86584ed4d93 100644
--- a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -10,7 +10,7 @@ Required properties:
               name. The content of each sub-node is defined by the
               standard binding for regulators; see regulator.txt.
 
-Regualtors of MCP16502 PMIC:
+Regulators of MCP16502 PMIC:
 1) VDD_IO	- Buck (1.2 - 3.7 V)
 2) VDD_DDR	- Buck (0.6 - 1.85 V)
 3) VDD_CORE	- Buck (0.6 - 1.85 V)
-- 
2.29.2

