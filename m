Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7C304570
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392365AbhAZRfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389579AbhAZHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:41:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EC4C06178B;
        Mon, 25 Jan 2021 23:25:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g15so1709847pjd.2;
        Mon, 25 Jan 2021 23:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Je2ntjDWSBXAispem6dfor8Yc3f/+2unXMZ7ooJA1F4=;
        b=J3f/j0bjOzvOb6iiMSf3pYlO47/WMk8cSJVTvhYvTSsayxnVauUvre4M8uwpeL/8SW
         3ilBTDER3aQ9giImDv7epaU1OCptI2TwruigcVb9ZXgKSb5zos6BKrNEUP8m5rGc/lI5
         iBL6SBOZr4W6UNgcxCRxzkLzZJ831xlR2tZDD1IYp4hW7rK7XTbU664OgZnjB3+ih6Ip
         W9eGAFATS74Ol76OAUJ1uLlEefbJJxH3iWNDn/X/hmYg4NEZc5fLRbKFrJPG8fCcU69t
         adMIzszL6BYTcaMDw/WWstd8L5nNKmBkyg2OHyHIZq4yUSNHJa6oPb9T3Sgl4+Ay6vgf
         lugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Je2ntjDWSBXAispem6dfor8Yc3f/+2unXMZ7ooJA1F4=;
        b=sGHcuj7d0Bx5NZj5p+iw4XCsppb372E61QuEU25eQb6/8TmqsH3PrvN+wfpBL605gn
         ZuKJ/pi+PBKUiG2ZcMlsiYcMujK6JRCegJX05M9qw8NA5orttFoRvp6H6glXLTz7sheh
         FPkCZ5mkbtK0Pr2Y/7G7MDShX1DrlNN5Bx+kaIy4X/VYEaeaK8mA4/swOrXe44+nXpTh
         fMsDBFOKPWA2Wf6cWS0sma2g6i+FNjLx8qD/ShvklzjU7Qfn56tLIpkFFfSj6DIPwmF4
         +By4aLwJggGjr2ozVOa+5Ls8XhBnnRHrNk/Bi1dyNDNCOHjDwLARO67ZUfhZpKwnWA7v
         QbeA==
X-Gm-Message-State: AOAM531fE37kb+se/7ESLRmRE9vNrBZlxKRKKTDaIIwfnPb7bKPMZseW
        /H+FUiMYHJrT6T4obkuGKC8=
X-Google-Smtp-Source: ABdhPJwqeTWkVwUGZf9zIrZ5NfzIoCvNnGKHzpPR+p26BnaVSnhkgYhpGPbxCFwix6CHWexuZR/eRw==
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr4682236pja.47.1611645935552;
        Mon, 25 Jan 2021 23:25:35 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:35 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] docs: path-lookup: update i_op->put_link and cookie description
Date:   Tue, 26 Jan 2021 15:24:39 +0800
Message-Id: <20210126072443.33066-9-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No inode->put_link operation anymore. We use delayed_call to
deal with link destruction. Cookie has been replaced with
struct delayed_call.

Related commit: fceef393a538134f03b778c5d2519e670269342f

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 31 +++++++----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 0a362849b26f..8572300b5405 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1068,34 +1068,21 @@ method. This is called both in RCU-walk and REF-walk. In RCU-walk the
 RCU-walk.  Much like the ``i_op->permission()`` method we
 looked at previously, ``->get_link()`` would need to be careful that
 all the data structures it references are safe to be accessed while
-holding no counted reference, only the RCU lock.  Though getting a
-reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
-code is ready to release the reference when that does happen.
-
-This need to drop the reference to a symlink adds significant
-complexity.  It requires a reference to the inode so that the
-``i_op->put_link()`` inode operation can be called.  In REF-walk, that
-reference is kept implicitly through a reference to the dentry, so
-keeping the ``struct path`` of the symlink is easiest.  For RCU-walk,
-the pointer to the inode is kept separately.  To allow switching from
-RCU-walk back to REF-walk in the middle of processing nested symlinks
-we also need the seq number for the dentry so we can confirm that
-switching back was safe.
-
-Finally, when providing a reference to a symlink, the filesystem also
-provides an opaque "cookie" that must be passed to ``->put_link()`` so that it
-knows what to free.  This might be the allocated memory area, or a
-pointer to the ``struct page`` in the page cache, or something else
-completely.  Only the filesystem knows what it is.
+holding no counted reference, only the RCU lock.
+
+Finally, a callback ``struct delayed_called`` will be passed to get_link,
+file systems can set their own put_link function and argument through
+``set_delayed_call``. Latter on, when vfs wants to put link, it will call 
+``do_delayed_call`` to invoke that callback function with the argument.
 
 In order for the reference to each symlink to be dropped when the walk completes,
 whether in RCU-walk or REF-walk, the symlink stack needs to contain,
 along with the path remnants:
 
-- the ``struct path`` to provide a reference to the inode in REF-walk
-- the ``struct inode *`` to provide a reference to the inode in RCU-walk
+- the ``struct path`` to provide a reference to the previous path
+- the ``const char *`` to provide a reference to the to previous name
 - the ``seq`` to allow the path to be safely switched from RCU-walk to REF-walk
-- the ``cookie`` that tells ``->put_path()`` what to put.
+- the ``struct delayed_call`` for later invocation.
 
 This means that each entry in the symlink stack needs to hold five
 pointers and an integer instead of just one pointer (the path
-- 
2.30.0

