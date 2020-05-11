Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCA1CD122
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 06:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgEKEyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 00:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgEKExq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13402063A;
        Mon, 11 May 2020 04:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172825;
        bh=284oPI9GIPHpEC5gNFA9Sv4pwU6P4+U98zOmf/LPL2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6rCWsGUNmFE2wgipUWge3Igud3unskkHO3DxOvxdRCL3qseYR1z836Y3PZA7Zf99
         tCmZ63mzy8MBghSopVk0zkd/6rQ3RUpVQIT+K2EcdoBg/H4KobzTqz3t0v55QUP45E
         a4pAEmgoWVOz1h9Pc49E/ILOT5OfRslxgyd7hJds=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 14/18] x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation
Date:   Mon, 11 May 2020 00:53:07 -0400
Message-Id: <20200511045311.4785-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Before enabling FSGSBASE the kernel could safely assume that the content
of GS base was a user address. Thus any speculative access as the result
of a mispredicted branch controlling the execution of SWAPGS would be to
a user address. So systems with speculation-proof SMAP did not need to
add additional LFENCE instructions to mitigate.

With FSGSBASE enabled a hostile user can set GS base to a kernel address.
So they can make the kernel speculatively access data they wish to leak
via a side channel. This means that SMAP provides no protection.

Add FSGSBASE as an additional condition to enable the fence-based SWAPGS
mitigation.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c396..487603ea51cd1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -450,14 +450,12 @@ static void __init spectre_v1_select_mitigation(void)
 		 * If FSGSBASE is enabled, the user can put a kernel address in
 		 * GS, in which case SMAP provides no protection.
 		 *
-		 * [ NOTE: Don't check for X86_FEATURE_FSGSBASE until the
-		 *	   FSGSBASE enablement patches have been merged. ]
-		 *
 		 * If FSGSBASE is disabled, the user can only put a user space
 		 * address in GS.  That makes an attack harder, but still
 		 * possible if there's no SMAP protection.
 		 */
-		if (!smap_works_speculatively()) {
+		if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
+		    !smap_works_speculatively()) {
 			/*
 			 * Mitigation can be provided from SWAPGS itself or
 			 * PTI as the CR3 write in the Meltdown mitigation
-- 
2.20.1

