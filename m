Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960772CA496
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391505AbgLANzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388223AbgLANzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606830865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zlp63ghNuJN5qLaeR/Uw1vB64odm9laTGsc28DExrOk=;
        b=OWC01J/1WG23dwKwtLykseX61rC1nRR0qqZgbSIsrthgPpYGg9kHnNuEgcUxq+muGfCkx9
        efWRpXc4g4jJUAIE7KTR6fDH03o9p4E1nHk2jm8+axzqBDZyHViLP/M4xn4BITcx8mLM0/
        z+CjXxU1DCGq9jKD7Ne85EYgCC7O3gI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-OLVTAZyhOryyOTjU7erF7Q-1; Tue, 01 Dec 2020 08:54:24 -0500
X-MC-Unique: OLVTAZyhOryyOTjU7erF7Q-1
Received: by mail-ed1-f70.google.com with SMTP id z20so1365411edi.22
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zlp63ghNuJN5qLaeR/Uw1vB64odm9laTGsc28DExrOk=;
        b=L5xJ3OsrlZBLvsGfY6L9nBYIWwecbqdWzM7cBZ2vLykXCzhGpaFqqyCxWW+UCCEduL
         rktoDP3sIfGfrnH+KJqPz1cE4aVM9cmvzfFYL6siIuKmOD2nK44U3GjbsK1fvfWpHxSH
         iN9xlZZTASuzN7IWqonObiTVx9Xftcii3OcvfND96Mgsf/yXWN731tpQIPz6kmbwcm9k
         CdjzKhQxEgkZy64so1ZnN1ZndapcZrBrPSbBMP/zGoZbcSsxcfoibQTHhdPc2dfnDhO1
         Lf8fkvDcU/UMixfsnkfYAVhbZF9PRLgwq9/1/zdmCQ9PtiLR/kmyfRfXub9mTr4nbVga
         lmbg==
X-Gm-Message-State: AOAM530stwA7gReugY0rU4YQrzXXBtBThgG2339pVIhW/IaOWn2QrOm2
        nU2lulFU7z1puZy1p/J7+nZ9utkBCmShvGMONK+EYMEOzqpz8BIbJoV2NPdguPT1AEx2Yu378Tn
        B2gKgEk4KJBqvK9/nNyaNEeo2
X-Received: by 2002:a17:906:1481:: with SMTP id x1mr3191921ejc.186.1606830862966;
        Tue, 01 Dec 2020 05:54:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuPYcp9AoEFo8pa7arudlzcI2mpRWw2XyW8S7Jv9w9oVSNDVtZazhpCPXvJRRBMa8nz9Wc0w==
X-Received: by 2002:a17:906:1481:: with SMTP id x1mr3191900ejc.186.1606830862707;
        Tue, 01 Dec 2020 05:54:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p35sm890952edd.58.2020.12.01.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:54:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A70EE182EF0; Tue,  1 Dec 2020 14:54:20 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] fs: 9p: add generic splice_read file operations
Date:   Tue,  1 Dec 2020 14:54:09 +0100
Message-Id: <20201201135409.55510-1-toke@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v9fs file operations were missing the splice_read operations, which
breaks sendfile() of files on such a filesystem. I discovered this while
trying to load an eBPF program using iproute2 inside a 'virtme' environment
which uses 9pfs for the virtual file system. iproute2 relies on sendfile()
with an AF_ALG socket to hash files, which was erroring out in the virtual
environment.

Since generic_file_splice_read() seems to just implement splice_read in
terms of the read_iter operation, I simply added the generic implementation
to the file operations, which fixed the error I was seeing. A quick grep
indicates that this is what most other file systems do as well.

The only caveat is that my test case was only hitting the
v9fs_file_operations_dotl implementation. I added it to the other file
operations structs as well because it seemed like the sensible thing to do
given that they all implement read_iter, but those are only compile tested.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 fs/9p/vfs_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b177fd3b1eb3..01026b47018c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -655,6 +655,7 @@ const struct file_operations v9fs_cached_file_operations = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
 	.mmap = v9fs_file_mmap,
+	.splice_read = generic_file_splice_read,
 	.fsync = v9fs_file_fsync,
 };
 
@@ -667,6 +668,7 @@ const struct file_operations v9fs_cached_file_operations_dotl = {
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_file_mmap,
+	.splice_read = generic_file_splice_read,
 	.fsync = v9fs_file_fsync_dotl,
 };
 
@@ -678,6 +680,7 @@ const struct file_operations v9fs_file_operations = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
+	.splice_read = generic_file_splice_read,
 	.fsync = v9fs_file_fsync,
 };
 
@@ -690,6 +693,7 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
 	.mmap = generic_file_readonly_mmap,
+	.splice_read = generic_file_splice_read,
 	.fsync = v9fs_file_fsync_dotl,
 };
 
@@ -701,6 +705,7 @@ const struct file_operations v9fs_mmap_file_operations = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
 	.mmap = v9fs_mmap_file_mmap,
+	.splice_read = generic_file_splice_read,
 	.fsync = v9fs_file_fsync,
 };
 
@@ -713,5 +718,6 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_mmap_file_mmap,
+	.splice_read = generic_file_splice_read,
 	.fsync = v9fs_file_fsync_dotl,
 };
-- 
2.29.2

