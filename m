Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573222F3633
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405066AbhALQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbhALQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:52:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:51:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t30so3258669wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lAJS/ciMI//6oB+au/tisJfr1aUYml4srA0rz4DDtWU=;
        b=pg9ptp6tLIOH1e1NfW9ncCZwY5ERzbd6nAeG+1fPw8hytCmDnWVVv+lktiq3Z98quW
         Dcgpt2s0AMvFuT19S1jNk4H9mxQlgCtbrdvczcyN5mUJxcLmUiD7nhAdIz/za5TqInWf
         ByL/o6+zdHSEcAK/4S9ZlONamddW9OWxMNUDS25yEV16CROxgQO2mg2HpnqSFJEU40wI
         6JkdVhWfsKhTQu4wzqIozuFRBJGkDa74Q7lO5Msm53P7C5NmVcj1LkXGjzau7UqE/uWI
         RKl97ijQhyGC+TziqSBeBuvSFw1PJT1tsxig13TaEJKtptvdtddBJPcZ7zgm+URkq84M
         teYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lAJS/ciMI//6oB+au/tisJfr1aUYml4srA0rz4DDtWU=;
        b=mvNxWn1EL2Y+4v3PVWM9w+GDx0Zo057d6R/+n90YrfrRuWzu2Q/nApOEN7vQmnM6Su
         onspnGW0zDYlxfbjxMhzVNKoXd94sgX09g5kp/+Txg/RdnSWKGbvYfETSAQh9zPybmd8
         2mja7CiMZnO+7f23tP78a4HFEIcCALKDMkS+Ibv7MhreyNM6tZvmw/IPOqYg/7+tjXDP
         HLjQjnpQCUQ06LbulycIM65q3DwelvkSxxinpY206Cfs2+/T0HPjFlb4JNO1F6t09B2l
         5S3S0i6FmoRKBz8M+oi9D4L2P8ezJeeFfVaypu+rvFnxFYNuNRZzTy/EB2W5zACXtKBV
         6QWA==
X-Gm-Message-State: AOAM531YPkhbZwf7vV7D+EQ8GKL6KHsSa7hkb2d+CSKvVVxUSZ4kLDjA
        b5rA9keb79hH8JV26wCxYKM=
X-Google-Smtp-Source: ABdhPJyMJrJ0h+ZyMZn3PzMPqkOMHh22wE/bmyCFfMJVSBN3S+GzxN/Y3z8MVdsUOVP0JGr2UzLEzg==
X-Received: by 2002:adf:c6c4:: with SMTP id c4mr5413286wrh.348.1610470296369;
        Tue, 12 Jan 2021 08:51:36 -0800 (PST)
Received: from localhost.localdomain ([151.68.76.215])
        by smtp.gmail.com with ESMTPSA id u205sm4792163wme.42.2021.01.12.08.51.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 08:51:35 -0800 (PST)
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     linux@armlinux.org.uk
Cc:     giancarlo.ferrari@nokia.com, michal.simek@xilinx.com,
        Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Date:   Tue, 12 Jan 2021 16:49:06 +0000
Message-Id: <1610470147-22641-1-git-send-email-giancarlo.ferrari89@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_kexec() need to set rw permission in text and rodata sections
to assign some variables (e.g. kexec_start_address). To do that at
the end (after flushing pdm in memory, inv D-Cache, etc.) it needs to
invalidate TLB [section] entries.

If during the TLB invalidation an interrupt occours, which might cause
a context switch, there is the risk to inject invalid TLBs, with ro
permissions.

When trying to assign .text labels, this lead to the following issue:

"Unable to handle kernel paging request at virtual address <valid_addr>"

with FSR 0x80d.

Signed-off-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
---
 arch/arm/kernel/machine_kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 76300f3..bbe912d 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -176,6 +176,13 @@ void machine_kexec(struct kimage *image)
 
 	reboot_code_buffer = page_address(image->control_code_page);
 
+	/*
+	 * If below part is not atomic TLB entries might be corrupted after TLB
+	 * invalidation, which leads to Data Abort in .text variable assignment
+	 */
+	raw_local_irq_disable();
+	local_fiq_disable();
+
 	/* Prepare parameters for reboot_code_buffer*/
 	set_kernel_text_rw();
 	kexec_start_address = image->start;
@@ -183,6 +190,9 @@ void machine_kexec(struct kimage *image)
 	kexec_mach_type = machine_arch_type;
 	kexec_boot_atags = image->arch.kernel_r2;
 
+	local_fiq_enable();
+	raw_local_irq_enable();
+
 	/* copy our kernel relocation code to the control code page */
 	reboot_entry = fncpy(reboot_code_buffer,
 			     &relocate_new_kernel,
-- 
2.7.4

