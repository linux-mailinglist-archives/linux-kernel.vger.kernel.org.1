Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C72ECDDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhAGKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:31:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48818 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbhAGKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:31:46 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107ATiCJ007408;
        Thu, 7 Jan 2021 05:30:49 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wnkjhdt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 05:30:48 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 107AUl37041841
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jan 2021 05:30:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 7 Jan 2021
 05:30:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 7 Jan 2021 05:30:46 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 107AUhsh013109;
        Thu, 7 Jan 2021 05:30:44 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <mark.thoren@analog.com>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/4] hwmon: (ltc2945): add support for sense resistor
Date:   Thu, 7 Jan 2021 12:34:13 +0200
Message-ID: <20210107103417.16010-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_05:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset adds support for sense resistor.

Changelog v2 -> v3:
* https://lore.kernel.org/linux-hwmon/20201111091259.46773-1-alexandru.ardelean@analog.com/
* dropped patch 'docs: hwmon: (ltc2945): change type of val to ULL in ltc2945_val_to_reg()'
* add patch 'hwmon: (ltc2945): clamp values before converting'
* for patch 'hwmon: (ltc2945): add support for sense resistor'
  - sense-resistor is represented in milli-ohms internally; this
    risks of any other potential overflows with the multiplication to
    1000; the scaling in the driver becomes simpler, but we can't allow
    a lower resistor value that 1 mOhm, and all resistor values
    need to be integer in mOhm.
  - added max power and max amps limits, adjusted to sense resistor
* for patch 'dt-bindings: hwmon: ltc2945: add device tree doc for ltc2945 '
  added 'Reviewed-by: Rob Herring <robh@kernel.org>'

Alexandru Ardelean (4):
  hwmon: (ltc2945): wrap regmap into an ltc2945_state struct
  hwmon: (ltc2945): clamp values before converting
  hwmon: (ltc2945): add support for sense resistor
  dt-bindings: hwmon: ltc2945: add device tree doc for ltc2945

 .../bindings/hwmon/adi,ltc2945.yaml           |  49 +++++++
 drivers/hwmon/ltc2945.c                       | 128 +++++++++++++++---
 2 files changed, 156 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

-- 
2.17.1

