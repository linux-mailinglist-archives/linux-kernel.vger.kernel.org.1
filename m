Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E51270DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgISMpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 08:45:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgISMpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 08:45:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE58AD6DAF789CC2C0ED;
        Sat, 19 Sep 2020 20:45:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 20:44:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Haojian Zhuang" <haojian.zhuang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/1] clocksource: sp804: add support for Hisilicon sp804 timer
Date:   Sat, 19 Sep 2020 20:44:11 +0800
Message-ID: <20200919124412.4135-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is one of the series:
https://patchwork.ozlabs.org/project/devicetree-bindings/cover/20200918132237.3552-1-thunder.leizhen@huawei.com/

All are applied by Daniel Lezcano, except this one.

This patch is come from:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20200918132237.3552-10-thunder.leizhen@huawei.com/

But one modification was added:
1. "arm,sp804.yaml" contains "select" property, it requires compatible must
   contain "arm,sp804", so the nodes with compatible "hisilicon,sp804" are
   skipped and are not checked by "arm,sp804.yaml". Add "oneOf" into "select"
   to require one of them.

 select:
   properties:
     compatible:
       contains:
-        const: arm,sp804
+        oneOf:
+          - const: arm,sp804
+          - const: hisilicon,sp804
   required:
     - compatible


Zhen Lei (1):
  dt-bindings: sp804: add support for Hisilicon sp804 timer

 Documentation/devicetree/bindings/timer/arm,sp804.yaml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
1.8.3


