Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0724E259
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHUVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 17:00:04 -0400
Received: from alpha.anastas.io ([104.248.188.109]:47267 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHUVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:00:03 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 17:00:03 EDT
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 616C07ECD8;
        Fri, 21 Aug 2020 15:51:20 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1598043080; bh=3aXxNw1T7kdHi4tVgB2VciVb6/V2lhrq6znhBANHZfc=;
        h=From:To:Cc:Subject:Date:From;
        b=M26UuQrQm8jPQgBKQNmE7/gc3QUIpQLE3JP7bkeox+74vKkCH06Ofnn06ZNyzLtmf
         3S9Z+OdGy2PvCKk+c0dQPQoyFkmvt8acccvKt76J0MO5ONwaUCP+o22a33Vd/m+5g2
         KfIuw9cEq/iyOr25uJE0BLGLsWQSNE8keBvzh+Cw2cWXEHDRC6oYt8KgjWVQ9pFMab
         Tke5ZQW/VWJGqs+voAbjrFQnZyM2sIusApZsZvhG/pTlroWH0v1Y2QhpY5dX3qv/Ay
         ZzF0PgVdpZZhfBbgZNhxBEoJk81cb4B3k3DsW8q+y8j2lZ+6XqN3jV6WdN9A/8G19Y
         Vga/+fpo7uINg==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, mpe@ellerman.id.au, oohall@gmail.com,
        aik@ozlabs.ru
Subject: [PATCH] powerpc/pseries: Add pcibios_default_alignment implementation
Date:   Fri, 21 Aug 2020 15:51:15 -0500
Message-Id: <20200821205115.50333-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement pcibios_default_alignment for pseries so that
resources are page-aligned. The main benefit of this is being
able to map any resource from userspace via mechanisms like VFIO.

This is identical to powernv's implementation.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/platforms/pseries/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 911534b89c85..6d922c096354 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -210,6 +210,11 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
 }
 #endif
 
+static resource_size_t pseries_pcibios_default_alignment(void)
+{
+	return PAGE_SIZE;
+}
+
 static void __init pSeries_request_regions(void)
 {
 	if (!isa_io_base)
@@ -231,6 +236,8 @@ void __init pSeries_final_fixup(void)
 
 	eeh_show_enabled();
 
+	ppc_md.pcibios_default_alignment = pseries_pcibios_default_alignment;
+
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
 	ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
-- 
2.28.0

