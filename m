Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE952F3F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbhALW1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:27:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:29642 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbhALW1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:27:16 -0500
IronPort-SDR: hKDgy7C2eC8aSIt4K4ydXLxkdQJeaoag/qDaebA9eGy9w4D3viSjaJtJYhirdCmnetzwCnXUtp
 Ommze/Sr5Etg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174607976"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="174607976"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 14:25:30 -0800
IronPort-SDR: roAGRNnfSbrWZcjWKNrcgJGEtlLIF7QYFZve01w7PrcT7yV6qzchbLM4yH8BQVuPQzeengeo/x
 nI1WQf31dyaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="363670765"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2021 14:25:29 -0800
Subject: [PATCH] x86/sgx: rename and document SGX bit lock
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, jarkko@kernel.org, bp@suse.de,
        x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 12 Jan 2021 14:19:01 -0800
Message-Id: <20210112221901.2CE31C8E@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SGX ioctl() calls are serialized with a lock.  It's a weird open-coded
lock that is not even called a "lock".  That makes it a weird beast,
but Sean has convinced me it's a good idea without better alternatives.

Give the lock bit a better name, and document what it actually trying
to do.

Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org

---

 b/arch/x86/kernel/cpu/sgx/encl.h  |    2 +-
 b/arch/x86/kernel/cpu/sgx/ioctl.c |   19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff -puN arch/x86/kernel/cpu/sgx/ioctl.c~sgx-encl-flags arch/x86/kernel/cpu/sgx/ioctl.c
--- a/arch/x86/kernel/cpu/sgx/ioctl.c~sgx-encl-flags	2021-01-12 14:02:24.480689006 -0800
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c	2021-01-12 14:02:24.486689006 -0800
@@ -690,8 +690,21 @@ long sgx_ioctl(struct file *filep, unsig
 	struct sgx_encl *encl = filep->private_data;
 	int ret;
 
-	if (test_and_set_bit(SGX_ENCL_IOCTL, &encl->flags))
-		return -EBUSY;
+	/*
+	 * Behold, the Big SGX Lock
+	 *
+	 * The primary function of this "lock" is to actively discourage
+	 * attempts at multi-threaded enclave management.  Enclave management
+	 * is fundamentally a single-threaded affair.  Enclave measurement,
+	 * for instance would be worthless if two ADD_PAGES instances raced
+	 * and occurred in different orders.
+	 *
+	 * encl->lock is ill suited for this because it would need to be
+	 * conditionally dropped and reqacuired for operations like enclave
+	 * page allocation and reclaim.
+	 */
+	if (test_and_set_bit(SGX_ENCL_IOCTL_LOCK, &encl->flags))
+		return -EINVAL;
 
 	switch (cmd) {
 	case SGX_IOC_ENCLAVE_CREATE:
@@ -711,6 +724,6 @@ long sgx_ioctl(struct file *filep, unsig
 		break;
 	}
 
-	clear_bit(SGX_ENCL_IOCTL, &encl->flags);
+	clear_bit(SGX_ENCL_IOCTL_LOCK, &encl->flags);
 	return ret;
 }
diff -puN arch/x86/kernel/cpu/sgx/encl.h~sgx-encl-flags arch/x86/kernel/cpu/sgx/encl.h
--- a/arch/x86/kernel/cpu/sgx/encl.h~sgx-encl-flags	2021-01-12 14:02:24.482689006 -0800
+++ b/arch/x86/kernel/cpu/sgx/encl.h	2021-01-12 14:16:37.511686879 -0800
@@ -34,7 +34,7 @@ struct sgx_encl_page {
 };
 
 enum sgx_encl_flags {
-	SGX_ENCL_IOCTL		= BIT(0),
+	SGX_ENCL_IOCTL_LOCK	= BIT(0), /* See sgx_ioctl() */
 	SGX_ENCL_DEBUG		= BIT(1),
 	SGX_ENCL_CREATED	= BIT(2),
 	SGX_ENCL_INITIALIZED	= BIT(3),
_
