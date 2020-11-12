Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E72B0129
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgKLIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:23:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKLIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:23:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8293x177316;
        Thu, 12 Nov 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=BOefgtfDxCCP0iW0ZFVr08Iqc8h0WhLGvV4gIHw/bnE=;
 b=j6apinlh6HdiB8g7dXA88jZXc0wYwu7ttKzgle62yd5sR5eke5MFB1H+6HuW/Z0zyG90
 1kS1yvEyrAsIb/sRhlxF/NZgyf9KjMBSoh9ihcvZvqDxa7xQdLGRx46NLe6B+5gw0i9t
 G4eSi3Ipk7MEwr6Ppw6QVSbFpQp0/d7ePOoIsYkdyhA/BG+fc84wScp93W5MKpY8lm8g
 5DjO4ZMD4zJUOK+RaTaBuoYydlbpPl0EwlgtNvxF2pZQAQqnOJrJOVE1Qey+SiPJlcKy
 HjEZhrKbE5g0iHYowRQ3Smy/MRYVQjZStIawEgOO8AtnYaujKkgZ3yaOyF8azKxFqpN9 QA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34rg32dpyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 03:23:07 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8M0Ea006062;
        Thu, 12 Nov 2020 08:23:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 34nk782rxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 08:23:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC8N2oo51380632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 08:23:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B83735204F;
        Thu, 12 Nov 2020 08:23:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6D91C52051;
        Thu, 12 Nov 2020 08:23:02 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Date:   Thu, 12 Nov 2020 09:23:00 +0100
Message-Id: <20201112082302.82441-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_02:2020-11-10,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=1 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while searching for a bug around zPCI + NVMe IRQ handling on a distro
kernel, I got confused around handling of the maximum number
of I/O queues in the NVMe driver.
I think I groked it in the end but would like to propose the following
improvements, that said I'm quite new to this code.
I tested both patches on s390x (with a debug config) and x86_64 so
with both data center and consumer NVMes.
For the second patch, since I don't own a device with the quirk, I tried
always returning 1 from nvme_max_io_queues() and confirmed that on my
Evo 970 Pro this resulted in about half the performance in a fio test
but did not otherwise break things. I couldn't find a reason why
allocating only the I/O queues we actually use would be problematic in
the code either but I might have missed something of course.

Best regards,
Niklas Schnelle

Niklas Schnelle (2):
  nvme-pci: drop min() from nr_io_queues assignment
  nvme-pci: don't allocate unused I/O queues

 drivers/nvme/host/pci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
2.17.1

