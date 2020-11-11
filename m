Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230492AECAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKKJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:08:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8920 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgKKJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:08:24 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB981ax014206;
        Wed, 11 Nov 2020 04:08:06 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34nsc94j4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:08:06 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AB985LK040528
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Nov 2020 04:08:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Nov
 2020 04:08:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Nov 2020 04:08:04 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AB981gE023509;
        Wed, 11 Nov 2020 04:08:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <mark.thoren@analog.com>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/4] hwmon: (ltc2945): add support for sense resistor
Date:   Wed, 11 Nov 2020 11:12:55 +0200
Message-ID: <20201111091259.46773-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds support the sense resistor that can be connected on
a board to computer current & power.

The sense resistor is a parameter of the board. It should be configured in
the driver via a device-tree / ACPI property, so that the proper current
measurements can be done in the driver.

Changelog v1 -> v2:
* https://lore.kernel.org/linux-hwmon/20201106101825.30960-1-alexandru.ardelean@analog.com/
* reverted kstrotoull() -> kstrtoul()
* added sanity check for resistor, to prevent crashing when DT provides
  zero value
* add DT binding doc for ltc2945

Alexandru Ardelean (4):
  hwmon: (ltc2945): wrap regmap into an ltc2945_state struct
  docs: hwmon: (ltc2945): change type of val to ULL in
    ltc2945_val_to_reg()
  hwmon: (ltc2945): add support for sense resistor
  dt-bindings: hwmon: ltc2945: add device tree doc for ltc2945

 .../bindings/hwmon/adi,ltc2945.yaml           | 49 ++++++++++
 drivers/hwmon/ltc2945.c                       | 89 +++++++++++--------
 2 files changed, 103 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

-- 
2.17.1

