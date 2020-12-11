Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A232D74C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394876AbgLKLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbgLKLdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:33:20 -0500
From:   Jarkko Sakkinen <jarkko@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH] x86/sgx: Synchronize encl->srcu in sgx_encl_release().
Date:   Fri, 11 Dec 2020 13:32:30 +0200
Message-Id: <20201211113230.28909-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each sgx_mmun_notifier_release() starts a grace period, which means that
one extra synchronize_rcu() in sgx_encl_release(). Add it there.

sgx_release() has the loop that drains the list but with bad luck the
entry is already gone from the list before that loop processes it.

Fixes: 1728ab54b4be ("x86/sgx: Add a page reclaimer")
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a5010277..48539a6ee315 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -438,6 +438,13 @@ void sgx_encl_release(struct kref *ref)
 	if (encl->backing)
 		fput(encl->backing);
 
+	/*
+	 * Each sgx_mmun_notifier_release() starts a grace period. Thus one
+	 * "extra" synchronize_rcu() is required here. This can go undetected by
+	 * sgx_release() when it drains the mm list.
+	 */
+	synchronize_srcu(&encl->srcu);
+
 	cleanup_srcu_struct(&encl->srcu);
 
 	WARN_ON_ONCE(!list_empty(&encl->mm_list));
-- 
2.27.0

