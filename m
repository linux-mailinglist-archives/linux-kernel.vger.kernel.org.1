Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280C2AB011
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 04:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgKIDpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 22:45:50 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:27173 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKIDpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:45:50 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id A4287665BF6;
        Mon,  9 Nov 2020 11:45:46 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Wang Qing <wangqing@vivo.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: remove duplicate include
Date:   Mon,  9 Nov 2020 11:45:41 +0800
Message-Id: <1604893542-20961-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSU0ZQ0wZT00dH0xKVkpNS09DQkhOT0xJSklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSo6Eio*Cj8jIxI4DE0dEwMR
        KShPCz1VSlVKTUtPQ0JITk9MTkNCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTE5JNwY+
X-HM-Tid: 0a75ab1c1a4a9373kuwsa4287665bf6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/x86/kernel/head64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 05e1171..5e9beb7
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -37,7 +37,6 @@
 #include <asm/kasan.h>
 #include <asm/fixmap.h>
 #include <asm/realmode.h>
-#include <asm/desc.h>
 #include <asm/extable.h>
 #include <asm/trapnr.h>
 #include <asm/sev-es.h>
-- 
2.7.4

