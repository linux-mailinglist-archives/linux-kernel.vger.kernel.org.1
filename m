Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7727A69A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI1Ekk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:40:40 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:5162 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgI1Ekj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:40:39 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S4deVY004992
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=ZYYLOG7cjd2FFEodYR9sOCf8GNcOlT5pXjKUseFXTPE=;
 b=hMHXFRHy1PFW6mIbYcVha8lUwf7hgI65aQ1glKE8rAMcOhYuyQ4S95Y5o1XaAqSbGACl
 eF2Ldeu4wQlldq5C9aN3GvC+ZwIIvYwp+JMGclQFmjhKsPVZ2MvVHgk/7eaPZ9M3SW5h
 QXjh+nTMUTAvTeUqQM3KrceBLzqWJI8t/IE5ja4NslQCoQ/f5LkIOYPJIMArYsF/avfZ
 gXBA72IesX7bL/wLdvFDWUwDx74Afc1gYcnn/+pP9mIUmZpatV5q/RtaOXvmi/t198Vk
 Qj0cQXvYBIrCaNeUhHfO19cyDW8JrJa+rOw4yL48yjXxe7z4ke+zOLAfy/aSyx3mzK3i qQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33t1fyb28c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:38 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S4dZIm087193
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:37 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 33u81u0k67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:37 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.77,312,1596517200"; 
   d="scan'208";a="1434187423"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     linux-kernel@vger.kernel.org, darcari@redhat.com,
        Yijun.Shen@dell.com, Perry.Yuan@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 0/3] Improve s0ix flows for systems i219LM
Date:   Sun, 27 Sep 2020 23:40:21 -0500
Message-Id: <20200928044024.7595-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_03:2020-09-24,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=533 clxscore=1011
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280037
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=717 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
disabled s0ix flows for systems that have various incarnations of the
i219-LM ethernet controller.  This was done because of some regressions
caused by an earlier
commit 632fbd5eb5b0e ("e1000e: fix S0ix flows for cable connected case")
with i219-LM controller.

Performing suspend to idle with these ethernet controllers requires a properly
configured system.  To make enabling such systems easier, this patch
series offers configuration options to enable/disable the flows.

The flows have also been confirmed to be configured correctly on Dell's Latitude
and Precision CML systems containing the i219-LM controller, when the kernel also
contains the fix for s0i3.2 entry here:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20200914/021361.html

Patches 2 and 3 will turn the behavior on by default for Dell's CML systems.
These patches should only be carried if that patch linked above is also applied.

Mario Limonciello (3):
  e1000e: allow turning s0ix flows on for systems with ME
  e1000e: Add Dell's Comet Lake systems into s0ix heuristics
  e1000e: Add more Dell CML systems into s0ix heuristics

 .../device_drivers/ethernet/intel/e1000e.rst  |  23 ++
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |   7 +
 drivers/net/ethernet/intel/e1000e/netdev.c    |  64 +++---
 drivers/net/ethernet/intel/e1000e/param.c     | 209 ++++++++++++++++++
 5 files changed, 266 insertions(+), 38 deletions(-)

-- 
2.25.1

