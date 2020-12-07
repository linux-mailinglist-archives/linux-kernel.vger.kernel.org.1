Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF42D0CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgLGJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:21:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44334 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgLGJVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:21:13 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7A50200D66;
        Mon,  7 Dec 2020 10:20:26 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A72FC200AE5;
        Mon,  7 Dec 2020 10:20:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 09FD840287;
        Mon,  7 Dec 2020 10:20:16 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH 0/3] Add sound card support for imx8mn-evk board
Date:   Mon,  7 Dec 2020 17:12:33 +0800
Message-Id: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support wm8524 and spdif sound card.

Shengjiu Wang (3):
  arm64: dts: imx8mn: Configure clock rate for audio plls
  arm64: dts: imx8mn-evk: Add sound-wm8524 card nodes
  arm64: dts: imx8mn-evk: Add sound-spdif card nodes

 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 75 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  8 +-
 2 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.27.0

