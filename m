Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50126331B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgIIQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD212222E;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=9mtg6cPA9MJfrf7/vYpFkaem8befp1IfLRwT5OVMr08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dS8pMw7j1MtPEqlMq0ixPlfAtQhJpyIBoponCnJTeqk8I5zJhdvnX0evblJGL2p8w
         ia/f5r7YNjiwb0UFrLSCiYZShlLWVBHQOYsmKLHEkbiTs5PRbpIWH/cC68CUiZfH+K
         SzpQs/A7P9ghDVdFKlFuqT3KbFg5nXDj9s+jDLSw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXB-Eq; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] docs: powerpc: syscall64-abi.rst: fix a malformed table
Date:   Wed,  9 Sep 2020 16:10:46 +0200
Message-Id: <0c2159084936a8a14aaa9e6416424e80fe488a03.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported:

	Documentation/powerpc/syscall64-abi.rst:53: WARNING: Malformed table.
	Text in column margin in table line 2.

	=========== ============= ========================================
	--- For the sc instruction, differences with the ELF ABI ---
	r0          Volatile      (System call number.)

This table requires a different notation to be valid.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/powerpc/syscall64-abi.rst | 32 ++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/powerpc/syscall64-abi.rst b/Documentation/powerpc/syscall64-abi.rst
index 379817ca64d2..cf9b2857c72a 100644
--- a/Documentation/powerpc/syscall64-abi.rst
+++ b/Documentation/powerpc/syscall64-abi.rst
@@ -49,22 +49,22 @@ Register preservation rules
 Register preservation rules match the ELF ABI calling sequence with the
 following differences:
 
---- For the sc instruction, differences with the ELF ABI ---
-=========== ============= ========================================
-r0          Volatile      (System call number.)
-r3          Volatile      (Parameter 1, and return value.)
-r4-r8       Volatile      (Parameters 2-6.)
-cr0         Volatile      (cr0.SO is the return error condition.)
-cr1, cr5-7  Nonvolatile
-lr          Nonvolatile
-=========== ============= ========================================
-
---- For the scv 0 instruction, differences with the ELF ABI ---
-=========== ============= ========================================
-r0          Volatile      (System call number.)
-r3          Volatile      (Parameter 1, and return value.)
-r4-r8       Volatile      (Parameters 2-6.)
-=========== ============= ========================================
++------------------------------------------------------------------------+
+|        For the sc instruction, differences with the ELF ABI		 |
++--------------+--------------+------------------------------------------+
+| r0           | Volatile     | (System call number.)			 |
+| rr3          | Volatile     | (Parameter 1, and return value.)	 |
+| rr4-r8       | Volatile     | (Parameters 2-6.)			 |
+| rcr0         | Volatile     | (cr0.SO is the return error condition.)	 |
+| rcr1, cr5-7  | Nonvolatile  |						 |
+| rlr          | Nonvolatile  |						 |
++--------------+--------------+------------------------------------------+
+|      For the scv 0 instruction, differences with the ELF ABI		 |
++--------------+--------------+------------------------------------------+
+| r0           | Volatile     | (System call number.)			 |
+| r3           | Volatile     | (Parameter 1, and return value.)	 |
+| r4-r8        | Volatile     | (Parameters 2-6.)			 |
++--------------+--------------+------------------------------------------+
 
 All floating point and vector data registers as well as control and status
 registers are nonvolatile.
-- 
2.26.2

