Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89C24F0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHXAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHXAb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:31:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96D5C061573;
        Sun, 23 Aug 2020 17:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iM0SYJEwCSfM/KX5jOc8DR6fgqQxcRAOf/ZjYNYJiLg=; b=uvA44k96e2xJrd+e1flZL8Yw8F
        Bv6IOBb6LU0hfu4SDw3Quxz6eddj8qf2YVsGrV4WxnE3cvxXWh5Tc6u8DCAB7sj+NQyYrfMxyRKYN
        pnkQIRkhxiQIzNLbou0rvV4RG8jpjdefb3a9iDfY0quCuZDelXA5B+4t0/DFE72LTeZwSZgOadZ0q
        u1FkTLW9FiLgfbSeA8Deb1VlcdMxXsP/mucUw9kVwPk9ZZaqJpcIbu+3sF3hdMOJJmpO65bfNQIgn
        oJP8bIWd20jzznmBh3XWU10IsOOzT17KVn5CMpJqmk7KD7OFABKVpjHDH+qtjb5nMJUd2S7DEnMSl
        LMpmhnag==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kA0OM-0003lt-Dd; Mon, 24 Aug 2020 00:31:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/powerpc: fix malformed table in syscall64-abi
Message-ID: <e06de4d3-a36f-2745-9775-467e125436cc@infradead.org>
Date:   Sun, 23 Aug 2020 17:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix malformed table warning in powerpc/syscall64-abi.rst by making
two tables and moving the headings.

Documentation/powerpc/syscall64-abi.rst:53: WARNING: Malformed table.
Text in column margin in table line 2.

=========== ============= ========================================
--- For the sc instruction, differences with the ELF ABI ---
r0          Volatile      (System call number.)
r3          Volatile      (Parameter 1, and return value.)
r4-r8       Volatile      (Parameters 2-6.)
cr0         Volatile      (cr0.SO is the return error condition.)
cr1, cr5-7  Nonvolatile
lr          Nonvolatile

--- For the scv 0 instruction, differences with the ELF ABI ---
r0          Volatile      (System call number.)
r3          Volatile      (Parameter 1, and return value.)
r4-r8       Volatile      (Parameters 2-6.)
=========== ============= ========================================

Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/powerpc/syscall64-abi.rst |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- lnx-59-rc2.orig/Documentation/powerpc/syscall64-abi.rst
+++ lnx-59-rc2/Documentation/powerpc/syscall64-abi.rst
@@ -49,16 +49,18 @@ Register preservation rules
 Register preservation rules match the ELF ABI calling sequence with the
 following differences:
 
-=========== ============= ========================================
 --- For the sc instruction, differences with the ELF ABI ---
+=========== ============= ========================================
 r0          Volatile      (System call number.)
 r3          Volatile      (Parameter 1, and return value.)
 r4-r8       Volatile      (Parameters 2-6.)
 cr0         Volatile      (cr0.SO is the return error condition.)
 cr1, cr5-7  Nonvolatile
 lr          Nonvolatile
+=========== ============= ========================================
 
 --- For the scv 0 instruction, differences with the ELF ABI ---
+=========== ============= ========================================
 r0          Volatile      (System call number.)
 r3          Volatile      (Parameter 1, and return value.)
 r4-r8       Volatile      (Parameters 2-6.)


