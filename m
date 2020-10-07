Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33932868A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgJGTx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:53:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41389 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgJGTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:53:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id b69so4359055qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xP9l6h0pLyt3eoh/GbILll4OJvuxDhCM2RX4gvFhu+A=;
        b=i7Nb63mff+2T4tryal45l4fw3Sjnt4HJzS9dHsWUF831KZHxO/d8YbQWriVSmPKeLb
         wvD2o2adjEisTTz7TsUukK2P0hjtOWTiG2y5/rcsccRqSAZnCs1D9OFO4NlyVK00PP/p
         PmmkTHVjc15C2nY2ZRnzr9QNrOOCTHMAv2u+kuWnU+mk9cwWEQaSntTStW2nkUFhD3eR
         VRH5Kir14c6CyRQgjWajHqUp1knrYlRhs+agQRT2HI3//60lp4yHDQK4Te2WLVw13/Re
         Jqq4qg0oqWqG9ju13K4Bfu+s8XQL2LmuY12xWNZIGLEICyEoY0wEqIP+xSK4iMrrGGo9
         JMng==
X-Gm-Message-State: AOAM533f1zo1Br41IloJmsU9xC4GH31lriPQfY4vm99z19se9a+a0pZ4
        nSgahTgUOCuen/e2Vi/AK1TSYUPNWXtFrw==
X-Google-Smtp-Source: ABdhPJzw4cKZIs3RJtqdINVlyUW5G6purulAFQ2HfTKGJ03T9RSlB2YRjypGB2CL+9PPDHcsEPQKUw==
X-Received: by 2002:a05:620a:851:: with SMTP id u17mr4518967qku.344.1602100435410;
        Wed, 07 Oct 2020 12:53:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2287658qtm.44.2020.10.07.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:53:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] x86/boot/64: Change add_identity_map() to take size for ease of use
Date:   Wed,  7 Oct 2020 15:53:49 -0400
Message-Id: <20201007195351.776555-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007195351.776555-1-nivedita@alum.mit.edu>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change back the arguments of add_identity_map() to (start, size) instead
of (start, end). This reverts

  21cf2372618e ("x86/boot/compressed/64: Change add_identity_map() to take start and end")

since we will soon have more callers that know the size rather than the
end address.

This also makes the #PF handler print the original CR2 value in case of
error, instead of after aligning to PMD_SIZE.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/ident_map_64.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 063a60edcf99..070cda70aef3 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -90,8 +90,9 @@ static struct x86_mapping_info mapping_info;
 /*
  * Adds the specified range to the identity mappings.
  */
-static void add_identity_map(unsigned long start, unsigned long end)
+static void add_identity_map(unsigned long start, unsigned long size)
 {
+	unsigned long end = start + size;
 	int ret;
 
 	/* Align boundary to 2M. */
@@ -152,7 +153,7 @@ void initialize_identity_maps(void)
 	 * New page-table is set up - map the kernel image and load it
 	 * into cr3.
 	 */
-	add_identity_map((unsigned long)_head, (unsigned long)_end);
+	add_identity_map((unsigned long)_head, (unsigned long)_end - (unsigned long)_head);
 	write_cr3(top_level_pgt);
 }
 
@@ -322,14 +323,10 @@ static void do_pf_error(const char *msg, unsigned long error_code,
 void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	unsigned long address = native_read_cr2();
-	unsigned long end;
 	bool ghcb_fault;
 
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
-	address   &= PMD_MASK;
-	end        = address + PMD_SIZE;
-
 	/*
 	 * Check for unexpected error codes. Unexpected are:
 	 *	- Faults on present pages
@@ -345,5 +342,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 * Error code is sane - now identity map the 2M region around
 	 * the faulting address.
 	 */
-	add_identity_map(address, end);
+	add_identity_map(address & PMD_MASK, PMD_SIZE);
 }
-- 
2.26.2

