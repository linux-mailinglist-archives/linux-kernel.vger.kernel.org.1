Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8861C28CCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgJMLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbgJMLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:55:03 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867C8229C7;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=A7lLnKa6YyaQtK0OX9oslHuXqmGCRzRwzf23PGqcyNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=es+mVdswFam7SjIexEi+YO/n+dft4hdbRCZNDKezrWfwE7ve0K+RUvGiSa/10grNz
         f4Q4Y0aGZJrTh6bjs+rMSeswIFeZT6zqt9cn4PDbs7/Y7B+jvS7a50mUBuFG6UY8xR
         buIgrkXjonIoVIXxmOFxbwgtrYG8NJ/m3e2YXnyo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUg-J8; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 34/80] docs: pstore-blk.rst: fix kernel-doc tags
Date:   Tue, 13 Oct 2020 13:53:49 +0200
Message-Id: <34ea299db48fdff99991a245d5d88040e498a16a.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a problem with kernel-doc tags from blk.c:

	.../Documentation/admin-guide/pstore-blk:239: ./fs/pstore/blk.c:175: WARNING: Duplicate C declaration, also defined in 'admin-guide/pstore-blk'.
	Declaration is 'register_pstore_device'.
	.../Documentation/admin-guide/pstore-blk:239: ./fs/pstore/blk.c:432: WARNING: Duplicate C declaration, also defined in 'admin-guide/pstore-blk'.
	Declaration is 'register_pstore_blk'.
	.../Documentation/admin-guide/pstore-blk:242: ./include/linux/pstore_blk.h:43: WARNING: Duplicate C declaration, also defined in 'admin-guide/pstore-blk'.
	Declaration is 'pstore_device_info'.

Basically, the internal parts is shown with :export:, instead
of :internal:. Yet, there are some other exported docs that
aren't at the document, because they lack :identifiers:.

So, instead, let's just use :export: at the kAPI part of
the documentation.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/pstore-blk.rst | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 296d5027787a..6898aba9fb5c 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -154,17 +154,11 @@ Configurations for driver
 Only a block device driver cares about these configurations. A block device
 driver uses ``register_pstore_blk`` to register to pstore/blk.
 
-.. kernel-doc:: fs/pstore/blk.c
-   :identifiers: register_pstore_blk
-
 A non-block device driver uses ``register_pstore_device`` with
 ``struct pstore_device_info`` to register to pstore/blk.
 
 .. kernel-doc:: fs/pstore/blk.c
-   :identifiers: register_pstore_device
-
-.. kernel-doc:: include/linux/pstore_blk.h
-   :identifiers: pstore_device_info
+   :export:
 
 Compression and header
 ----------------------
@@ -237,7 +231,7 @@ For developer reference, here are all the important structures and APIs:
    :internal:
 
 .. kernel-doc:: fs/pstore/blk.c
-   :export:
+   :internal:
 
 .. kernel-doc:: include/linux/pstore_blk.h
    :internal:
-- 
2.26.2

