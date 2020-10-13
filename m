Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15C928CD99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgJMMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8188322280;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=2vOhXSLKPSRDq4fwV/l5qiMktT9sFbutjxIXyI0HcqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyb/G1a67ELuVQJTlD7UPK6nCoO9+7WoZDZLyye6SFTD9ZA3Aldtj36kMMQ/jq2vD
         6uvq+poRKrYu6cR6xmfzeGS4MMZcMTQgLAgwCWIck9mEkfTPrexyz05ApVmHDbyEro
         o6fMfKLSKid1k0tHP3SF5RccUEAv54PUsjz7xlUk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUR-Di; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>, Marco Elver <elver@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 28/80] docs: kernel-api.rst: drop kernel/irq/manage.c kernel-doc tag
Date:   Tue, 13 Oct 2020 13:53:43 +0200
Message-Id: <087bc7c5071c0b223b3ea81978fe220ad10fdf0b.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

