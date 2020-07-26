Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27A22E23E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 21:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGZTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 15:24:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28345 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgGZTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:24:55 -0400
X-IronPort-AV: E=Sophos;i="5.75,399,1589234400"; 
   d="scan'208";a="461367851"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 26 Jul 2020 21:24:53 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: vfs: correct flag name
Date:   Sun, 26 Jul 2020 20:43:40 +0200
Message-Id: <1595789020-12941-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no flag REMAP_CAN_SHORTEN.  Commit eca3654e3cc7 ("vfs: enable
remap callers that can handle short operations") that introduces this
text also introduces the flag REMAP_FILE_CAN_SHORTEN.  Change the name
in the documentation accordingly.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/filesystems/vfs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index da4b735..d08357d 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1116,7 +1116,7 @@ otherwise noted.
 	before any bytes were remapped.  The remap_flags parameter
 	accepts REMAP_FILE_* flags.  If REMAP_FILE_DEDUP is set then the
 	implementation must only remap if the requested file ranges have
-	identical contents.  If REMAP_CAN_SHORTEN is set, the caller is
+	identical contents.  If REMAP_FILE_CAN_SHORTEN is set, the caller is
 	ok with the implementation shortening the request length to
 	satisfy alignment or EOF requirements (or any other reason).
 

