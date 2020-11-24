Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F822C300D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404299AbgKXSie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:38:34 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:31546 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404105AbgKXSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606243109;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=kIeMOXXOGHJK6ewMOS8V/425b9H+d+22uxD1hGTflB0=;
        b=cDuc27ATs+Y6Ts/KFB5tfSbnwU2dtM6XsJx62cVNX6v6zj8E3h1buZSMHbDNmz2qeU
        vZcZYZoU8BULbkLeIUG2r1NI2CvX16GuJnAv7mG3oG9KGz8q5w45M+ua3+kK718uamZ4
        ywoE2b30ZRQi8KnacgvYk2KOm3bcCU6G2HeSlBdb9PbtaiZDRJLk4pUS8yvMVB5u7mti
        6fTPRw9FZ5c9BdyE70Czmg/a6GLmBOa7FxeuVgaCm6A+O8AmlIX8Kpr+FNc7s4hIHFpa
        9rMm7XKmLSf+Y7siLA7uhveW4v8T/b+ziOjPAQZnY+wcwPeLXPbTlJRYvmlqZZeT/S6Z
        vdbQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAOIcQFbI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 24 Nov 2020 19:38:26 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1khdCp-0008JW-1T; Tue, 24 Nov 2020 19:38:23 +0100
Received: (nullmailer pid 2250749 invoked by uid 502);
        Tue, 24 Nov 2020 18:38:23 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH 1/2] Documentation: mcp16502-regulator: fix spelling mistake
Date:   Tue, 24 Nov 2020 19:37:29 +0100
Message-Id: <20201124183730.2250690-2-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124183730.2250690-1-michael@fossekall.de>
References: <20201124183730.2250690-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Klein <michael@fossekall.de>
---
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

