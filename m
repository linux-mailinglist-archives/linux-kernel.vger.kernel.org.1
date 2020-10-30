Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5187E2A0A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJ3Pri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:47:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43738 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3Prh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:47:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFTP3j184821;
        Fri, 30 Oct 2020 15:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=WRz5+0gecDX06Zz8e8bk1a/2cefOBhLim3Rp/cYIgTI=;
 b=r3fmu5oWyD2PuZHE85eacjcebHmQ/lgRP2qbrAuRy3vIRCjJZEHuCBzKQzPV5OthVvZ2
 ZaP9xR568EjshV8fsnS/MlbC5LbfF6HuI7/WV0pKFvBDyG0zgDW5A+x1CHZao3mEFyBg
 0vWAF2pAqzRmMoGb8yapSWahy2xc02bN3xihZpSgdu1G4mhjJXzHP9f0uEluP2mXI150
 tNeXAxpWGMuFgXKsIlgNkOUNv1NVn+XnHdrGfAm0Pj0WMUzKeMjST9Y5AweQkUymAdrR
 oBy78UfZhrRTNLRk8IuMHWRUAY5tTKxpFSNC8HiuwzgRz5rddWmR5Hc5Od7yD0N1vns8 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sbahah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 15:47:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFUaSs089329;
        Fri, 30 Oct 2020 15:47:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by aserp3030.oracle.com with ESMTP id 34cwur3t8h-1;
        Fri, 30 Oct 2020 15:47:31 +0000
From:   john.p.donnelly@oracle.com
To:     linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, tiwai@suse.de
Subject: [PATCH 4.14 ] ALSA: Corrects warning: missing braces around initializer
Date:   Fri, 30 Oct 2020 08:47:31 -0700
Message-Id: <20201030154731.6669-1-john.p.donnelly@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=974 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Donnelly <john.p.donnelly@oracle.com>

The assignment statement of a local variable "struct hpi_pci pci = { 0
}; " is not valid for all versions of compiler.

Fixes: 9c3c9d37ae1e ("ALSA: asihpi: fix iounmap in error handler")

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
---
 sound/pci/asihpi/hpioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index b4ccd9f92400..1cd7c197ab96 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -350,8 +350,9 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	struct hpi_message hm;
 	struct hpi_response hr;
 	struct hpi_adapter adapter;
-	struct hpi_pci pci = { 0 };
+	struct hpi_pci pci;
 
+	memset(&pci, 0, sizeof(pci));
 	memset(&adapter, 0, sizeof(adapter));
 
 	dev_printk(KERN_DEBUG, &pci_dev->dev,
-- 
2.27.0

