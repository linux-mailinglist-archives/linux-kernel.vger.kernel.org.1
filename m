Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF12B0127
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKLIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:23:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgKLIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:23:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC83U3p193617;
        Thu, 12 Nov 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=TDhSzs5RWDN7s0fOYRUkavz2KWlMhWKoqBn2ndAIeOY=;
 b=tfC8GY6hcxxeRcOaKN9ppbZtMz1pzx+Fn++7dmLFMPsOeH0WKxQn0sJwUWeek2MFvR3Z
 ywghY4EN9JDo78g23818GlWF49y7vE5/rvZvpfNI7mCzxUmwJ9NsaYkIq5vp5uTRDhav
 PRTnPF+pxDEEV69vND1wydbI4whquuOzhP0eXABlOZO8278JKYXegRPj/MNpwqzsnjab
 34IrvoYwTfPM4SP0NfKwMBLD9wwgfxcMTxsBtTla0DEPHDiIzEGaRd7C+ZZUHv5ANxWB
 GPxuF0N5aWuECA2+fGtLXHaT5qJ4Rf6IX9Y6EtPwfNYXsPit2qgDYT7oywnWW4VohNQN /w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34rnpaj2n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 03:23:07 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8Mr0j000510;
        Thu, 12 Nov 2020 08:23:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 34nk78nern-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 08:23:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC8N3e354001926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 08:23:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5447A5204F;
        Thu, 12 Nov 2020 08:23:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14C8552054;
        Thu, 12 Nov 2020 08:23:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/2] nvme-pci: don't allocate unused I/O queues
Date:   Thu, 12 Nov 2020 09:23:02 +0100
Message-Id: <20201112082302.82441-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112082302.82441-1-schnelle@linux.ibm.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_02:2020-11-10,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=1 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently the NVME_QUIRK_SHARED_TAGS quirk for Apple devices is handled
during the assignment of nr_io_queues in nvme_setup_io_queues().
This however means that for these devices nvme_max_io_queues() will
actually not return the supported maximum which is confusing and
unexpected and also means that in nvme_probe() we are allocating
for I/O queues that will never be used.
Fix this by moving the quirk handling into nvme_max_io_queues().

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b56250b83bdf..0f8cea5b30eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2089,6 +2089,12 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 {
+	/*
+	 * If tags are shared with admin queue (Apple bug), then
+	 * make sure we only use one IO queue.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+		return 1;
 	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
 }
 
@@ -2107,15 +2113,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 
-	/*
-	 * If tags are shared with admin queue (Apple bug), then
-	 * make sure we only use one IO queue.
-	 */
-	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
-		nr_io_queues = 1;
-	else
-		nr_io_queues = dev->nr_allocated_queues - 1;
-
+	nr_io_queues = dev->nr_allocated_queues - 1;
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.17.1

