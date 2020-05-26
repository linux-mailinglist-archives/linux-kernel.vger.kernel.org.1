Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9421A335A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDILmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 07:42:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgDILmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:42:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD028843B943801B9B5E;
        Thu,  9 Apr 2020 19:42:21 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 19:42:13 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <yanaijie@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: i8259: make default_legacy_pic static
Date:   Thu, 9 Apr 2020 19:40:45 +0800
Message-ID: <20200409114045.38648-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

arch/x86/kernel/i8259.c:410:19: warning: symbol 'default_legacy_pic' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/x86/kernel/i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 519649ddf100..004f32d2c61c 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -407,7 +407,7 @@ struct legacy_pic null_legacy_pic = {
 	.make_irq = legacy_pic_uint_noop,
 };
 
-struct legacy_pic default_legacy_pic = {
+static struct legacy_pic default_legacy_pic = {
 	.nr_legacy_irqs = NR_IRQS_LEGACY,
 	.chip  = &i8259A_chip,
 	.mask = mask_8259A_irq,
-- 
2.17.2

