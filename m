Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09381AABD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636897AbgDOPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 11:25:53 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:14794 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634875AbgDOPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:25:39 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 422274E17AD;
        Wed, 15 Apr 2020 23:25:29 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v2,0/5] drivers: uio: new driver uio_fsl_85xx_cache_sram
Date:   Wed, 15 Apr 2020 08:24:37 -0700
Message-Id: <20200415152442.122873-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415124929.GA3265842@kroah.com>
References: <20200415124929.GA3265842@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVCTE5CQkJDSElKTkhISVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxA6DDo4CDg3PAg3PyoNGRUL
        HzMwCRZVSlVKTkNNQk1PSEhKTkJKVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlPS0M3Bg++
X-HM-Tid: 0a717e71f4179376kuws422274e17ad
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a new uio driver for freescale 85xx platforms to
access the Cache-Sram form user level. This is extremely helpful
for the user-space applications that require high performance memory
accesses.

It fixes the compile errors and warning of the hardware level drivers
and implements the uio driver in uio_fsl_85xx_cache_sram.c.

Changes since v1:
 * Addressed comments of Greg K-H
 * Moved kfree(info->name) into uio_info_free_internal()

Wang Wenhu (5):
  powerpc: 85xx: make FSL_85XX_CACHE_SRAM configurable
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  drivers: uio: new driver for fsl_85xx_cache_sram

 arch/powerpc/platforms/85xx/Kconfig       |   2 +-
 arch/powerpc/platforms/Kconfig.cputype    |   5 +-
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c |   3 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   1 +
 drivers/uio/Kconfig                       |   8 +
 drivers/uio/Makefile                      |   1 +
 drivers/uio/uio_fsl_85xx_cache_sram.c     | 182 ++++++++++++++++++++++
 7 files changed, 198 insertions(+), 4 deletions(-)
 create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c

-- 
2.17.1

