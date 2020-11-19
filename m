Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7582B96B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgKSPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:53 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23128 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728601AbgKSPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:44:51 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJFR2kP016552;
        Thu, 19 Nov 2020 10:44:50 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19j7mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:44:50 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AJFikGC035880
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Nov 2020 10:44:49 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 07:43:55 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 07:42:45 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 07:43:55 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AJFhotS032189;
        Thu, 19 Nov 2020 10:43:53 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/4] uio: uio_hv_generic: use devm_kzalloc() for private data alloc
Date:   Thu, 19 Nov 2020 17:49:03 +0200
Message-ID: <20201119154903.82099-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119154903.82099-1-alexandru.ardelean@analog.com>
References: <20201119154903.82099-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=3
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=659 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor cleanup for the management of the private object of this
driver. The allocation can be tied to the life-time of the hv_device
object.
This cleans up a bit the exit & error paths, since the object doesn't need
to be explicitly free'd anymore.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_hv_generic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 4dae2320b103..0330ba99730e 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -247,14 +247,14 @@ hv_uio_probe(struct hv_device *dev,
 		return -ENOTSUPP;
 	}
 
-	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
 	ret = vmbus_alloc_ring(channel, HV_RING_SIZE * PAGE_SIZE,
 			       HV_RING_SIZE * PAGE_SIZE);
 	if (ret)
-		goto fail;
+		return ret;
 
 	set_channel_read_mode(channel, HV_CALL_ISR);
 
@@ -347,8 +347,6 @@ hv_uio_probe(struct hv_device *dev,
 
 fail_close:
 	hv_uio_cleanup(dev, pdata);
-fail:
-	kfree(pdata);
 
 	return ret;
 }
@@ -364,10 +362,8 @@ hv_uio_remove(struct hv_device *dev)
 	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
-	hv_set_drvdata(dev, NULL);
 
 	vmbus_free_ring(dev->channel);
-	kfree(pdata);
 	return 0;
 }
 
-- 
2.17.1

