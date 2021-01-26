Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED883304553
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbhAZR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389268AbhAZHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:54 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA5C0613ED;
        Mon, 25 Jan 2021 23:25:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q2so6550744plk.4;
        Mon, 25 Jan 2021 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QT1UJqEJdO7hqz6isap+LZMfTT7N3dUGOD0yi6KYQnI=;
        b=AsT6SM3BOkRyKTPHqpY8irjoviRt8udU74rH46Jgq3lF7fHZxmOyJ/88YOUafjXoAa
         n2cp1PogjRIELqNQt3oSl98oD4Cna01E/hWrQJ5/ic4PRN5sQ5kd7REE4DCAvEXo0/2y
         NZQyupeDguCkdjAHwhJTHCtDm8U9w56RreDkiTP54Nzb7JABUwX9SH5jwOtgDS+z4FhX
         H3AjNwG+Y1PYPJjvHiU5UfxxXeufRXJU3oTJW4g+2suPj3OU9exFF44uYJgIEBJqUsHN
         O8v4FKAO1ccFtrELH8P8GvXfQrqwpVBsqrytttPwcK5GI6PAkKXD2iRPtJl6QdE9/d5b
         s3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QT1UJqEJdO7hqz6isap+LZMfTT7N3dUGOD0yi6KYQnI=;
        b=nOnCWKZkY6G7AbBvi/qg1Yw/AdLURT2LSb6ay9sFyEKPHJ0Zyx679JR6sMx7jAx20f
         oodZC651kDsdq6jkJtmoQt+Uh5MWSipDWQVvuTiMmZipde3Ch0Qm+8MjDRZzGXk47CqM
         osVDeCdGmzGNVUCS7YXOqkHSXFi0RqsWVg60Ppcen2LP5dO/pJv6Yvq7Oaino3+BHVeY
         Q00aPJxuUaP8xkYctmo4xmKncN0zDizLvbS36mxi67754URhYfiXK7PVfCOx8euIBFzu
         gmBkhz3G+T2FWJ4Yq9H59EfVdzdW5A+gmpMJHsEusPhUqnBDr2ujG8n1dMcKHH0GrNg9
         0yiw==
X-Gm-Message-State: AOAM532rutQ9WnMEQV+4xlJ+SJsShHaFgFGivE8nODIqcObiB5TJKecJ
        Iv5wkdhR+g+1/5Wjk8wwYDrzUIpCP8BdpmyASyc=
X-Google-Smtp-Source: ABdhPJzXp+3FvrHTe2vMXCXyFA4Kp+u4zy3rzFQxIW1cU8ueXBILqGTKpU4t/6JSPFMeGLSaLHOmbQ==
X-Received: by 2002:a17:90a:ba02:: with SMTP id s2mr4802857pjr.53.1611645929990;
        Mon, 25 Jan 2021 23:25:29 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:29 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] docs: path-lookup: update do_last() part
Date:   Tue, 26 Jan 2021 15:24:35 +0800
Message-Id: <20210126072443.33066-5-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

traling_symlink() was merged into lookup_last, do_last().

do_last() has later been split into open_last_lookups()
and do_open().

see related commit: c5971b8c6354a95c9ee7eb722928af5000bac247

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 34 +++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 4e77c8520fa9..1f05b1417a55 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -496,11 +496,11 @@ one provided by a dead NFS server.  In the current kernel, path_mountpoint
 has been merged into ``path_lookup_at()`` with a new flag LOOKUP_MOUNTPOINT.
 
 Finally ``path_openat()`` is used for the ``open()`` system call; it
-contains, in support functions starting with "``do_last()``", all the
+contains, in support functions starting with "``open_last_lookups()``", all the
 complexity needed to handle the different subtleties of O_CREAT (with
 or without O_EXCL), final "``/``" characters, and trailing symbolic
 links.  We will revisit this in the final part of this series, which
-focuses on those symbolic links.  "``do_last()``" will sometimes, but
+focuses on those symbolic links.  "``open_last_lookups()``" will sometimes, but
 not always, take ``i_rwsem``, depending on what it finds.
 
 Each of these, or the functions which call them, need to be alert to
@@ -1201,26 +1201,26 @@ symlink.
 This case is handled by the relevant caller of ``link_path_walk()``, such as
 ``path_lookupat()`` using a loop that calls ``link_path_walk()``, and then
 handles the final component.  If the final component is a symlink
-that needs to be followed, then ``trailing_symlink()`` is called to set
-things up properly and the loop repeats, calling ``link_path_walk()``
-again.  This could loop as many as 40 times if the last component of
-each symlink is another symlink.
+that needs to be followed, then ``open_last_lookups()`` and ``do_open()`` is
+called to set things up properly and the loop repeats, calling
+``link_path_walk()`` again.  This could loop as many as 40 times if the last
+component of each symlink is another symlink.
 
 The various functions that examine the final component and possibly
-report that it is a symlink are ``lookup_last()``, ``mountpoint_last()``
-and ``do_last()``, each of which use the same convention as
-``walk_component()`` of returning ``1`` if a symlink was found that needs
-to be followed.
+report that it is a symlink are ``lookup_last()``, ``open_last_lookups()``
+, each of which use the same convention as
+``walk_component()`` of returning ``char *name`` if a symlink was found that
+needs to be followed.
 
-Of these, ``do_last()`` is the most interesting as it is used for
-opening a file.  Part of ``do_last()`` runs with ``i_rwsem`` held and this
-part is in a separate function: ``lookup_open()``.
+Of these, ``open_last_lookups()``, ``do_open()`` is the most interesting as it is
+used for opening a file.  Part of ``open_last_lookups()`` runs with ``i_rwsem``
+held and this part is in a separate function: ``lookup_open()``.
 
-Explaining ``do_last()`` completely is beyond the scope of this article,
-but a few highlights should help those interested in exploring the
-code.
+Explaining ``open_last_lookups()``, ``do_open()`` completely is beyond the scope
+of this article, but a few highlights should help those interested in exploring
+the code.
 
-1. Rather than just finding the target file, ``do_last()`` needs to open
+1. Rather than just finding the target file, ``do_open()`` needs to open
    it.  If the file was found in the dcache, then ``vfs_open()`` is used for
    this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
    the filesystem provides it) to combine the final lookup with the open, or
-- 
2.30.0

