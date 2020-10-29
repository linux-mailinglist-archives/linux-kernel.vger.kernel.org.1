Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661A729EBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJ2M1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:27:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59542 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ2M1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:27:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCPLFq082737
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=ksCEFqmdS0UwAoS1e6QeT4Ku0NjU/5fHd/MWFxTzHyk=;
 b=BLV5vGhiVdqqR3k7WT3r8ZDxuPgWk2vkbHYvv7fg8YJhf26RjYKfjpCLpmoB9YbUZL6V
 asmg/M2M4KVAiqwnMG3I/RsO9gRQ6M8NBzKfl5zlTHKpm5/SA0Nkj0AqNQRbFycY1opP
 yzXQXGzwgm97FcDgdfrCcKyNXIukJWdaqRwIOPtz3SN+s1AhTW+0l9QnArCmmIpGlFJy
 Uyh1Fl6Lo8SjZSQOKTotqptZxq4MYkuaFKAVQXdjF8czsH6A9hcjAa5xnuQjR34Rq2Bd
 EuIv8EaymQQ3hKmm8zNAX4MPohp0N+RairTVpPzjuowZFsNlnNjBeEQUdNTk4w2kxYVs Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7m4gxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCAP7n059340
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:25:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1t5epy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:25:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TCPnjZ027373
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:25:49 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 05:25:48 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH] add support for pci in the pvpanic driver
Date:   Thu, 29 Oct 2020 13:43:03 +0200
Message-Id: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for pci in the pvpanic driver. They were assembled
from an old RFC from 2019 [1] which was left unmerged.

In order to test this, you need also to apply the patches I have sent for pci
pvpanic support in qemu [2].

[1] https://lwn.net/ml/linux-kernel/1550575668-6240-1-git-send-email-peng.hao2@zte.com.cn/
[2] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08709.html

Peng Hao (4):
  misc/pvpanic : preparing for pvpanic driver framework
  misc/pvpanic: Add pvpanic driver framework
  misc/pvpanic: Avoid initializing multiple pvpanic devices
  misc/pvpanic: add new pvpanic pci driver

 drivers/misc/Kconfig                |   1 +
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 196 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  34 +++++++
 drivers/misc/pvpanic/Makefile       |   8 ++
 drivers/misc/pvpanic/pvpanic-acpi.c |  77 ++++++++++++++
 drivers/misc/pvpanic/pvpanic-of.c   |  53 ++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c  |  56 +++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 150 +++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  15 +++
 10 files changed, 395 insertions(+), 197 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

