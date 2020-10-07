Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980182866B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgJGSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:14:54 -0400
Received: from out28-218.mail.aliyun.com ([115.124.28.218]:51594 "EHLO
        out28-218.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgJGSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:14:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2892578|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0279153-0.000780125-0.971305;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IgNey8v_1602094473;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IgNey8v_1602094473)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 08 Oct 2020 02:14:39 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sernia.zhou@foxmail.com
Subject: [PATCH 0/1] Add macro definition for the upcoming new OST driver.
Date:   Thu,  8 Oct 2020 02:14:06 +0800
Message-Id: <20201007181407.46889-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new macro definition to "ingenic,sysost.h", exchange the original
ABI values of OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER, prepare
for the upcoming new OST driver.

周琰杰 (Zhou Yanjie) (1):
  dt-bindings: clock: Add new OST support for the upcoming new driver.

 include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.11.0

