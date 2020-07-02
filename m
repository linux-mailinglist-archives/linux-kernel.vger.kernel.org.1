Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A485A212667
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgGBOg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:36:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729482AbgGBOg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:36:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BC290DC5CBB87568F7A4;
        Thu,  2 Jul 2020 22:36:54 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 22:36:46 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scftorture: Make symbol 'scf_torture_rand' static
Date:   Thu, 2 Jul 2020 22:47:00 +0800
Message-ID: <20200702144700.3602-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warning:

kernel/scftorture.c:124:1: warning:
 symbol '__pcpu_scope_scf_torture_rand' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 52750c564404..d63d700ad297 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -121,7 +121,7 @@ static unsigned long scf_sel_totweight;
 static atomic_t n_started;
 static atomic_t n_errs;
 
-DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
+static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)

