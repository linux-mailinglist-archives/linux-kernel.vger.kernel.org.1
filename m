Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897A327DDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgI3BUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgI3BUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:20:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E45C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so415459ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=SkYLlbk/QVyeZ8H3h2WamWGpJNG0N9vY2AmCSYNYmgU=;
        b=dABZmGqSFzz1GK4Q+V0hn9ld2fPMleDQjezgEMJkJZGD62P+xTxnTxGDANGDc8C7o9
         jCDXXcQF3qaIm5Y8OwGDyksok9iMW7PNCeObEsV9rwTdf/iV/EgW0Cc7GicAAKCGPL8X
         yTYkh65gsS6D+G0kp+x5azhPTg+ETy8ESTyvoelAvBCwyWMx+Von5HWD7x8r8ju90oRt
         RqwGrk59E9vqEs0m3xifUjjCzsVLRrGHdbYx6wA0qsepY7QsERrTvWfvzEvmsfSTStxJ
         8p+fusYhMs3Khus78/5Z9j/RVbI6W8V88/bHj0h8BauS3PkQJsA4YoFr/InVEZ04NaBe
         lKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=SkYLlbk/QVyeZ8H3h2WamWGpJNG0N9vY2AmCSYNYmgU=;
        b=p3rcZYQdLEcIkedOW2FPQAHvRXWsqLPGA4sg5VE/fjfoCgk2qA3skT5slK+H/ezN8T
         x14hQJ8IbgdVosFWp/bVxEHZWakf7DdX29vwKeo6rSiXfqcfRm15spaTL8rN45mqgXVq
         ObBgSjMo8xLtK0YCXexhBsw/5ZHd6UbohJlflutFaw6mxXvq6JNXzt90WKO2KbZhOWNz
         wXQjuwxk2o+mYNg5HkS7UEInN3Zf0Ds1FuMG0JpiwikmL+1U13j35Oq08yR/BQpITSEA
         1RcPR0EwjOh281XwxxkcA8zXgoTYhUQohcxHjHBqACHmTa9vP2RAfYyF682Vb8BGibp0
         lRww==
X-Gm-Message-State: AOAM530UYNOa0vkqu3mVIqqbnX2iNxdTtHYvMlq5lbGR+dibgqLYLwjh
        UpuLYf5kZE/7OmQ/gYpSIPcplnXHmwScnGrXoDJafQ==
X-Google-Smtp-Source: ABdhPJyIzeDgcumibpF4LXHJo9wpiZYhqcK1auU45s2iksKYX+f5p+9ffbvzpcy8gSwTcSNY0TW02yvSdMOFR9CbRJA=
X-Received: by 2002:a17:906:9389:: with SMTP id l9mr382229ejx.537.1601428802195;
 Tue, 29 Sep 2020 18:20:02 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2020 18:20:00 -0700
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930011944.19869-1-jannh@google.com>
References: <20200930011944.19869-1-jannh@google.com>
MIME-Version: 1.0
Date:   Tue, 29 Sep 2020 18:20:00 -0700
Message-ID: <CAG48ez1-PBCdv3y8pn-Ty-b+FmBSLwDuVKFSt8h7wARLy0dF-Q@mail.gmail.com>
Subject: [PATCH 2/4] binfmt_elf: Take the mmap lock around find_extend_vma()
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_elf_tables() runs after setup_new_exec(), so other tasks can
already access our new mm and do things like process_madvise() on it.
(At the time I'm writing this commit, process_madvise() is not in mainline
yet, but has been in akpm's tree for some time.)

While I believe that there are currently no APIs that would actually allow
another process to mess up our VMA tree (process_madvise() is limited to
MADV_COLD and MADV_PAGEOUT, and uring and userfaultfd cannot reach an mm
under which no syscalls have been executed yet), this seems like an
accident waiting to happen.

Let's make sure that we always take the mmap lock around GUP paths as long
as another process might be able to see the mm.

(Yes, this diff looks suspicious because we drop the lock before doing
anything with `vma`, but that's because we actually don't do anything with
it apart from the NULL check.)

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 40ec0b9b4b4f..cd7c574a91a4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -309,7 +309,10 @@ create_elf_tables(struct linux_binprm *bprm,
const struct elfhdr *exec,
 	 * Grow the stack manually; some architectures have a limit on how
 	 * far ahead a user-space access may be in order to grow the stack.
 	 */
+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
 	vma = find_extend_vma(mm, bprm->p);
+	mmap_read_unlock(mm);
 	if (!vma)
 		return -EFAULT;

-- 
2.28.0.709.gb0816b6eb0-goog
