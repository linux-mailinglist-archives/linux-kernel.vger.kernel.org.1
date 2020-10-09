Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D447288C9A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgJIPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:30:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41072 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbgJIPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 65ABB20101E;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58DAA2010D6;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2384C2039C;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/2] staging: dpaa2-switch: add a dpaa2_switch_ prefix
Date:   Fri,  9 Oct 2020 18:29:58 +0300
Message-Id: <20201009153000.14550-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on adding the remaining functionality so that this switch
driver can be somewhat sane and moved out of staging, I stumbled upon
the fact that there is somewhat of an inconsistency in terms of function
prefixes in this driver.

This patch set just adds the same prefix - dpaa2_switch_ - to all
functions, static or not, of the driver.


Ioana Ciornei (2):
  staging: dpaa2-switch: add a dpaa2_switch_ prefix to all functions in
    ethsw-ethtool.c
  staging: dpaa2-switch: add a dpaa2_switch prefix to all functions in
    ethsw.c

 .../staging/fsl-dpaa2/ethsw/ethsw-ethtool.c   |  55 +--
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 441 +++++++++---------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h       |   2 +-
 3 files changed, 249 insertions(+), 249 deletions(-)

-- 
2.28.0

