Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0D2FF8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbhAUXZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbhAUXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:06:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B4FC061A28
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:03:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l10so3714901ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CZMyGWlKFZQTRektdrF/slvssAIzMQGtBohXi2xlJZo=;
        b=rrCQEqKVW1ZDhW4+xC0fjbzkbeY/JM71fiwBKXHsmFH4bwE2GxtDFk+U88/SUhdZrf
         m7wzzh7s3pqKnNjd10foCZJDNdK/vkuuRpPD69ujIVZe3eifyns8biUA8hZoFwPNKnDb
         Ba3v3G79vllZnXC34ggan7U2sUksnH545H+f+6bih9NuBbW12SjTSwsWplttdtVyg536
         GP0pN9LaqdE82PHlByUSvgve2pSMZuoQ6XfZu6yXARBBw+19h3asuK13j5tmK1ncQkcY
         r6k+aHDCwUHG8X/Lo9Rh9plI3yOEJxIzYYGPgdsvlhvIGQPysaEunA99fEdDpORoP0Ww
         T1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CZMyGWlKFZQTRektdrF/slvssAIzMQGtBohXi2xlJZo=;
        b=KkVzOI5luKnU1VsUrylmiInrYsQdYulfydJAU+eMouz2DBbA1cI0Q4CQPNmmoQqVdn
         xXd//CtjOugpTI92gyhkwEbicOSmOwewSxyWihiPwiU4Y58qgwTBcWW4EaSrcg5KF0Vl
         0t7CwEw/Xgud4WSR7BllUnSYM/1sWMrfOoAd5g0+Gibp4MThxtxAY7m9Bj7h2jP7CYiZ
         u2rB+EtC0db2flgr+a/WkhUUtjpiEkL1esJD5RrqKOQq6gbVrCz5Yyp3Cosh0gsXPVzn
         1ig3NtiEV/v/JJMSQ4ZpeI6CvJ5xjTSXcl6fn+aZVxybCt8cRIfRTXicRX0LnzhfyByX
         M/EQ==
X-Gm-Message-State: AOAM5317T8BfgC2m60MImMBWffqzFm+4tyQRnOL/3PkRV25GtXRRuvIx
        iqAnTxyjy0Y1xIOpWfmz9KFlGsRk5P8=
X-Google-Smtp-Source: ABdhPJwB0G5OeVzx657WHRwvKU6JZee+AtLxAL7APPuuacdYF8k9c5jXPavHspxiawBp2gvtwJK1mN7H78c=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:61c2:: with SMTP id v185mr2563181ybb.378.1611270234438;
 Thu, 21 Jan 2021 15:03:54 -0800 (PST)
Date:   Thu, 21 Jan 2021 23:03:36 +0000
In-Reply-To: <20210121230336.1373726-1-satyat@google.com>
Message-Id: <20210121230336.1373726-9-satyat@google.com>
Mime-Version: 1.0
References: <20210121230336.1373726-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v8 8/8] fscrypt: update documentation for direct I/O support
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 44b67ebd6e40..c0c1747fa2fb 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1047,8 +1047,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances (see `Direct I/O support`_ for details). When these
+  circumstances are not met, attempts to use direct I/O on encrypted
+  files will fall back to buffered I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1121,6 +1123,21 @@ It is not currently possible to backup and restore encrypted files
 without the encryption key.  This would require special APIs which
 have not yet been implemented.
 
+Direct I/O support
+==================
+
+Direct I/O on encrypted files is supported through blk-crypto. In
+particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
+enabled, the filesystem must have had the 'inlinecrypt' mount option
+specified, and either hardware inline encryption must be present, or
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
+the starting position in the file and the length of any I/O must be aligned
+to the filesystem block size (*not* necessarily the same as the block
+device's block size). If any of these conditions isn't met, attempts to do
+direct I/O on an encrypted file will fall back to buffered I/O. However,
+there aren't any additional requirements on user buffer alignment (apart
+from those already present when using direct I/O on unencrypted files).
+
 Encryption policy enforcement
 =============================
 
-- 
2.30.0.280.ga3ce27912f-goog

