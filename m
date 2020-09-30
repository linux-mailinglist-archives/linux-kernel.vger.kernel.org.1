Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40227E9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgI3N1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730225AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7950235FC;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=2vOhXSLKPSRDq4fwV/l5qiMktT9sFbutjxIXyI0HcqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IX/qUc95D7PcaswOMTskSA1Xp+PIWteXDw2R3Jmfcv+5bIHMuTqcNu64Gh8c2ZM08
         IFgta0xvMvYfSXFboJwhKSJT1AQt48OR1CDPDiFRM/gpaS3r0OC0+ZSetlYpSLJLlD
         WwtBiXOyvpnK3G7IM5Y2I+G+QxYGNg31uCKcE8/I=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XK2-SZ; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>, Marco Elver <elver@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 27/52] docs: kernel-api.rst: drop kernel/irq/manage.c kernel-doc tag
Date:   Wed, 30 Sep 2020 15:24:50 +0200
Message-Id: <76f39912e9774c97a1257a88afb44d2f0e91cdee.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already included at genericirq.rst. Adding it twice
causes C namespace duplication:

	.../Documentation/core-api/kernel-api:237: ../kernel/irq/manage.c:100: WARNING: Duplicate C declaration, also defined in 'genericirq'.
	Declaration is 'synchronize_hardirq'.
	.../Documentation/core-api/kernel-api:237: ../kernel/irq/manage.c:128: WARNING: Duplicate C declaration, also defined in 'genericirq'.
	Declaration is 'synchronize_irq'.
	.../Documentation/core-api/kernel-api:237: ../kernel/irq/manage.c:443: WARNING: Duplicate C declaration, also defined in 'genericirq'.
	Declaration is 'irq_set_affinity_notifier'.
	...

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/kernel-api.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 4ac53a1363f6..741aa37dc181 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -231,12 +231,6 @@ Refer to the file kernel/module.c for more information.
 Hardware Interfaces
 ===================
 
-Interrupt Handling
-------------------
-
-.. kernel-doc:: kernel/irq/manage.c
-   :export:
-
 DMA Channels
 ------------
 
-- 
2.26.2

