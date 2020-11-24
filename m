Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF45B2C22B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgKXKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbgKXKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8554C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:20:05 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7658A1EC0532;
        Tue, 24 Nov 2020 11:20:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pp7zBwHJQPdJo01j+3WxNC8JMxQ/nEa8UEHM9ceGnr4=;
        b=dXrhcU1xfc1R5fxq2mVZtMegQtn6fQzbLeLqnRXf9o0UdlOpuZNNexVzXjq3puD9wcF4db
        +0GgLwu4TAd09pOshOvEJQXwcQvpBWz3jUV3zD8vKE5EsxzQnK8PviFra0HZeh8yELl34H
        kLhqiY5kiPUX++8ZZUyDMJJVD2OW52U=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 06/19] perf/x86/intel/ds: Check insn_get_length() retval
Date:   Tue, 24 Nov 2020 11:19:39 +0100
Message-Id: <20201124101952.7909-7-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
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
index fb327d11a04d..56cbcfee0ab1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1263,14 +1263,14 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
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
2.21.0

