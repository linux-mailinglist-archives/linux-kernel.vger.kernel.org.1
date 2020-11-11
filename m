Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9310E2AECA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgKKJHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:07:31 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33326 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgKKJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605085638; x=1636621638;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iv3G4J9JUq3CxncRA4zAVFQQuvvOG2VBpsyejAP8KX4=;
  b=rJXAzCNBxsNis8k1/qIOsiRvkQ4aOmoXKlpOZT4de90hp3naF5TeHpNT
   /EAAPsVOgx8302UG4JZ4d2oQY9F0WgPxJvnC3YftXbBkhZTWkmZJsRa5j
   5rm7kUH0AlxphrsLG++Mq71Xl3Y3rrjs9YyL8FQ6Rrkn2nMTWbSDPhm2M
   9PB5ZlM0oGxUnKBw7crfiPMpwCMTqWb+5WrQnnS0hX5nLBKBoOmRl+5Hj
   1wijM7rN1CnQFhjl2B/fITRSWN7ORHVoDd4o+fR1MPgdWYGQ2azyMnkzE
   6NN3+/WbLRNTuQu/1JU9bFMIIzVeviFq1bAYWJw0HtaljONIh6US3yGfe
   A==;
IronPort-SDR: HjhEgYHHaEFPFQXguKKGG5L4Tvf6wQTms6tte+nn1lUZcy4/caXnqawvlUybA/zV0Si77+iQkY
 swyL5bh4jDm2gJOp4gLSeni5nox/zejOgqW5F92kPScV3qwPdT/MnE5jHtzBnd7xxFHp8MD37o
 vlLNI8SZP7O3288uNh24lu0UaVIdFpdwDn1x8lvPFgVRD5Dx/iyzKbLJ83gt1YoqkGnsvLFgad
 Rpwu7HQ8KjwZ+ZM67czTxCEozbQWQd79cu3w8Q5E/Zw2abYB54DsrFJdesLidluz4gVu7zUrje
 vdY=
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="95887090"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2020 02:07:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 02:07:16 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 11 Nov 2020 02:07:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/6] regulator: mcp16502: add support for ramp delay
Date:   Wed, 11 Nov 2020 11:06:12 +0200
Message-ID: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for ramp delay on mcp16502. It also adds
some cleanup on mcp16502.

Apart from that patches 1/6 fixes the selector validation in case
the regulator::desc::linear_min_sel is not zero.

Thank you,
Claudiu Beznea

Changes in v2:
- rebase on top of regulator/for-next
- checked 1/6 and 3/6 applies on top of regulator/for-5.10

Claudiu Beznea (6):
  regulator: core: validate selector against linear_min_sel
  regulator: core: do not continue if selector match
  regulator: mcp16502: add linear_min_sel
  regulator: mcp16502: adapt for get/set on other registers
  regulator: mcp16502: add support for ramp delay
  regulator: mcp16502: remove void documentation of struct mcp16502

 drivers/regulator/core.c     |  12 +++-
 drivers/regulator/helpers.c  |   3 +-
 drivers/regulator/mcp16502.c | 135 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 127 insertions(+), 23 deletions(-)

-- 
2.7.4

