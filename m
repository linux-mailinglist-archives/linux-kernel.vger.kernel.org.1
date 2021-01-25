Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B678C303D27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403933AbhAZKOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbhAYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0888C061797
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:41 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id r9so10496387qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5oItsXz80VGMkIK9n/+4yNTlc3wm3VkQinupbSJHsbU=;
        b=PZYpwfrFvSlaUCkpDD05HG1cJCDlDOf+CUaa46d/3Sf4IeCJvLQ226vo3BkaPzPeVK
         JZbb1ZDcCU7ye9jeVV1OG5khyvwWUIfNQO1CqaBvXmiHejT5L+rDVKo6Rm4kpcbugs9G
         ne9oGFKvOQsVFYgujx0RQze9i3AqNviHN45Bb0YFDIo741ZRjS1YRjfDGXn69eAi4PAV
         JIhvMTg3YI2g+4P9Vz7u/dSGxJd8MHa37mdnHAj1kcTor+MsBSmxNUee4ll41ONPNKp7
         VCcG8A9NH9nt8ykRu91p3nz82wHjF6r3JWAGbffQLeTodD/nuGq7TYWmm9RrzYzoTo1a
         sSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oItsXz80VGMkIK9n/+4yNTlc3wm3VkQinupbSJHsbU=;
        b=S6dNMdasCdIRwuy9VI8B+qqpclasmRS+1bNpoCdFAE4vzwS2uWinqqxLndiZ26f3gf
         x3ftd5nwnrG+VY5lBQpadfvldLeGtklDn18xcrUtMrMNVVLZkhsouJJh8lmaVcoaqzs7
         y1ICyQ27ytm9EERAtzNOMTk2ZmTq0o8BP3usRyiX+h485LiMNQL+8KsMyzVZyXTwIFzA
         2aFqB6Kgw6WxR8oLSJrfCb1ORwguCAl51xM3mICFaSb2NQSP/V79poQ9K5KQv52umpL2
         Iqy3pEcR1GOaQD5eVLHe5k9+x51+cBR7fXsd4SI4+3IybIXjxvLHgAfGO2/ehGXDj31D
         +sFA==
X-Gm-Message-State: AOAM533DFsyh1YgvGZB6W+aLw//y4Mg+RS9Z2NxNGxeV3vva9NtJq8/l
        4vl8l3KKUrFZCmxysDeV28Stpw==
X-Google-Smtp-Source: ABdhPJydaAMyVai0d0oDbWxmrL/nu0WOLUZ8DiszpSfhSyLHotQkTYoRRSqhOnxoO+wBONtIKJSi8w==
X-Received: by 2002:ac8:490e:: with SMTP id e14mr1966761qtq.99.1611602380917;
        Mon, 25 Jan 2021 11:19:40 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:40 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 10/18] arm64: kexec: call kexec_image_info only once
Date:   Mon, 25 Jan 2021 14:19:15 -0500
Message-Id: <20210125191923.1060122-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec_image_info() is called during load time, and
right before kernel is being kexec'ed. There is no need to do both.
So, call it only once when segments are loaded and the physical
location of page with copy of arm64_relocate_new_kernel is known.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index a8aaa6562429..90a335c74442 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -66,6 +66,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
 	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
@@ -84,8 +85,6 @@ int machine_kexec_post_load(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kexec_image_info(kimage);
-
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
 		return -EBUSY;
@@ -170,8 +169,6 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	kexec_image_info(kimage);
-
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);
 
-- 
2.25.1

