Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9126332F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgIIQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5840E221ED;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=TI6Ssuo/TmzG8/JJTfqrCwvAcH95Ulrou5VOJodRhrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNq5IssL2ZGD8gyYrcaekt9ecwux7kBqCb43EHzgxlhSVw0Dg/3C+bVQVSLl+bLKt
         uZBCDcpm+9fXilbkK5fPxYmwrX9A9wm9jGMDcETfQIUeqmpUVXWNwsV4SLWlfVDNI1
         iSb9+46hoPWTMi/YUltZi8GzdWmVHFgi5JtNev0g=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXE-Fl; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/30] docs: watch_queue: fix some warnings
Date:   Wed,  9 Sep 2020 16:10:47 +0200
Message-Id: <42706310c09a6b4588a1a41078207246ad1238fa.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix those warnings:

    Documentation/watch_queue.rst:108: WARNING: Inline literal start-string without end-string.
    Documentation/watch_queue.rst:108: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:108: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:108: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:185: WARNING: Inline literal start-string without end-string.
    Documentation/watch_queue.rst:185: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:184: WARNING: Inline emphasis start-string without end-string.

The problem here is that the ``notation`` doesn't accept
multi lines. So, replace it to a code block using:

	::

		notation

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/watch_queue.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 3e647992be31..85565e8a15da 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -104,8 +104,10 @@ watch that specific key).
 
 To manage a watch list, the following functions are provided:
 
-  * ``void init_watch_list(struct watch_list *wlist,
-			   void (*release_watch)(struct watch *wlist));``
+  * ::
+
+	void init_watch_list(struct watch_list *wlist,
+			     void (*release_watch)(struct watch *wlist));
 
     Initialise a watch list.  If ``release_watch`` is not NULL, then this
     indicates a function that should be called when the watch_list object is
@@ -180,9 +182,11 @@ The following functions are provided to manage watches:
     driver-settable fields in the watch struct must have been set before this
     is called.
 
-  * ``int remove_watch_from_object(struct watch_list *wlist,
-				   struct watch_queue *wqueue,
-				   u64 id, false);``
+  * ::
+
+	int remove_watch_from_object(struct watch_list *wlist,
+				     struct watch_queue *wqueue,
+				     u64 id, false);
 
     Remove a watch from a watch list, where the watch must match the specified
     watch queue (``wqueue``) and object identifier (``id``).  A notification
-- 
2.26.2

