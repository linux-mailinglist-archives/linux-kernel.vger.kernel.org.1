Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7847290AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbgJPRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:36:12 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60992 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391668AbgJPRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:36:03 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09GHQLpa024369;
        Fri, 16 Oct 2020 12:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=5ARtZ8iuUZWTt92xPnGmGgGIFglUvN30JaId3ybKh1U=;
 b=GqfLhYq5fVpf+NH05aA5aX6efreXaoZKcOKIXf8AFjnDuhgwGvpB1ZBdaBjpsln/gC4h
 JajQmv+HrdtfuzSRUt6s0d56rZpsJrlr5b2w9tBdrsFyeTfMVxdg/hKEVTChxPzitGdu
 eDOZxAHo//3K9LsLrF990RCy/EtNOI8CnUgEec0At13WXlzHXkec6cDmo8VpzgKUoFhc
 gSsRcekD0ACXP5JEKop4s3VrbLNltWrWYda8QbtJSdkloLcHmkGdKSTurH9qYQrOPHvs
 dEp6D9CwM1cUKzqgcnPc8lQRXiQ2R2WmzjRP4t5AwdmnIoceJFvYUlpeatKfe51Lz7JB dg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 343ac20jk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Oct 2020 12:35:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 16 Oct
 2020 18:35:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 16 Oct 2020 18:35:44 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1542545;
        Fri, 16 Oct 2020 17:35:44 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/7] Add support for Rpi4b + Cirrus Lochnagar2 and CS47L15
Date:   Fri, 16 Oct 2020 18:35:34 +0100
Message-ID: <20201016173541.21180-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=871 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches provides support for using the Raspberry Pi 4b with
a Cirrus Logic Lochnagar 2 audio development platform plus Cirrus Logic
CS47L15 codec.

Patches are needed to audio-graph-card to enable support for setting the
component sysclks and plls. The codec sysclks and plls cannot be placed
under the clock framwork because they are I2C/SPI-connected peripherals
and access to the registers would cause a nested get of the I2C/SPI bus
clock. The clock framework does not support this and it would result in
a deadlock.

Richard Fitzgerald (7):
  of: base: Add of_count_phandle_with_fixed_args()
  ASoC: audio-graph-card: Add plls and sysclks DT bindings
  ASoC: audio-graph-card: Support setting component plls and sysclks
  ASoC: arizona: Allow codecs to be selected from kernel config
  ASoC: madera: Allow codecs to be selected from kernel config
  ARM: dts: Add dts for RPi4b + Cirrus Logic Lochnagar2 + CS47L15
  MAINTAINERS: Add dts for Cirrus Logic Lochnagar on RPi4

 .../bindings/sound/audio-graph-card.txt       |  44 ++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 ...bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dts | 166 +++++++++++++++
 .../dts/bcm2711-rpi4b-cirrus-lochnagar.dtsi   | 201 ++++++++++++++++++
 drivers/of/base.c                             |  73 +++++--
 include/linux/of.h                            |   9 +
 include/sound/simple_card_utils.h             |  24 +++
 sound/soc/codecs/Kconfig                      |  18 +-
 sound/soc/generic/audio-graph-card.c          |  16 +-
 sound/soc/generic/simple-card-utils.c         | 184 ++++++++++++++++
 11 files changed, 703 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar.dtsi

-- 
2.20.1

