Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47A1ABD66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504470AbgDPJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 05:55:44 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:49294 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504147AbgDPJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:55:41 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id A18BC4E30C2;
        Thu, 16 Apr 2020 15:42:00 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3,2/4] powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
Date:   Thu, 16 Apr 2020 00:41:39 -0700
Message-Id: <20200416074141.3555-3-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416074141.3555-1-wenhu.wang@vivo.com>
References: <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200416074141.3555-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVCS0pCQkJCTktPS0NCT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6HSo4Vjg#OAg3HSxIKjYt
        SU4wFBJVSlVKTkNMS0lJQklKS09KVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhIS0M3Bg++
X-HM-Tid: 0a7181effcdd9376kuwsa18bc4e30c2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/io.h into fsl_85xx_cache_sram.c to fix the
implicit-declaration compile error when building Cache-Sram.

arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
  cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
                          ^~~~~~~~~~~~~~~~
                          bitmap_complement
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
                        ^
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
  iounmap(cache_sram->base_virt);
  ^~~~~~~
  roundup
cc1: all warnings being treated as errors

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
---
Changes since v1:
 * None
Changes since v2:
 * None
---
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index f6c665dac725..be3aef4229d7 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <asm/pgtable.h>
 #include <asm/fsl_85xx_cache_sram.h>
+#include <linux/io.h>
 
 #include "fsl_85xx_cache_ctlr.h"
 
-- 
2.17.1

