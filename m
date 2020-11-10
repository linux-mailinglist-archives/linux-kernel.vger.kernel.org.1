Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306BD2ADA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgKJPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:18:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60826 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730200AbgKJPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:18:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAFDbHg028629;
        Tue, 10 Nov 2020 10:17:14 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34nsc91gws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 10:17:14 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AAFHDls022516
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 10 Nov 2020 10:17:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 10 Nov
 2020 10:17:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 10 Nov 2020 10:17:12 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AAFH7KT031436;
        Tue, 10 Nov 2020 10:17:08 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <bogdan.togorean@analog.com>, <tiwai@suse.com>, <perex@perex.cz>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] ASoc: adi: Kconfig: Remove depends on for ADI reference designs
Date:   Tue, 10 Nov 2020 17:22:13 +0200
Message-ID: <20201110152213.37811-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_06:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=558 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bogdan Togorean <bogdan.togorean@analog.com>

Audio ADI reference designs are also used on some ZynqMP boards, and can
also be used on Intel FPGA boards and also on some more complex FPGA
combinations (FPGA cards connected through PCIe).

This change removes the dependency on Microblaze and Zynq architectures
to allow the usage of this driver for the systems described above.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 sound/soc/adi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/adi/Kconfig b/sound/soc/adi/Kconfig
index e321e3b672da..0236dc5b4e9f 100644
--- a/sound/soc/adi/Kconfig
+++ b/sound/soc/adi/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SND_SOC_ADI
 	tristate "Audio support for Analog Devices reference designs"
-	depends on MICROBLAZE || ARCH_ZYNQ || COMPILE_TEST
 	help
 	  Audio support for various reference designs by Analog Devices.
 
-- 
2.17.1

