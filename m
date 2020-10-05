Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1C283650
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJENMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:12:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39656 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJENMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:12:53 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095DCRvw029620;
        Mon, 5 Oct 2020 09:12:37 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33xp74m3jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 09:12:36 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 095DCZ2t019542
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 5 Oct 2020 09:12:35 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 5 Oct 2020 06:12:21 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 5 Oct 2020 06:12:20 -0700
Received: from saturn.ad.analog.com ([10.48.65.110])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 095DCT0b004599;
        Mon, 5 Oct 2020 09:12:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <corbet@lwn.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] docs: hwmon: (ltc2945): update datasheet link
Date:   Mon, 5 Oct 2020 16:12:26 +0300
Message-ID: <20201005131226.1774081-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_07:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old one isn't working anymore. Update to the latest datasheet link.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/hwmon/ltc2945.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/ltc2945.rst b/Documentation/hwmon/ltc2945.rst
index 20c884985367..8d65c141ce2b 100644
--- a/Documentation/hwmon/ltc2945.rst
+++ b/Documentation/hwmon/ltc2945.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Datasheet:
 
-	http://cds.linear.com/docs/en/datasheet/2945fa.pdf
+	https://www.analog.com/media/en/technical-documentation/data-sheets/2945fb.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
-- 
2.25.1

