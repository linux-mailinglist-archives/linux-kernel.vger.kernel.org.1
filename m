Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19587223FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgGQPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 11:48:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60268 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgGQPsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:48:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58295200998;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B93F20097A;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 09A9B205C9;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] bus: fsl-mc: scattered updates
Date:   Fri, 17 Jul 2020 18:47:57 +0300
Message-Id: <20200717154800.17169-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds some scattered updates to the fsl-mc bus: first we
add some missing device types that can be found on the bus, then there
is a change needed for the PREEMPT_RT variant and the probe order for the
newly added objects on the fsl-mc bus is changed so that allocatable
objects are probed at first since they are being used by any other
driver.

Grigore Popescu (1):
  bus: fsl-mc: probe the allocatable objects first

Ioana Ciornei (1):
  bus: fsl-mc: add missing device types

Laurentiu Tudor (1):
  bus: fsl-mc: use raw spin lock to serialize mc cmds

 drivers/bus/fsl-mc/dprc-driver.c | 57 ++++++++++++++++++++++----------
 drivers/bus/fsl-mc/fsl-mc-bus.c  | 30 +++++++++++++++++
 drivers/bus/fsl-mc/mc-io.c       |  2 +-
 drivers/bus/fsl-mc/mc-sys.c      |  4 +--
 include/linux/fsl/mc.h           | 32 +++++++++++++++++-
 5 files changed, 104 insertions(+), 21 deletions(-)

-- 
2.25.1

