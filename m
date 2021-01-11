Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52702F0D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbhAKHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:39:55 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46478 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbhAKHjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:39:54 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E097D1A0202;
        Mon, 11 Jan 2021 08:39:07 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 938CA1A00B1;
        Mon, 11 Jan 2021 08:39:05 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 787654029B;
        Mon, 11 Jan 2021 08:39:02 +0100 (CET)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 0/3] Enable flexcan support in LS1028A/LX2160A
Date:   Mon, 11 Jan 2021 13:08:46 +0530
Message-Id: <1610350729-21287-1-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds device-tree support for LX2160A-RDB/QDS.

Also, update flexcan entry for LS1028A and enable support further for
LS1028A-RDB/QDS.

Patch1: Add dtsi and dts properties for LX2160A
Patch2: Update dtsi properties for LS1028A
Patch3: Add dts properties for LS1028A.

Kuldeep Singh (3):
  arm64: dts: lx2160a: Add flexcan support
  arm64: dtsi: ls1028a: Update flexcan properties
  arm64: dts: ls1028a: Enable flexcan support for LS1028A-RDB/QDS

 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 20 ++++++++++++++++++++
 6 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.7.4

