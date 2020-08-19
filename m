Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612A3249BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHSLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 07:31:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbgHSLbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:31:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3334D484B4B2916F6863;
        Wed, 19 Aug 2020 19:31:22 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 19:31:20 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <penberg@kernel.org>, <rppt@kernel.org>,
        <eert@linux-m68k.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/mpparse: remove duplicate include
Date:   Wed, 19 Aug 2020 19:29:10 +0800
Message-ID: <20200819112910.7629-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asm/io_apic.h which is included more than once

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/x86/kernel/mpparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 411af4aa7b51..00e51626eeb0 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -24,7 +24,6 @@
 #include <asm/irqdomain.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/io_apic.h>
 #include <asm/proto.h>
 #include <asm/bios_ebda.h>
 #include <asm/e820/api.h>
-- 
2.17.1

