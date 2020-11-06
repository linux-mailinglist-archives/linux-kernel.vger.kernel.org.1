Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1596A2A9374
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKFJxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:46 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33261 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKFJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656422; x=1636192422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bL4b2G1z+hSvb2mT1f4bDkWQQS5bBvnQanE7rK0peHM=;
  b=z+UuI1CqZyW5SsHTfRgdPuzbSpgmn1CHx6+hCY0dl/A0dyMqwnMy2ZFs
   g0wmrR5bPQKacE/1xmNCoyFXS1KrYlAtJ3tIttjJzIjzrZ1lm4CiYS4pZ
   ZRGxbOV507u4I10ilezyivGfaludA+j250nRYU229807FrOYsd7F+29q1
   lFD2h3aIOH3IHWM+wX+OU/Y+1aENDMMjP6k5S5j5lNVB7+CVkR84og2JN
   vPMhtgKn38wOvaQNaK6bCqkdQeFhdzh1ekm1k4BSjPU2ZKq1oryuK7veD
   6EudvNaEeuT1ii8jQlUkYqIxzWkH+PaPBYKRZpnclDO/7k+L+cPVdalwi
   A==;
IronPort-SDR: NElkqgOsk5izQdVzLddqnChz4FwMDUmahFwpQRONnSP8Hu3nD6/b20hPn2oK6o/N+4KfYrIPLg
 R1jmmqn+y9H7QRbIREfJfNtqvtR0P31ZxCjf2Ap1oMrtEjdZlvRdSFZokzdFVomNYh7icqohsp
 bjy6WLQynyzsLcOdw4b846ZtlEtXCYps5E7bf6e/g5Uq94VvmzqqRaiDAGgPOvRF2a8BM/TM/o
 FphzL3JyN+1BkY/n5RLW33QRe1AegK6MjgJ+v46A+jr03eCekJmIY72n4QxNP0M/p1rklG6Nsq
 9zk=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="32681471"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:41 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/6] regulator: mcp16502: remove void documentation of struct mcp16502
Date:   Fri, 6 Nov 2020 11:53:04 +0200
Message-ID: <1604656384-827-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mcp16502 has no members called rdev or rmap. Remove the
documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 0cd4f5936e94..7a46641da60e 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -135,8 +135,6 @@ enum {
 
 /*
  * struct mcp16502 - PMIC representation
- * @rdev: the regulators belonging to this chip
- * @rmap: regmap to be used for I2C communication
  * @lpm: LPM GPIO descriptor
  */
 struct mcp16502 {
-- 
2.7.4

