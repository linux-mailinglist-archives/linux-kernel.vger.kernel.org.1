Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9522E26C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgGZUDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 16:03:41 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59364
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgGZUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:03:40 -0400
X-IronPort-AV: E=Sophos;i="5.75,399,1589234400"; 
   d="scan'208";a="355325586"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 26 Jul 2020 22:03:38 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: vfs: correct sync_mode flag names
Date:   Sun, 26 Jul 2020 21:22:21 +0200
Message-Id: <1595791341-13209-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the nonexistent flag names WBC_SYNC_ALL and WBC_SYNC_NONE to
WB_SYNC_ALL and WB_SYNC_NONE, respectively, as used in the code with
wbc->sync_mode.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/filesystems/vfs.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index da4b735..57e9b51 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -766,9 +766,9 @@ cache in your filesystem.  The following members are defined:
 
 ``writepages``
 	called by the VM to write out pages associated with the
-	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
+	address_space object.  If wbc->sync_mode is WB_SYNC_ALL, then
 	the writeback_control will specify a range of pages that must be
-	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is
+	written out.  If it is WB_SYNC_NONE, then a nr_to_write is
 	given and that many pages should be written if possible.  If no
 	->writepages is given, then mpage_writepages is used instead.
 	This will choose pages from the address space that are tagged as

