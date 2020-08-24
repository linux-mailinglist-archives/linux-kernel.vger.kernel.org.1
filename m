Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8924F36C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHXH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 03:56:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39058 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgHXH4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:56:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D115A1A11FE;
        Mon, 24 Aug 2020 09:56:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 106541A02F7;
        Mon, 24 Aug 2020 09:56:14 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 17BE4402D2;
        Mon, 24 Aug 2020 09:56:09 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Add headphone detection for sound card
Date:   Mon, 24 Aug 2020 15:50:36 +0800
Message-Id: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add headphone detection for sound card
and add audio sound card node for imx6sll.

Shengjiu Wang (3):
  ARM: dts: imx6sx-sdb: Add headphone detection for sound card
  ARM: dts: imx6sl-evk: Add headphone detection for sound card
  ARM: dts: imx6sll-evk: Add audio sound card node

changes in v2
- add pinctrl_hp, don't add headphone detect GPIO in hog group

 arch/arm/boot/dts/imx6sl-evk.dts  |  9 ++++
 arch/arm/boot/dts/imx6sll-evk.dts | 73 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi |  9 ++++
 3 files changed, 91 insertions(+)

-- 
2.27.0

