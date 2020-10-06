Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE99284D28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgJFOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC7821D7B;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=6FnAXTisJK9UFRAN8m9cKwYQmxfqAucBzkfFzqVowps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi+ZrUtT5ElxmbnMVNO1H40JGT7rwiPdByCXMYjTPYsR1MK/45qcJwtU06yKR9SqC
         TpUL9oUPOdv4KaEtP1MHQwG2GIFsgA97h8nBv1vZoOlZCepsu6smmbKU0kLGNgU9iP
         /hSLY5xNy7wXosuxIoOhjNS2bW3RR7HwE2+lj28k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019Fv-Dt; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 32/52] docs: basics.rst: get rid of rcu kernel-doc macros
Date:   Tue,  6 Oct 2020 16:03:29 +0200
Message-Id: <2501bfd97f2b09a69815f8fa0b810d8af6e278ce.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are already defined at kernel-api.rst, as part of the
synchronization primitives chapter.

This solves several Sphinx 3 warnings, like:

	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'rcu_idle_enter'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'rcu_idle_exit'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'rcu_is_watching'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'call_rcu'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'synchronize_rcu'.
	...

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/basics.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 54f8d5ca7475..63bbe3ed5e76 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -103,12 +103,6 @@ Kernel utility functions
 .. kernel-doc:: kernel/panic.c
    :export:
 
-.. kernel-doc:: kernel/rcu/tree.c
-   :export:
-
-.. kernel-doc:: kernel/rcu/update.c
-   :export:
-
 .. kernel-doc:: include/linux/overflow.h
    :internal:
 
-- 
2.26.2

