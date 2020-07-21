Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04987227B81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgGUJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 05:19:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56030 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUJTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F5E720090C;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4349220044D;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 04B4D202A9;
        Tue, 21 Jul 2020 11:19:30 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/6] staging: dpaa2-ethsw: various fixes
Date:   Tue, 21 Jul 2020 12:19:13 +0300
Message-Id: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds various fixes to the dpaa2-ethsw driver: checking
the received notifier block before acting on a switchdev notification,
destroying a workqueue after deregistering the notifiers, making sure
that new VLANs added have a place before actually adding them and other
problems like this.

I know this driver should be moved along from staging but we still have
the Rx/Tx functionality on switch ports and some general cleanup that we
are working towards. This is tackling the second part, no new feature
added here.

Ioana Ciornei (6):
  staging: dpaa2-ethsw: verify the nofifier block
  staging: dpaa2-ethsw: don't allow interfaces from different DPSWs to
    be bridged
  staging: dpaa2-ethsw: setup the STP state for all installed VLANs
  staging: dpaa2-ethsw: destroy workqueue after deregistering the
    notifiers
  staging: dpaa2-ethsw: read the port state from firmware
  staging: dpaa2-ethsw: check if there is space for a new VLAN

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 114 +++++++++++++++++++-----
 1 file changed, 90 insertions(+), 24 deletions(-)

-- 
2.25.1

