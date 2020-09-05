Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8FC25E74D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgIELgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 07:36:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgIELfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 07:35:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F274D650A2997407E73;
        Sat,  5 Sep 2020 19:18:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 19:18:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <ruscur@russell.cc>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] powerpc/eeh: fix compile warning with CONFIG_PROC_FS=n
Date:   Sat, 5 Sep 2020 19:17:49 +0800
Message-ID: <20200905111749.3198998-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compile warning:

arch/powerpc/kernel/eeh.c:1639:12: error: 'proc_eeh_show' defined but not used [-Werror=unused-function]
 static int proc_eeh_show(struct seq_file *m, void *v)

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/powerpc/kernel/eeh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 94682382fc8c..420c3c25c6e7 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1636,6 +1636,7 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 }
 EXPORT_SYMBOL_GPL(eeh_pe_inject_err);
 
+#ifdef CONFIG_PROC_FS
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (!eeh_enabled()) {
@@ -1662,6 +1663,7 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 static int eeh_enable_dbgfs_set(void *data, u64 val)
-- 
2.25.1

