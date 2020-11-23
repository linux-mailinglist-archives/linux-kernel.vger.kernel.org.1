Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659C62C0471
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgKWLVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728952AbgKWLVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:21:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANB1DZi125038;
        Mon, 23 Nov 2020 06:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=CNhHuTR/FpcuF1o4XyM69eGfMUV05+mWx2wnYv3FznU=;
 b=E5paWbOfgOKcU2yspSZHmnVgFapaRhwm9b7soUKqdhr2FgJfU09EUFcvEldG9aJQMhMV
 6kLb48btcsn0My90S3ryE64WTYJM1PlJz1ruKbxnsQhP6LvLRLFgrhjAWP+lOSVA+8Ll
 gNor8KiWnWRo3qE38olM+8fPXlEPhk6A0A3Q2eCn0YmaeYmbK22/a2yQBCnaHn2IEYqu
 8tHrUoZgtwDGXTQKDq2Elp9g5nlB7e0eyqYvgPmFODUqLa3+zp+JmFCAcfyTM7kRSaqK
 3qV+6yeek5KHTdfacgvezkV3KA+NoSAtIrkPq+nt7KUp0VRcUKKpqQ1VHLonCV8yUOGT kQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34yudn3wkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 06:21:04 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANBIGHG001433;
        Mon, 23 Nov 2020 11:21:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 34xth82dbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 11:21:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANBJj8H62521672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 11:19:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC963A4051;
        Mon, 23 Nov 2020 11:19:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CF19A4040;
        Mon, 23 Nov 2020 11:19:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Nov 2020 11:19:45 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: make driver_probe_device() static
Date:   Mon, 23 Nov 2020 12:19:38 +0100
Message-Id: <20201123111938.18968-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_06:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used inside drivers/base/dd.c

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/base/base.h | 1 -
 drivers/base/dd.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 91cfb8405abd..f5600a83124f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -133,7 +133,6 @@ extern void device_release_driver_internal(struct device *dev,
 					   struct device *parent);
 
 extern void driver_detach(struct device_driver *drv);
-extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
 extern void device_set_deferred_probe_reason(const struct device *dev,
 					     struct va_format *vaf);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..ff62f0b33ad5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -717,7 +717,7 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
  *
  * If the device has a parent, runtime-resume the parent before driver probing.
  */
-int driver_probe_device(struct device_driver *drv, struct device *dev)
+static int driver_probe_device(struct device_driver *drv, struct device *dev)
 {
 	int ret = 0;
 
-- 
2.17.1

