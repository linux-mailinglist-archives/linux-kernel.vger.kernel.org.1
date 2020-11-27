Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232372C660B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgK0Mww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:52:52 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:17509 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgK0Mwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606481569;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+5GbyrGaTQLcWS3fDVfBX6HApp+b0jPB0ubFLEsp0g4=;
        b=KpFWadxuomW5lC9TpRLNG5rV+a4Cuw50e1iJI0tirJLoSSKjHSBiVEbDx4dmtgh3WM
        Jcsw2W6oNSh9LuX/vZ98I9BHXOdcWqAoyVPG47h0fbiiFCOOy/0KzPbcwdk/mPIDJnMa
        qRTca3KjZ44goDA2y5cRdmlmh3dIV0d/+U5+YIkxLnyc310xGu4fisls1o9cbIj4eMqB
        +JqPog4XUJlpzCafcvX5yIfSQndrjGfUZ4Tb6jLRnLMSh+WrTai6dVD01yVTGw4BFPG4
        X9J4syzzxshdLYcKtA89f4jHHVly6gQhTkYTrTBFOKcuxznAVd7LR84ugTsG3ThfRk0Z
        n45Q==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wARCqkaJc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 27 Nov 2020 13:52:46 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kidEt-0003p7-NE; Fri, 27 Nov 2020 13:52:39 +0100
Received: (nullmailer pid 23977 invoked by uid 502);
        Fri, 27 Nov 2020 12:52:39 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH v2 2/3] mfd: si476x-core.h: fix "regulator" spelling in comment
Date:   Fri, 27 Nov 2020 13:52:01 +0100
Message-Id: <20201127125202.23917-2-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127125202.23917-1-michael@fossekall.de>
References: <20201127093142.GP2455276@dell>
 <20201127125202.23917-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"regualtor" -> "regulator"

Signed-off-by: Michael Klein <michael@fossekall.de>
---
Changes in v2:
  - split patch
  - make subject line more forthcoming

 include/linux/mfd/si476x-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/si476x-core.h b/include/linux/mfd/si476x-core.h
index 4708c2b8512a..dd95c37ca134 100644
--- a/include/linux/mfd/si476x-core.h
+++ b/include/linux/mfd/si476x-core.h
@@ -57,7 +57,7 @@ enum si476x_mfd_cells {
  * @SI476X_POWER_DOWN: In this state all regulators are turned off
  * and the reset line is pulled low. The device is completely
  * inactive.
- * @SI476X_POWER_UP_FULL: In this state all the power regualtors are
+ * @SI476X_POWER_UP_FULL: In this state all the power regulators are
  * turned on, reset line pulled high, IRQ line is enabled(polling is
  * active for polling use scenario) and device is turned on with
  * POWER_UP command. The device is ready to be used.
-- 
2.29.2

