Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8F2060D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392329AbgFWUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 16:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390462AbgFWUqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6882098B;
        Tue, 23 Jun 2020 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945206;
        bh=quuauKdGsLcpm3i7NzrtvO8cv96O3DkOJUuEUR/Wm1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFHaH/Age4SuLzAiYy4N9h7f0NImKrHyliZebNxI/HfWwO4r3bZbQeX5P8mmAcQQC
         sfhpozOI52VFJhXlB8v7Q64teppn67ZrXhDopSifPb7nvzAhVmsc31lqgUhT2I5zus
         WVoPAtOJU1R6+fPr5No6508wKNd/vmbJ8WAIXFec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huhai <huhai@tj.kylinos.cn>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 081/136] powerpc/4xx: Dont unmap NULL mbase
Date:   Tue, 23 Jun 2020 21:58:57 +0200
Message-Id: <20200623195307.774953314@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huhai <huhai@tj.kylinos.cn>

[ Upstream commit bcec081ecc940fc38730b29c743bbee661164161 ]

Signed-off-by: huhai <huhai@tj.kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200521072648.1254699-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/4xx/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx/pci.c
index 73e6b36bcd512..256943af58aae 100644
--- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -1242,7 +1242,7 @@ static void __init ppc460sx_pciex_check_link(struct ppc4xx_pciex_port *port)
 	if (mbase == NULL) {
 		printk(KERN_ERR "%pOF: Can't map internal config space !",
 			port->node);
-		goto done;
+		return;
 	}
 
 	while (attempt && (0 == (in_le32(mbase + PECFG_460SX_DLLSTA)
@@ -1252,9 +1252,7 @@ static void __init ppc460sx_pciex_check_link(struct ppc4xx_pciex_port *port)
 	}
 	if (attempt)
 		port->link = 1;
-done:
 	iounmap(mbase);
-
 }
 
 static struct ppc4xx_pciex_hwops ppc460sx_pcie_hwops __initdata = {
-- 
2.25.1



