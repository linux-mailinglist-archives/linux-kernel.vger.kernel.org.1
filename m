Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494761ACA89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632833AbgDPPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:36:09 -0400
Received: from mail-m127101.qiye.163.com ([115.236.127.101]:3902 "EHLO
        mail-m127101.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410349AbgDPPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:36:00 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by mail-m127101.qiye.163.com (Hmail) with ESMTPA id 4FA7E47833;
        Thu, 16 Apr 2020 23:35:57 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4,3/4] powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
Date:   Thu, 16 Apr 2020 08:35:36 -0700
Message-Id: <20200416153537.23736-4-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416153537.23736-1-wenhu.wang@vivo.com>
References: <20200416153537.23736-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSlVCQ0tCQkJCT01OQk9JT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06TSo6IjgrGg8MFj85KS8s
        EgsKFA5VSlVKTkNMS05KSE5MTU1DVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlMTUw3Bg++
X-HM-Tid: 0a7183a1e5979865kuuu4fa7e47833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function instantiate_cache_sram should not be linked into the init
section for its caller mpc85xx_l2ctlr_of_probe is none-__init.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Warning information:
  MODPOST vmlinux.o
WARNING: modpost: vmlinux.o(.text+0x1e540): Section mismatch in reference from the function mpc85xx_l2ctlr_of_probe() to the function .init.text:instantiate_cache_sram()
The function mpc85xx_l2ctlr_of_probe() references
the function __init instantiate_cache_sram().
This is often because mpc85xx_l2ctlr_of_probe lacks a __init
annotation or the annotation of instantiate_cache_sram is wrong.
---
Changes since v1:
 * None
Changes since v2:
 * None
Changes since v3:
 * None
---
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index be3aef4229d7..3de5ac8382c0 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -68,7 +68,7 @@ void mpc85xx_cache_sram_free(void *ptr)
 }
 EXPORT_SYMBOL(mpc85xx_cache_sram_free);
 
-int __init instantiate_cache_sram(struct platform_device *dev,
+int instantiate_cache_sram(struct platform_device *dev,
 		struct sram_parameters sram_params)
 {
 	int ret = 0;
-- 
2.17.1

