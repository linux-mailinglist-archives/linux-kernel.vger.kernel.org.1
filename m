Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B327197C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIUC4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:56:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgIUC4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:56:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L2sJNg046765;
        Mon, 21 Sep 2020 02:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=kCcBsMlDoyyHUcI3aMmAseEqdqUXvyjGKKNiZtQJEWY=;
 b=p8JJfsXoX8CMen9mhQLn3suyGaIhbXQ7Gx4O6SFSuUALvH1/0HKFq/RpLbN43ut4FXfS
 z4WOD7er0dHVTMsLIIpCufZXV0Dqo+x2Ax1JrM7VHM2gIRpdRADFkKF4e+1gsBfNijD1
 s6tl5ECEEYsI/O6mgfxHKh2ud2A7NFVIdYaSpxEdppyRURCxARmHLCe2jg045K/SSMsV
 G1DRexw37H+X4pSxxgmsDfVHm0J3jDipuxC6olvoWTVg13qpn8WC51B3uRGoLYQP4Xou
 /v+8ys+Dzr++918+McHT9hbmqUy6bQv1X/FCZngYRUKDMw9ESfymE3VZp1lSlpE4YkD8 jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33n9dqu7an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 02:56:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L2oDNa177028;
        Mon, 21 Sep 2020 02:54:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33nujk0tra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 02:54:27 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08L2sKJE022553;
        Mon, 21 Sep 2020 02:54:20 GMT
Received: from localhost.localdomain (/10.159.233.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 20 Sep 2020 19:54:20 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL] ARM: soc: TI driver updates for v5.10
Date:   Sun, 20 Sep 2020 19:53:48 -0700
Message-Id: <1600656828-29267-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=4 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.10

for you to fetch changes up to dcca7a97c6bfff2a7a18b928a0b9bf215cc8f4f5:

  Add missing '#' to fix schema errors: (2020-09-20 19:36:37 -0700)

----------------------------------------------------------------
ARM: soc: TI driver updates for v5.10

Consist of:
 - Add Ring accelerator support for AM65x
 - Add TI PRUSS platform driver and enable it on available platforms
 - Extend PRUSS driver for CORECLK_MUX/IEPCLK_MUX support
 - UDMA rx ring pair fix
 - Add socinfo entry for J7200

----------------------------------------------------------------
Grygorii Strashko (2):
      soc: ti: k3: ringacc: add am65x sr2.0 support
      bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk

Grzegorz Jaszczyk (3):
      dt-bindings: soc: ti: Add TI PRUSS bindings
      dt-bindings: soc: ti: Update TI PRUSS bindings regarding clock-muxes
      soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX

Krzysztof Kozlowski (1):
      Add missing '#' to fix schema errors:

Peter Ujfalusi (2):
      soc: ti: k3-socinfo: Add entry for J7200
      dmaengine: ti: k3-udma-glue: Fix parameters for rx ring pair request

Qinglang Miao (1):
      soc: ti: Convert to DEFINE_SHOW_ATTRIBUTE

Suman Anna (6):
      soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
      soc: ti: pruss: Add support for PRU-ICSSs on AM437x SoCs
      soc: ti: pruss: Add support for PRU-ICSS subsystems on AM57xx SoCs
      soc: ti: pruss: Add support for PRU-ICSS subsystems on 66AK2G SoC
      soc: ti: pruss: Enable support for ICSSG subsystems on K3 AM65x SoCs
      soc: ti: pruss: Enable support for ICSSG subsystems on K3 J721E SoCs

Tero Kristo (2):
      soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one
      firmware: ti_sci: allow frequency change for disabled clocks by default

 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     |   6 -
 .../devicetree/bindings/soc/ti/ti,pruss.yaml       | 439 +++++++++++++++++++++
 drivers/dma/ti/k3-udma-glue.c                      |   2 +-
 drivers/firmware/ti_sci.c                          |   6 +-
 drivers/soc/ti/Kconfig                             |  11 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/k3-ringacc.c                        |  33 +-
 drivers/soc/ti/k3-socinfo.c                        |   1 +
 drivers/soc/ti/knav_dma.c                          |  16 +-
 drivers/soc/ti/knav_qmss_queue.c                   |  14 +-
 drivers/soc/ti/pruss.c                             | 354 +++++++++++++++++
 drivers/soc/ti/ti_sci_pm_domains.c                 | 251 ++++++------
 include/linux/pruss_driver.h                       |  54 +++
 13 files changed, 1021 insertions(+), 167 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
 create mode 100644 drivers/soc/ti/pruss.c
 create mode 100644 include/linux/pruss_driver.h
