Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB032B1E75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:19 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:42999 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605280878; x=1636816878;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=YXgfgr2knptkzSXCzMDZEs0JHWWcZETLqSKKH7uRk5w=;
  b=khS7yF6kY2Si+a42eCFyHnhYvPmY5977c84wcNztO8zs6xSqy3th5jjR
   P5LXJSnnRPQdtdqfpB1qjWmO14LIkLcOc9jcprSxbmji34jAIkIkgaFyg
   XZNvwWu5DqbD8Sz0fBuMCU/T4oFFmy61ijbWH6g+FYHSFqtUNMcDWblCI
   DiO+8AE7AGnIZ9YoM5xL3ibzj+Ax7hQPJZGRcL5d6wszsEluVXRhBW+9j
   f1gjBJ2siCBU4kKjjWx5K6gC7pQQR5ha2wDINH8enGi63Ubp9mTFNFOOA
   oEc+mxtMN1OPvxl6s6dcUOUQrybXQtLl9pQt9JK5zBEe72sqxj+doEdKi
   A==;
IronPort-SDR: sjhkPn+RfnVqlGyEqeCAjNV1PWFXYKBNYDb8TN7qo+zaVLLM+I5z8Wr8gQsbHvJGDuKyxHOihw
 1U9hj30zQbPODoIbXIluD49vIY0VelIpJ2uuST1rff5rIXn75xug1gc6o8grx1lJQrJ9DKyZbl
 g6x6YhSjvoyg/PGu7kquJGhz2prrojxrMiFcCSvSy5cGRvmd9Y8XydWWBSGtWBtSWsDmH1WALQ
 nDpR8AMDRyNkLj7v9aPj7Z5GkrOatUZXSETv9gOTtXhlzQSAIHq/CP0iyuYyFT2BKrqByNuTbq
 m4w=
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="93552093"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 08:21:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:21:17 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 08:21:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/6] regulator: mcp16502: add support for ramp delay
Date:   Fri, 13 Nov 2020 17:21:04 +0200
Message-ID: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes in v3:
- fix compilation error in patch 5/6
  Reported-by: kernel test robot <lkp@intel.com>

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

