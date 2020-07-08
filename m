Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C477219121
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGHUET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 16:04:19 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:35924 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:04:18 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 79B19BC0C2;
        Wed,  8 Jul 2020 20:04:15 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] VFAT/FAT/MSDOS FILESYSTEM: Replace HTTP links with HTTPS ones
Date:   Wed,  8 Jul 2020 22:04:09 +0200
Message-Id: <20200708200409.22293-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 fs/fat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index ca31993dcb47..66532a71e8fd 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -41,7 +41,7 @@ config MSDOS_FS
 	  they are compressed; to access compressed MSDOS partitions under
 	  Linux, you can either use the DOS emulator DOSEMU, described in the
 	  DOSEMU-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>, or try dmsdosfs in
+	  <https://www.tldp.org/docs.html#howto>, or try dmsdosfs in
 	  <ftp://ibiblio.org/pub/Linux/system/filesystems/dosfs/>. If you
 	  intend to use dosemu with a non-compressed MSDOS partition, say Y
 	  here) and MSDOS floppies. This means that file access becomes
-- 
2.27.0

