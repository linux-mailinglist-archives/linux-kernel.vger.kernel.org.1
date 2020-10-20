Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0B293B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394355AbgJTMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394298AbgJTMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:19:08 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D338C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:19:08 -0700 (PDT)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 92F12272;
        Tue, 20 Oct 2020 14:19:05 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] x86/sev-es: Mitigate some HV attack vectors
Date:   Tue, 20 Oct 2020 14:18:51 +0200
Message-Id: <20201020121856.19427-1-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here are some enhancements to the SEV(-ES) code in the Linux kernel to
self-protect it against some newly detected hypervisor attacks. There
are 3 attacks addressed here:

	1) Hypervisor does not present the SEV-enabled bit via CPUID

	2) The Hypervisor presents the wrong C-bit position via CPUID

	3) An encrypted RAM page is mapped as MMIO in the nested
	   page-table, causing #VC exceptions and possible leak of the
	   data to the hypervisor or data/code injection from the
	   Hypervisor.

The attacks are described in more detail in this paper:

	https://arxiv.org/abs/2010.07094

Please review.

Thanks,

	Joerg

Changes to v1:

	- Disable CR4.PGE during C-bit test

	- Do not safe/restore caller-safed registers in
	  set_sev_encryption_mask()

Joerg Roedel (5):
  x86/boot/compressed/64: Introduce sev_status
  x86/boot/compressed/64: Add CPUID sanity check to early #VC handler
  x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path
  x86/head/64: Check SEV encryption before switching to kernel
    page-table
  x86/sev-es: Do not support MMIO to/from encrypted memory

 arch/x86/boot/compressed/ident_map_64.c |  1 +
 arch/x86/boot/compressed/mem_encrypt.S  | 14 +++-
 arch/x86/boot/compressed/misc.h         |  2 +
 arch/x86/kernel/head_64.S               | 14 +++-
 arch/x86/kernel/sev-es-shared.c         | 26 +++++++
 arch/x86/kernel/sev-es.c                | 20 ++++--
 arch/x86/kernel/sev_verify_cbit.S       | 91 +++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c               |  1 +
 8 files changed, 160 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/kernel/sev_verify_cbit.S

-- 
2.28.0

