Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B986290DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405472AbgJPW51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391637AbgJPW50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:57:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CF2C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:57:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f21so3804009wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjBB2JaY5bJm6k9IpxpRkKH0xd7Yv8aEjcNyDWDRvy0=;
        b=bs0Z0z2us9V9boWADbuKzEk9SQFh0Jatkct0jqT5S67/vZs57slN2TcmjqNSrfYk+A
         xbk4eVFlk6zSdcQ4B3Xrfz0ea37DwQ4hL8hvACT0JtMS1FkbculwLKp2ll+ZE2vNJtA8
         mYoFOjqwkePh30EF/RnyOPGRkH9VhSzLt1Vr4DJcBDj/AqGxOGffGunuxyt2vR90mGwI
         haCKxPUjNGP/kUXu1xcbvxO6Iuu5wApdRvY0KOf2dYy6RGZuMWQbC0jbzN53xliI5vFa
         4eDmQBc8c8hlpbFg/UuRTyw8szCM91ulJm3H3IIk1n2GcCdJgfhVv6tt7R1ZngdOTW61
         mWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjBB2JaY5bJm6k9IpxpRkKH0xd7Yv8aEjcNyDWDRvy0=;
        b=ValKx5cO2RPkxkDCA6mrdEQrQDD9MM5g7zm/aQQWON4vw8ER5OURBRBkcLcFC40/cw
         9AJ2Yd867b8eCsGoBCQMQ0sFBiOpStNvbJL3byQtGRi+Ar9S10Qm7tmhbAqxC5sVsxCD
         oTqL/DGznPXg+E4/bB2Pjkv5z2dHmYuK3+ZR/OzH9/AberQ0ouwdTvLycz0bxrdDFQp+
         LSRvw+URBrMNA3MgALxLrCAekAOCA2pajIRYlN8DQrDUxOY7sAXylv5VKY81uXENXmpP
         NlutQvHAAzsOGyiK4KkkM5S6OOBzfa72DQXVJOW+IAPgQAGpAuQ4kvBAaY01ua0lD2O8
         a+3Q==
X-Gm-Message-State: AOAM532kVUP9Tm72agNUS4uYsZiOLuNONWj1FiKDPnYhCaVroDk8Lply
        a+tH9EpUDvB/m1IdhNzi3XGXpw==
X-Google-Smtp-Source: ABdhPJywmOHdxuUVQyRE0AKiuANgfnN6uJA6It5hK9+AcLv37PijB9EFDk60ZteXSW+UQWfwGNVhoA==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr6079437wmp.187.1602889042377;
        Fri, 16 Oct 2020 15:57:22 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id f14sm5586714wrt.53.2020.10.16.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:57:21 -0700 (PDT)
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
Subject: [PATCH resend v3 0/2] Broad write-locking of nascent mm in execve
Date:   Sat, 17 Oct 2020 00:57:11 +0200
Message-Id: <20201016225713.1971256-1-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resending because DKIM got mangled on the first try by the kvack
list, hopefully setting sendemail.transferEncoding to
quoted-printable helps...)

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

[1] https://lkml.kernel.org/r/CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoC=
nNAjcg@mail.gmail.com

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
--=20
2.29.0.rc1.297.gfa9743e501-goog

