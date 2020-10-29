Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB91329E7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgJ2Jp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:45:57 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59992 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgJ2Jp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:45:57 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T9S3Jl022648;
        Thu, 29 Oct 2020 05:45:44 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34ch6526p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 05:45:44 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 09T9jgio042393
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Oct 2020 05:45:42 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 29 Oct 2020 02:45:41 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 29 Oct 2020 02:45:41 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 09T9jcAJ008861;
        Thu, 29 Oct 2020 05:45:38 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/3] hwmon: ltc2992: Add support
Date:   Thu, 29 Oct 2020 11:49:08 +0200
Message-ID: <20201029094911.79173-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_03:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

LTC2992 is is a rail-to-rail system monitor that
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

 .../bindings/hwmon/adi,ltc2992.yaml           |  78 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/ltc2992.rst               |  51 +
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/ltc2992.c                       | 903 ++++++++++++++++++
 6 files changed, 1046 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
 create mode 100644 Documentation/hwmon/ltc2992.rst
 create mode 100644 drivers/hwmon/ltc2992.c

-- 
2.20.1

