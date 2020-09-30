Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC89E27E9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgI3N1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbgI3NZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118AF2396E;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=e7SfKQrnoPiyPXMeWnFCrrMuZKgfoFc+6m9qIBd4Co8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WyNHjVbNbrfOzppAg+kfW64BBPedCDGME0Nvbc01eyD8XRRctg7IDDoT692BJlSu
         r1CNdI1jnvQADpBjKMeDMKchzpBNTVjynD0oiWEl223pScxWm2B9pRQbnp8Idk1sYS
         jnzaoueyCTrhz1xIXDunArRnUqSSJsAi7w2eoGTM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XKP-5a; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 34/52] docs: pstore-blk.rst: fix kernel-doc tags
Date:   Wed, 30 Sep 2020 15:24:57 +0200
Message-Id: <cecf37b806ceb3bd53e642fc5437111e29e1c1f3.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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

