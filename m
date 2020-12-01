Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D62CAC90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392307AbgLATjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:39:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37408 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgLATjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:39:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1Jcu2x098710;
        Tue, 1 Dec 2020 19:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=o3rs1gQs878ZsMzbkxh2V3i0uCl75W9OVAYYEFwz/FM=;
 b=wyywyIbaMJM79jGkslYwgyIEcPdP+hvYbN/280vSqmErqxp3n4M58xETUs9FyBuMclpu
 4tl3P8nOmzcENvv4DbZIiyzXQyRSupiEYzDP0HhDlqaF/Bydev6/l9bXjfyTc0WALhkv
 wmDNxsKUHlRRrfkIrH3XS06+RZ0Nq+pfDTsmv1cUNUYP4+wJrXX0uOTUgT9+9jyW/FQy
 1pVZQ2HvaoTbn/4j8AW+7N393xgJ8qR05kXa2MSNjvG/dWPWSPfh1It0Rh4eoP9H6Czs
 1IQ9JEHn1QhJiJdyAShBX+1EAuI4muqV4borvakcgouNPh8GzVwONmTcXrNNOInUNjrU Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 353c2avk4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 19:39:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1JUPKx168538;
        Tue, 1 Dec 2020 19:37:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35404na56c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 19:37:02 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B1JaxKQ017275;
        Tue, 1 Dec 2020 19:37:00 GMT
Received: from localhost.localdomain (/10.159.239.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 11:36:59 -0800
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 1/2] drivers: soc: TI SOC changes for 5.11
Date:   Tue,  1 Dec 2020 11:36:45 -0800
Message-Id: <1606851405-26338-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.11

for you to fetch changes up to 4cba398f37f868f515ff12868418dc28574853a1:

  drivers: soc: ti: knav_qmss_queue: Fix error return code in knav_queue_probe (2020-11-21 19:22:38 -0800)

----------------------------------------------------------------
drivers: soc: TI SOC changes for 5.11

- ti_sci changes towards DMSS support
- Static warning fixes
- Kconfig update for Keystone ARM64 socs
- AM64X SOC family support

----------------------------------------------------------------
Grzegorz Jaszczyk (1):
      soc: ti: pruss: Remove wrong check against *get_match_data return value

Lee Jones (6):
      soc: ti: knav_qmss_queue: Remove set but unchecked variable 'ret'
      soc: ti: knav_qmss_queue: Fix a whole host of function documentation issues
      soc: ti: knav_dma: Fix a kernel function doc formatting issue
      soc: ti: pm33xx: Remove set but unused variable 'ret'
      soc: ti: wkup_m3_ipc: Document 'm3_ipc' parameter throughout
      soc: ti: k3-ringacc: Provide documentation for 'k3_ring's 'state'

Nishanth Menon (1):
      soc: ti: Kconfig: Drop ARM64 SoC specific configs

Peter Ujfalusi (11):
      firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx channel
      firmware: ti_sci: Use struct ti_sci_resource_desc in get_range ops
      firmware: ti_sci: rm: Add support for second resource range
      soc: ti: ti_sci_inta_msi: Add support for second range in resource ranges
      firmware: ti_sci: rm: Add support for extended_ch_type for tx channel
      firmware: ti_sci: rm: Remove ring_get_config support
      firmware: ti_sci: rm: Add new ops for ring configuration
      soc: ti: k3-ringacc: Use the ti_sci set_cfg callback for ring configuration
      firmware: ti_sci: rm: Remove unused config() from ti_sci_rm_ringacc_ops
      soc: ti: k3-ringacc: Use correct device for allocation in RING mode
      soc: ti: k3-socinfo: Add entry for AM64X SoC family

Tony Lindgren (1):
      soc: ti: omap-prm: Do not check rstst bit on deassert if already deasserted

Zhang Qilong (2):
      soc: ti: knav_qmss: fix reference leak in knav_queue_probe
      soc: ti: Fix reference imbalance in knav_dma_probe

Zhihao Cheng (1):
      drivers: soc: ti: knav_qmss_queue: Fix error return code in knav_queue_probe

 drivers/firmware/ti_sci.c              | 213 +++++++++++----------------------
 drivers/firmware/ti_sci.h              |  72 ++++-------
 drivers/soc/ti/Kconfig                 |  18 ---
 drivers/soc/ti/k3-ringacc.c            |  98 +++++++--------
 drivers/soc/ti/k3-socinfo.c            |   1 +
 drivers/soc/ti/knav_dma.c              |  15 ++-
 drivers/soc/ti/knav_qmss_queue.c       |  66 +++++-----
 drivers/soc/ti/omap_prm.c              |   4 +
 drivers/soc/ti/pm33xx.c                |   4 +-
 drivers/soc/ti/pruss.c                 |   6 -
 drivers/soc/ti/ti_sci_inta_msi.c       |  12 ++
 drivers/soc/ti/wkup_m3_ipc.c           |   8 +-
 include/linux/soc/ti/k3-ringacc.h      |   5 +
 include/linux/soc/ti/ti_sci_protocol.h |  85 ++++++++-----
 14 files changed, 272 insertions(+), 335 deletions(-)
