Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8522A5AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 01:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgKDAJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 19:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKDAJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:09:56 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11BC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 16:09:56 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k9so17229349qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 16:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYojc7vmSWu8GGbZzz8wSzFwi9UD9yKVFssMaSFOz4E=;
        b=XoFqBsYAqL+CmBvKIOcJ8rojcXXEQbIr1wWWNyIDQDm+JCKm6rJxn1ViLr0pzjARCU
         VTwB16zKG/j9yQ/O7zEm3bzjtG1ZUs/0mBfvdo37fxkYk/WaEia32OyQQwmkz4SeKOUD
         eXGjqArvNdCliYvooX0ckqAHgbvA5gE0YZgNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYojc7vmSWu8GGbZzz8wSzFwi9UD9yKVFssMaSFOz4E=;
        b=E9r8sTamRMhRGqRS87Sl6jMB0Ldkch8qjOudwIdxVa+jwDhO8I7j07E2/zR6fWTzSd
         ZUyUUtnxhTDH9rvfxNF4sMYBZYUV8GlFE0b9r1SS7EkmE9RLCIoWeD9dSgFjqH84CcO1
         jSvmyYyK/yjgOWbQU+Rhb2EOtD/kxfN+ijdBS9YLS/OWKuTmiMDcbiV872mOGC5xgOWm
         H96MpySjLT5gq9OX1rbO2Gh8UtISzK+t0LrrVPSoG3YDdo8ULexDysdLCfu8Sgo6pi35
         PJ4CENL6CK43TXzngQ/O9kOUHvMmSBr7IAGvw4UdI1zJIpH36gVT0+AbSbl6xaSri9K/
         7ZQA==
X-Gm-Message-State: AOAM533SXkMoriiXwN7KVhPnlIU8TfQ7hmG/i2AsStGdhhBirjm4QJt7
        ccmzXBM2H8nF/iboSL7wtrKd5g==
X-Google-Smtp-Source: ABdhPJzsaO5Jjftr+mIe2epKX6LtZrXcLRkAX4K97vVHjm6AsPbKhuziuQZCn1q+0iw6Pon4kPu5bw==
X-Received: by 2002:a37:b241:: with SMTP id b62mr12176047qkf.209.1604448595391;
        Tue, 03 Nov 2020 16:09:55 -0800 (PST)
Received: from yamaha.cs.unc.edu (yamaha.cs.unc.edu. [152.2.129.229])
        by smtp.gmail.com with ESMTPSA id r190sm523861qkf.101.2020.11.03.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 16:09:54 -0800 (PST)
From:   Joshua Bakita <jbakita@cs.unc.edu>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joshua Bakita <jbakita@cs.unc.edu>
Subject: [PATCH] binfmt_elf: Fix regression limiting ELF program header size
Date:   Tue,  3 Nov 2020 19:09:30 -0500
Message-Id: <20201104000930.155577-1-jbakita@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a
function") merged load_elf_binary and load_elf_interp into
load_elf_phdrs. This change imposed a limit that the program headers of
all ELF binaries are smaller than ELF_MIN_ALIGN. This is a mistake for
two reasons:
1. load_elf_binary previously had no such constraint, meaning that
   previously valid ELF program headers are now rejected by the kernel as
   oversize and invalid.
2. The ELF interpreter's program headers should never have been limited to
   ELF_MIN_ALIGN (and previously PAGE_SIZE) in the first place. Commit
   057f54fbba73 ("Import 1.1.54") introduced this limit to the ELF
   interpreter alongside the initial ELF parsing support without any
   explanation.
This patch removes the ELF_MIN_ALIGN size constraint in favor of only
relying on an earlier check that the allocation will be less than 64KiB.
(It's worth mentioning that the 64KiB limit is also unnecessarily strict,
but that's not addressed here for simplicity. The ELF manpage says that
the program header size is supposed to have at most 64 thousand entries,
not less than 64 thousand bytes.)

Fixes: 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a function")
Signed-off-by: Joshua Bakita <jbakita@cs.unc.edu>
---
 fs/binfmt_elf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2472af2798c7..55162056590f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -412,15 +412,11 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
 	/* Sanity check the number of program headers... */
 	if (elf_ex->e_phnum < 1 ||
 		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
 		goto out;
 
-	/* ...and their total size. */
 	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
-	if (size > ELF_MIN_ALIGN)
-		goto out;
-
 	elf_phdata = kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
 	/* Read in the program headers */
-- 
2.25.1

