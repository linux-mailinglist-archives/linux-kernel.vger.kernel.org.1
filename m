Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3296A2F0FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbhAKKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbhAKKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:15:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:15:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f088f0076781dde3322831e.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:7678:1dde:3322:831e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7780D1EC04DE;
        Mon, 11 Jan 2021 11:15:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610360100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=QR7DiRD554jh+hGalm2pZVNoketlTs2mdhguC+pnBic=;
        b=kBEPYNVyijvHOmqf/N3AXP0dGFjTBHzEbIZaWw1JWreZwLZzxcDKeUFWEpHEqOWKZ6kDb8
        g67UMFINaR6JUavr461B6o0Chn3mXNEowtadELr4iVT+SD6E/5pEc+EF2PFeWS6iRvcP/F
        MxLAeb3bzDNPN3XvWFG20LxlVnVA5lQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johnathan Smithinovic <johnathan.smithinovic@gmx.at>,
        Rafael Kitover <rkitover@gmail.com>
Subject: [PATCH] x86/cpu/amd: Set __max_die_per_package on AMD
Date:   Mon, 11 Jan 2021 11:14:55 +0100
Message-Id: <20210111101455.1194-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

Set the maximum DIE per package variable on AMD using the
NodesPerProcessor topology value. This will be used by RAPL, among
others, to determine the maximum number of DIEs on the system in order
to do per-DIE manipulations.

 [ bp: Productize into a proper patch. ]

Fixes: 028c221ed190 ("x86/CPU/AMD: Save AMD NodeId as cpu_die_id")
Reported-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Reported-by: Rafael Kitover <rkitover@gmail.com>
Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Tested-by: Rafael Kitover <rkitover@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=210939
---
 arch/x86/kernel/cpu/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f8ca66f3d861..347a956f71ca 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -542,12 +542,12 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		u32 ecx;
 
 		ecx = cpuid_ecx(0x8000001e);
-		nodes_per_socket = ((ecx >> 8) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((ecx >> 8) & 7) + 1;
 	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		nodes_per_socket = ((value >> 3) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
-- 
2.29.2

