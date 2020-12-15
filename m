Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551912DB5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgLOVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730702AbgLOVlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:41:24 -0500
From:   Jarkko Sakkinen <jarkko@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Jethro Beekman <jethro@fortanix.com>
Subject: [PATCH] x86/sgx: Synchronize encl->srcu in sgx_encl_release().
Date:   Tue, 15 Dec 2020 23:40:28 +0200
Message-Id: <20201215214028.55352-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add synchronize_srcu_expedited() to sgx_encl_release() to catch a grace
period initiated by sgx_mmu_notifier_release().

A trivial example of a failing sequence with tasks A and B:

1. A: -> sgx_release()
2. B: -> sgx_mmu_notifier_release()
3. B: -> list_del_rcu()
3. A: -> sgx_encl_release()
4. A: -> cleanup_srcu_struct()

The loop in sgx_release() observes an empty list because B has removed its
entry in the middle, and calls cleanup_srcu_struct() before B has a chance
to calls synchronize_srcu().

Fixes: 1728ab54b4be ("x86/sgx: Add a page reclaimer")
Suggested-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a5010277..fe7256db6e73 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -438,6 +438,12 @@ void sgx_encl_release(struct kref *ref)
 	if (encl->backing)
 		fput(encl->backing);
 
+	/*
+	 * Each sgx_mmu_notifier_release() starts a grace period. Therefore, an
+	 * additional sync is required here.
+	 */
+	synchronize_srcu_expedited(&encl->srcu);
+
 	cleanup_srcu_struct(&encl->srcu);
 
 	WARN_ON_ONCE(!list_empty(&encl->mm_list));
-- 
2.27.0

