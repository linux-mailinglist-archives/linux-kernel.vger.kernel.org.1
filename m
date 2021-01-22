Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C902FF9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAVBJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbhAVBJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:09:14 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/oDnqYJ3Lv1FNKyp8PO4ESlMBOKK0rSIbZdQUowJFjk=; b=pynfINvSeqWntJ7H2DC9OXw42W
        gPGMtkR3FjaP6TBhxkgwhPjxvIZgO4WCClO7QZRx6nfkNPnSE4B+kVNHFczaWXURysQX81s6bkNgd
        zmu5B24ZAhVyuKe/T69GTOLf8ZZQ1cw76yg3ww+TNRifyDCHqjh7fi2eo36osbo4Q02uoUFboxNWw
        Wq7aoY3B/fKHSjG5LkoI2QZgOTaIaW7xfdDhjnj/MrFtPgXGstvPcaRbESTnCr8O8Trlhvv7neS6r
        sOb+TKohIRWl9mWxXHpVjasNCYCaBbFXaS3RrhDggCLCz7P3BTpCHNTdHI/+ccWttDn3Nhxj+GoeI
        U9WlK+sg==;
Received: from [2601:1c0:6280:3f0::9abc] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2kw7-0000Va-5O; Fri, 22 Jan 2021 01:08:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: export 'cpm_setbrg' for modules
Date:   Thu, 21 Jan 2021 17:08:19 -0800
Message-Id: <20210122010819.30986-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing export for a loadable module build:

ERROR: modpost: "cpm_setbrg" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!

Fixes: 4128a89ac80d ("powerpc/8xx: move CPM1 related files from sysdev/ to platforms/8xx")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: clang-built-linux@googlegroups.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/8xx/cpm1.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210121.orig/arch/powerpc/platforms/8xx/cpm1.c
+++ linux-next-20210121/arch/powerpc/platforms/8xx/cpm1.c
@@ -280,6 +280,7 @@ cpm_setbrg(uint brg, uint rate)
 		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
 			      CPM_BRG_EN | CPM_BRG_DIV16);
 }
+EXPORT_SYMBOL(cpm_setbrg);
 
 struct cpm_ioport16 {
 	__be16 dir, par, odr_sor, dat, intr;
