Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728E72854C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJFWzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFWzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:55:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E51C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 15:55:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so30076wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3EBwbT5ZqslEinIhfYEc6EohRkTeBanAs0p5SKagfA=;
        b=Yv99Iir3LR8sa5GHm0IDQWRqeZkE7PfTCFVlvAvR8KfAhOmoOIWH02RdRzE4V4v0gM
         rkCNjg9qr0N9PIZ1y59iPMiDy6GHxR39elcelR7vcKp6TgMV96Bk1yBBB7M22x7rZFDd
         qMpWFuiiZDssV4NihC3LPFSIlZE5pUZnAHdQ6HRdK8PHSMWjOcsnv1jLXlAInfA2ae+a
         9dPV6Danf3KkVvaSgOmRnbB4SuMZl929wq+gynw/KSE2E5GMVGstEMP8D6iQd3B8W0j2
         os2Sob0FDDOlRRebcTqNNbbkzXj6FfnDoKqXSNpwnebRmj1yIARezliPUh3tvkh5+HeW
         8law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3EBwbT5ZqslEinIhfYEc6EohRkTeBanAs0p5SKagfA=;
        b=Utv9B1CdYG1Q+A5fHkVPJfOHaMkkQDu+m57eL/UtcAB5kB5OU/ZQdz/g+7uE27fA53
         NMSmaNZO7ybmIqEe1OntGRkUsanSzT8N//uu4NXd/4jO1/MAc5l5jSB/jzYR9ZJTiC29
         UsJ1tSlom913osdQxY9PlCyzO7qJ0Z5aedeRQgCqZXxMgN70srr6H+dqHVxDsSk2nR+o
         H+/YfevW0I5uGFmqfdiZ/THNq6x1mUIDUbKy4cOoLTUEWQt+E2SC0jFcoMt6ekRy4wDN
         XfLCRuSUP899xOMOyGmBIBXvwCtzGty/PqBO3E6VKgs71831w1jR5+lpGDKTuRPLamMQ
         ZxbQ==
X-Gm-Message-State: AOAM532Hty3pl6gWiPzETEQcw0yZO1K9eiHygar/tdIyLM/8H22sR7fU
        yehbeOO9PBm1eQeIVcqLXo4xjdMEV0W5KA==
X-Google-Smtp-Source: ABdhPJy+4v/kWsvqrk7kOklUz/nwg6c8o5g+mFSg90Kgg7sip06wAlk4NNCH2rrtA2c4Q96nB+dGaA==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr201205wrn.73.1602024898548;
        Tue, 06 Oct 2020 15:54:58 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id t124sm206819wmg.31.2020.10.06.15.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:54:57 -0700 (PDT)
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] Broad write-locking of nascent mm in execve
Date:   Wed,  7 Oct 2020 00:54:48 +0200
Message-Id: <20201006225450.751742-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.28.0.806.g8561365e88-goog

