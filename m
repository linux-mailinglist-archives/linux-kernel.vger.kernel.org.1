Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA482CD019
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbgLCHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:08:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58528 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387393AbgLCHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:08:04 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B375pH1025906;
        Thu, 3 Dec 2020 02:07:11 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vj5mv7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 02:07:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B3779DT062107
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 02:07:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 02:07:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 02:07:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 02:07:08 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B3775E5018799;
        Thu, 3 Dec 2020 02:07:05 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <Weston.Sapia@analog.com>, <Brad.Lovell@analog.com>,
        <Sal.Afzal@analog.com>, <robh+dt@kernel.org>, <linux@roeck-us.net>,
        "Alexandru Tachici" <alexandru.tachici@analog.com>
Subject: [PATCH v3 0/3] hwmon: ltc2992: Add support
Date:   Thu, 3 Dec 2020 09:11:52 +0200
Message-ID: <20201203071155.68859-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_03:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

LTC2992 is a rail-to-rail system monitor that
measures current, voltage, and power of two supplies.

Two ADCs simultaneously measure each supply’s current.
A third ADC monitors the input voltages and four
auxiliary external voltages (GPIOs).

1. Use hwmon to create sysfs entries for current, voltage
and power of two 0V to 100V supplies. Create sysfs entries
for voltage sensed on the 4 GPIO pins.

2. Expose to userspace the 4 open-drain GPIOs provided by ltc2992.

3. DT bindings for ltc2992.

Alexandru Tachici (3):
  hwmon: ltc2992: Add support
  hwmon: ltc2992: Add support for GPIOs.
  dt-binding: hwmon: Add documentation for ltc2992

Changelog v2 -> v3:
- removed unnecessary includes
- removed unnecessary initialization of 'reg' in ltc2992_write_in() and ltc2992_write_power().
- removed i2c_check_functionality() in ltc2992_i2c_probe

 .../bindings/hwmon/adi,ltc2992.yaml           |  80 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/ltc2992.rst               |  56 +
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/ltc2992.c                       | 971 ++++++++++++++++++
 6 files changed, 1121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
 create mode 100644 Documentation/hwmon/ltc2992.rst
 create mode 100644 drivers/hwmon/ltc2992.c

-- 
2.20.1

