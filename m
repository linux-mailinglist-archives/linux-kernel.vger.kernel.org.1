Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF32E2010
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgLWRoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:44:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgLWRn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:26 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01AA81EC0529;
        Wed, 23 Dec 2020 18:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A/4FlMUZWfwbXaxLMg1kqT1UlgMMHWAyTMPnMXPGxg=;
        b=pCM++I8aUZPfttxlzdElDuqs4v+lV5WNlP/fLtUeVoWUcE358sHpCXs6brY3CVTy0HfjuA
        ZuDumyMC9dsE4uIOMOqwxBV5gZ1tafjD9w9lnLfuULgQFPyhzrJHs34hLu7NYaVD0Bi5+B
        0RE5YAOzvvFMsJYSrLQcMXxRcXgjlp0=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 06/19] perf/x86/intel/ds: Check insn_get_length() retval
Date:   Wed, 23 Dec 2020 18:42:20 +0100
Message-Id: <20201223174233.28638-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

intel_pmu_pebs_fixup_ip() needs only the insn length so use the
appropriate helper instead of a full decode. A full decode differs only
in running insn_complete() on the decoded insn but that is not needed
here.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/intel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 67dbc91bccfe..3786b4e07078 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1265,14 +1265,14 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
-		insn_get_length(&insn);
+
 		/*
 		 * Make sure there was not a problem decoding the
 		 * instruction and getting the length.  This is
 		 * doubly important because we have an infinite
 		 * loop if insn.length=0.
 		 */
-		if (!insn.length)
+		if (insn_get_length(&insn) || !insn.length)
 			break;
 
 		to += insn.length;
-- 
2.29.2

