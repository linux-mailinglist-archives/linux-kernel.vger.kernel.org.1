Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3662CB219
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgLBBKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLBBKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:10:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB55C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GLS29JPliofdLClDLIcf/EjxRzDsiF9nerluyizgtuo=; b=nW+s9po3Z7UDGR5/Eq137VKbvP
        i+P+unnI2oRphD4NjgwgeKLrldBbiIYvQIUfotliPLPbgjyP6D6CjgY13i4CDerEvW5RggWOg/Hiw
        tvo5pfaXZEp9hTj5moNuTLBJOFJC0db9AnErrTVidHo5a517R2xzZcwrSMT1YpzhhmRlAzcm9UvrD
        m6ucI4pEimy4x+hLo8o2NByME/Fk0j6efPHTYpl7NwPG87QJVv0L9xWg7Wu3HztuKeTcEvGQo9Cxr
        mB/p7sPsLBXCZS96xHvl8/RUoMWQcD8gYlXl6J3ifvJQsxYg8kj7y94YzMo1p8b36dh1zuXeC6bBq
        H3NM/k/w==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkGeH-0000Qn-Su; Wed, 02 Dec 2020 01:09:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH] tmpfs: fix Documentation nits
Date:   Tue,  1 Dec 2020 17:09:34 -0800
Message-Id: <20201202010934.18566-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo, punctuation, use uppercase for CPUs, and limit
tmpfs to keeping only its files in virtual memory (phrasing).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Down <chris@chrisdown.name>
---
 Documentation/filesystems/tmpfs.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20201201.orig/Documentation/filesystems/tmpfs.rst
+++ linux-next-20201201/Documentation/filesystems/tmpfs.rst
@@ -4,7 +4,7 @@
 Tmpfs
 =====
 
-Tmpfs is a file system which keeps all files in virtual memory.
+Tmpfs is a file system which keeps all of its files in virtual memory.
 
 
 Everything in tmpfs is temporary in the sense that no files will be
@@ -35,7 +35,7 @@ tmpfs has the following uses:
    memory.
 
    This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
-   set, the user visible part of tmpfs is not build. But the internal
+   set, the user visible part of tmpfs is not built. But the internal
    mechanisms are always present.
 
 2) glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
@@ -50,7 +50,7 @@ tmpfs has the following uses:
    This mount is _not_ needed for SYSV shared memory. The internal
    mount is used for that. (In the 2.3 kernel versions it was
    necessary to mount the predecessor of tmpfs (shm fs) to use SYSV
-   shared memory)
+   shared memory.)
 
 3) Some people (including me) find it very convenient to mount it
    e.g. on /tmp and /var/tmp and have a big swap partition. And now
@@ -83,7 +83,7 @@ If nr_blocks=0 (or size=0), blocks will
 if nr_inodes=0, inodes will not be limited.  It is generally unwise to
 mount with such options, since it allows any user with write access to
 use up all the memory on the machine; but enhances the scalability of
-that instance in a system with many cpus making intensive use of it.
+that instance in a system with many CPUs making intensive use of it.
 
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
