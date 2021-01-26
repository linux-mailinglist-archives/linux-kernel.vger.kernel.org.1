Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EA30464B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbhAZRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389575AbhAZHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:40:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D1C061797;
        Mon, 25 Jan 2021 23:25:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t25so3033792pga.2;
        Mon, 25 Jan 2021 23:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYQjGrreBxAElr6Uc7E2xNYl1ZHh4lNeYv3YVnq1Azg=;
        b=BYhvgjtyZnmRq/0OOKpD+u298xHkA/5FMpygS6NKJ0AK/dk/ZzlFCyiadPuQT21Bg+
         4PQQkRyZKzFTq0qPj2KaLCx5BAtI2YjhGQr810HDMwaA3vL4OYzbQyi26FI8yBeAOpHr
         oSvCEgoeuGOUZOjEyOtHyyUaDBWZUqWnylkDjljSeouJyF29w0c86CSXcf9HTA3rwfGm
         +c8CJs5re387Wfc5BXfkbsP1CFoQRK1XvrEhzXwQZrWjwEHJaL+UvyX9RIlv4ivBRQqH
         Th2UvzPpOlgYwmV1G+8i2UnBJ+KMtV5aTHpzmKWJgMKqXKKxSOVtvL+lilOEF5LUgWgJ
         Z7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYQjGrreBxAElr6Uc7E2xNYl1ZHh4lNeYv3YVnq1Azg=;
        b=uX0rjZO4IYjOY9dlw+4C9CoehC7wtKwOI7Dtjul9mX8epqqEG7KK+8AgR0puLF6yLE
         8F3afZMARS4/HShk+/CT1x/EISfoioyzd7GlCLXB9HxtrAPSIa1WEhnQaNVMinIt6XLa
         q2/EljGAmFBLVpAT9iLa+exjH4k0KLB3OIAbNjLG9In/HPlauOGz4uYQytPI0uO8kIK6
         yHA/Yz2X9GZk4ewWLzyHwfOgUBUXF9ft/9DZT32CuL2QKyo3AxAPrBvctLL8RkECi8BC
         MqhLuUhrqjPDllQDzhjFhlD6TkAyoZ5AYLQxIabF2DLy5rrU3kmosZL8RKST7IzVPHCE
         dzXw==
X-Gm-Message-State: AOAM531qgS7GiogROKxGz9fLommbbjyLXF6n8nQZ9iCFrTamwvQN4gQf
        u2TxZsiUe1cQi1N/ZUwGBXM=
X-Google-Smtp-Source: ABdhPJw779iXvaKTjbYXqgTFCTH7h+kyWKHt3/6+CBGwfc8AVjLc0oQommeyBIH9mR0jCF1vvgQh+A==
X-Received: by 2002:a62:800d:0:b029:1bc:9cd1:8ee1 with SMTP id j13-20020a62800d0000b02901bc9cd18ee1mr4006255pfd.69.1611645941144;
        Mon, 25 Jan 2021 23:25:41 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:40 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] docs: path-lookup: update symlink description
Date:   Tue, 26 Jan 2021 15:24:43 +0800
Message-Id: <20210126072443.33066-13-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instead of lookup_real()/vfs_create(), i_op->lookup() and
i_op->create() will be called directly.

update vfs_open() logic

should_follow_link is merged into lookup_last() or open_last_lookup()
which returns symlink name instead of an integer.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 2bb3ca486acd..0c6fc296056c 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1204,16 +1204,15 @@ the code.
    it.  If the file was found in the dcache, then ``vfs_open()`` is used for
    this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
    the filesystem provides it) to combine the final lookup with the open, or
-   will perform the separate ``lookup_real()`` and ``vfs_create()`` steps
+   will perform the separate ``i_op->lookup()`` and ``i_op->create()`` steps
    directly.  In the later case the actual "open" of this newly found or
    created file will be performed by ``vfs_open()``, just as if the name
    were found in the dcache.
 
 2. ``vfs_open()`` can fail with ``-EOPENSTALE`` if the cached information
-   wasn't quite current enough.  Rather than restarting the lookup from
-   the top with ``LOOKUP_REVAL`` set, ``lookup_open()`` is called instead,
-   giving the filesystem a chance to resolve small inconsistencies.
-   If that doesn't work, only then is the lookup restarted from the top.
+   wasn't quite current enough.  If it's in RCU-walk -ECHILD will be returned
+   otherwise will return -ESTALE.  When -ESTALE is returned, the caller may
+   retry with LOOKUP_REVAL flag set.
 
 3. An open with O_CREAT **does** follow a symlink in the final component,
    unlike other creation system calls (like ``mkdir``).  So the sequence::
@@ -1223,8 +1222,8 @@ the code.
 
    will create a file called ``/tmp/bar``.  This is not permitted if
    ``O_EXCL`` is set but otherwise is handled for an O_CREAT open much
-   like for a non-creating open: ``should_follow_link()`` returns ``1``, and
-   so does ``do_last()`` so that ``trailing_symlink()`` gets called and the
+   like for a non-creating open: ``lookup_last()`` or ``open_last_lookup()``
+   returns a non ``Null`` value, and ``link_path_walk()`` gets called and the
    open process continues on the symlink that was found.
 
 Updating the access time
-- 
2.30.0

