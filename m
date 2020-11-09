Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67442AAF99
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgKICqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:46:00 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:2502 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKICqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:46:00 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 35580666C59;
        Mon,  9 Nov 2020 10:45:57 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Wang Qing <wangqing@vivo.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: sh: remove duplicate include
Date:   Mon,  9 Nov 2020 10:45:51 +0800
Message-Id: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHRkZQx5KT0xJGEpDVkpNS09DQ0JCTkxOSktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6DSo4Ej8vPxMcKzI3KBYj
        TR0KCyNVSlVKTUtPQ0NCQk5MQk1IVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKSElNNwY+
X-HM-Tid: 0a75aae554089373kuws35580666c59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/sh/kernel/cpu/sh3/entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index 25eb809..e48b3dd
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -14,7 +14,6 @@
 #include <cpu/mmu_context.h>
 #include <asm/page.h>
 #include <asm/cache.h>
-#include <asm/thread_info.h>
 
 ! NOTE:
 ! GNU as (as of 2.9.1) changes bf/s into bt/s and bra, when the address
-- 
2.7.4

