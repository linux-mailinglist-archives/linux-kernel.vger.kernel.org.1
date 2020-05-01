Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9151A1C19CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgEAPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 11:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbgEAPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB11B24959;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347482;
        bh=Q6vbFSFsvP1/PVPUMh4N6HimvTPIEBmlU6XjmJ+LSx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLXlwnlYM13v2PQiRfNv3a0ERgc+r0tmucBlmapm89I9kUkfrTfYz/KbivrLIxy6y
         uUBzRXA1jt6z3qIHTGQggdOjo1np+mLLcXbDuRjpw0aBr/njAupmXNWpelBAbPVv3V
         sQuFKOiPxW5dc1/XkVKZBNZvpPExRbcY2oDM2aGY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjk-00FE4U-W0; Fri, 01 May 2020 17:38:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 02/14] docs: add bus-virt-phys-mapping.txt to core-api
Date:   Fri,  1 May 2020 17:37:46 +0200
Message-Id: <ccd32aa5231b0e235a555fdecc4c0d274e5a6161.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes an old interface used prior the new DMA-API
interfaces. Add it to the core-api guide, just after the
DMA stuff.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bus-virt-phys-mapping.rst}                                   | 0
 Documentation/core-api/index.rst                                 | 1 +
 2 files changed, 1 insertion(+)
 rename Documentation/{bus-virt-phys-mapping.txt => core-api/bus-virt-phys-mapping.rst} (100%)

diff --git a/Documentation/bus-virt-phys-mapping.txt b/Documentation/core-api/bus-virt-phys-mapping.rst
similarity index 100%
rename from Documentation/bus-virt-phys-mapping.txt
rename to Documentation/core-api/bus-virt-phys-mapping.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index c00aef843341..b70039d458a7 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -84,6 +84,7 @@ more memory-management documentation in :doc:`/vm/index`.
    dma-api-howto
    dma-attributes
    dma-isa-lpc
+   bus-virt-phys-mapping
    mm-api
    genalloc
    pin_user_pages
-- 
2.25.4

