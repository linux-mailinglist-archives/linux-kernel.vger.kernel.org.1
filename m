Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93CE280BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 03:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgJBBYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 21:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 21:24:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B5C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 18:24:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id md26so524438ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 18:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=ZuhbLiKiM/JcAkw5V2qrfXh3m4GeTtm0DV+AllcZcTo=;
        b=phnG+o1kyRsRwF9i0GexiGaNbZOP24P5O4ULQ5ExpA//VqilVb567sh0HefGxeA8xg
         nMG3wUlLYwDwz4ju0m6VjavsnNxCh5MJxDO+LJyeqWjOILRr8M1KBstrnZUQ1H7jEgaG
         V7tVvRw8Fx6gNANGF4V4dkqKva+5oIleHhh3HEfSVIeDZjy9uS09Ntv7j0ce+RhBTF1Q
         uNwPxns7ceb7L4mDxU8VbGuG7YWdhfiiSKigxqQF5GocQsOaAujd0SYo9X38CLWdA9V6
         2OGNFwDeurCJMAYhq9WaWDC678AEwJyWPQELa8jAOn4Wl6+AxVScu4594E9io4FCn4g1
         4itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=ZuhbLiKiM/JcAkw5V2qrfXh3m4GeTtm0DV+AllcZcTo=;
        b=XbTsC2PJWuHPWziUPXeeOepwv6ttCSd1zc1azCCbkzDzBMqwDlqg8o/TZPZScrbRzm
         6Wa1rrcnP1leX/Xe1sWoCETY0S3nhMRk1jb+g2qop9BD5duDHJZtNrmMtxoq9F6pjuki
         IaQg5gxKvdIVoorzpPT+46g0QvwmVdHOe6DaHid34mR0laQor3dI6dSONXOIqTuhP32G
         hf7A5lik3jEs4kGCeoxF+9VLbrIBDvJABGbQKvssy/E0slJoMv6HUXRfEdWhpI1eDx4l
         NmuUao3YuUwDJ1+ggC9SbXfP1k6R0Gkj4LE7An0bsM90ghLFvMQFTKNXMVmgPXPkxOKr
         3LYQ==
X-Gm-Message-State: AOAM5336utch7H+to0WejQ+Y8b1/UczFzHKYFFa0YJoG+VhiFyflLf79
        bCY2Gsda4Q5CR8qbjAoUQEYM5JllSFnhj97zcAZiyQ==
X-Google-Smtp-Source: ABdhPJw5ERWukkY+5ZDguQiFbaiYeqNOoiZ2ZEg/InHvYl6Vbjj5rB8NrevRCvjERC75sEP74nGnWjbbHtYkIX1mGeo=
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr6469076eja.233.1601601838935;
 Thu, 01 Oct 2020 18:23:58 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2020 21:23:58 -0400
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Date:   Thu, 1 Oct 2020 21:23:58 -0400
Message-ID: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
Subject: [PATCH 0/2] Broad write-locking of nascent mm in execve
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches replace "mmap locking API: don't check locking
if the mm isn't live yet"[1], which is currently in the mmotm tree,
and should be placed in the same spot where the old patch was.

While I originally said that this would be an alternative
patch (meaning that the existing patch would have worked just
as well), the new patches actually address an additional issue
that the old patch missed (bprm->vma is used after the switch
to the new mm).

I have boot-tested these patches on x64-64 (with lockdep) and
!MMU arm (the latter with both FLAT and ELF).

[1] https://lkml.kernel.org/r/CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com

Jann Horn (2):
  mmap locking API: Order lock of nascent mm outside lock of live mm
  exec: Broadly lock nascent mm until setup_arg_pages()

 arch/um/include/asm/mmu_context.h |  3 +-
 fs/exec.c                         | 64 ++++++++++++++++---------------
 include/linux/binfmts.h           |  2 +-
 include/linux/mmap_lock.h         | 23 ++++++++++-
 kernel/fork.c                     |  7 +---
 5 files changed, 59 insertions(+), 40 deletions(-)


base-commit: fb0155a09b0224a7147cb07a4ce6034c8d29667f
prerequisite-patch-id: 08f97130a51898a5f6efddeeb5b42638577398c7
prerequisite-patch-id: 577664d761cd23fe9031ffdb1d3c9ac313572c67
prerequisite-patch-id: dc29a39716aa8689f80ba2767803d9df3709beaa
prerequisite-patch-id: 42b1b546d33391ead2753621f541bcc408af1769
prerequisite-patch-id: 2cbb839f57006f32e21f4229e099ae1bd782be24
prerequisite-patch-id: 1b4daf01cf61654a5ec54b5c3f7c7508be7244ee
prerequisite-patch-id: f46cc8c99f1909fe2a65fbc3cf1f6bc57489a086
prerequisite-patch-id: 2b0caed97223241d5008898dde995d02fda544e4
prerequisite-patch-id: 6b7adcb54989e1ec3370f256ff2c35d19cf785aa
-- 
2.28.0.806.g8561365e88-goog
