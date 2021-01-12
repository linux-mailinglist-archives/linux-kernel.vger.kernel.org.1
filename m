Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828832F2657
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbhALCi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbhALCi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:38:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57D3422CAD;
        Tue, 12 Jan 2021 02:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610419068;
        bh=sK4Lld2OfYF7cZZkxMp0bBGgxfOde4PwtozvlLWeiGo=;
        h=From:To:Cc:Subject:Date:From;
        b=aubr0/zhul2ZBGUk+kNEweUlY9ngTUDB28nsC0iUbNKcKzxlV5Xt6wMFVJSBUUGJe
         x6DBp7nVyDY1aitcpq4teX6nHXn8NkyVtpX8HxCI1Z85y70FXsF8QSbbbTKfWTP6Cs
         nqYlbn1qcWJugEXe879LzQhIDYOudfDlVrtL4ECO2GbqctAxqTHy6N7UNJp9qVIjnu
         WYzx/OyR5Jg5oqbngQDfRyhODvEIzK11vpE2QNQ/oBK0+rre99N6ekXUu1cmCHmqGE
         NKm5h/raBw77uXW2uFvJ8sBJSIcI1+TF81SQl9Ear8UxFdDoV/EFsSCLKYuuR5lyAC
         u0wNGdGHWO+8Q==
From:   guoren@kernel.org
To:     palmerdabbelt@google.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] riscv: Remove duplicate definition in pagtable.h
Date:   Tue, 12 Jan 2021 10:35:34 +0800
Message-Id: <20210112023534.117354-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

PAGE_KERNEL_EXEC has been defined above.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Pekka Enberg <penberg@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 41a72861987c..dff51a84e52e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -101,7 +101,6 @@
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
 #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
-#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
 #define PAGE_KERNEL_READ_EXEC	__pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
 					 | _PAGE_EXEC)
 
-- 
2.17.1

