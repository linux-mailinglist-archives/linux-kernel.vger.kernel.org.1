Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5132B8BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKSGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:45:19 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:40468 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbgKSGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:45:18 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5215877|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0133038-6.33072e-05-0.986633;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IygQvnF_1605768303;
Received: from localhost.localdomain(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.IygQvnF_1605768303)
          by smtp.aliyun-inc.com(10.147.40.233);
          Thu, 19 Nov 2020 14:45:03 +0800
From:   fuyao@allwinnertech.com
To:     mripard@kernel.org, wens@csie.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     fuyao <fuyao@allwinnertech.com>
Subject: [PATCH 0/2] introduce sunxi hwspinlock
Date:   Thu, 19 Nov 2020 14:44:51 +0800
Message-Id: <cover.1605767679.git.fuyao@allwinnertech.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fuyao <fuyao@allwinnertech.com>

this series add hwspinlock of sunxi. it provides hardware assistance for
synchronization between the multiple processors in the system.
(Or1k, Cortex-A7, Cortex-A53, Xtensa)

fuyao (2):
  dt-bindings: hwlock: add sunxi hwlock
  hwspinlock: add SUNXI implementation

 .../bindings/hwlock/sunxi,hwspinlock.yaml     |  46 ++++
 MAINTAINERS                                   |   6 +
 drivers/hwspinlock/Kconfig                    |  10 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/sunxi_hwspinlock.c         | 205 ++++++++++++++++++
 5 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sunxi,hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/sunxi_hwspinlock.c

-- 
2.29.2

