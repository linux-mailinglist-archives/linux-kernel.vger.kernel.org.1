Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762F7301F10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 23:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAXWK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 17:10:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6998 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbhAXWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:10:57 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10OMAFFH029281;
        Sun, 24 Jan 2021 17:10:15 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 368ehab9xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 17:10:14 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10OMADTr046526
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 24 Jan 2021 17:10:13 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 24 Jan 2021 14:10:12 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Sun, 24 Jan 2021 14:10:12 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 24 Jan 2021 14:10:11 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10OMA98w001908;
        Sun, 24 Jan 2021 17:10:09 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <petre.minciunescu@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/2] clk: ad9545: Add support
Date:   Mon, 25 Jan 2021 00:13:02 +0200
Message-ID: <20210124221304.51007-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_10:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add support for AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588,
1 pps Synchronizer and Jitter Cleaner.

At the core of the device there are PLL blocks. Each block consists
of one DPLL and one APLL. The DPLL can be fed timestamps from one of
the 4 reference input dividers or one of the two auxiliary NCOs.

The APLL takes the output of the DPLL and up-converts this
frequency to 1.2-2.0 GHZ. First 6 output dividers are receiving
clock from APLL0 and last 4 outputs are receiving clock from APLL1.

Current approach is to register under common clock framework,
depending whether they are mentioned in the device-tree,
any of the used references input dividers, the two auxiliary
NCOs, PLL blocks, output dividers.

A clock tree example:
Ref-B
  Ref-B-Div
    PLL0
      Q0C-div
    PLL1
      Q1A-div
      Q1B-div


Alexandru Tachici (2):
  clk: ad9545: Add support
  dt-bindings: clock: ad9545: Add documentation

 .../devicetree/bindings/clock/clk-ad9545.yaml |  352 ++++
 drivers/clk/Kconfig                           |    6 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/adi/Kconfig                       |   29 +
 drivers/clk/adi/Makefile                      |    9 +
 drivers/clk/adi/clk-ad9545-i2c.c              |   61 +
 drivers/clk/adi/clk-ad9545-spi.c              |   75 +
 drivers/clk/adi/clk-ad9545.c                  | 1678 +++++++++++++++++
 drivers/clk/adi/clk-ad9545.h                  |   16 +
 include/dt-bindings/clock/ad9545.h            |   64 +
 10 files changed, 2291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml
 create mode 100644 drivers/clk/adi/Kconfig
 create mode 100644 drivers/clk/adi/Makefile
 create mode 100644 drivers/clk/adi/clk-ad9545-i2c.c
 create mode 100644 drivers/clk/adi/clk-ad9545-spi.c
 create mode 100644 drivers/clk/adi/clk-ad9545.c
 create mode 100644 drivers/clk/adi/clk-ad9545.h
 create mode 100644 include/dt-bindings/clock/ad9545.h

-- 
2.20.1

