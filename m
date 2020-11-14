Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11F2B1F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKMP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:58:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7234 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgKMP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:58:15 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXjmQ3wNszkjgB;
        Fri, 13 Nov 2020 23:57:58 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Nov 2020
 23:58:03 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gengdongjiu@huawei.com>
Subject: [PATCH v3 0/2] Enable Hi3559A SOC clock
Date:   Sat, 14 Nov 2020 00:22:35 +0000
Message-ID: <20201114002237.35962-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
1. change dt-bindings documents from txt to yaml format.
2. Add SHUB clock to access the devices of m7

Dongjiu Geng (2):
  dt-bindings: Document the hi3559a clock bindings
  clk: hisilicon: Add clock driver for hi3559A SoC

 .../clock/hisilicon,hi3559av100-clock.yaml    |  65 ++
 drivers/clk/hisilicon/Kconfig                 |   7 +
 drivers/clk/hisilicon/Makefile                |   1 +
 drivers/clk/hisilicon/clk-hi3559a.c           | 865 ++++++++++++++++++
 include/dt-bindings/clock/hi3559av100-clock.h | 165 ++++
 5 files changed, 1103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
 create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
 create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h

-- 
2.17.1

