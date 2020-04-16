Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22361ACA88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410237AbgDPPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:36:05 -0400
Received: from mail-m127101.qiye.163.com ([115.236.127.101]:3706 "EHLO
        mail-m127101.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407626AbgDPPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:35:55 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by mail-m127101.qiye.163.com (Hmail) with ESMTPA id B2D3747589;
        Thu, 16 Apr 2020 23:35:48 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v4,0/4] drivers: uio: new driver uio_fsl_85xx_cache_sram
Date:   Thu, 16 Apr 2020 08:35:33 -0700
Message-Id: <20200416153537.23736-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVOQk1LS0tKQk9OT0JOTVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Vio6QzgwEg8hF00rTkMw
        LQMaCRNVSlVKTkNMS05KSE5KS0JCVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlNTk83Bg++
X-HM-Tid: 0a7183a1c3ec9865kuuub2d3747589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes since v1:
 * Addressed comments from Greg K-H
 * Moved kfree(info->name) into uio_info_free_internal()

Changes since v2:
 * Drop the patch that modifies Kconfigs of arch/powerpc/platforms
   and modified the sequence of patches:
    01:dropped, 02->03, 03->02, 04->01, 05->04
 * Addressed comments from Greg, Scott and Christophe
 * Use "uiomem->internal_addr" as if condition for sram memory free,
   and memset the uiomem entry
 * Modified of_match_table make the driver apart from Cache-Sram HW info
   which belong to the HW level driver fsl_85xx_cache_sram to match
 * Use roundup_pow_of_two for align calc(really learned a lot from Christophe)
 * Remove useless clear block of uiomem entries.
 * Use UIO_INFO_VER micro for info->version, and define it as
   "devicetree,pseudo", meaning this is pseudo device and probed from
   device tree configuration
 * Select FSL_85XX_CACHE_SRAM rather than depends on it

Changes since v3:
 * Addressed comments from Christophe(use devm_xxx memory alloc interfaces)

Wang Wenhu (4):
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  drivers: uio: new driver for fsl_85xx_cache_sram

 arch/powerpc/sysdev/fsl_85xx_cache_sram.c |   3 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   1 +
 drivers/uio/Kconfig                       |   9 ++
 drivers/uio/Makefile                      |   1 +
 drivers/uio/uio_fsl_85xx_cache_sram.c     | 148 ++++++++++++++++++++++
 5 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c

-- 
2.17.1

