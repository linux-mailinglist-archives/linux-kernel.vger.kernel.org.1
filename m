Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33D128E28D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgJNOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:54:52 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:19950 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgJNOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:54:50 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EEpi7x023902;
        Wed, 14 Oct 2020 09:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=5gpOaifqkyHGSGsd6h7jaAAlzyQmydM3Z2vku9IislI=;
 b=CYE0Yi8rJr6uMBLKvIu3qBAhGfXDBQuQtdnuGR2zSXR7zLRpCm711jYfnbcJCUhmwaD3
 INW6bIncywPL3xJExc0wcGZ0KxJt6t/5mGUh+1ci4izXfGBmDoUUuJQfIndRtBAnYWTW
 utRIbknon7gaNSgFTm4XZS3S9nv7j7hNVunreo8UsqTwprpbglhFFcsD82yzm2jD0cW2
 1m2OYEaZ6IIzMLTj2iEQfhFkxigSbOp/q9WApYyUkpBexdVHf72pUsPzgEFWl6u0sL8f
 +BN2tdmbalFxyX1AvpPIP8tH96KosoTGxuv+fOEI1AruQAQnBtqGJqPfx2FoyMiBzdBo nw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 343ac1wbwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 09:54:34 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 15:54:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 14 Oct 2020 15:54:32 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9D41045;
        Wed, 14 Oct 2020 14:54:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Date:   Wed, 14 Oct 2020 15:54:11 +0100
Message-ID: <20201014145418.31838-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=936 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches provides support for using the Cirrus Logic
Lochnagar audio development platform plus Cirrus Logic Madera/Arizona
codecs with the simple-card machine driver and a Raspberry Pi4. The
ultimate aim is to provide the dts file but some updates are needed to
the simple-card machine driver.

Patches are needed to simple-card to enable support for setting the
component sysclks and plls. The codec sysclks and plls cannot be
placed under the clock framwork because they are I2C/SPI-connected
peripherals and access to the registers would cause a nested get
of the I2C/SPI bus clock. The clock framework does not support this
and it would result in a deadlock.

Richard Fitzgerald (7):
  of: base: Add of_count_phandle_with_fixed_args()
  ASoC: simple-card: Add plls and sysclks DT schema
  ASoC: simple-card: Support setting component plls and sysclks
  ASoC: arizona: Allow codecs to be selected from kernel config
  ASoC: madera: Allow codecs to be selected from kernel config
  ARM: dts: Add dts for Raspberry Pi 4 + Cirrus Logic Lochnagar2
  MAINTAINERS: Add dts for Cirrus Logic Lochnagar on RPi4

 .../bindings/sound/simple-card.yaml           |   56 +
 MAINTAINERS                                   |    1 +
 arch/arm/boot/dts/Makefile                    |    1 +
 .../dts/bcm2711-rpi4b-cirrus-lochnagar.dts    | 1296 +++++++++++++++++
 drivers/of/base.c                             |   42 +
 include/linux/of.h                            |    9 +
 include/sound/simple_card_utils.h             |   24 +
 sound/soc/codecs/Kconfig                      |   18 +-
 sound/soc/generic/simple-card-utils.c         |  184 +++
 sound/soc/generic/simple-card.c               |   14 +-
 10 files changed, 1635 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar.dts

-- 
2.20.1

