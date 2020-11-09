Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89EB2AB3AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgKIJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:36:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:57788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:36:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A368ABCC;
        Mon,  9 Nov 2020 09:36:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/platform/uv: drop last traces of uv_flush_tlb_others
Date:   Mon,  9 Nov 2020 10:36:53 +0100
Message-Id: <20201109093653.2042-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown
Handler") removed uv_flush_tlb_others. Its declaration was removed also
from asm/uv/uv.h. But only for the CONFIG_X86_UV=y case. The inline
definition (!X86_UV case) is still in place.

So remove this implementation with everything what was added to support
uv_flush_tlb_others:
* include of asm/tlbflush.h
* forward declarations of struct cpumask, mm_struct, and flush_tlb_info

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/uv/uv.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 172d3e4a9e4b..648eb23fe7f0 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -2,14 +2,8 @@
 #ifndef _ASM_X86_UV_UV_H
 #define _ASM_X86_UV_UV_H
 
-#include <asm/tlbflush.h>
-
 enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
 
-struct cpumask;
-struct mm_struct;
-struct flush_tlb_info;
-
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
@@ -44,10 +38,6 @@ static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
-static inline const struct cpumask *
-uv_flush_tlb_others(const struct cpumask *cpumask,
-		    const struct flush_tlb_info *info)
-{ return cpumask; }
 
 #endif	/* X86_UV */
 
-- 
2.29.2

