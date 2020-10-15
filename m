Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17128E9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgJOBTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388051AbgJOBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45CC0076FB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:00:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so1023813wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dcwlglX8iOlpi6mOSe7tPpaLqVdYBCo/S0EI6csZEvA=;
        b=hSX8Eum4r3FmRooY1FU1i1yMO//cL7GCj57llsBbGkKQfr6zo9iMYqjUX/4DF8LHfb
         LRS8tGyofnY6n2M0Ykw6HChlj/thsee6pIpA30NW/w7KfLJshEf88/m6PVFoETxiRXD/
         82u5R3nlVYUGB26DnmqOEovqLVtxBli1ljzFIakT4Syf8Sb202bYI4tPXSO8Uu7+1tDH
         +hY7JRFAIVP5ltMKPeTliTOky59KMH6aE3tbzxVERkb44+pENz7qfhJWDUHS3CDLdXOB
         glZZ3WGXRvZ2w627pEe4bwPOjrql6E9ultblF3nu86OURTS+3wfgH1SeXJdKA83kbp2Q
         BGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dcwlglX8iOlpi6mOSe7tPpaLqVdYBCo/S0EI6csZEvA=;
        b=f5B4jPrOV/EvFSjwW/rBPtOiY2TnCgucoCuV1tGvEjtjwNuDJhKyybDWkEYcTmhbkc
         BINrOK+uXPcTl+dadvl0cYGnLOewXM5HfiuNBK4FMf15NMI5kKEwjlyACwKWsnErNZ28
         Gu9+WNub8sxH3H9j6/h5SZlAsMJnCT5RTnFIFl19yS2TCAft/F+rE7P3hKZjy5PHsKCp
         vmtwcM5SV62B6KypFJ1IdUmhOWMWLD3ACtz5c5QgA+G8pPaAg1geo2U3VSTKIr9qS2t2
         XxR3eAbVNqup9MWZZEji88AhbVyydZj2522WinGuGwbyU7wQ7QpD/qHznI6Im/AJNAt3
         bNgg==
X-Gm-Message-State: AOAM530CvgWTmi0XqAC/4vQlkX5KoNekBPO561S6uRlU6uUJS56Fkg/p
        /eQusyuiNnxVlKfbKq4OJpMT3w==
X-Google-Smtp-Source: ABdhPJym+Qy1Ozx/d9cUaPJGBmjZDj1SlCf0AIF1ayERayiA+KXQG6VjdYmuJ9wI/O3AcGbfGeStJw==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr1115358wrt.75.1602720053779;
        Wed, 14 Oct 2020 17:00:53 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id 24sm1489113wmg.8.2020.10.14.17.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:00:52 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
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
        John Hubbard <jhubbard@nvidia.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 0/2] Broad write-locking of nascent mm in execve
Date:   Thu, 15 Oct 2020 02:00:39 +0200
Message-Id: <20201015000041.1734214-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
 - add note about how this also fixes arch/um/ locking in patch 1
   (Johannes Berg)
 - use IS_DEFINED() instead of #ifdef in patch 2 (Jason Gunthorpe)
v2:
 - fix commit message of patch 1/2 and be more verbose about where
   the old mmap lock is taken (Michel, Jason)
 - resending without mangling the diffs :/ (Michel, Jason)

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
2.28.0.1011.ga647a8990f-goog

