Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2712B0128
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKLIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:23:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgKLIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:23:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC83U3g193582;
        Thu, 12 Nov 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=EJ8jWsKubf/i/O2OipMlFg3r4/MfebuU8bTeplatuPw=;
 b=Kd6V0k0wgx3jgKo+0cHd4f+2W738lg59GGp9FD79CNfXmyNt97LKKooZMufG19bjZ0Pb
 pbJtiA/2jZZLWI19i9XGTg8IO/UF7JQSadAhIdB3vXG6m23vE4uhX9jpWrPR74eZVfm/
 ynpL8RrSOmemgViC4qdluwh9zaqt649RyS8Vzh/53ot6vI3npzZBt4TdkRqP7EG9jCaV
 +WYXwJs0PoaKeHsnuUDpoLVyHpPcVFQtS2iUpXi5uUvgIBkjvFtWYcm3SrezclL++fCg
 kXzrSugH45NGm6jwZEAZK5J06iSsjJgXVz8iyscqWTVV8xHDW/i/cGPxECj2syvgZ8fJ OQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34rnpaj2n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 03:23:07 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8DhI2023505;
        Thu, 12 Nov 2020 08:23:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 34nk78asd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 08:23:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC8N3N954001922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 08:23:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1006852052;
        Thu, 12 Nov 2020 08:23:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB3035205F;
        Thu, 12 Nov 2020 08:23:02 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/2] nvme-pci: drop min() from nr_io_queues assignment
Date:   Thu, 12 Nov 2020 09:23:01 +0100
Message-Id: <20201112082302.82441-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112082302.82441-1-schnelle@linux.ibm.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_02:2020-11-10,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=1 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in nvme_setup_io_queues() the number of I/O queues is set to either 1 in
case of a quirky Apple device or to the min of nvme_max_io_queues() or
dev->nr_allocated_queues - 1.
This is unnecessarily complicated as dev->nr_allocated_queues is only
assigned once and is nvme_max_io_queues() + 1.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..b56250b83bdf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2114,8 +2114,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		nr_io_queues = 1;
 	else
-		nr_io_queues = min(nvme_max_io_queues(dev),
-				   dev->nr_allocated_queues - 1);
+		nr_io_queues = dev->nr_allocated_queues - 1;
 
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
-- 
2.17.1

