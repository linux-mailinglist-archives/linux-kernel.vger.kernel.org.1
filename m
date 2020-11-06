Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D412A936E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKFJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:17 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33213 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656396; x=1636192396;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=9Jxutl/Gk/wKI16r21z0eDKyy4ooHbZsirRZxMXLqiU=;
  b=Juia1vWaE+u/zdyaQuaiwa/0BtdFsYQxK6fuvZ5lmmwwyukojCkSdx1w
   6MErRI9SzR3w9VdjrpPu1bzDWwvmddy7mOLU4btLQGh1bYGmAeeR0AUug
   PdygMq/0+NX++ooMKWfW0E5p/t04J+cbNyoofg+ZIsdhcfjNeXmxzvVIW
   qz9tZ1CwluQ9gVz8vgf/fyPn6gGJgMoSqBUZ8ieXzvCCnRvCidPkPaJBt
   GyS4ScgUyOEh7YJeRUpLFC2FmksxT8mkk/meVziz4Wnc4yYCh4q7O5STT
   otqcqTCZZRjRjZCHuT10np95YQDA0pmQJTGghV9z2PDPBK4INNcvPBC0R
   w==;
IronPort-SDR: w/vgWTOUbQBC0Qi+fIlJXhaGV4HKsIgClVqlmAYLy4hI7nNzlYW1wNVsyR5YeCxGelAAzi7Hq7
 DY8pG0nEQdBQqaij4SNj/vVvdRZjZCTxLr+KFICCklr+dKivYcQp7G4hzwXilRZGcisaKPQJ+h
 8Pwqw1aPItPuR8HHOUQ1qErI6CdMrNdK7uO/x9sSkCIG/F1FrGsHfSr3v0tXZPtfspKJVSjXIW
 Dwx0bro7Fic7M5wio/SddzXK3hifFSd69ETch3VWErHLZ0p7xCCQ8XE10VM3pP6D1HMtEagmad
 OTc=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="32681416"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:15 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/6] regulator: mcp16502: add support for ramp delay
Date:   Fri, 6 Nov 2020 11:52:58 +0200
Message-ID: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
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

Claudiu Beznea (6):
  regulator: core: validate selector against linear_min_sel
  regulator: core: do not continue if selector match
  regulator: mcp16502: add linear_min_sel
  regulator: mcp16502: adapt for get/set on other registers
  regulator: mcp16502: add support for ramp delay
  regulator: mcp16502: remove void documentation of struct mcp16502

 drivers/regulator/core.c     |  12 +++-
 drivers/regulator/helpers.c  |   3 +-
 drivers/regulator/mcp16502.c | 132 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.7.4

