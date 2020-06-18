Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E881FEB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFRGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 02:15:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46938 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgFRGPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:15:01 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D33D61A0E3C;
        Thu, 18 Jun 2020 08:14:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EA441A00D4;
        Thu, 18 Jun 2020 08:14:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 048B64024F;
        Thu, 18 Jun 2020 14:14:50 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Add audio support for imx6sx platform
Date:   Thu, 18 Jun 2020 14:03:44 +0800
Message-Id: <cover.1592460381.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio support for imx6sx platform.
Enable ASRC, ESAI, SPDIF, MQS.

Shengjiu Wang (5):
  ARM: dts: imx6sx: Enable ASRC device
  ARM: dts: imx6sx-sdb: Add MQS support
  ARM: dts: imx6sx-sdb: Add SPDIF support
  ARM: dts: imx6sx-sabreauto: Add SPDIF support
  ARM: dts: imx6sx-sabreauto: Add cs42888 sound card support

 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 96 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-mqs.dts   | 48 +++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi      | 30 ++++++++
 arch/arm/boot/dts/imx6sx.dtsi          | 36 +++++++---
 5 files changed, 203 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-mqs.dts

-- 
2.21.0

