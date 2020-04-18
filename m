Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB061AE94A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDRCAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 22:00:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgDRCAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 22:00:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D658AC94021AA480A3CA;
        Sat, 18 Apr 2020 10:00:08 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 09:59:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <richardcochran@gmail.com>, <davem@davemloft.net>
CC:     <pbonzini@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ptp_kvm: Make kvm_ptp_lock static
Date:   Sat, 18 Apr 2020 09:51:54 +0800
Message-ID: <20200418015154.45976-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/ptp/ptp_kvm.c:25:1: warning:
 symbol 'kvm_ptp_lock' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ptp/ptp_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_kvm.c b/drivers/ptp/ptp_kvm.c
index fc7d0b77e118..658d33fc3195 100644
--- a/drivers/ptp/ptp_kvm.c
+++ b/drivers/ptp/ptp_kvm.c
@@ -22,7 +22,7 @@ struct kvm_ptp_clock {
 	struct ptp_clock_info caps;
 };
 
-DEFINE_SPINLOCK(kvm_ptp_lock);
+static DEFINE_SPINLOCK(kvm_ptp_lock);
 
 static struct pvclock_vsyscall_time_info *hv_clock;
 
-- 
2.17.1


