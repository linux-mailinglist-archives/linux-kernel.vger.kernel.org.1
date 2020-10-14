Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2328E298
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgJNOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:55:07 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2160 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729276AbgJNOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:54:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EEpi86023902;
        Wed, 14 Oct 2020 09:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NbuRtoi+iQyrOz1VZGTizLtn/VqJReoSWynFwYIAIsg=;
 b=eoVgEewyMaXaPElcE4qhIUvMuRcZHJuuzgblZ+UkA86T1S/gZhRKUffDAXAeleIf0CF8
 L8L3cU0f/xNQdb0OLghok3s/r5Gz2Qwzn5LrUNNFXks2k0118VgbZNHD1qD3454kg6Rt
 4q/s8xWICQToAPa3VzF/J1GdeKV8+iqbhuLSAQDlWVolIhX7Ud+3iJKFdTaPWO/giwrP
 sznPTYgpWqSw3hUv9AC9jwrayCAuFjRUQY2wCyIimYTsGTDFIZCeVj362t22otN/h0Lk
 Gdt9WaldBuj7RdNBpDs7PrKIfqFIKOoH6CxDuZLST0EXYDJzNzwL7G+1eAY7zJo8q4jp TQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 343ac1wbwc-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 09:54:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 15:54:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 14 Oct 2020 15:54:36 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A1FEE2AA;
        Wed, 14 Oct 2020 14:54:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 7/7] MAINTAINERS: Add dts for Cirrus Logic Lochnagar on RPi4
Date:   Wed, 14 Oct 2020 15:54:18 +0100
Message-ID: <20201014145418.31838-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014145418.31838-1-rf@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Cirrus Logic driver maintainers to include the device
tree .dts for using the Lochnagar with a Raspberry Pi 4.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87ceaac748a4..09bc583a5b2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4199,6 +4199,7 @@ M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	patches@opensource.cirrus.com
 S:	Supported
+F:	arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar.dts
 F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
 F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
 F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
-- 
2.20.1

