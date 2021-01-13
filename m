Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDA2F41D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbhAMCdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:33:55 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:58887 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbhAMCdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:33:54 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 21:33:54 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 10D2N2sj039155
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:23:02 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 10D2LWuX038877;
        Wed, 13 Jan 2021 10:21:32 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 Jan 2021
 10:24:12 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <kasan-dev@googlegroups.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <dvyukov@google.com>, <glider@google.com>,
        <aryabinin@virtuozzo.com>, <alankao@andestech.com>,
        <nickhu@andestech.com>, <nylon7@andestech.com>
Subject: [PATCH 1/1] riscv: Fix KASAN memory mapping.
Date:   Wed, 13 Jan 2021 10:24:10 +0800
Message-ID: <20210113022410.9057-1-nylon7@andestech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 10D2LWuX038877
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hu <nickhu@andestech.com>

Use virtual address instead of physical address when translating
the address to shadow memory by kasan_mem_to_shadow().

Signed-off-by: Nick Hu <nickhu@andestech.com>
Signed-off-by: Nylon Chen <nylon7@andestech.com>
---
 arch/riscv/mm/kasan_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 12ddd1f6bf70..a8a2ffd9114a 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -93,8 +93,8 @@ void __init kasan_init(void)
 								VMALLOC_END));
 
 	for_each_mem_range(i, &_start, &_end) {
-		void *start = (void *)_start;
-		void *end = (void *)_end;
+		void *start = (void *)__va(_start);
+		void *end = (void *)__va(_end);
 
 		if (start >= end)
 			break;
-- 
2.17.1

